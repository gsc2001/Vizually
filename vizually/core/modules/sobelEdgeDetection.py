import cv2
import numpy as np


def sobelEDHandler(image: np.array, params: dict) -> np.array:
    """Sobel Edge Detection Handler

    Args:
        image (np.array): image to change
        params (dict): params has { }

    Returns:
        np.array:  image  after sobel edge detection 
    """
    new_img = sobelED(image)
    return new_img

def sobelED(image: np.array) -> np.array:
    """Sobel Edge detection technique 

    Args:
        image (np.array): image to change

    Returns:
        np.array: image after sobel edge detection
    """
    blurred_img = cv2.blur(image, (5,5))
    blurred_img = cv2.cvtColor(blurred_img, cv2.COLOR_BGR2GRAY)

    img_x = cv2.Sobel(blurred_img,cv2.CV_64F,1,0,ksize=5)  
    img_y = cv2.Sobel(blurred_img,cv2.CV_64F,0,1,ksize=5)
    
    final_img = cv2.addWeighted(cv2.convertScaleAbs(img_x), 0.5, cv2.convertScaleAbs(img_y), 0.5, 0)
    return cv2.cvtColor(final_img,cv2.COLOR_GRAY2BGR)
    