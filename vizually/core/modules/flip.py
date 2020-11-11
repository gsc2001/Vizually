import cv2
import numpy as np


def flipHandler(image: np.array, params : dict)-> np.array:
    """ Flipping Image Handler

    Args:
        image (np.array): image to change
        params (dict): params has { flipCode : int}

        THE FLIPCODE MUST BE AMONG 
         1 : to flip horizontally
         0 : to flip vertically
        -1 : to flip both horizontally and vertically
    
    Returns:
        np.array: Flipped image

    """

    new_img = flipImage(image, round(params['flipCode']))
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
