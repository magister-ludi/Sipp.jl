
#! format: off
const cosxcosyTinyFft = [
-6.0+0.0im 0.0+0.0im 1.618033988749895+6.432881625776282im 0.0+0.0im 2.618033988749895-0.44902797657958615im 0.0+0.0im -0.6180339887498949-6.6043950509300915im 0.0+0.0im 0.3819660112501051+4.9797965697655595im 0.0+0.0im -2.0+0.0im 0.0+0.0im 0.3819660112501051-4.9797965697655595im 0.0+0.0im -0.6180339887498949+6.6043950509300915im 0.0+0.0im 2.618033988749895+0.44902797657958615im 0.0+0.0im 1.618033988749895-6.432881625776282im 0.0+0.0im
0.0+0.0im 5.73266050294879+3.9655787577012136im 0.0+0.0im -8.577627128280994-2.570022922409268im 0.0+0.0im 4.060497472914843-10.79245196208926im 0.0+0.0im -5.591266066100834-0.012486406574207187im 0.0+0.0im 7.495886511675053-5.557536515835409im 0.0+0.0im 2.2360679775010794-6.881909602356245im 0.0+0.0im 5.1649489327391525-2.666045055090495im 0.0+0.0im -7.998847468754418-6.341559150781226im 0.0+0.0im -1.6660450550905201+6.229503485085139im 0.0+0.0im 8.764835310677139+1.9238859367485226im
3.8541019662496847-8.057480106940814im 0.0+0.0im 2.2360679774997894+1.6245984811645324im 0.0+0.0im -3.3819660112501047+4.2532540417602im 0.0+0.0im 3.6180339887498945-1.1755705045849465im 0.0+0.0im 3.5278640450004204+12.310734148701014im 0.0+0.0im 1.381966011250105-3.3551980886010284im 0.0+0.0im -4.23606797749979+9.23305061152576im 0.0+0.0im -1.3819660112501047-1.9021130325903075im 0.0+0.0im -2.854101966249685+3.5267115137548384im 0.0+0.0im -2.7639320225002098+7.053423027509677im 0.0+0.0im
0.0+0.0im -5.094869601436027-7.363627415743853im 0.0+0.0im 5.0008919469614685+3.480534028619176im 0.0+0.0im 10.178475052770501-0.4839100580909341im 0.0+0.0im -10.128599151701406+4.7159209561596im 0.0+0.0im 2.719978035591339-5.647706459585381im 0.0+0.0im -5.411638482084527-8.027807636106559im 0.0+0.0im -2.2360679774997854+1.6245984811645338im 0.0+0.0im 2.6660450550905175-12.698622074110702im 0.0+0.0im -4.458053684715686+11.232848261033226im 0.0+0.0im -1.7734010631007484+6.411638482085072im
0.3819660112501051+2.628655560595668im 0.0+0.0im 3.8541019662496847+1.9021130325903068im 0.0+0.0im -0.34752415750147203-1.069569378312981im 0.0+0.0im -9.23606797749979+5.257311121191336im 0.0+0.0im -2.381966011250103-0.27751455142577486im 0.0+0.0im -4.562305898749054-0.2775145514257753im 0.0+0.0im -9.090169943749473+1.9021130325903068im 0.0+0.0im 0.23606797749978892-2.179627584016083im 0.0+0.0im 1.8885438199983178-9.06153718637195im 0.0+0.0im -8.381966011250105+1.1755705045849463im 0.0+0.0im
0.0+0.0im -12.755062467594591-3.277514551425334im 0.0+0.0im -8.518994490094439+5.5912660661006175im 0.0+0.0im -2.0-8.0im 0.0+0.0im 2.3386546025957067-1.1191301111012617im 0.0+0.0im -1.8974133749038629-2.7224854485746164im 0.0+0.0im 12.620938536936137+5.0948696014349935im 0.0+0.0im 3.795469328063323+5.057480106940792im 0.0+0.0im 10.0+0.0im 0.0+0.0im 12.857006514435408-11.057480106941002im 0.0+0.0im 3.559401350563398-9.567005556434701im
-2.8541019662496847-0.2775145514257753im 0.0+0.0im -3.6180339887498945+1.1755705045849458im 0.0+0.0im 12.47213595499958+2.906170112021443im 0.0+0.0im -2.2360679774997902+6.881909602355869im 0.0+0.0im 3.854101966249684+5.706339097770922im 0.0+0.0im 3.618033988749895+7.330937578935453im 0.0+0.0im -5.618033988749894+2.628655560595668im 0.0+0.0im -7.23606797749979+11.412678195541844im 0.0+0.0im 0.2360679774997898+2.1796275840160826im 0.0+0.0im 1.3819660112501047-1.9021130325903073im 0.0+0.0im
0.0+0.0im 4.516089941908957-3.2965654504144895im 0.0+0.0im 8.892531174201782+8.520147021340158im 0.0+0.0im -1.2342031427713414-2.280021964409276im 0.0+0.0im 7.031976668605138-6.276082318435137im 0.0+0.0im 9.567005556436925-8.816712471755087im 0.0+0.0im 10.537333085600949+4.060497472915017im 0.0+0.0im 0.2053374728119497+8.11467589646806im 0.0+0.0im -1.1381810100900969+2.5182821866117537im 0.0+0.0im -2.2360679774996584-1.6245984811645746im 0.0+0.0im -3.0604974729149275+5.736011568605747im
2.618033988749895+4.2532540417602im 0.0+0.0im -4.76393202250021+8.5065080835204im 0.0+0.0im 2.0901699437494745+1.1755705045849454im 0.0+0.0im -10.618033988749895-1.9021130325903077im 0.0+0.0im -31.65247584249853+22.996869816237496im 0.0+0.0im 15.562305898749054-8.057480106940814im 0.0+0.0im -33.88854381999832-10.857649092690291im 0.0+0.0im -2.854101966249685+1.1755705045849467im 0.0+0.0im -4.618033988749894-8.057480106940814im 0.0+0.0im -4.23606797749979-9.23305061152576im 0.0+0.0im
0.0+0.0im -4.259818534174122-3.2063955066654932im 0.0+0.0im 1.1191301111010779-6.167853480924767im 0.0+0.0im 6.4116384820847365-1.3878879254096894im 0.0+0.0im 11.341559150781181-6.3742489875898665im 0.0+0.0im 12054.234470881485-3918.7611270475163im 0.0+0.0im 12665.487880901226-52.576361779246916im 0.0+0.0im 2.1381810100900647+9.47870044741421im 0.0+0.0im -0.9454244412447408+13.577627128281016im 0.0+0.0im 8.07111904476048+1.1381810100901792im 0.0+0.0im 2.236067977500512+6.8819096023556785im
-2.0+0.0im 0.0+0.0im 0.8541019662496847-3.5267115137548384im 0.0+0.0im 0.4376941012509459+8.057480106940814im 0.0+0.0im -5.854101966249685-5.706339097770921im 0.0+0.0im 20.562305898749052-0.27751455142577464im 0.0+0.0im 51370.0+0.0im 0.0+0.0im 20.562305898749052+0.27751455142577464im 0.0+0.0im -5.854101966249685+5.706339097770921im 0.0+0.0im 0.4376941012509459-8.057480106940814im 0.0+0.0im 0.8541019662496847+3.5267115137548384im 0.0+0.0im
0.0+0.0im 2.236067977500512-6.8819096023556785im 0.0+0.0im 8.07111904476048-1.1381810100901792im 0.0+0.0im -0.9454244412447408-13.577627128281016im 0.0+0.0im 2.1381810100900647-9.47870044741421im 0.0+0.0im 12665.487880901226+52.576361779246916im 0.0+0.0im 12054.234470881485+3918.7611270475163im 0.0+0.0im 11.341559150781181+6.3742489875898665im 0.0+0.0im 6.4116384820847365+1.3878879254096894im 0.0+0.0im 1.1191301111010779+6.167853480924767im 0.0+0.0im -4.259818534174122+3.2063955066654932im
2.618033988749895-4.2532540417602im 0.0+0.0im -4.23606797749979+9.23305061152576im 0.0+0.0im -4.618033988749894+8.057480106940814im 0.0+0.0im -2.854101966249685-1.1755705045849467im 0.0+0.0im -33.88854381999832+10.857649092690291im 0.0+0.0im 15.562305898749054+8.057480106940814im 0.0+0.0im -31.65247584249853-22.996869816237496im 0.0+0.0im -10.618033988749895+1.9021130325903077im 0.0+0.0im 2.0901699437494745-1.1755705045849454im 0.0+0.0im -4.76393202250021-8.5065080835204im 0.0+0.0im
0.0+0.0im -3.0604974729149275-5.736011568605747im 0.0+0.0im -2.2360679774996584+1.6245984811645746im 0.0+0.0im -1.1381810100900969-2.5182821866117537im 0.0+0.0im 0.2053374728119497-8.11467589646806im 0.0+0.0im 10.537333085600949-4.060497472915017im 0.0+0.0im 9.567005556436925+8.816712471755087im 0.0+0.0im 7.031976668605138+6.276082318435137im 0.0+0.0im -1.2342031427713414+2.280021964409276im 0.0+0.0im 8.892531174201782-8.520147021340158im 0.0+0.0im 4.516089941908957+3.2965654504144895im
-2.8541019662496847+0.2775145514257753im 0.0+0.0im 1.3819660112501047+1.9021130325903073im 0.0+0.0im 0.2360679774997898-2.1796275840160826im 0.0+0.0im -7.23606797749979-11.412678195541844im 0.0+0.0im -5.618033988749894-2.628655560595668im 0.0+0.0im 3.618033988749895-7.330937578935453im 0.0+0.0im 3.854101966249684-5.706339097770922im 0.0+0.0im -2.2360679774997902-6.881909602355869im 0.0+0.0im 12.47213595499958-2.906170112021443im 0.0+0.0im -3.6180339887498945-1.1755705045849458im 0.0+0.0im
0.0+0.0im 3.559401350563398+9.567005556434701im 0.0+0.0im 12.857006514435408+11.057480106941002im 0.0+0.0im 10.0+0.0im 0.0+0.0im 3.795469328063323-5.057480106940792im 0.0+0.0im 12.620938536936137-5.0948696014349935im 0.0+0.0im -1.8974133749038629+2.7224854485746164im 0.0+0.0im 2.3386546025957067+1.1191301111012617im 0.0+0.0im -2.0+8.0im 0.0+0.0im -8.518994490094439-5.5912660661006175im 0.0+0.0im -12.755062467594591+3.277514551425334im
0.3819660112501051-2.628655560595668im 0.0+0.0im -8.381966011250105-1.1755705045849463im 0.0+0.0im 1.8885438199983178+9.06153718637195im 0.0+0.0im 0.23606797749978892+2.179627584016083im 0.0+0.0im -9.090169943749473-1.9021130325903068im 0.0+0.0im -4.562305898749054+0.2775145514257753im 0.0+0.0im -2.381966011250103+0.27751455142577486im 0.0+0.0im -9.23606797749979-5.257311121191336im 0.0+0.0im -0.34752415750147203+1.069569378312981im 0.0+0.0im 3.8541019662496847-1.9021130325903068im 0.0+0.0im
0.0+0.0im -1.7734010631007484-6.411638482085072im 0.0+0.0im -4.458053684715686-11.232848261033226im 0.0+0.0im 2.6660450550905175+12.698622074110702im 0.0+0.0im -2.2360679774997854-1.6245984811645338im 0.0+0.0im -5.411638482084527+8.027807636106559im 0.0+0.0im 2.719978035591339+5.647706459585381im 0.0+0.0im -10.128599151701406-4.7159209561596im 0.0+0.0im 10.178475052770501+0.4839100580909341im 0.0+0.0im 5.0008919469614685-3.480534028619176im 0.0+0.0im -5.094869601436027+7.363627415743853im
3.8541019662496847+8.057480106940814im 0.0+0.0im -2.7639320225002098-7.053423027509677im 0.0+0.0im -2.854101966249685-3.5267115137548384im 0.0+0.0im -1.3819660112501047+1.9021130325903075im 0.0+0.0im -4.23606797749979-9.23305061152576im 0.0+0.0im 1.381966011250105+3.3551980886010284im 0.0+0.0im 3.5278640450004204-12.310734148701014im 0.0+0.0im 3.6180339887498945+1.1755705045849465im 0.0+0.0im -3.3819660112501047-4.2532540417602im 0.0+0.0im 2.2360679774997894-1.6245984811645324im 0.0+0.0im
0.0+0.0im 8.764835310677139-1.9238859367485226im 0.0+0.0im -1.6660450550905201-6.229503485085139im 0.0+0.0im -7.998847468754418+6.341559150781226im 0.0+0.0im 5.1649489327391525+2.666045055090495im 0.0+0.0im 2.2360679775010794+6.881909602356245im 0.0+0.0im 7.495886511675053+5.557536515835409im 0.0+0.0im -5.591266066100834+0.012486406574207187im 0.0+0.0im 4.060497472914843+10.79245196208926im 0.0+0.0im -8.577627128280994+2.570022922409268im 0.0+0.0im 5.73266050294879-3.9655787577012136im
]

# The values for cosxcosyTinySpect are *not* the same as the values
# in the original Go version. See notes in ../differences.md
const cosxcosyTinySpect = Gray{N0f8}.([
  46   0  48   0  30   0  48   0  42   0  26   0  42   0  48   0  30   0  48   0
   0  49   0  54   0  59   0  44   0  55   0  50   0  45   0  57   0  47   0  54
  54   0  31   0  44   0  37   0  62   0  36   0  57   0  28   0  40   0  51   0
   0  54   0  46   0  57   0  59   0  47   0  56   0  31   0  62   0  60   0  48
  30   0  39   0  18   0  58   0  29   0  40   0  55   0  27   0  55   0  53   0
   0  62   0  57   0  52   0  30   0  34   0  63   0  47   0  56   0  68   0  57
  32   0  37   0  62   0  50   0  49   0  52   0  46   0  63   0  27   0  28   0
   0  44   0  61   0  30   0  55   0  62   0  59   0  52   0  31   0  31   0  47
  42   0  56   0  29   0  58   0  87   0  69   0  85   0  33   0  55   0  57   0
   0  43   0  47   0  48   0  62   0 222   0 222   0  56   0  63   0  52   0  50
  26   0  36   0  52   0  52   0  72   0 255   0  72   0  52   0  52   0  36   0
   0  50   0  52   0  63   0  56   0 222   0 222   0  62   0  48   0  47   0  43
  42   0  57   0  55   0  33   0  85   0  69   0  87   0  58   0  29   0  56   0
   0  47   0  31   0  31   0  52   0  59   0  62   0  55   0  30   0  61   0  44
  32   0  28   0  27   0  63   0  46   0  52   0  49   0  50   0  62   0  37   0
   0  57   0  68   0  56   0  47   0  63   0  34   0  30   0  52   0  57   0  62
  30   0  53   0  55   0  27   0  55   0  40   0  29   0  58   0  18   0  39   0
   0  48   0  60   0  62   0  31   0  56   0  47   0  59   0  57   0  46   0  54
  54   0  51   0  40   0  28   0  57   0  36   0  62   0  37   0  44   0  31   0
   0  54   0  47   0  57   0  45   0  50   0  55   0  44   0  59   0  54   0  49
] ./ 255)
#! format: on

@testset "Sipp FFT" begin
    fft = FFTImage(cosxCosyTiny)
    @test fft.data.re_min == minimum(v -> real(v), fft.data.pix)
    @test fft.data.re_max == maximum(v -> real(v), fft.data.pix)
    @test fft.data.im_min == minimum(v -> imag(v), fft.data.pix)
    @test fft.data.im_max == maximum(v -> imag(v), fft.data.pix)
    @test fft.data.mod_max == maximum(v -> abs(v), fft.data.pix)

    tol = 1e-10
    for (i, v) in enumerate(fft.data.pix)
        @test v ≈ cosxcosyTinyFft[i] atol = tol
    end
    spect = log_spectrum(fft)
    for (a, b) in zip(spect, cosxcosyTinySpect)
        @test value(a) ≈ value(b)
    end
end
