import cv2
import numpy as np

from ..models.image import Image


def OtsuThresholdingHandler(image: np.array, params: dict) -> np.array:
    """Adaptive Thresholding Handler

    Args:
        image (np.array): image to change
        params (dict): params has { apply: bool }

    Returns:
        np.array: thresholded image
    """

    if params['apply'] is False:
        return image

    return GaussianOtsuImageBinarizer(image)


def GaussianOtsuImageBinarizer(image: np.array) -> np.array:
    """Binarize the image

    Args:
        image (np.array): image to change

    Returns:
        np.array: binarized image
    """

    gray = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)
    gaussianImg = cv2.GaussianBlur(gray, (5, 5), 0)

    ret, retImg = cv2.threshold(
        gaussianImg, 127, 255, cv2.THRESH_TOZERO + cv2.THRESH_OTSU)

    retImg = cv2.cvtColor(retImg, cv2.COLOR_GRAY2BGR)
    return retImg
