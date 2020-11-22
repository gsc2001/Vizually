import cv2
import numpy as np

from ..models.image import Image


def cannyEDHandler(image: np.array, params: dict) -> np.array:
    """Canny Edge Detection Hnadler

    Args:
        image (np.array): image to change
        params (dict): params has { min_threshold, max_threshold}

        thresholds is in range [0, 255]
        step value = 1

    Returns:
        np.array:  image  after canny edge detection
    """

    if 'strength' not in params:
        return image

    params['min_threshold'] = 255 if params['min_threshold'] > 255 else params['min_threshold']
    params['min_threshold'] = 0 if params['min_threshold'] < 0 else params['min_threshold']

    params['max_threshold'] = 255 if params['max_threshold'] > 255 else params['max_threshold']
    params['max_threshold'] = 0 if params['max_threshold'] < 0 else params['max_threshold']

    return cannyED(image, round(min(params['max_threshold'], params['min_threshold'])),
                   round(max(params['max_threshold'], params['min_threshold'])))


def cannyED(image: np.array, min_threshold: int, max_threshold: int) -> np.array:
    """Canny Edge detection technique

    Args:
        image (np.array): image to change
        threshold (float): For getting threshholds

    Returns:
        np.array: image after canny edge detection
    """
    blurred_img = cv2.blur(image, (7, 7))
    final_img = cv2.Canny(blurred_img, min_threshold, max_threshold)
    return cv2.cvtColor(final_img, cv2.COLOR_GRAY2BGR)
