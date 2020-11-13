import cv2
import numpy as np


def threshHandler(image: np.array, params: dict) -> np.array:
    """Thresholding handler

    Args:
        image (np.array): image to change
        params (dict): params has { threshold_value: float(1,254) }

    Returns:
        np.array: thresholded image
    """


    if 'threshold_value' not in params:
        return image

    if params['threshold_value'] < 0: 
        params['threshold_value'] = 0

    new_img = binarizeImage(image, round(params['threshold_value']))
    return new_img    

    
def binarizeImage(image: np.array, thresh_value: int) -> np.array:
    """Binarize the image

    Args:
        image (np.array): image to change
        thresh_value (float): Threshold Value to choose

    Returns:
        np.array: binarized image
    """

    gray = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)
    binary = np.array(255 * (gray > thresh_value), dtype=np.uint8)
    return cv2.cvtColor(binary, cv2.COLOR_GRAY2BGR)
