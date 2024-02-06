module Sipp

using ArgParse
using Dates
using FFTW
using FileIO
using ImageCore
using ImageIO
using Printf
using SparseArrays

export ComplexImage, Delentropy, Entropy, FFTImage, SippGradKernel

export bpp, fdgrad, fdgrad32, gradient, histogram, log_spectrum, read_image, render
export thumbnail, value

include("main.jl")

include("image.jl")
include("greyhist.jl")
include("complex_image.jl")
include("fft.jl")

include("grad.jl")
include("hist.jl")
include("flathist.jl")
include("sparse_hist.jl")
include("entropy.jl")

end # module Sipp
