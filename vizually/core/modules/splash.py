import cv2
import numpy as np

from ..models.image import Image


def splashHandler(image: np.array, params: dict) -> np.array:
    """Splash Hnadler

    Args:
        image (np.array): image to change
        params (dict): params has { min[i], max[i]} (multiple)
        min_hue and max_hue both have range [0,179] with STEP = 1

    Returns:
        np.array:  image  with extracted colors
    """

    strm = ("min", "max")
    min_max_list = []
    for i in range(10):
        m = (strm[0] + str(i), strm[1] + str(i))
        if m[0] not in params or m[1] not in params:
            break
        else:
            params[m[0]] = 179 if params[m[0]] > 179 else params[m[0]]
            params[m[1]] = 179 if params[m[1]] > 179 else params[m[1]]
            params[m[0]] = 0 if params[m[0]] < 0 else params[m[0]]
            params[m[1]] = 0 if params[m[1]] < 0 else params[m[1]]

            pair = (round(min(params[m[0]], params[m[1]])), round(
                max(params[m[0]], params[m[1]])))
            min_max_list.append(pair)

    return getColors(image, min_max_list)


def getColors(image: np.array, min_max_list: list) -> np.array:
    """Splash Sketch

    Args:
        image (np.array): image to change

    Returns:
        np.array: pencil sketched image
    """

    hsv = cv2.cvtColor(image, cv2.COLOR_BGR2HSV)
    mask0 = cv2.inRange(hsv, (0, 0, 0), (0, 0, 0))
    final_img = cv2.bitwise_and(image, image, mask=mask0)

    for minH, maxH in min_max_list:
        mask = cv2.inRange(hsv, (minH, 0, 0), (maxH, 255, 255))
        cur_img = cv2.bitwise_and(image, image, mask=mask)
        mask0 = mask0 | mask
        final_img = final_img | cur_img

    inv = ~mask0
    gray = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)
    grayMask = cv2.bitwise_and(gray, gray, mask=inv)
    back = cv2.cvtColor(grayMask, cv2.COLOR_GRAY2BGR)
    return final_img | back
