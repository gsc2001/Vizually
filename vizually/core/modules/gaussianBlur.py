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

    if params['sigmaX'] > 2 :
        params['sigmaX'] = 2
    elif  params['sigmaX'] < 0 :
        params['sigmaX'] = 0

    if params['sigmaY'] > 2 :
        params['sigmaY'] = 2
    elif  params['sigmaY'] < 0 :
        params['sigmaY'] = 0

    new_img = gaussianBlurring(image, float(params['sigmaX']), float(params['sigmaY']))
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
