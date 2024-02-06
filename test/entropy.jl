
const smallPicEntropy = 4.0

const smallPicEntropyImage =
    Gray{N0f8}.([
        1.0 1.0 1.0 1.0
        1.0 1.0 1.0 1.0
        1.0 1.0 1.0 1.0
        1.0 1.0 1.0 1.0
    ])

const smallPic16Entropy = 4.0

const cosxCosyTinyEntropy = 5.211838049805185

#! format: off
const cosxCosyTinyEntropyImage = Gray{N0f8}.([
 155 255 255 155 155 255 255 255 255 155 155 255 255 255 255 155 155 255 255 155
 255 155 208 155 255 255 125 208 155 255 255 155 208 183 255 255 155 208 155 255
 255 208 125 255 155 155 208 155 208 255 255 208 155 208 155 155 255  52 208 255
 155 155 255 125 255 255 155 208 125 255 255 125 208 155 255 255 125 255 155 155
 155 255 155 255 155 155 255 155 255 255 255 255 155 255 155 155 255 155 255 155
 255 255 155 255 155 155 255 155 255 155 155 255 155 255 155 155 255 155 255 255
 255 183  91 155 255 255 125 255 155 155 155 155 255  52 255 255 155 208 183 255
 255  91 155  91 155 155 255 125 208 255 255  91 125 255 155 155 208 155 208 255
 255 155  91 183 255 255 155 208 155 255 255 155  91 155 255 255 183 208 155 255
 155 255 255 255 255 155 155 255 255 155 155 255 255 155 155 255 255 255 255 155
 155 255 255 255 255 155 155 255 255 155 155 255 255 155 155 255 255 255 255 155
 255 155 208 183 255 255 155 208 155 255 255 155 208 155 255 255 125 208 155 255
 255 208 155 208 155 155 255  52 208 255 255 208 125 255 155 155 208 155 208 255
 255 125 208 155 255 255 125 255 155 155 155 155 255 125 255 255 155 208 125 255
 255 255 155 255 155 155 255 155 255 155 155 255 155 255 155 155 255 155 255 255
 155 255 155 255 155 155 255 155 255 255 255 255 155 255 155 155 255 155 255 155
 155 155 255  52 255 255 155 208 183 255 255 183  91 155 255 255 125 255 155 155
 255  91 125 255 155 155 208 155 208 255 255  91 155  91 155 155 255 125 208 255
 255 155  91 155 255 255 183 208 155 255 255 155  91 183 255 255 155 208 155 255
 155 255 255 155 155 255 255 255 255 155 155 255 255 255 255 155 155 255 255 155
] ./ 255)
#! format: on

const expectedDelentropy = 6.775012499324653
const expectedMaxDelentropy = 0.12179180114985422
const expectedDelentropyArray = [
    0.023534224451211,
    0.04152828269743585,
    0.0719762329848994,
    0.09824198104431049,
    0.0855114533517979,
    0.12179180114985422,
]

#! format: off
# The values for sgrayCosxCosyTinyDelentropy are *not* the same as the values
# in the original Go version. See notes in ../differences.md
const sgrayCosxCosyTinyDelentropy = Gray{N0f8}.([
 206 151  87  87  87  87  87 151 151  49  87 206 206  87 206  87  87 206 206
 206 206 151 151  87 206  87 255 151  87 151 206  87 206  87  87 151  87 206
  87  87  87  87  87  87 255  87  87  49  87  87 206  87 206 206 206 151  87
  87 206 206 206 179 151  87 206  87  87  87 151  87 206 179 206 206  87  87
 206  87 206 179 179 179  87  87  87  49  87  87  87 179 179 179 206  87 206
  87 151 206 206 179 206  87 151  87  87  87 206 151 151 179 206  87 206  87
 151 151 206 206 206 206  87  87  87  49 206  87 255 151  87  87 206  87 206
  87 206 151 151  87 206  87 206 151  87  87 255  87 206  87  87 151 206 206
  87  87 151  87 206  87  87 206 206 179 151  87 206  87  87  87 151 151  87
  49 206  87 206  49 206  87 206 179 179 179  87  49  87  49  87  49  87  49
  87 206 206  87 206  87  87 206 206 179 206 151  87  87  87  87  87 151 151
 151 206  87 206  87  87 151  87 206 206 206 206 151 151  87 206  87 255 151
  87  87 206  87 206 206 206 151  87  87  87  87  87  87  87  87 255  87  87
  87 151  87 206 179 206 206  87  87 206  87 206 206 206 179 151  87 206  87
  87  87  87 179 179 179 206  87 206  49 206  87 206 179 179 179  87  87  87
  87 206 151 151 179 206  87 206  87 206  87 151 206 206 179 206  87 151  87
 206  87 255 151  87  87 206  87 206  87 151 151 206 206 206 206  87  87  87
  87 255  87 206  87  87 151 206 206 206  87 206 151 151  87 206  87 206 151
 151  87 206  87  87  87 151 151  87  49  87  87 151  87 206  87  87 206 206
] ./ 255)
#! format: on

@testset "Conventional Entropy" begin
    ent = Entropy(cosxCosyTiny)
    @test ent.entropy == cosxCosyTinyEntropy

    entIm = render(ent)
    for (a, b) in zip(entIm, cosxCosyTinyEntropyImage)
        @test value(a) == value(b)
    end

    ent16 = Entropy(smallPic16)
    @test ent16.entropy == smallPic16Entropy

    entIm16 = render(ent16)
    @test all(entIm16 .== smallPicEntropyImage)
end

struct EntropyTest
    grad::Matrix{ComplexF64}
    maxDelentropy::Float64
    delentropyArray::Vector{Float64}
    delentropy::Float64
    histDelentropyImageName::String
    delentropyImage::Matrix{Gray{N0f8}}
end

@testset "Delentropy" begin
    tests = [
        EntropyTest(
            CosxCosyTinyGrad,
            expectedMaxDelentropy,
            expectedDelentropyArray,
            expectedDelentropy,
            "cosxcosy_tiny_hist_delent.png",
            sgrayCosxCosyTinyDelentropy,
        ),
    ]
    for test in tests
        hist = histogram(ComplexImage(test.grad))
        dent = Delentropy(hist)

        @test dent.hist.height == hist.height
        @test dent.hist.width == hist.width
        @test dent.hist.max == hist.max
        @test test.maxDelentropy == dent.bin_max
        @test test.delentropyArray == dent.bins

        @test dent.entropy ≈ test.delentropy

        histDentImage = render(dent, :histogram)
        checkName = joinpath(TestDir, test.histDelentropyImageName)
        check = load(checkName)
        for (a, b) in zip(histDentImage, check)
            @test value(a) == value(b)
        end

        delentImage = render(dent, :gradient)
        for (a, b) in zip(delentImage, test.delentropyImage)
            @test value(a) == value(b)
        end
    end
end
