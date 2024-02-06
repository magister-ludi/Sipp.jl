
"""
    Entropy(im::Matrix{G <: Gray})

`Entropy` is a structure that holds a reference to an image, the 1D
histogram of its values, and the entropy values derived from the histogram.
"""
struct Entropy{G <: Gray}
    # A reference to the image.
    im::Matrix{G}
    # A reference to the 1D histogram
    histogram::Vector{UInt32}
    # The entropy for each bin value that actually occurred.
    bins::Vector{Float64}
    # The largest entropy value of any bin.
    bin_max::Float64
    # The entropy for the image, i.e. the sum of the entropies for all
    # the pixels.
    entropy::Float64

    function Entropy(im::Matrix{G}) where {G}
        hist = histogram(im)
        h, w = size(im)
        total = h * w
        normHist = hist ./ total
        bins = zeros(length(hist))
        entropy = 0.0
        bin_max = -Inf
        for (j, p) in enumerate(normHist)
            if p > 0
                bins[j] = -1.0 * p * log2(p)
                entropy += bins[j]
                if bins[j] > bin_max
                    bin_max = bins[j]
                end
            end
        end
        return new{G}(im, hist, bins, bin_max, entropy)
    end
end

"""
    render(ent::Entropy)

Render a greyscale image of the entropy for each pixel of
the data contained in `ent`.
"""
function render(ent::Entropy)
    h, w = size(ent.im)
    img = Matrix{Gray{N0f8}}(undef, h, w)
    scale = 1 / ent.bin_max
    for i in eachindex(img)
        val = value(ent.im[i])
        img[i] = ent.bins[val + 1] * scale
    end
    return img
end

"""
    Delentropy(hist::Histogram)

`Delentropy` is a structure that holds a reference to a gradient histogram
and the delentropy values derived from it.
"""
struct Delentropy{H <: Histogram}
    # A reference to the histogram we are computing from
    hist::H
    # The Delentropy for each bin value, in the same order as returned by
    # Histogram.Bins().
    bins::Vector{Float64}
    # The largest Delentropy value of any bin.
    bin_max::Float64
    # The Delentropy for the image, i.e. the sum of the delentropies for all
    # of the histogram bins.
    entropy::Float64

    # Delentropy returns a Delentropy structure for the given Histogram.
    function Delentropy(hist::H) where {H}
        # Store the entropy values corresponding to the bin counts that actually
        # occurred.
        bins = zeros(size(hist.bins))
        # pix is a matrix of complexF64s, so its length is the number of pixels.
        numPixels = length(hist.grad.pix)
        bin_max = -Inf
        entropy = 0.0

        for (i, bin) in enumerate(hist.bins)
            p = bin.value / numPixels
            bins[i] = -p * log2(p)
            if bins[i] > bin_max
                bin_max = bins[i]
            end
            entropy += bins[i] * bin.count
        end
        return new{H}(hist, bins, bin_max, entropy)
    end
end

"""
    render(dent::Delentropy, source::Symbol)

Return a greyscale image of `dent` using specific source data.
If `source` is `:histogram`, use the histogram bins as source data.
If `source` is `:gradient`, use the gradient pixels as source data.
"""
function render(dent::Delentropy, source::Symbol)
    if source == :histogram
        return histogram_render(dent)
    elseif source == :gradient
        return gradient_render(dent)
    else
        error("Invalid source ':$source'")
    end
end

function histogram_render(dent::Delentropy)
    # Make a greyscale image of the entropy for each bin.
    bins = dent.hist.bins
    scaledDelentropy = Vector{Gray{N0f8}}(undef, length(bins))
    # scale the Delentropy from (0-hist.bin_max) to (0-255)
    scale = 1 / dent.bin_max
    for i in eachindex(bins)
        scaledDelentropy[i] = dent.bins[i] * scale
    end
    return render(dent.hist, scaledDelentropy, Gray{N0f8}(0))
end

function gradient_render(dent::Delentropy)
    h, w = size(dent.hist.grad)
    # Make a greyscale image of the entropy for each bin.
    img = Matrix{Gray{N0f8}}(undef, h, w)
    # scale the entropy from (0-hist.bin_max) to (0-255)
    scale = 1 / dent.bin_max
    for c = 1:w
        for r = 1:h
            img[r, c] = dent.bins[bin_for_pixel(dent.hist, r, c)] * scale
        end
    end
    return img
end
