# Vizually: An Image-Processing application
![favicon](https://user-images.githubusercontent.com/48274694/126595421-8cd2e8f1-1ed3-4882-9fc5-712f3984ab28.png)

## Operators
- ### Blur
  - Average Blur
  - Gaussian Blur
  - Bilateral Blur

- ### Edge Detection
  - Canny Edge Detection
  - Sobel Edge Detection

- ### Thresholding
  - Otsu
    Before             |  After
    :-------------------------:|:-------------------------:
    ![otsu-before](https://user-images.githubusercontent.com/48274694/126597408-9d92f12a-401f-4b16-b0e3-3fc07282f00b.png)  |  ![otsu-after](https://user-images.githubusercontent.com/48274694/126597450-d5dbad2a-4ed6-4423-a740-5e0678693543.png)
  - Adaptive
  - Absolute

- ### Ridge Detection

- ### Corner Detection

- ### Contour Detection

- ### Perspective Transform

- ### Image masking

- ### Filters
  - Canny Cartoon
  - Color Sheet
  - Day Light
  - Emboss
  - Invert
  - Pencil Sketch
  - Sepia
  - Summer
  - Thresh Cartoon
  - Winter

- ### Contrast Filters
   - Contrast
   - Sharpening
   - Hue
   - Splash

- ### Blending

- ### Interpolation

## Installation Instructions
- Clone the repository
- To setup the venv and remove conficting qt and opencv
```shell
python3 -m venv venv
source venv bin/activate
pip install -r requirements.txt
rm ./venv/lib/python3.8/site-packages/cv2/qt/plugins/platform/libqxcb.so
```
- To run do `python main.py --style material`


## Created By 
-   Gurkirat Singh 
-   Sanchit Arora 
-   Kannav Mehta
-   Triansh Sharma
-   Shrey Gupta
-   Pratyush Priyadarshi
-   Raj Maheshwari
