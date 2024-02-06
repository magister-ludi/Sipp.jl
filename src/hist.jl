
# A BinPair holds the value of a histogram bin, and the number of times that
# value occurs in the histogram. That makes it a kind of histogram of a
# histogram.
mutable struct BinPair
    value::UInt32
    count::UInt32
end

# Convenient for testing...
Base.:(==)(p1::BinPair, p2::BinPair) = p1.value == p2.value && p1.count == p2.count

# A Histogram is a 2D histogram.
abstract type Histogram end

gradient(hist::Histogram) = hist.grad

Base.size(hist::Histogram) = hist.height, hist.width

Base.max(hist::Histogram) = hist.max

bins(hist::Histogram) = hist.bins

"""
    compute_hist_size(grad::ComplexImage)

Compute the width and height of the histogram and the maximum excursion.
The width and height are twice the maximum excursion on the real and
imaginary axes, respectively, plus one to ensure that the width and height
are odd so that there is always a single central bin in both dimensions. The
returned overall maximum excursion is the maximum of the maximum excursions
for each axis.
"""
function compute_hist_size(grad::ComplexImage)
    real_range = trunc(Int, max(abs(grad.re_max), abs(grad.re_min)))
    imag_range = trunc(Int, max(abs(grad.im_max), abs(grad.im_min)))
    max_range = max(real_range, imag_range)

    width = real_range * 2 + 1 # Ensure both are odd
    height = imag_range * 2 + 1
    return max_range, height, width
end

# All images with maximum excursions less than or equal to minSparseExcursion
# will use the flat version of the histogram, in order to avoid the
# computational overhead of sparse histograms for 8-bit and low-excursion
# 16-bit images, even though the sparse histogram would usually be smaller.
# Note that excursion, the distance from 0 along either axis of the complex
# plane, is always positive.
const minSparseExcursion = 1024

"""
    histogram(grad::ComplexImage)

Compute a 2D histogram from the given gradient image.
Internally, a 2D histogram can be either "flat", meaning that storage exists
for every possible bin, or sparse, meaning that storage is allocated in a map
based on actually occurring values.
"""
function histogram(grad::ComplexImage)
    max_range, height, width = compute_hist_size(grad)
    # The following sizes are number of uint32s for the histogram.
    flatHistSize = flat_size(height, width)
    maxSparseSize = maxSparseHistSize(grad)
    if max_range > minSparseExcursion && maxSparseSize < flatHistSize
        # Use a sparse histogram
        return SparseHistogram(grad, height, width)
    else
        # Use a flat histogram
        return FlatHistogram(grad, height, width)
    end
end

"""
    add_value!(bins::AbstractVector{BinPair}, binval)

Record an entry in `bins`, either by incrementing the count of the
relevant entry if the value is already in `bins`, or appending a new entry
if it isn't.
"""
function add_value!(bins::AbstractVector{BinPair}, binval)
    if binval != 0
        i = findfirst(pair -> binval == pair.value, bins)
        if isnothing(i)
            push!(bins, BinPair(binval, 1))
        else
            bins[i].count += 1
        end
    end
    return bins
end

struct NonZeroIterator{H <: Histogram}
    hist::H
    NonZeroIterator(h::H) where {H <: Histogram} = new{H}(h)
end

"""
    nonzero_items(h::Histogram)

Provide an iterator that returns `(r, c, val)` for all non-zero
values in the binned data of `h`, where `(r, c)` are the row
and column in which `value` occurs. Convenient for constructing
images related to `h`.
"""
nonzero_items(h::Histogram) = NonZeroIterator(h)

# The maximum size of either dimension of a rendering of a histogram. If
# either excursion is such that the image would be larger than this in either
# dimension, then the histogram is scaled, equally in both dimensions to
# preserve aspect ratio, so that the larger dimension is this size.
const maxRenderExtent = 4096

"""
    render_setup(hist::Histogram)

Create and return a Matrix{N0f8} correctly sized for `hist` initialised
with `init`,
along with the scale factor used and the pixel scale factor
mapping bin values to `[0, 1]`. The correct size is determined by
taking `maxRenderExtent` into account. If `hist` is already
smaller in both dimensions, the existing width and height are used.
Otherwise, the larger dimension is scaled down to `maxRenderExtent` and the
other dimension is scaled by the same factor, preserving the aspect ratio.
"""
function render_setup(hist::Histogram, init::Gray{N0f8} = zero(Gray{N0f8}))
    height, width = size(hist)
    if width <= maxRenderExtent && height <= maxRenderExtent
        scale = 1.0
    elseif hist.width > maxRenderExtent
        width = maxRenderExtent
        scale = hist.width / maxRenderExtent
        height = trunc(Int, hist.height / scale)
    else
        height = maxRenderExtent
        scale = hist.height / maxRenderExtent
        width = trunc(Int, hist.width / scale)
    end
    rnd = fill(init, height, width)
    pixScale = 1 / hist.max
    return rnd, scale, pixScale
end

"""
    render(hist::Histogram, clip)

Render the binned data of `hist` into an 8-bit grayscale image.
If `clip` is `true`, values are used 'as is', clipped to 1.
If `clip` is `false`, values are scaled so that the maximum value is 1.
"""
function render(hist::Histogram, clip)
    img, scale, pixScale = render_setup(hist)
    if scale == 1.0
        for (row, col, val) in nonzero_items(hist)
            if clip
                val > 255 && (val = 255)
                img[row, col] = val / 255
            else
                img[row, col] = val * pixScale
            end
        end
    else
        return nothing
        # render_setup by rows to ensure that the intermediate fits in memory
        # Use a block as wide as the output image but only as tall as one
        # vertical filter. Fill this block, generate the output row, then
        # roll the block.
        # Allocate the intermediate block as a ring buffer of rows
        # precompute both filters
        # fill the first row of the ring buffer by filtering horizontally
        # for each ouput row
        #     fill the remaining rows of the ring buffer by filtering horizontally
        #     filter the buffer vertically into the output row
        #     discard all the rows except the last (if the filter is non-zero!)
        #     make the last row the first
    end
    return img
end

"""
    supScale(x, y, centx, centy, maxDist)

Determine a scale factor that is the ratio of the distance to
the given `(x, y)` from the given centre, over the given maximum distance.
This is used for rendering suppressed images of the histogram.
"""
function supScale(x, y, centx, centy, maxDist)
    xdist = x - centx
    ydist = y - centy
    hyp = hypot(xdist, ydist)
    return hyp / maxDist
end

"""
    render(hist::Histogram)

Render a suppressed version of the histogram and return
the result as an 8-bit grayscale image.
"""
function render(hist::Histogram)
    img, filterScale, _ = render_setup(hist)
    maxSuppressed = 0.0
    suppressed = zeros(size(img))
    centx = (hist.width - 1) / 2 + 1
    centy = (hist.height - 1) / 2 + 1
    h, w = size(hist.binned_data)
    if filterScale == 1.0
        for (r, c, val) in nonzero_items(hist)
            sscale = supScale(c, r, centx, centy, hist.grad.mod_max)
            suppressed[r, c] = val * sscale
            if suppressed[r, c] > maxSuppressed
                maxSuppressed = suppressed[r, c]
            end
        end
        pixScale = 1 / maxSuppressed
        for (index, val) in enumerate(suppressed)
            sval = val * pixScale
            img[index] = val * pixScale
        end
    else
        return nothing
    end
    return img
end

# Populate the `invertedBins` map for the given histogram.
# `invertedBins` stores the index in the bins for each occurring histogram
# value. Used to lazily populate invertedBins when needed.
function generate_inverted_bins!(invertedBins::Dict{UInt32, Int}, bins::AbstractVector{BinPair})
    empty!(invertedBins)
    for (index, val) in enumerate(bins)
        invertedBins[val.value] = index
    end
    return invertedBins
end

"""
    render(hist::Histogram, subs::AbstractVector{Gray{N0f8}}, zeroVal::Gray{N0f8})

Render an 8-bit image of the histogram, substituting
the given value as the pixel value for each corresponding bin value.
`subs` should have an entry for the greylevel required for each entry
in `hist.bins`, in the same order. Since `hist.bins` does not register
empty bins, `zeroVal` is used for the corresponding pixels.
This is used to render the delentropy values of the histogram.
"""
function render(hist::Histogram, subs::AbstractVector{Gray{N0f8}}, zeroVal::Gray{N0f8})
    if isempty(hist.invertedBins)
        generate_inverted_bins!(hist.invertedBins, hist.bins)
    end
    img, scale, _ = render_setup(hist, zeroVal)
    h, w = size(img)
    if scale == 1.0
        for (r, c, val) in nonzero_items(hist)
            img[r, c] = subs[hist.invertedBins[val]]
        end
    else
        return nothing
    end
    return img
end
