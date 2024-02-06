
const SippGray = Matrix{Gray{N0f8}}
const SippGray16 = Matrix{Gray{N0f16}}

bpp(::Color{N0f8}) = 8

bpp(::Color{N0f16}) = 16

bpp(m::AbstractMatrix{C}) where {C <: Color} = bpp(m[1])

integer_value(g::Gray{N0f8}) = round(UInt8, g * 255)

integer_value(g::Gray{N0f16}) = round(UInt16, g * 65535)

# Thumbnails are square, this many pixels on a side, padded with black if
# original isn't square.
const thumbSide = 150

"""
    read_image(file::AbstractString)

Read an image from `file`, convert it to grayscale and return
the converted image.
"""
function read_image(file::AbstractString)
    img = load(file)
    return Gray.(img)
end

"""
    thumbnail(src::Matrix{C <: Color})

Produce a scaled version of `img`. In the cuurent implementation,
the result is 150×150 pixels.
"""
function thumbnail(src::Matrix{C}) where {C <: Color}
    thumb = SippGray(undef, thumbSide, thumbSide)
    # TODO: if the original is smaller than or equal to this, just center it
    scale_down(src, thumb)
    return thumb
end

value(g::Gray) = reinterpret(gray(g))

# Scale the source image down to the destination image.
# Preserves aspect ratio, leaving unused destination pixels untouched.
# At present it just uses a simple box filter.
# It might be possible to improve performance and clarity by making all
# pixel fractions 1/16 and using essentially fixed-point arithmetic.
function scale_down(
    src::AbstractMatrix{Gray{F}},
    dst::AbstractMatrix{Gray{N0f8}},
) where {F <: FixedPoint}
    srcHeight, srcWidth = size(src)
    dstHeight, dstWidth = size(dst)

    srcAR = srcWidth / srcHeight
    dstAR = dstWidth / dstHeight

    if srcAR < dstAR
        # scale vertically and use a horizontal offset
        scale = srcHeight / dstHeight
        outWidth = trunc(Int, srcWidth / scale)
        outHeight = dstHeight
    else
        # scale horizontally and use a vertical offset
        scale = srcWidth / dstWidth
        outHeight = trunc(Int, srcHeight / scale)
        outWidth = dstWidth
    end

    # One of the following will be 0.
    hoff = (dstWidth - outWidth) ÷ 2
    voff = (dstHeight - outHeight) ÷ 2

    # Scale 16-bit images down to 8. We incour the cost spuriously for 8-bit
    # images so that we can access the source polymorphically.
    scaleBpp = 1.0 / ((reinterpret(typemax(F)) + 1) >> 8)

    hfilter = precompute_filter(scale, outWidth, srcWidth, scaleBpp)
    intrm = Matrix{Float64}(undef, srcHeight, outWidth)

    for inty = 1:srcHeight
        # Apply the filter to the source row, generating an intermediate row
        for intx = 1:outWidth
            val = 0.0
            for i = 1:(hfilter[intx].n)
                val += value(src[inty, hfilter[intx].idx + i]) * hfilter[intx].weights[i]
            end
            intrm[inty, intx] = clamp(round(val), 0, 255)
        end
    end

    scaleBpp = 1.0 # The intermediate is already 8-bit
    vfilter = precompute_filter(scale, outHeight, srcHeight, scaleBpp)

    for outx = 1:outWidth
        # Apply the filter to the intermediate column, generating an output column
        for outy = 1:outHeight
            val = 0.0
            for i = 1:(vfilter[outy].n)
                val += intrm[vfilter[outy].idx + i, outx] * vfilter[outy].weights[i]
            end
            dst[outy + voff, outx + hoff] = clamp(round(val), 0, 255) / 255
        end
    end
end

# Set of weights to use for an output pixel
struct Filter
    # Index into the source row/column where these weights start
    idx::Int
    # Number of pixels that contribute
    n::Int
    # Weight for each input pixel. There are n of these.
    weights::Vector{Float64}
    Filter(idx, n) = new(idx, n, Vector{Float64}(undef, n))
end

# precompute_filter returns a slice of filter structs, one for each output
# pixel. The scaleBpp parameter is used to scale down 16-bit pixels to 8-bit
# during the filtering.
function precompute_filter(scale::Real, outSize::Integer, srcSize::Integer, scaleBpp::Real)
    #	scale,outSize,srcSize,scaleBpp)
    ret = Vector{Filter}(undef, outSize)

    # The minimum worthwhile fraction of a pixel. This value is also used
    # to avoid direct floating-point comparisons  instead of comparing two
    # values for equality, we test if their difference is smaller than this
    # value.
    minFrac = 1.0 / 256.0

    for i = 1:outSize
        # compute the address and first weight
        invw, addr = modf((i - 1) * scale)
        idx = Int(addr)
        frstw = 1 - invw
        if frstw < minFrac
            idx += 1
            frstw = 0.0
        else
            n = 1
        end
        # compute the number of pixels
        frac, count = modf(scale - frstw)
        count = Int(count)
        n += count
        if frac >= minFrac
            n += 1
        else
            frac = 0.0
        end
        # allocate the slice of weights
        ret[i] = Filter(idx, n)
        windx = 1
        if frstw > 0.0
            ret[i].weights[windx] = frstw / scale * scaleBpp
            windx += 1
        end
        for j = 1:count
            ret[i].weights[windx] = 1.0 / scale * scaleBpp
            windx += 1
        end
        if frac > 0.0
            ret[i].weights[windx] = frac / scale * scaleBpp
        end
    end
    return ret
end
