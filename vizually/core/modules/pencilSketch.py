import cv2
import numpy as np

from ..models.image import Image


def pencilSketchHandler(image: np.array, params: dict) -> np.array:
    """Pencil Sketch Hnadler

    Args:
        image (np.array): image to change
        params (dict): params has { apply: bool}

    Returns:
        np.array:  image  after pencil sketch
    """

    if params['apply'] is False: 
        return image

    return sketchImage(image)


def sketchImage(image: np.array) -> np.array:
    """Pencil Sketch

    Args:
        image (np.array): image to change

    Returns:
        np.array: pencil sketched image
    """
    gray = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)
    inv = cv2.bitwise_not(gray)
    smooth = cv2.GaussianBlur(inv, (21, 21), sigmaX=0, sigmaY=0)
    final = cv2.divide(gray, 255-smooth, scale=256)
    return cv2.cvtColor(final, cv2.COLOR_GRAY2BGR)
