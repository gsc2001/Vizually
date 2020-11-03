import cv2
import numpy as np

from ..models.image import Image

def cannyEDHandler(image: Image, params: dict) -> Image:
    """Canny Edge Detection Hnadler

    Args:
        image (np.array): image to change
        params (dict): params has { strength}

        strength is used to calculate low and high thresholds
        strength is in range [0, 127]
        step value = 1

    Returns:
        np.array:  image  after canny edge detection 
    """
    new_img = cannyED(image.img, params['strength'])
    new_image = Image(path=image.path, img=new_img)
    return new_image

def cannyED(image: np.array, strength: float) -> np.array:
    """Canny Edge detection technique 

    Args:
        image (np.array): image to change
        strength (float): For getting threshholds

    Returns:
        np.array: image after canny edge detection
    """
    blurred_img =  cv2.blur(image, (5,5))
    final_img = cv2.Canny(blurred_img, strength*.5, strength*2)
    return cv2.cvtColor(final_img,cv2.COLOR_GRAY2BGR)
    

