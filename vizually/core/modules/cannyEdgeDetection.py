import cv2
import numpy as np

from ..models.image import Image


def cannyEDHandler(image: np.array, params: dict) -> np.array:
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


    if 'strength' not in params:
        return image

    if params['strength'] > 127 :
        params['strength'] = 127
    elif  params['strength'] < 0 :
        params['strength'] = 0

    return cannyED(image, float(params['strength']))


def cannyED(image: np.array, strength: float) -> np.array:
    """Canny Edge detection technique

    Args:
        image (np.array): image to change
        strength (float): For getting threshholds

    Returns:
        np.array: image after canny edge detection
    """
    blurred_img = cv2.blur(image, (5, 5))
    final_img = cv2.Canny(blurred_img, strength * .5, strength * 2)
    return cv2.cvtColor(final_img, cv2.COLOR_GRAY2BGR)
