import cv2
import numpy as np


def summerHandler(image: np.array, params: dict) -> np.array:
    """Summer filter handler

    Args:
        image(np.array): image to change
        params (dict): params has { summer_value } range: (0, 1) step size of 0.01

    Returns:
        np.array: Image having a summer filter
    """

    if 'summer_value' not in params:
        return image

    if params['summer_value'] >= 1:
        params['summer_value'] = 0.99
    elif params['summer_value'] < 0:
        params['summer_value'] = 0

    new_img = summerFilter(
        image, float(params['summer_value']))
    return new_img


def summerFilter(image: np.array, summer_value: float) -> np.array:
    """Apply summer filter on the image

    Args:
        image (np.array): image to change
        summer_value (float): How much gamma function's power should be taken

    Returns:
        np.array: summer filter applied image
    """
    image[:, :, 0] = gamma_function(image[:, :, 0], 1 - summer_value)
    image[:, :, 2] = gamma_function(image[:, :, 2], 1 + summer_value)
    hsv = cv2.cvtColor(image, cv2.COLOR_BGR2HSV)
    hsv[:, :, 1] = gamma_function(hsv[:, :, 1], 1 + (4 / 5 * summer_value))

    return cv2.cvtColor(hsv, cv2.COLOR_HSV2BGR)


def gamma_function(channel: np.array, gamma: float) -> np.array:
    table = np.array([((i / 255) ** (1/gamma)) *
                      255 for i in np.arange(0, 256)]).astype("uint8")
    channel = cv2.LUT(channel, table)
    return channel
