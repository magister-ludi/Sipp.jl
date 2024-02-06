
"""
    SparseHistogram(grad::ComplexImage, height, width)

`SparseHistogram` is a 2-dimensional histogram of the values in a complex
gradient image, stored sparsely to conserve memory.
"""
struct SparseHistogram{T} <: Histogram
    # Embed the core fields
    # A reference to the gradient image we are computing from
    grad::ComplexImage{T}
    # width and height of the histogram, not the image.
    # These should be odd so that there is always a centre point.
    height::Int
    width::Int
    # The maximum bin value in the histogram.
    max::UInt32
    # The set of bin values that actually occur, and the number of their
    # occurrences.
    bins::Vector{BinPair}
    # The inverse of bins. For a given bin value, stores the index in bins.
    # Lazily initialised as needed.
    invertedBins::Dict{UInt32, Int}

    # The histogram data
    binned_data::SparseMatrixCSC{UInt32, Int64}
    # The index of the histogram binned_data for each gradient image pixel.
    binIndex::Matrix{CartesianIndex{2}}

    function SparseHistogram(grad::ComplexImage{T}, height, width) where {T}
        binned_data = spzeros(UInt32, height, width)
        binIndex = Matrix{CartesianIndex{2}}(undef, size(grad.pix))
        numUsedBins = 0

        # Walk through the image, computing the bin address from the gradient
        # values, storing the bin address in binIndex, and incrementing the
        # bin. Save the maximum bin value and count the number of actually used
        # bins.
        xoff = (width - 1) ÷ 2 + 1
        yoff = (height - 1) ÷ 2 + 1
        maxval = 0
        h, w = size(grad.pix)
        for c = 1:w
            for r = 1:h
                pixel = grad.pix[r, c]
                hc = floor(Int, real(pixel)) + xoff
                hr = floor(Int, imag(pixel)) + yoff
                binIndex[r, c] = CartesianIndex(hr, hc)
                if binned_data[hr, hc] == 0
                    # First use of this bin, so count it
                    numUsedBins += 1
                end
                binned_data[hr, hc] += 1
                if binned_data[hr, hc] > maxval
                    maxval = binned_data[hr, hc]
                end
            end
        end
        # numUsedBins is larger, or in the worst case equal, to the number of
        # distinct bin values, so it can be used as the capacity of the slice of
        # distinct bin values.
        bins = Vector{BinPair}()
        sizehint!(bins, numUsedBins)
        for binval in nonzeros(binned_data)
            bins = add_value!(bins, binval)
        end
        return new{T}(grad, height, width, maxval, bins, Dict(), binned_data, binIndex)
    end
end

# sparseHistogramEntrySize is the number of uint32s per histogram entry.
# The size in bytes (or uint32s) of a Go map is not easy to determine, but the
# number of buckets is always a power of 2, so as a rough estimate, we'll take
# the minimum size of an entry to be the size of the ComplexF64 index (4 uint32s)
# plus the count (1 UInt32) plus a 64-bit pointer for overhead (2 uint32s). The
# last of these is just a wild guess. Then we multiply this entry size by the
# number of pixels rounded up to the next power of 2 to get an estimate of the
# sparse histogram size.
const sparseHistogramEntrySize = 4 + 1 + 2 # See above

# maxSparseHistSize returns the maximum size of a sparse histogram for the
# given image, in uint32s.
# The maximum size of a sparse histogram is one sparseHistogramEntry per
# gradient pixel, but Go maps always have a power of 2 number of entries.
# See the comment for sparseHistogramEntrySize above.
maxSparseHistSize(grad::ComplexImage) = sparseHistogramEntrySize * nextpow(2, length(grad.pix))

function bin_for_pixel(hist::SparseHistogram, r, c)
    hi = hist.binIndex[r, c]
    val = hist.binned_data[hi]
    i = findfirst(binVal -> val == binVal.value, hist.bins)
    isnothing(i) && error("No bin found for pixel!")
    return i
end

function Base.iterate(it::NonZeroIterator, state = nothing)
    #https://stackoverflow.com/questions/52603561/
    mat = it.hist.binned_data
    # cit: column iteration return value -> (column number, iterator state)
    # rit: nzrange iteration return value -> (index into rowvals/nonzeros, iterator state)
    if isnothing(state)
        cit = iterate(1:size(mat, 2))
        isnothing(cit) && return nothing
        col, colstate = cit
        rowstate = nothing
    else
        col, colstate, rowstate = state
    end
    if isnothing(rowstate)
        rit = iterate(nzrange(mat, col))
    else
        rit = iterate(nzrange(mat, col), rowstate)
    end
    while isnothing(rit)
        cit = iterate(1:size(mat, 2), colstate)
        isnothing(cit) && return nothing
        col, colstate = cit
        rowstate = nothing
        rit = iterate(nzrange(mat, col))
    end
    row_idx, rowstate = rit
    row = rowvals(mat)[row_idx]
    if row > size(mat, 1) || col > size(mat, 2)
        error("Oops!")
    end
    return (row, col, nonzeros(mat)[row_idx]), (col, colstate, rowstate)
end
