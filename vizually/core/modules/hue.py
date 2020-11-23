import cv2
import numpy as np


def hueHandler(image: np.array, params: dict) -> np.array:
    """hue filter handler

    Args:
        image(np.array): image to change
        params (dict): params has { hue_value } range: [-35, 35] step size of 1

    Returns:
        np.array: Image having a hue filter
    """

    if 'hue_value' not in params:
        return image

    if params['hue_value'] >= 35:
        params['hue_value'] = 35
    elif params['hue_value'] < -35:
        params['hue_value'] = -35

    new_img = hueFilter(
        image, float(params['hue_value']))
    return new_img


def hueFilter(image: np.array, hue_value: float) -> np.array:
    """Apply hue filter on the image

    Args:
        image (np.array): image to change
        hue_value (float): How much hue to increase

    Returns:
        np.array: hue filter applied image
    """
    hsv = cv2.cvtColor(image, cv2.COLOR_BGR2HSV)
    hsv[..., 0] = hsv[..., 0]+hue_value
    hsv[..., 0][hsv[..., 0] > 179] = 179
    hsv[..., 0][hsv[..., 0] < 0] = 0

    return cv2.cvtColor(hsv, cv2.COLOR_HSV2BGR)
