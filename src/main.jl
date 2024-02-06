
function get_options(args)
    s = ArgParseSettings()
#! format: off
    @add_arg_table! s begin
        "-t"
            help = "save thumbnail image"
            action = :store_true
        "-g"
            help = "save gradient real and imaginary images"
            action = :store_true
        "--ht"
            help = "save histogram image"
            action = :store_true
        "--hs"
            help = "save histogram image with the center spike suppressed"
            action = :store_true
        "--hde"
            help = "save histogram Delentropy image"
            action = :store_true
        "--de"
            help = "save Delentropy image"
            action = :store_true
        "-e"
            help = "save conventional entropy image"
            action = :store_true
        "-f"
            help = "save fft real and imaginary images"
            action = :store_true
        "--fls"
            help = "save fft log spectrum image"
            action = :store_true
        "-a"
            help = "save all images"
            action = :store_true
        "-v"
            help = "verbose mode"
            action = :store_true
        "--csv"
            help = "save the name of the image, a comma, and the Delentropy,on a single line."
            action = :store_true
        "--pre"
            help = "output prefix"
            default = "sipp"
        "inp"
            help = "input image"
            required = true
    end
#! format: on
    opts = parse_args(args, s; as_symbols = true)
    if opts[:a]
        opts[:thb] = true
        opts[:grd] = true
        opts[:hst] = true
        opts[:hsp] = true
        opts[:hde] = true
        opts[:de] = true
        opts[:e] = true
        opts[:f] = true
        opts[:g] = true
        opts[:fls] = true
    end
    return NamedTuple(opts)
end

"""
    sipp(args::AbstractVector{<: AbstractString} = ARGS)

A driver for the rest of the package. For details of the interpretation
of the arguments, run

    Sipp.sipp([])

or read the package `README.md`.
"""
function sipp(args = ARGS)
    start = now()
    if isempty(args)
        # Treat no argument as a cry for help.
        get_options(["-h"])
    end
    options = get_options(args)

    if options.v
        println("input file: <", options.inp, ">")
        println("output file prefix: <", options.pre, ">")
    end

    src = load(options.inp)
    if options.v
        println("source image read")
    end

    if options.thb
        thumb = thumbnail(src)
        if options.v
            println("thumbnail generated")
        end
        tname = options.pre * "_thumb.png"
        save(tname, thumb)
    end

    grad = fdgrad(src)
    if options.v
        println("gradient image computed")
    end
    if options.grd
        re, im = render(grad)
        reName = options.pre * "_grad_real.png"
        save(reName, re)
        imName = options.pre * "_grad_imag.png"
        save(imName, im)
    end
    hist = histogram(grad)

    if options.hst
        rhist = render(hist, false)
        if !isnothing(rhist)
            histName = options.pre * "_hist.png"
            save(histName, rhist)
        end
    end

    if options.hsp
        histSup = render(hist)
        if !isnothing(histSup)
            histSupName = options.pre * "_hist_sup.png"
            save(histSupName, histSup)
        end
    end

    sippDel = Delentropy(hist)
    delentropy = sippDel.entropy / 2.0

    if options.csv
        @printf("%s,%.2f\n", options.inp, delentropy)
    else
        println("Delentropy: ", delentropy)
    end
    if options.hde
        histEntImg = render(sippDel, :histogram)
        if !isnothing(histEntImg)
            histEntName = options.pre * "_hist_delent.png"
            save(histEntName, histEntImg)
        end
    end

    if options.de
        delEntImg = render(sippDel, :gradient)
        if !isnothing(delEntImg)
            delEntName = options.pre * "_delent.png"
            save(delEntName, delEntImg)
        end
    end

    ent = Entropy(src)
    if options.v
        println("Conventional entropy of the source image: ", ent.entropy)
    end

    entImg = render(ent)
    if options.e
        entName = options.pre * "_conv_ent.png"
        save(entName, entImg)
    end

    dft = FFTImage(src)
    if options.v
        println("fft computed")
    end

    if options.f
        re, im = render(dft)
        reName = options.pre * "_fft_real.png"
        imName = options.pre * "_fft_imag.png"
        save(reName, re)
        save(imName, im)
    end

    if options.fls
        ls = log_spectrum(dft)
        println("Log spectrum computed")
        lsName = options.pre * "_fft_spectrum.png"
        save(lsName, ls)
    end

    if options.v
        println("Elapsed time: ", now() - start)
    end
end
