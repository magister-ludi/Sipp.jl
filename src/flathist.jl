
"""
    FlatHistogram(grad::ComplexImage, height, width)

`FlatHistogram` is a 2-dimensional histogram of the values in a complex gradient
image.
"""
struct FlatHistogram{T} <: Histogram
    # Embed the core fields.
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

    # The histogram data.
    binned_data::Matrix{UInt32}
    # The index of the histogram binned_data for each gradient image pixel.
    binIndex::Matrix{NTuple{2, Int}}

    # Make a flat histogram from the given complex gradient image. The width and
    # height (of the histogram, not the image) are passed in to avoid recomputing
    # them, as they were needed to decide whether to use this histogram or the
    # sparse one.
    function FlatHistogram(grad::ComplexImage{T}, height, width) where {T}
        binned_data = zeros(UInt32, height, width)
        binIndex = Matrix{NTuple{2, Int}}(undef, size(grad.pix))
        numUsedBins = 0

        # Walk through the image, computing the bin address from the gradient
        # values, storing the bin address in binIndex, and incrementing the
        # bin. Save the maximum bin value and count the number of actually used
        # bins.
        xoff = (width - 1) ÷ 2 + 1
        yoff = (height - 1) ÷ 2 + 1
        maxval = 0
        h, w = size(grad.pix)
        for r = 1:h
            for c = 1:w
                pixel = grad.pix[r, c]
                hc = floor(Int, real(pixel)) + xoff
                hr = floor(Int, imag(pixel)) + yoff
                binIndex[r, c] = (hr, hc)
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
        for binval in binned_data
            bins = add_value!(bins, binval)
        end
        return new{T}(grad, height, width, maxval, bins, Dict(), binned_data, binIndex)
    end
end

# flatBinSize is the number of Uint32s per histogram entry.
const flatBinSize = 1

# flat_size returns the size of the histogram in uint32s.
# The size of a flat histogram is one flatBinSize per bin.
flat_size(height, width) = width * height * flatBinSize

"""
    bin_for_pixel(hist::Histogram, row, column)

Return the index into the binned data of `hist` for the
value of the gradient-image pixel at the given `row` and `column`.
"""
function bin_for_pixel(hist::FlatHistogram, r, c)
    hr, hc = hist.binIndex[r, c]
    val = hist.binned_data[hr, hc]
    i = findfirst(binVal -> val == binVal.value, hist.bins)
    isnothing(i) && error("No bin found for pixel!")
    return i
end

function Base.iterate(it::NonZeroIterator{<:FlatHistogram}, state = nothing)
    mat = it.hist.binned_data
    index = isnothing(state) ? oneunit(CartesianIndex{2}) : state
    index[2] > size(mat, 2) && return nothing
    index = findnext(!iszero, mat, index)
    isnothing(index) && return nothing
    return (index[1], index[2], mat[index]), nextind(mat, index)
end
