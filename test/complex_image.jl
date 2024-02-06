
#! format: off
const shiftedPic = ComplexF64[
  1  -2   3  -4
 -5   6  -7   8
  9 -10  11 -12
-13  14 -15  16
]

const minShiftedPic = -15.0
const maxShiftedPic = 16.0
const maxShiftedMod = 16.0

const scaledShiftedPic = Gray{N0f8}.([
131 106 148  90
 82 172  65 189
197  41 213  24
 16 238   0 255
] ./ 255)

const smallZeroPic = zeros(Gray{N0f8},4,4)

const shiftedPicInt32 = Complex{Int32}[
  1  -2  3  -4
 -5   6  -7  8
  9 -10  11 -12
-13  14 -15  16
]
#! format: on

const shiftedPicInt32MinRe = Int32(-15)
const shiftedPicInt32MaxRe = Int32(16)
const shiftedPicInt32MaxMod = 16.0

const CosxCosyTinyGradInt32MinRe = Int32(-40)
const CosxCosyTinyGradInt32MaxRe = Int32(40)
const CosxCosyTinyGradInt32MinIm = Int32(-40)
const CosxCosyTinyGradInt32MaxIm = Int32(39)

@testset "ComplexImages" begin
    @testset "ComplexImage construction" begin
        cpx = ComplexImage(CosxCosyTinyGradInt32)
        @test cpx.pix === CosxCosyTinyGradInt32

        @test cpx.re_min == CosxCosyTinyGradInt32MinRe
        @test cpx.re_max == CosxCosyTinyGradInt32MaxRe
        @test cpx.im_min == CosxCosyTinyGradInt32MinIm
        @test cpx.im_max == CosxCosyTinyGradInt32MaxIm
        @test cpx.mod_max == CosxCosyTinyGradMaxMod
    end

    @testset "ComplexImage conversion" begin
        comp = ComplexImage{Int32}(smallPic)
        @test shiftedPicInt32 == comp.pix
        @test comp.re_min == shiftedPicInt32MinRe
        @test comp.re_max == shiftedPicInt32MaxRe
        @test comp.mod_max == shiftedPicInt32MaxMod
        re, im = render(comp)
        @test re ≈ scaledShiftedPic
        @test im ≈ smallZeroPic

        comp = ComplexImage{Int32}(smallPic16)
        @test shiftedPicInt32 == comp.pix

        re, im = render(comp)
        @test re ≈ scaledShiftedPic
        @test im ≈ smallZeroPic
    end
end
