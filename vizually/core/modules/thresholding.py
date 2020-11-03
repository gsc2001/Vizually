import cv2
import numpy as np

from ..models.image import Image


def threshHandler(image: Image, params: dict) -> Image:
    """Thresholding handler

    Args:
        image (np.array): image to change
        params (dict): params has { threshold_value: float }

    Returns:
        np.array: thresholded image
    """
    new_img = binarizeImage(image.img, params['threshold_value'])
    new_image = Image(path=image.path, img=new_img)
    return new_image


def binarizeImage(image: np.array, thresh_value: float) -> np.array:
    """Binarize the image

    Args:
        image (np.array): image to change
        thresh_value (float): Threshold Value to choose

    Returns:
        np.array: binarized image
    """

    gray = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)
    binary = np.array(255 * (gray > thresh_value), dtype=np.uint8)
    return binary
