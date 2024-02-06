
const TestDir = joinpath(@__DIR__, "testdata")

#! format: off
const smallPic = Gray{N0f8}.([
    1  2  3  4
    5  6  7  8
    9 10 11 12
    13 14 15 16
] ./ 255)

const smallPic16 = Gray{N0f16}.([
     1  2  3  4
     5  6  7  8
     9 10 11 12
    13 14 15 16
] ./ 65535)

# Values are stored at n.2 fixed point. As the shift by 2 exactly cancels the
# divide by 4, the fixed-point average is the same as the sum.
const SmallPicRowAverages = Int32[
    0b1010,      # (1+2+3+4)/4 << 2
    0b11010,     # (5+6+7+8)/4 << 2
    0b101010,    # (9+10+11+12)/4 << 2
    0b111010,    # (13+14+15+16)4 << 2
]

const SmallPicColumnAverages = Int32[
    0b11100,     # (1+5+9+13)/4 << 2
    0b100000,    # (2+6+10+14)/4 << 2
    0b100100,    # (3+7+11+15)/4 << 2
    0b101000,    # (4+8+12+16)/4 << 2
]

const cosxCosyTiny = Gray{N0f8}.([
    252 240 217 186 149 109  72  40  17   4   4  17  40  72 109 148 185 217 240 252
    240 229 208 180 146 111  78  49  28  17  17  28  49  77 111 146 179 208 229 240
    217 208 192 169 143 115  88  65  49  40  40  49  65  88 114 142 169 191 208 217
    185 179 169 154 137 119 102  88  78  72  72  78  88 102 119 137 154 169 179 185
    148 146 142 137 131 125 119 115 111 109 109 111 115 119 125 131 137 142 146 148
    109 111 114 119 125 131 137 143 146 149 149 146 143 137 131 125 119 114 111 109
     72  77  87 102 119 137 154 169 180 186 186 180 169 155 137 119 102  88  77  72
     40  48  65  87 114 142 169 192 208 217 217 209 192 169 143 115  88  65  49  40
     17  28  48  77 111 146 179 208 229 240 240 229 209 180 146 111  77  49  28  17
      4  17  40  72 109 148 185 217 240 252 252 240 217 186 149 109  72  40  17   4
      4  17  40  72 109 148 185 217 240 252 252 240 217 186 149 109  72  40  17   4
     17  28  49  77 111 146 179 208 229 240 240 229 208 180 146 111  78  49  28  17
     40  49  65  88 114 142 169 191 208 217 217 208 192 169 143 115  88  65  49  40
     72  78  88 102 119 137 154 169 179 185 185 179 169 154 137 119 102  88  78  72
    109 111 115 119 125 131 137 142 146 148 148 146 142 137 131 125 119 115 111 109
    149 146 143 137 131 125 119 114 111 109 109 111 114 119 125 131 137 143 146 149
    186 180 169 155 137 119 102  88  77  72  72  77  87 102 119 137 154 169 180 186
    217 209 192 169 143 115  88  65  49  40  40  48  65  87 114 142 169 192 208 217
    240 229 209 180 146 111  77  49  28  17  17  28  48  77 111 146 179 208 229 240
    252 240 217 186 149 109  72  40  17   4   4  17  40  72 109 148 185 217 240 252
] ./ 255)

const CosxCosyTinyGradInt32 = Complex{Int32}[
    complex(-23, 0) complex(-32, -12) complex(-37, -22) complex(-40, -31) complex(-38, -37) complex(-31, -39) complex(-23, -38) complex(-12, -32) complex(0, -24) complex(13, -13) complex(24, 0) complex(32, 12) complex(37, 23) complex(39, 32) complex(37, 37) complex(31, 39) complex(23, 38) complex(12, 32) complex(0, 23)
    complex(-32, 12) complex(-37, 0) complex(-39, -12) complex(-37, -23) complex(-31, -32) complex(-23, -37) complex(-13, -39) complex(0, -37) complex(12, -32) complex(23, -23) complex(32, -12) complex(37, 0) complex(39, 12) complex(37, 23) complex(31, 32) complex(23, 37) complex(12, 39) complex(0, 38) complex(-12, 32)
    complex(-38, 23) complex(-39, 13) complex(-38, 0) complex(-32, -11) complex(-24, -22) complex(-13, -31) complex(0, -37) complex(13, -39) complex(23, -38) complex(32, -32) complex(38, -23) complex(39, -13) complex(37, 0) complex(31, 12) complex(23, 23) complex(12, 32) complex(0, 37) complex(-12, 39) complex(-23, 38)
    complex(-39, 31) complex(-37, 23) complex(-32, 12) complex(-23, 0) complex(-12, -12) complex(0, -23) complex(13, -31) complex(23, -37) complex(31, -39) complex(37, -37) complex(39, -31) complex(37, -23) complex(31, -13) complex(23, 0) complex(12, 12) complex(0, 23) complex(-12, 32) complex(-23, 37) complex(-31, 39)
    complex(-37, 37) complex(-32, 31) complex(-23, 23) complex(-12, 12) complex(0, 0) complex(12, -12) complex(24, -22) complex(31, -32) complex(38, -37) complex(40, -40) complex(37, -38) complex(32, -31) complex(22, -24) complex(12, -12) complex(0, 0) complex(-12, 12) complex(-23, 23) complex(-31, 32) complex(-37, 37)
    complex(-32, 39) complex(-24, 37) complex(-12, 32) complex(0, 23) complex(12, 12) complex(23, 0) complex(32, -11) complex(37, -23) complex(40, -31) complex(37, -37) complex(31, -40) complex(23, -37) complex(12, -32) complex(0, -24) complex(-12, -12) complex(-23, 0) complex(-31, 12) complex(-37, 23) complex(-39, 32)
    complex(-24, 37) complex(-12, 39) complex(0, 37) complex(12, 32) complex(23, 23) complex(32, 12) complex(38, 0) complex(39, -12) complex(37, -22) complex(31, -31) complex(23, -37) complex(12, -40) complex(0, -37) complex(-12, -32) complex(-22, -24) complex(-31, -13) complex(-37, 0) complex(-39, 12) complex(-37, 23)
    complex(-12, 31) complex(0, 37) complex(12, 39) complex(24, 37) complex(32, 31) complex(37, 23) complex(39, 13) complex(37, 0) complex(32, -12) complex(23, -23) complex(12, -31) complex(0, -37) complex(-12, -40) complex(-23, -37) complex(-32, -31) complex(-38, -23) complex(-39, -12) complex(-37, 0) complex(-32, 12)
    complex(0, 24) complex(12, 31) complex(24, 37) complex(32, 39) complex(37, 37) complex(39, 31) complex(38, 23) complex(32, 12) complex(23, 0) complex(12, -12) complex(0, -23) complex(-12, -31) complex(-23, -37) complex(-31, -40) complex(-37, -38) complex(-39, -32) complex(-37, -23) complex(-32, -12) complex(-24, 0)
    complex(13, 13) complex(23, 23) complex(32, 32) complex(37, 37) complex(39, 39) complex(37, 37) complex(32, 32) complex(23, 23) complex(12, 12) complex(0, 0) complex(-12, -12) complex(-23, -23) complex(-31, -31) complex(-37, -37) complex(-40, -40) complex(-37, -37) complex(-32, -32) complex(-23, -23) complex(-13, -13)
    complex(24, 0) complex(32, 12) complex(37, 23) complex(39, 32) complex(37, 37) complex(31, 39) complex(23, 38) complex(12, 32) complex(0, 23) complex(-12, 12) complex(-23, 0) complex(-32, -12) complex(-37, -22) complex(-40, -31) complex(-38, -37) complex(-31, -39) complex(-23, -38) complex(-12, -32) complex(0, -24)
    complex(32, -12) complex(37, 0) complex(39, 12) complex(37, 23) complex(31, 32) complex(23, 37) complex(12, 39) complex(0, 38) complex(-12, 32) complex(-23, 23) complex(-32, 12) complex(-37, 0) complex(-39, -12) complex(-37, -23) complex(-31, -32) complex(-23, -37) complex(-13, -39) complex(0, -37) complex(12, -32)
    complex(38, -23) complex(39, -13) complex(37, 0) complex(31, 12) complex(23, 23) complex(12, 32) complex(0, 37) complex(-12, 39) complex(-23, 38) complex(-32, 32) complex(-38, 23) complex(-39, 13) complex(-38, 0) complex(-32, -11) complex(-24, -22) complex(-13, -31) complex(0, -37) complex(13, -39) complex(23, -38)
    complex(39, -31) complex(37, -23) complex(31, -13) complex(23, 0) complex(12, 12) complex(0, 23) complex(-12, 32) complex(-23, 37) complex(-31, 39) complex(-37, 37) complex(-39, 31) complex(-37, 23) complex(-32, 12) complex(-23, 0) complex(-12, -12) complex(0, -23) complex(13, -31) complex(23, -37) complex(31, -39)
    complex(37, -38) complex(32, -31) complex(22, -24) complex(12, -12) complex(0, 0) complex(-12, 12) complex(-23, 23) complex(-31, 32) complex(-37, 37) complex(-39, 39) complex(-37, 37) complex(-32, 31) complex(-23, 23) complex(-12, 12) complex(0, 0) complex(12, -12) complex(24, -22) complex(31, -32) complex(38, -37)
    complex(31, -40) complex(23, -37) complex(12, -32) complex(0, -24) complex(-12, -12) complex(-23, 0) complex(-31, 12) complex(-37, 23) complex(-39, 32) complex(-37, 37) complex(-32, 39) complex(-24, 37) complex(-12, 32) complex(0, 23) complex(12, 12) complex(23, 0) complex(32, -11) complex(37, -23) complex(40, -31)
    complex(23, -37) complex(12, -40) complex(0, -37) complex(-12, -32) complex(-22, -24) complex(-31, -13) complex(-37, 0) complex(-39, 12) complex(-37, 23) complex(-32, 32) complex(-24, 37) complex(-12, 39) complex(0, 37) complex(12, 32) complex(23, 23) complex(32, 12) complex(38, 0) complex(39, -12) complex(37, -22)
    complex(12, -31) complex(0, -37) complex(-12, -40) complex(-23, -37) complex(-32, -31) complex(-38, -23) complex(-39, -12) complex(-37, 0) complex(-32, 12) complex(-23, 23) complex(-12, 31) complex(0, 37) complex(12, 39) complex(24, 37) complex(32, 31) complex(37, 23) complex(39, 13) complex(37, 0) complex(32, -12)
    complex(0, -23) complex(-12, -31) complex(-23, -37) complex(-31, -40) complex(-37, -38) complex(-39, -32) complex(-37, -23) complex(-32, -12) complex(-24, 0) complex(-13, 13) complex(0, 24) complex(12, 31) complex(24, 37) complex(32, 39) complex(37, 37) complex(39, 31) complex(38, 23) complex(32, 12) complex(23, 0)
]

const CosxCosyTinyGrad = ComplexF64[
    (-23+0im) (-32-12im) (-37-22im) (-40-31im) (-38-37im) (-31-39im) (-23-38im) (-12-32im) ( 0-24im) ( 13-13im) ( 24+0im) ( 32+12im) ( 37+23im) ( 39+32im) ( 37+37im) ( 31+39im) ( 23+38im) ( 12+32im) ( 0+23im)
    (-32+12im) (-37+0im) (-39-12im) (-37-23im) (-31-32im) (-23-37im) (-13-39im) ( 0-37im) ( 12-32im) ( 23-23im) ( 32-12im) ( 37+0im) ( 39+12im) ( 37+23im) ( 31+32im) ( 23+37im) ( 12+39im) ( 0+38im) (-12+32im)
    (-38+23im) (-39+13im) (-38+0im) (-32-11im) (-24-22im) (-13-31im) ( 0-37im) ( 13-39im) ( 23-38im) ( 32-32im) ( 38-23im) ( 39-13im) ( 37+0im) ( 31+12im) ( 23+23im) ( 12+32im) ( 0+37im) (-12+39im) (-23+38im)
    (-39+31im) (-37+23im) (-32+12im) (-23+0im) (-12-12im) ( 0-23im) ( 13-31im) ( 23-37im) ( 31-39im) ( 37-37im) ( 39-31im) ( 37-23im) ( 31-13im) ( 23+0im) ( 12+12im) ( 0+23im) (-12+32im) (-23+37im) (-31+39im)
    (-37+37im) (-32+31im) (-23+23im) (-12+12im) ( 0+0im) ( 12-12im) ( 24-22im) ( 31-32im) ( 38-37im) ( 40-40im) ( 37-38im) ( 32-31im) ( 22-24im) ( 12-12im) ( 0+0im) (-12+12im) (-23+23im) (-31+32im) (-37+37im)
    (-32+39im) (-24+37im) (-12+32im) ( 0+23im) ( 12+12im) ( 23+0im) ( 32-11im) ( 37-23im) ( 40-31im) ( 37-37im) ( 31-40im) ( 23-37im) ( 12-32im) ( 0-24im) (-12-12im) (-23+0im) (-31+12im) (-37+23im) (-39+32im)
    (-24+37im) (-12+39im) ( 0+37im) ( 12+32im) ( 23+23im) ( 32+12im) ( 38+0im) ( 39-12im) ( 37-22im) ( 31-31im) ( 23-37im) ( 12-40im) ( 0-37im) (-12-32im) (-22-24im) (-31-13im) (-37+0im) (-39+12im) (-37+23im)
    (-12+31im) ( 0+37im) ( 12+39im) ( 24+37im) ( 32+31im) ( 37+23im) ( 39+13im) ( 37+0im) ( 32-12im) ( 23-23im) ( 12-31im) ( 0-37im) (-12-40im) (-23-37im) (-32-31im) (-38-23im) (-39-12im) (-37+0im) (-32+12im)
    ( 0+24im) ( 12+31im) ( 24+37im) ( 32+39im) ( 37+37im) ( 39+31im) ( 38+23im) ( 32+12im) ( 23+0im) ( 12-12im) ( 0-23im) (-12-31im) (-23-37im) (-31-40im) (-37-38im) (-39-32im) (-37-23im) (-32-12im) (-24+0im)
    ( 13+13im) ( 23+23im) ( 32+32im) ( 37+37im) ( 39+39im) ( 37+37im) ( 32+32im) ( 23+23im) ( 12+12im) ( 0+0im) (-12-12im) (-23-23im) (-31-31im) (-37-37im) (-40-40im) (-37-37im) (-32-32im) (-23-23im) (-13-13im)
    ( 24+0im) ( 32+12im) ( 37+23im) ( 39+32im) ( 37+37im) ( 31+39im) ( 23+38im) ( 12+32im) ( 0+23im) (-12+12im) (-23+0im) (-32-12im) (-37-22im) (-40-31im) (-38-37im) (-31-39im) (-23-38im) (-12-32im) ( 0-24im)
    ( 32-12im) ( 37+0im) ( 39+12im) ( 37+23im) ( 31+32im) ( 23+37im) ( 12+39im) ( 0+38im) (-12+32im) (-23+23im) (-32+12im) (-37+0im) (-39-12im) (-37-23im) (-31-32im) (-23-37im) (-13-39im) ( 0-37im) ( 12-32im)
    ( 38-23im) ( 39-13im) ( 37+0im) ( 31+12im) ( 23+23im) ( 12+32im) ( 0+37im) (-12+39im) (-23+38im) (-32+32im) (-38+23im) (-39+13im) (-38+0im) (-32-11im) (-24-22im) (-13-31im) ( 0-37im) ( 13-39im) ( 23-38im)
    ( 39-31im) ( 37-23im) ( 31-13im) ( 23+0im) ( 12+12im) ( 0+23im) (-12+32im) (-23+37im) (-31+39im) (-37+37im) (-39+31im) (-37+23im) (-32+12im) (-23+0im) (-12-12im) ( 0-23im) ( 13-31im) ( 23-37im) ( 31-39im)
    ( 37-38im) ( 32-31im) ( 22-24im) ( 12-12im) ( 0+0im) (-12+12im) (-23+23im) (-31+32im) (-37+37im) (-39+39im) (-37+37im) (-32+31im) (-23+23im) (-12+12im) ( 0+0im) ( 12-12im) ( 24-22im) ( 31-32im) ( 38-37im)
    ( 31-40im) ( 23-37im) ( 12-32im) ( 0-24im) (-12-12im) (-23+0im) (-31+12im) (-37+23im) (-39+32im) (-37+37im) (-32+39im) (-24+37im) (-12+32im) ( 0+23im) ( 12+12im) ( 23+0im) ( 32-11im) ( 37-23im) ( 40-31im)
    ( 23-37im) ( 12-40im) ( 0-37im) (-12-32im) (-22-24im) (-31-13im) (-37+0im) (-39+12im) (-37+23im) (-32+32im) (-24+37im) (-12+39im) ( 0+37im) ( 12+32im) ( 23+23im) ( 32+12im) ( 38+0im) ( 39-12im) ( 37-22im)
    ( 12-31im) ( 0-37im) (-12-40im) (-23-37im) (-32-31im) (-38-23im) (-39-12im) (-37+0im) (-32+12im) (-23+23im) (-12+31im) ( 0+37im) ( 12+39im) ( 24+37im) ( 32+31im) ( 37+23im) ( 39+13im) ( 37+0im) ( 32-12im)
    ( 0-23im) (-12-31im) (-23-37im) (-31-40im) (-37-38im) (-39-32im) (-37-23im) (-32-12im) (-24+0im) (-13+13im) ( 0+24im) ( 12+31im) ( 24+37im) ( 32+39im) ( 37+37im) ( 39+31im) ( 38+23im) ( 32+12im) ( 23+0im)
]
#! format: on

const CosxCosyTinyGradMaxMod = 56.568542494923804
const CosxCosyTinyGradMaxRe = 40.0
const CosxCoxyTinyGradMinRe = -40.0
const CosxCosyTinyGradMaxIm = 39.0
const CosxCosyTinyGradMinIm = -40.0

const CosxCosyTinyStride = 20
const CosxCosyTinyMaxReExc = 40
const CosxCosyTinyMaxImExc = 40
const CosxCosyTinyMaxExcursion = 40
