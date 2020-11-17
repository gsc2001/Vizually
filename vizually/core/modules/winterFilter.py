import cv2
import numpy as np


def winterHandler(image: np.array, params: dict) -> np.array:
    """winter filter handler

    Args:
        image(np.array): image to change
        params (dict): params has { winter_value } range: (0, 1) step size of 0.01

    Returns:
        np.array: Image having a winter filter
    """

    if 'winter_value' not in params:
        return image

    if params['winter_value'] >= 1:
        params['winter_value'] = 0.99
    elif params['winter_value'] < 0:
        params['winter_value'] = 0

    new_img = winterFilter(
        image.copy(), float(params['winter_value']))
    return new_img


def winterFilter(image: np.array, winter_value: float) -> np.array:
    """Apply winter filter on the image

    Args:
        image (np.array): image to change
        winter_value (float): How much gamma function's power should be taken

    Returns:
        np.array: winter filter applied image
    """
    image[:, :, 2] = gamma_function(image[:, :, 2], 1 - winter_value)
    image[:, :, 0] = gamma_function(image[:, :, 0], 1 + winter_value)
    hsv = cv2.cvtColor(image, cv2.COLOR_BGR2HSV)
    hsv[:, :, 1] = gamma_function(hsv[:, :, 1], 1 + (4 / 5 * winter_value))

    return cv2.cvtColor(hsv, cv2.COLOR_HSV2BGR)


def gamma_function(channel: np.array, gamma: float) -> np.array:
    table = np.array([((i / 255) ** (1/gamma)) *
                      255 for i in np.arange(0, 256)]).astype("uint8")
    channel = cv2.LUT(channel, table)
    return channel
