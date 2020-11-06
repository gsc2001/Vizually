import cv2
import numpy as np

from ..models.image import Image


def gaussianBlurringHandler(image: Image, params: dict) -> Image:
    """Gaussian Blurring

    Args:
        image(np.array): image to change
        params (dict): params has { sigmaX and sigmaY : float ([0, 2], step size of 0.1)}
    Returns:
        np.array: Blurred image
    """
    new_img = gaussianBlurring(image.img, params['sigmaX'], params['sigmaY'])
    new_image = Image(path = image.path, img = new_img)
    return new_image


def gaussianBlurring(image: np.array, sigmaX: float, sigmaY: float) -> np.array:
    """Blurs the image

    Args:
        image (np.array): image to change

    Returns:
        np.array: blurred image
    """
    final = cv2.GaussianBlur(image, (5, 5), sigmaX, sigmaY)
    return final
