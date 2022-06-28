# HoleFilling-Light
Small image processing library that fills holes in images, 
along with a small command line utility that uses that library

# Command line utility
A command line utility that accepts an input image file(s), 𝑧, ε and connectivity type.
Example:
▫️  ImagePath: /Users/../Lenna.png
▫️  MaskPath: /Users/../Mask.png
▫️  Zeta: 3.0
▫️  Espsilon: 0.01
▫️  ImageModifiedPath: /Users/../pictureFilled.png

# Questions
1. If there are 𝑚 boundary pixels and 𝑛 pixels inside the hole, what’s the complexity of the algorithm that fills the hole,
assuming that the hole and boundary were already found? Try to also express the complexity only in terms of 𝑛.

   O(n*m)
   O(n^2) the boundary is determined by the hole for large n we will get m < n

2. Describe an algorithm that approximates the result in 𝑂(𝑛) to a high degree of accuracy.
Bonus: implement the suggested algorithm in your library in addition to the algorithm described above.


   We need to apply the holeFilling process into each pixel by iterating over all pixels into the hole.
   So we will not use all the boundary per hole pixel only the connected pixels depending on the connectivity 
