import cv2
import numpy as np


def sobelEDHandler(image: np.array, params: dict) -> np.array:
    """Sobel Edge Detection Handler

    Args:
        image (np.array): image to change
        params (dict): params has { kernel_size: int [3, 5] }

    Returns:
        np.array:  image  after sobel edge detection 
    """

    if 'kernel_size' not in params:
        return image

    new_img = sobelED(image, int(params['kernel_size']))
    return new_img

def sobelED(image: np.array, kernel_size: int) -> np.array:
    """Sobel Edge detection technique 

    Args:
        image (np.array): image to change

    Returns:
        np.array: image after sobel edge detection
    """
    blurred_img = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)
    blurred_img = cv2.GaussianBlur(blurred_img, (3,3),0)


    img_x = cv2.Sobel(blurred_img,cv2.CV_64F,1,0,ksize=kernel_size)  
    img_y = cv2.Sobel(blurred_img,cv2.CV_64F,0,1,ksize=kernel_size)
    
    final_img = cv2.addWeighted(cv2.convertScaleAbs(img_x), 0.5, cv2.convertScaleAbs(img_y), 0.5, 0)
    return cv2.cvtColor(final_img,cv2.COLOR_GRAY2BGR)
    