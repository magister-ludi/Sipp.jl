
# Facilities for the computation of a finite-difference
# gradient image from a source image and a 2x2 kernel.
# There are two versions, one using Float64s and ComplexF64s, and another using
# Int32s. The latter makes it easier to guarantee bit accuracy and numerical
# stability. It is not intended as a performance optimisation.
"""
    SippGradKernel{T}(m::AbstractMatrix)

A 2D kernel used to calculate the gradients in the `x-` and
`y-` directions of a matrix.
"""
struct SippGradKernel{T <: Real}
    k::Matrix{Complex{T}}
    δr::Int  # One less than the number of rows in k
    δc::Int  # One less than the number of cols in k
    SippGradKernel{T}(m::AbstractMatrix) where {T} = new{T}(m, size(m, 1) - 1, size(m, 2) - 1)
end

SippGradKernel(m::AbstractMatrix) = SippGradKernel{Float64}(m)

# A kernel to produce a finite difference as a complex number
const defaultInt32Kernel = SippGradKernel{Int32}([
    -1+0im 0+1im
    0-1im 1+0im
])

# The Float64 version of defaultInt32Kernel
const defaultKernel = SippGradKernel(defaultInt32Kernel.k)

"""
    apply_kernel(kern::SippGradKernel, data::AbstractMatrix, row, col)

Apply a SippGradKernel to pixel `data[row, col]` and its neighbours.
"""
apply_kernel(kern::SippGradKernel{T}, data, r, c) where {T} =
    sum(kern.k .* value.(@view(data[r:(r + kern.δr), c:(c + kern.δc)])))

"""
    fdgrad(src::AbstractMatrix{G}, kern::SippGradKernel)

Use a `SippGradKernel` to create a finite-differences complex gradient image,
one pixel narrower and shorter than the original. We'd rather reduce the size
of the output image than arbitrarily wrap around or extend the source image,
as any such procedure could introduce errors into the statistics.
"""
function fdgrad(src::AbstractMatrix{<:Gray}, kern::SippGradKernel{T}) where {T}
    h, w = size(src)
    grad = Matrix{Complex{T}}(undef, h - 1, w - 1)
    dsti = 0
    for x = 1:(w - 1)
        for y = 1:(h - 1)
            grad[y, x] = apply_kernel(kern, src, y, x)
        end
    end
    return ComplexImage(grad)
end

# Use a default SippGradKernel to compute a finite-differences gradient. See
# fdgrad for details.
fdgrad(src::AbstractMatrix{<:Gray}) = fdgrad(src, defaultKernel)

# Use a default SippGradKernel{Int32} to compute a finite-differences gradient.
# See FdgradInt32Kernel for details.
fdgrad32(src::AbstractMatrix{<:Gray}) = fdgrad(src, defaultInt32Kernel)
