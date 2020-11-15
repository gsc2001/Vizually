import cv2
import numpy as np

from ..models.image import Image


def dayLightHandler(image: np.array, params: dict) -> np.array:
    """Pencil Sketch Hnadler

    Args:
        image (np.array): image to change
        params (dict): params has { lighting }

        lighting is in range [1, 3] with step atmost 0.1 (you can change the step)

    Returns:
        np.array:  image  after pencil sketch
    """

    if 'lighting' not in params:
        return image

    if params['lighting'] > 3:
        params['lighting'] = 3
    elif params['lighting'] < 1:
        params['lighting'] = 1

    return increaseLight(image, float(params['lighting']))


def increaseLight(image: np.array, light_factor: float) -> np.array:
    """Daylight Filter

    Args:
        image (np.array): image to change

    Returns:
        np.array: image after increasing light
    """

    hls = cv2.cvtColor(image, cv2.COLOR_BGR2HLS)
    hls = np.array(hls, dtype=np.float64)
    hls[:, :, 1] *= light_factor
    hls[:, :, 1][hls[:, :, 1] > 255] = 255
    hls = np.array(hls, dtype=np.uint8)
    final_img = cv2.cvtColor(hls, cv2.COLOR_HLS2BGR)
    return final_img
