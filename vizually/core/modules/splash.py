import cv2
import numpy as np

from ..models.image import Image


def SplashHandler(image: np.array, params: dict) -> np.array:
    """Splash Hnadler

    Args:
        image (np.array): image to change
        params (dict): params has { min_hue, max_hue}
        min_hue and max_hue both have range [0,255] with STEP = 1

        Hue can be thought as colors that you want to get in final image
        If INTERFACE people can handle multiple values of (min_hue, max_hue); i will update the function, do tell me.

    Returns:
        np.array:  image  with extracted colors
    """

    if 'min_hue' not in params or 'max_hue' not in params:
        return image

    if params['min_hue'] > 255:
        params['min_hue'] = 255
    elif params['min_hue'] < 0:
        params['min_hue'] = 0

    if params['max_hue'] > 255:
        params['max_hue'] = 255
    elif params['max_hue'] < 0:
        params['max_hue'] = 0

    if params['max_hue'] < params['min_hue']:
        params['max_hue'], params['min_hue'] = params['min_hue'], params['max_hue']

    return getColors(image, round(params['min_hue']), round(params['max_hue']))


def getColors(image: np.array, min_hue: int, max_hue: int) -> np.array:
    """Color Extarction

    Args:
        image (np.array): image to change
        min_hue: (int) : 

    Returns:
        np.array: image  with extracted colors
    """

    hsv = cv2.cvtColor(image, cv2.COLOR_BGR2HSV)
    mask = cv2.inRange(hsv, (min_hue, 0, 0), (max_hue, 255, 255))
    final_img = cv2.bitwise_and(image, image, mask=mask)

    inv = ~mask
    gray = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)
    gray_mk = cv2.bitwise_and(gray, gray, mask=inv)
    bw = cv2.cvtColor(gray_mk, cv2.COLOR_GRAY2BGR)

    return (bw | final_img)
