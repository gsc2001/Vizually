import cv2
import numpy as np


def averageBlurringHandler(image: np.array, params: dict) -> np.array:
    """Adaptive Thresholding Handler

    Args:
        image(np.array): image to change
        params (dict): params has { 'blurValue' }, range (1, 20) step size of 1 (integer values only)

    Returns:
        np.array: Blurred image (without edge preservation)
    """
    new_img = averageBlur(image, params['blurValue'])
    return new_img

def averageBlur(image: np.array, blurValue: int) -> np.array:
    """Blurs the image

    Args:
        image (np.array): image to change

    Returns:
        np.array: blurred image
    """
    retImg = cv2.blur(image, (blurValue, blurValue))
    return retImg
