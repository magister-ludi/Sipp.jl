## TODO list (in no particular order)

 - Convert all images to 8-bit representation on load;
 internal handling of 16-bit images will be dropped
 - Add loading and processing of coloured images by
    - converting the image to 8-bit grey pixels, or
    - apply processing to (converted) 8-bit colour channels.
 - Remove the `SparseHistogram` type. In its current form it
 doesn't provide any benefit; in the original implementation,
 it is not actually used.
 - Remove the restriction on the size of output images. Conversion
 to 8 bit resolution will mitigate that, but if necessary, other
 options are
    - generate the full image
    - save the image to disk as it is generated
    - generate tiles.
