
# Description
***This repo contains the final project of the course **Digital Image Processing** of the 8th semester. The purpose of this project was to check if the method of Template Matching works better at a colored image (formats: RGB or YCbCr) or at a grayscale one.***

## Files explanation:
In code files, there are:
* script_rgb.m
* script_ycbcr.m
* Temp_Match_RGB.m
* draw_match.m
* local_max.m

## Results:
For the images which had been chosen, the results showed that:

### In the script_rgb.m file:
* if images are in grayscale, the algorithm can detect the smiley object at the wanted regions. Although the algorithm gives also regions as output, where the smiley object doesn't really exist.
* if images are in RGB format, the algorithm has better results. This happens with the mean method and not with the weight method.

### In the script_ycbcr.m file:
* with bigger weight at the luma component (brightness) the algorithm doesn't succeed so well (ycbcr2).
* with bigger weight at the chroma components (color information) the algorithm succeeds as good as in the rgb script(ycbcr3).   