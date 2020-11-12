import cv2
import numpy as np


def flipHandler(image: np.array, params : dict)-> np.array:
    """ Flipping Image Handler

    Args:
        image (np.array): image to change
        params (dict): params has { horizontal: bool, vertical: bool}
    
    Returns:
        np.array: Flipped image

    """

    if 'horizontal' not in params or 'vertical' not in params:
        return image

    flipCode = 0
    if params['horizontal'] is False and params['vertical'] is False:
        return image
    elif params['horizontal'] is True and params['vertical'] is False:
        flipCode = 1
    elif params['horizontal'] is False and params['vertical'] is True:
        flipCode = 0
    else:
        flipCode = -1

    # new_img = flipImage(image, round(params['flipCode']))
    new_img = flipImage(image, round(flipCode))
    return new_img


def flipImage(image: np.array, flipCode: int) -> np.array:
    """Flipping image
    Args:
        image (np.array): image to change
        flipCode (int) : the type of flip

    Returns:
        np.array: Flipped image
    """
    if flipCode < 0:
        flipCode = -1
    else:
        flipCode = 0 if flipCode == 0 else 1

    return cv2.flip(image, flipCode)
