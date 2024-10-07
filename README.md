# Template Matching: RGB vs Grayscale

This repository contains the final project for the **Digital Image Processing** course, taken during the 8th semester at EECE, DUTh. The purpose of this project was to evaluate whether the **Template Matching** method works more effectively on colored images (in **RGB** or **YCbCr** formats) or on grayscale images.

## Files Overview

The repository includes the following MATLAB scripts:

- **`script_rgb.m`**: Applies the template matching method on RGB and grayscale images.
- **`script_ycbcr.m`**: Applies the template matching method on YCbCr format images with varying weights on luma and chroma components.
- **`Temp_Match_RGB.m`**: Contains the core function for performing template matching on RGB images.
- **`draw_match.m`**: Visualizes the matching results on the images.
- **`local_max.m`**: Finds local maxima in the similarity map for template matching.

## Results

For the selected test images, the following results were observed:

### `script_rgb.m`

- **Grayscale Images**: The algorithm can detect the smiley object in the desired regions, but it sometimes identifies false positives where the object does not exist.
- **RGB Images**: The algorithm performs better in detecting the smiley object, especially when using the **mean method**. However, the **weight method** does not yield as accurate results.

### `script_ycbcr.m`

- **Higher Weight on Luma Component (ycbcr2)**: The algorithm struggles to detect the object effectively.
- **Higher Weight on Chroma Components (ycbcr3)**: The algorithm performs as well as in the RGB format, showing successful template matching.

## How to Use

1. Clone the repository:
    ```bash
    git clone https://github.com/yourusername/template-matching-project.git
    ```
2. Open the MATLAB environment and load the provided scripts.
3. Run `script_rgb.m` or `script_ycbcr.m` to execute template matching on the test images.
4. Modify the input images or parameters in the script to experiment with different scenarios.

## Conclusion

The project demonstrated that template matching yields better results on **RGB** images compared to **grayscale** images, particularly when using the **mean method**. When applied to **YCbCr** format images, the algorithm performed well when the chroma components were given more weight than the luma component.
