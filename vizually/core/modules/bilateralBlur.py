import cv2
import numpy as np


def bilateralBlurringHandler(image: np.array, params: dict) -> np.array:
    """Bilateral Thresholding Handler

    Args:
        image(np.array): image to change
        params (dict): params has { }

    Returns:
        np.array: Blurred image (with edge preservation)
    """
    new_img = bilateralBlur(
        image)
    return new_img


def bilateralBlur(image: np.array) -> np.array:
    """Blurs the image

    Args:
        image (np.array): image to change

    Returns:
        np.array: blurred image
    """
    retImg = cv2.bilateralFilter(image, 9, 75, 75)
    return retImg
