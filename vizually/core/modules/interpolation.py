import cv2
import numpy as np

interpolation_type = [cv2.INTER_CUBIC, cv2.INTER_AREA]


def interpolationHandler(image: np.array, params: dict) -> np.array:
    """Interpolation

    Args:
        image(np.array): resize an image
        params (dict): { type:{0: INTER_CUBIC, 1:INTER_AREA }, height: final_height, width: final_width }

    Returns:
        np.array: Interpolated image
    """
    try:
        params['width'] = int(params['width'])
        params['height'] = int(params['height'])
        params['type'] = int(params['type'])
    except Exception:
        return image

    new_img = interpolation(
        image, params['type'], (params['width'], params['height']))
    return new_img


def interpolation(image: np.array, type_i: int, size: tuple) -> np.array:
    """

    Args:
        image (np.array): image to change

    Returns:
        np.array: blurred image
    """
    retImg = cv2.resize(image, size, interpolation=interpolation_type[type_i])
    return retImg
