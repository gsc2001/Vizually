import cv2
import numpy as np

from ..models.image import Image


def bilateralBlurringHandler(image: Image, params: dict) -> Image:
    """Adaptive Thresholding Handler

    Args:
        image(np.array): image to change
        params (dict): params has { }

    Returns:
        np.array: Blurred image (with edge preservation)
    """
    new_img = bilateralBlur(
        image.img)
    new_image = Image(path=image.path, img=new_img)
    return new_image


def bilateralBlur(image: np.array) -> np.array:
    """Blurs the image

    Args:
        image (np.array): image to change

    Returns:
        np.array: blurred image
    """
    retImg = cv2.bilateralFilter(image, 9, 75, 75)
    return retImg
