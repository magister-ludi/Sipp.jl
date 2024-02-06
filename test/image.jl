
@testset "Images" begin
    @testset "Image load" begin
        # Read a file that doesn't exist
        @test_throws ArgumentError read_image("blahblah")

        # Read a file that exists but isn't an image
        @test_throws ErrorException read_image(joinpath(TestDir, "README"))

        # Read a file that isn't gray
        img = read_image(joinpath(TestDir, "mandrill.png"))
        @test eltype(img) <: Gray
    end

    @testset "8-bit image" begin
        barb = read_image(joinpath(TestDir, "barbara.png"))
        @test eltype(barb) <: Gray{N0f8}
        @test bpp(barb) == 8

        # thumbnail
        thm = thumbnail(barb)
        name = joinpath(TestDir, "barb_thumb.png")
        gold = read_image(name)
        @test thm == gold
    end

    @testset "16-bit image" begin
        cc = read_image(joinpath(TestDir, "cosxcosy.png"))
        @test eltype(cc) <: Gray{N0f16}
        @test bpp(cc) == 16

        # thumbnail
        thm = thumbnail(cc)
        name = joinpath(TestDir, "cosxcosy_thumb.png")
        gold = read_image(name)
        @test thm == gold
    end
end
