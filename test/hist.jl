
# BinPair is not exported
const BinPair = Sipp.BinPair

#! format: off
const cosxCosyTinyBinIndex = [
 (41, 18) (29, 9) (19, 4) (10, 1) (4, 3) (2, 10) (3, 18) (9, 29) (17, 41) (28, 54) (41, 65) (53, 73) (64, 78) (73, 80) (78, 78) (80, 72) (79, 64) (73, 53) (64, 41)
 (53, 9) (41, 4) (29, 2) (18, 4) (9, 10) (4, 18) (2, 28) (4, 41) (9, 53) (18, 64) (29, 73) (41, 78) (53, 80) (64, 78) (73, 72) (78, 64) (80, 53) (79, 41) (73, 29)
 (64, 3) (54, 2) (41, 3) (30, 9) (19, 17) (10, 28) (4, 41) (2, 54) (3, 64) (9, 73) (18, 79) (28, 80) (41, 78) (53, 72) (64, 64) (73, 53) (78, 41) (80, 29) (79, 18)
 (72, 2) (64, 4) (53, 9) (41, 18) (29, 29) (18, 41) (10, 54) (4, 64) (2, 72) (4, 78) (10, 80) (18, 78) (28, 72) (41, 64) (53, 53) (64, 41) (73, 29) (78, 18) (80, 10)
 (78, 4) (72, 9) (64, 18) (53, 29) (41, 41) (29, 53) (19, 65) (9, 72) (4, 79) (1, 81) (3, 78) (10, 73) (17, 63) (29, 53) (41, 41) (53, 29) (64, 18) (73, 10) (78, 4)
 (80, 9) (78, 17) (73, 29) (64, 41) (53, 53) (41, 64) (30, 73) (18, 78) (10, 81) (4, 78) (1, 72) (4, 64) (9, 53) (17, 41) (29, 29) (41, 18) (53, 10) (64, 4) (73, 2)
 (78, 17) (80, 29) (78, 41) (73, 53) (64, 64) (53, 73) (41, 79) (29, 80) (19, 78) (10, 72) (4, 64) (1, 53) (4, 41) (9, 29) (17, 19) (28, 10) (41, 4) (53, 2) (64, 4)
 (72, 29) (78, 41) (80, 53) (78, 65) (72, 73) (64, 78) (54, 80) (41, 78) (29, 73) (18, 64) (10, 53) (4, 41) (1, 29) (4, 18) (10, 9) (18, 3) (29, 2) (41, 4) (53, 9)
 (65, 41) (72, 53) (78, 65) (80, 73) (78, 78) (72, 80) (64, 79) (53, 73) (41, 64) (29, 53) (18, 41) (10, 29) (4, 18) (1, 10) (3, 4) (9, 2) (18, 4) (29, 9) (41, 17)
 (54, 54) (64, 64) (73, 73) (78, 78) (80, 80) (78, 78) (73, 73) (64, 64) (53, 53) (41, 41) (29, 29) (18, 18) (10, 10) (4, 4) (1, 1) (4, 4) (9, 9) (18, 18) (28, 28)
 (41, 65) (53, 73) (64, 78) (73, 80) (78, 78) (80, 72) (79, 64) (73, 53) (64, 41) (53, 29) (41, 18) (29, 9) (19, 4) (10, 1) (4, 3) (2, 10) (3, 18) (9, 29) (17, 41)
 (29, 73) (41, 78) (53, 80) (64, 78) (73, 72) (78, 64) (80, 53) (79, 41) (73, 29) (64, 18) (53, 9) (41, 4) (29, 2) (18, 4) (9, 10) (4, 18) (2, 28) (4, 41) (9, 53)
 (18, 79) (28, 80) (41, 78) (53, 72) (64, 64) (73, 53) (78, 41) (80, 29) (79, 18) (73, 9) (64, 3) (54, 2) (41, 3) (30, 9) (19, 17) (10, 28) (4, 41) (2, 54) (3, 64)
 (10, 80) (18, 78) (28, 72) (41, 64) (53, 53) (64, 41) (73, 29) (78, 18) (80, 10) (78, 4) (72, 2) (64, 4) (53, 9) (41, 18) (29, 29) (18, 41) (10, 54) (4, 64) (2, 72)
 (3, 78) (10, 73) (17, 63) (29, 53) (41, 41) (53, 29) (64, 18) (73, 10) (78, 4) (80, 2) (78, 4) (72, 9) (64, 18) (53, 29) (41, 41) (29, 53) (19, 65) (9, 72) (4, 79)
 (1, 72) (4, 64) (9, 53) (17, 41) (29, 29) (41, 18) (53, 10) (64, 4) (73, 2) (78, 4) (80, 9) (78, 17) (73, 29) (64, 41) (53, 53) (41, 64) (30, 73) (18, 78) (10, 81)
 (4, 64) (1, 53) (4, 41) (9, 29) (17, 19) (28, 10) (41, 4) (53, 2) (64, 4) (73, 9) (78, 17) (80, 29) (78, 41) (73, 53) (64, 64) (53, 73) (41, 79) (29, 80) (19, 78)
 (10, 53) (4, 41) (1, 29) (4, 18) (10, 9) (18, 3) (29, 2) (41, 4) (53, 9) (64, 18) (72, 29) (78, 41) (80, 53) (78, 65) (72, 73) (64, 78) (54, 80) (41, 78) (29, 73)
 (18, 41) (10, 29) (4, 18) (1, 10) (3, 4) (9, 2) (18, 4) (29, 9) (41, 17) (54, 28) (65, 41) (72, 53) (78, 65) (80, 73) (78, 78) (72, 80) (64, 79) (53, 73) (41, 64)
]

const expectedCosxCosyTinyNonZeroHistCount = 127

const cosxCosyTinyBinVals = [
    6, 6, 2, 2, 6, 2, 4, 2, 2, 1, 2, 4, 2, 2, 2,
    2, 6, 2, 4, 4, 6, 2, 6, 2, 4, 4, 6, 2, 6, 6,
    6, 2, 4, 2, 6, 2, 8, 2, 2, 4, 2, 6, 6, 6, 6,
    4, 4, 2, 6, 2, 6, 2, 2, 4, 8, 2, 6, 2, 4, 2,
    6, 5, 6, 6, 4, 2, 6, 2, 6, 2, 6, 5, 4, 4, 6,
    2, 2, 2, 2, 5, 5, 5, 6, 2, 6, 1, 6, 2, 6, 5,
    5, 5, 2, 2, 2, 2, 6, 2, 4, 5, 6, 6, 6, 2, 6,
    2, 2, 6, 6, 5, 6, 2, 2, 2, 2, 2, 8, 2, 2, 2,
    2, 2, 2, 2, 2, 4, 6, 6, 6, 2, 6, 4, 4, 4, 8,
    2, 6, 2, 4, 2, 6, 6, 6, 6, 2, 4, 2, 2, 6, 2,
    6, 4, 4, 4, 2, 2, 2, 2, 2, 4, 6, 5, 6, 6, 2,
    2, 6, 2, 6, 6, 2, 1, 2, 1, 2, 1, 2, 1, 2, 5,
    5, 5, 6, 2, 6, 1, 6, 2, 6, 1, 2, 4, 2, 2, 2,
    2, 6, 2, 4, 5, 6, 6, 2, 2, 6, 2, 4, 2, 2, 6,
    6, 2, 4, 2, 6, 2, 8, 2, 2, 4, 6, 2, 6, 2, 4,
    4, 6, 2, 6, 2, 6, 2, 2, 4, 8, 2, 6, 1, 2, 4,
    2, 6, 6, 6, 6, 4, 4, 2, 6, 2, 6, 5, 4, 4, 6,
    2, 2, 2, 4, 2, 6, 5, 6, 6, 4, 2, 6, 2, 6, 5,
    5, 5, 2, 2, 2, 1, 2, 2, 2, 5, 5, 5, 6, 2, 6,
    2, 2, 6, 6, 5, 6, 2, 2, 2, 2, 2, 6, 2, 4, 5,
    6, 6, 6, 2, 2, 4, 6, 6, 6, 2, 6, 4, 4, 1, 2,
    2, 8, 2, 2, 2, 2, 2, 2, 6, 2, 4, 2, 2, 6, 2,
    6, 4, 2, 4, 8, 2, 6, 2, 4, 2, 6, 6, 6, 6, 2,
    2, 6, 2, 6, 6, 2, 1, 4, 4, 2, 2, 2, 2, 2, 4, 6,
]
#! format: on

const cosxCosyTinyBins =
    [BinPair(1, 12), BinPair(2, 78), BinPair(4, 13), BinPair(6, 18), BinPair(5, 5), BinPair(8, 1)]

const cosxCosyTinyInvertedBins = Dict(1 => 1, 2 => 2, 4 => 3, 6 => 4, 5 => 5, 8 => 6)

const cosxCosyTinyHistWidth = CosxCosyTinyMaxReExc * 2 + 1
const cosxCosyTinyHistHeight = CosxCosyTinyMaxImExc * 2 + 1

const expectedMax = 8

# Invert the bins to be black on white.
function blackToWhite(bins::AbstractVector{BinPair}, max)
    white = Vector{Gray{N0f8}}(undef, length(bins))
    scale = 1 / max
    for (i, bin) in enumerate(bins)
        white[i] = (max - bin.value) * scale
    end
    zero = one(Gray{N0f8})
    return white, zero
end

# First test the 1D histogram

# 1st entry is 0, then next 16 entries should have a 1, all others 0
function checkHist(hist::AbstractVector{<:Integer})
    for (i, val) in enumerate(hist)
        check = 1 < i < 18 ? 1 : 0
        @test val == check
    end
end

@testset "Grey Histogram" begin
    hist = histogram(smallPic)
    checkHist(hist)
    hist = histogram(smallPic16)
    checkHist(hist)
end

# Next test the two 2D histograms.

@testset "2D histograms" begin
    struct CoreHistTest
        grad::Matrix{ComplexF64}
        max_range::Int
        width::Int
        height::Int
    end

    coreTests = [
        CoreHistTest(
            CosxCosyTinyGrad,
            CosxCosyTinyMaxExcursion,
            cosxCosyTinyHistWidth,
            cosxCosyTinyHistHeight,
        ),
    ]

    for test in coreTests
        grad = ComplexImage(test.grad)
        maxEx, width, height = Sipp.compute_hist_size(grad)
        @test maxEx == test.max_range
        @test width == test.width
        @test height == test.height
    end

    struct SupScaleTest
        x::Int
        y::Int
        cx::Float64
        cy::Float64
        md::Float64
        exp::Float64
    end

    # TODO: These could probably be improved
    supScaleTests = [
        SupScaleTest(10, 0, 0, 0, 100, 0.1),
        SupScaleTest(0, 10, 0, 0, 100, 0.1),
        SupScaleTest(10, 10, 0, 0, 100, 0.1414),
        SupScaleTest(-10, -10, 0, 0, 100, 0.1414),
        SupScaleTest(20, 20, 10, 10, 100, 0.1414),
    ]
    epsilon = 0.0001
    for test in supScaleTests
        scale = Sipp.supScale(test.x, test.y, test.cx, test.cy, test.md)
        @test test.exp ≈ scale atol = epsilon
    end
end

struct BinIndexTest
    # grad pixel coords and the expected histogram value
    x::Int
    y::Int
    binval::UInt32
end

@testset "Flat Histogram" begin

    struct FlatHistTest
        grad_img::Matrix{ComplexF64}
        width::Int
        height::Int
        maxMod::Float64
        count::Int
        binIndex::Matrix{NTuple{2, Int}}
        binVals::Vector{UInt32}
        bins::Vector{Sipp.BinPair}
        maxBinVal::UInt32
        binTests::Vector{BinIndexTest}
        suppressedImageName::String
        renderedHistogramName::String
        renderedScaledHistogramName::String
        substituedImageName::String
        invertedBins::Dict{UInt32, Int}
    end

    flatTests = [
        FlatHistTest(
            CosxCosyTinyGrad,
            cosxCosyTinyHistWidth,
            cosxCosyTinyHistHeight,
            CosxCosyTinyGradMaxMod,
            expectedCosxCosyTinyNonZeroHistCount,
            cosxCosyTinyBinIndex,
            cosxCosyTinyBinVals,
            cosxCosyTinyBins,
            expectedMax,
            [BinIndexTest(10, 1, 1), BinIndexTest(12, 4, 4), BinIndexTest(2, 18, 8)],
            "cosxcosy_tiny_hist_sup.png",
            "cosxcosy_tiny_hist.png",
            "cosxcosy_tiny_hist_scaled.png",
            "cosxcosy_tiny_hist_white.png",
            cosxCosyTinyInvertedBins,
        ),
    ]

    for test in flatTests
        # Test core API
        grad_img = ComplexImage(test.grad_img)
        hist = histogram(grad_img)
        @test hist isa Sipp.FlatHistogram
        @test gradient(hist) == grad_img
        height, width = size(hist)
        @test width == test.width
        @test height == test.height
        @test max(hist) == test.maxBinVal

        # Check internal variables
        bincount = count(!=(0), hist.binned_data)
        @test bincount == test.count
        @test all(hist.binIndex .== test.binIndex)

        for (i, (r, c)) in enumerate(hist.binIndex)
            @test hist.binned_data[r, c] == test.binVals[i]
        end

        numPix = length(gradient(hist).pix)
        totalBins = sum(hist.binned_data)
        @test totalBins == numPix

        Sipp.generate_inverted_bins!(hist.invertedBins, hist.bins)
        @test sort(collect(keys(test.invertedBins))) == sort(collect(keys(hist.invertedBins)))
        for (k, v) in test.invertedBins
            @test hist.invertedBins[k] == v
        end

        @test hist.bins == test.bins
        totalBins = 0
        for binVal in hist.bins
            totalBins += binVal.value * binVal.count
        end
        @test totalBins == numPix

        for btest in test.binTests
            index = Sipp.bin_for_pixel(hist, btest.y, btest.x)
            binval = hist.bins[index]
            @test binval.value == btest.binval
        end

        rnd = render(hist, true)
        checkName = joinpath(TestDir, test.renderedHistogramName)
        check = load(checkName)
        for (a, b) in zip(rnd, check)
            @test value(a) == value(b)
        end

        rnd = render(hist, false)
        checkName = joinpath(TestDir, test.renderedScaledHistogramName)
        check = load(checkName)
        for (a, b) in zip(rnd, check)
            @test value(a) == value(b)
        end

        supp = render(hist)
        checkName = joinpath(TestDir, test.suppressedImageName)
        check = load(checkName)
        for (a, b) in zip(supp, check)
            @test value(a) == value(b)
        end

        whiteBins, zero = blackToWhite(hist.bins, hist.max)
        subst = render(hist, whiteBins, zero)
        checkName = joinpath(TestDir, test.substituedImageName)
        check = load(checkName)
        for (a, b) in zip(subst, check)
            @test value(a) == value(b)
        end
    end
end
