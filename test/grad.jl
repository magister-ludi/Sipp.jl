
const smallPicGrad = ComplexF64[
    5-3im 5-3im 5-3im
    5-3im 5-3im 5-3im
    5-3im 5-3im 5-3im
]

const smallPicGradMaxMod = sqrt(34.0)
const smallPicMaxRe = 5
const smallPicMinRe = 5
const smallPicMaxIm = -3
const smallPicMinIm = -3

const identityKernel = SippGradKernel([
    1+0im 0+0im
    0+0im 0+0im
])

const imagIdentityKernel = SippGradKernel([
    0+1im 0+0im
    0+0im 0+0im
])

const kieransKernel = SippGradKernel([
    -1+0im 0-1im
    0+1im 1+0im
])

const smallPicGradKieransKernel = ComplexF64[
    5+3im 5+3im 5+3im
    5+3im 5+3im 5+3im
    5+3im 5+3im 5+3im
]

const smallPicGradInt32 = Complex{Int32}[
    5-3im 5-3im 5-3im
    5-3im 5-3im 5-3im
    5-3im 5-3im 5-3im
]

const identityKernelInt32 = SippGradKernel{Int32}([
    1+0im 0+0im
    0+0im 0+0im
])

const imagIdentityKernelInt32 = SippGradKernel{Int32}([
    0+1im 0+0im
    0+0im 0+0im
])

const kieransKernelInt32 = SippGradKernel{Int32}([
    -1+0im 0-1im
    0+1im 1+0im
])

const smallPicGradKieransKernelInt32 = Complex{Int32}[
    5+3im 5+3im 5+3im
    5+3im 5+3im 5+3im
    5+3im 5+3im 5+3im
]

@testset "Gradient images" begin
    @testset "Floating point" begin
        tests = [
            (
                name = "Default kernel smallPic",
                im = smallPic,
                w = 3,
                h = 3,
                gr = smallPicGrad,
                mm = smallPicGradMaxMod,
                mxr = smallPicMaxRe,
                mnr = smallPicMinRe,
                mxi = smallPicMaxIm,
                mni = smallPicMinIm,
            ),
            (
                name = "Default kernel cosxCosyTiny",
                im = cosxCosyTiny,
                w = 19,
                h = 19,
                gr = CosxCosyTinyGrad,
                mm = CosxCosyTinyGradMaxMod,
                mxr = CosxCosyTinyGradMaxRe,
                mnr = CosxCoxyTinyGradMinRe,
                mxi = CosxCosyTinyGradMaxIm,
                mni = CosxCosyTinyGradMinIm,
            ),
        ]
        for test in tests
            grad = fdgrad(test.im)
            @test size(grad) == (test.h, test.w)
            @test grad.pix == test.gr
            @test grad.mod_max == test.mm
            @test grad.re_max == test.mxr
            @test grad.re_min == test.mnr
            @test grad.im_max == test.mxi
            @test grad.im_min == test.mni
        end
    end

    # TODO: Test the extrema
    @testset "Integer" begin
        tests = [
            (
                name = "Default kernel smallPic",
                im = smallPic,
                w = 3,
                h = 3,
                gr = smallPicGradInt32,
                mm = smallPicGradMaxMod,
                mxr = smallPicMaxRe,
                mnr = smallPicMinRe,
                mxi = smallPicMaxIm,
                mni = smallPicMinIm,
            ),
            (
                name = "Default kernel cosxCosyTiny",
                im = cosxCosyTiny,
                w = 19,
                h = 19,
                gr = CosxCosyTinyGradInt32,
                mm = CosxCosyTinyGradMaxMod,
                mxr = CosxCosyTinyGradMaxRe,
                mnr = CosxCoxyTinyGradMinRe,
                mxi = CosxCosyTinyGradMaxIm,
                mni = CosxCosyTinyGradMinIm,
            ),
        ]
        for test in tests
            grad = fdgrad32(test.im)
            @test size(grad) == (test.h, test.w)
            @test grad.pix == test.gr
            @test grad.mod_max == test.mm
            @test grad.re_max == test.mxr
            @test grad.re_min == test.mnr
            @test grad.im_max == test.mxi
            @test grad.im_min == test.mni
        end
    end

    # equalSubImage returns true if the "test" image is a subset of either the real
    # or imaginary component of the "target" complex image, in the top-left corner.
    function is_subimage(test::ComplexImage, target, testReal)
        h, w = size(test)
        for x = 1:w
            for y = 1:h
                exp = value(target[y, x])
                tst = test[y, x]
                if testReal && real(tst) != exp
                    return false
                elseif !testReal && imag(tst) != exp
                    return false
                end
            end
        end
        return true
    end

    @testset "fdgrad kernel floating point" begin
        # cosxCosyTiny with identityKernel
        idGrad = fdgrad(cosxCosyTiny, identityKernel)
        @test is_subimage(idGrad, cosxCosyTiny, true)

        # cosxCosyTiny with imagIdentityKernel
        imagIdGrad = fdgrad(cosxCosyTiny, imagIdentityKernel)
        @test is_subimage(imagIdGrad, cosxCosyTiny, false)

        # smallPic with kieransKernel
        kierGrad = fdgrad(smallPic, kieransKernel)
        @test kierGrad.pix == smallPicGradKieransKernel
    end

    @testset "fdgrad kernel integer" begin
        # cosxCosyTiny with identityKernel
        idGrad = fdgrad(cosxCosyTiny, identityKernelInt32)
        @test is_subimage(idGrad, cosxCosyTiny, true)

        # cosxCosyTiny with imagIdentityKernel
        imagIdGrad = fdgrad(cosxCosyTiny, imagIdentityKernelInt32)
        @test is_subimage(imagIdGrad, cosxCosyTiny, false)

        # smallPic with kieransKernel
        kierGrad = fdgrad(smallPic, kieransKernelInt32)
        @test kierGrad.pix == smallPicGradKieransKernelInt32
    end
end
