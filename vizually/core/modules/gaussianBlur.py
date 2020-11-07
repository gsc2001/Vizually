import cv2
import numpy as np


def gaussianBlurringHandler(image: np.array, params: dict) -> np.array:
    """Gaussian Blurring

    Args:
        image(np.array): image to change
        params (dict): params has { sigmaX and sigmaY : float ([0, 2], step size of 0.1)}
    Returns:
        np.array: Blurred image
    """
    new_img = gaussianBlurring(image, params['sigmaX'], params['sigmaY'])
    return new_img


def gaussianBlurring(image: np.array, sigmaX: float, sigmaY: float) -> np.array:
    """Blurs the image

    Args:
        image (np.array): image to change

    Returns:
        np.array: blurred image
    """
    final = cv2.GaussianBlur(image, (5, 5), sigmaX, sigmaY)
    return final
