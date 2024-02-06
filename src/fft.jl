
"""
    FFTImage(src::AbstractMatrix{G <: Gray})

`FFTImage` contains the discrete Fourier Transform
of a greyscale image. It is the equivalent of a
`ComplexImage{Float64}` in Fourier space.
"""
struct FFTImage
    data::ComplexImage{Float64}
    function FFTImage(src::AbstractMatrix{G}) where {G <: Gray}
        comp = complex_matrix(Float64, src)
        data = ComplexImage(fft!(comp))
        return new(data)
    end
end

"""
    render(fft::FFTImage)

Render the data in `fft`, returning the real and imaginary parts
as separate 8-bit grayscale images.
"""
render(fft::FFTImage) = render(fft.data)

"""
    log_spectrum(fft::FFTImage)

Render the data in `fft`, returning  an 8-bit grayscale image
of the logarithmically scaled modulus values of the pixels.
"""
function log_spectrum(fft::FFTImage)
    img = Matrix{Gray{N0f8}}(undef, size(fft.data.pix))
    scale = 1 / log(1 + abs(fft.data.mod_max))
    for (index, pix) in enumerate(fft.data.pix)
        img[index] = log(1 + abs(pix)) * scale
    end
    return img
end
