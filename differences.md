## Design changes

The rewriting of the [original code](https://github.com/Causticity/sipp)
from Go to Julia means that some things which are easy in Go are less easy
in Julia, as well as the reverse. Changes to make everything more like standard
Julia code are as follows:

 - Julia provides easy-to-use multidimensional arrays. For image processing,
   the one-dimensional arrays used in Go have, in most places, been replaced by
   two-dimensional arrays (Julia's `Matrix` type). This is the case for images
   (see next point) as well as for Sipp's data analysis (the `Histogram` types
   use `Matrix` to store data).
 - Packages in [JuliaImages](https://github.com/orgs/JuliaImages) treat an image
   as a `Matrix` of pixels. Although the underlying storage for 8-bit pixels is a
   `UInt8` (and for 16-bit pixels a `UInt16`) the model for computing with pixels
   is a floating point number in the range [0.0, 1.0]. This permits a generalisation
   of most algorithms.
 - Notation for array indexing is different across computer languages and across
   applications.  
   Although the original Go implementation uses 1-dimensional storage,
   the model assumes row-major 2-dimensional arrays, indexed by (x, y) coordinates (which
   is the same as (column, row) coordinates. The indexing of arrays in Go is
   zero based.  
   The current implementation relies on Julia's column-major storage, and indexing using
   (row, column) coordinates: the reverse of the original implementation. In addition,
   Julia's array indexing is one based.
 - The original version saves images with zero-valued pixels in cases where
 a processing step has not been implemented. This implementation does not
 save anything in these cases.
 - The original implementation has an (unfinished) implementation of a `sparseSippHist`
 type, using Go's `map` (the equivalent of Julia's `Dict`) interface.  
 This implementation has a `SparseHistogram` type using a
 [`SparseMatrix`](https://docs.julialang.org/en/v1/stdlib/SparseArrays/).
 Benchmarking shows that this is usually slower than the `FlatHistogram` type
 and only marginally decreases memory requirements.
 - Unit tests in the [test](./test) directory are modifications of the unit tests
 for [sipp](https://github.com/Causticity/sipp). Inline data have been reconfigured
 to match the modified data structures used in this implementation.  
 Some of the inline data representing images and some of the images in the
 [testdata](./test/testdata) have also been changed. Some individual pixels in images
 differ in value by one grey level relative to the original data: conversion from
 floating point values to bytes in the original implementation used truncation; this
 implementation uses nearest-value rounding. Images are only used for qualitative
 information, so these differences are not considered important.
