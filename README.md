# HoleFilling-Light
Small image processing library that fills holes in images, 
along with a small command line utility that uses that library

# Command line utility
A command line utility that accepts an input image file(s), π§, Ξ΅ and connectivity type.
Example:
β«οΈ  ImagePath: /Users/../Lenna.png
β«οΈ  MaskPath: /Users/../Mask.png
β«οΈ  Zeta: 3.0
β«οΈ  Espsilon: 0.01
β«οΈ  ImageModifiedPath: /Users/../pictureFilled.png

# Questions
1. If there are π boundary pixels and π pixels inside the hole, whatβs the complexity of the algorithm that fills the hole,
assuming that the hole and boundary were already found? Try to also express the complexity only in terms of π.

   O(n*m)
   O(n^2) the boundary is determined by the hole for large n we will get m < n

2. Describe an algorithm that approximates the result in π(π) to a high degree of accuracy.
Bonus: implement the suggested algorithm in your library in addition to the algorithm described above.


   We need to apply the holeFilling process into each pixel by iterating over all pixels into the hole.
   So we will not use all the boundary per hole pixel only the connected pixels depending on the connectivity 
