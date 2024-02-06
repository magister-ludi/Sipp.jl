
"""
    ComplexImage{T <: Real}

An image where each pixel is a `Complex{T}`.
"""
struct ComplexImage{T <: Real}
    # The "pixel" data.
    pix::Matrix{Complex{T}}
    # Extremal values found in this image
    mod_max::Float64
    re_min::T
    re_max::T
    im_min::T
    im_max::T
end

Base.eltype(::ComplexImage{T}) where {T} = Complex{T}

Base.getindex(ci::ComplexImage, idx...) = getindex(ci.pix, idx...)

Base.size(ci::ComplexImage) = size(ci.pix)

"""
    ComplexImage(cpx::AbstractMatrix{T})

Wrap a matrix of complex numbers in a ComplexImage{T}.
"""
function ComplexImage(cpx::AbstractMatrix{Complex{T}}) where {T}
    re_min = im_min = typemax(T)
    re_max = im_max = typemin(T)
    mod_max2 = 0.0
    for c in cpx
        reVal = c.re
        imVal = c.im
        modsq = Float64(reVal)^2 + Float64(imVal)^2
        # store the maximum squared value, then take the root afterwards
        if modsq > mod_max2
            mod_max2 = modsq
        end
        if reVal < re_min
            re_min = reVal
        end
        if reVal > re_max
            re_max = reVal
        end
        if imVal < im_min
            im_min = imVal
        end
        if imVal > im_max
            im_max = imVal
        end
    end
    return ComplexImage{T}(cpx, sqrt(mod_max2), re_min, re_max, im_min, im_max)
end

function complex_matrix(::Type{T}, img::AbstractMatrix{G}) where {T, G <: Gray}
    height, width = size(img)
    pix = Matrix{Complex{T}}(undef, size(img))
    # Multiply by (-1)^(x+y) while converting the pixels to complex numbers
    shiftStart = one(Int32)
    shift = shiftStart
    for x = 1:width
        for y = 1:height
            #pix[y, x] = round(value(img[y, x])) * shift
            pix[y, x] = value(img[y, x]) * shift
            shift = -shift
        end
        shiftStart = -shiftStart
        shift = shiftStart
    end
    return pix
end

"""
    ComplexImage{T}(img::AbstractMatrix{G}) where {T, G <: Gray}

Convert the input image into a `ComplexImage{T}`,
multiplying each pixel by (-1)^(x+y), in order for a subsequent FFT to be
centred properly.
"""
ComplexImage{T}(img::AbstractMatrix{G}) where {T, G <: Gray} = ComplexImage(complex_matrix(T, img))

"""
    render(comp::ComplexImage{T}) where {T}

Render the real and imaginary parts of the image as separate 8-bit
grayscale images.
"""
function render(comp::ComplexImage)
    # compute scale and offset for each image
    rdiv = max(1, comp.re_max - comp.re_min)
    idiv = max(1, comp.im_max - comp.im_min)
    rscale = 1 / rdiv
    iscale = 1 / idiv
    rePix = Matrix{Gray{N0f8}}(undef, size(comp))
    imPix = Matrix{Gray{N0f8}}(undef, size(comp))
    for (index, pix) in enumerate(comp.pix)
        r = pix.re
        i = pix.im
        rePix[index] = Gray{N0f8}((r - comp.re_min) * rscale)
        imPix[index] = Gray{N0f8}((i - comp.im_min) * iscale)
    end
    return rePix, imPix
end
