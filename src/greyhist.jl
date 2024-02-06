
"""
    histogram(img::Matrix{<:Gray})

Compute a 1D histogram of the greyscale values in `img`.
Note that the values are offset by one, in order to maintain Julia's
1-based indexing.
"""
function histogram(img::Matrix{<:Gray})
    histSize = 2^bpp(img)
    hist = zeros(UInt32, histSize)
    for pxl in img
        hist[1 + value(pxl)] += 1
    end
    return hist
end
