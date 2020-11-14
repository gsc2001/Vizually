import cv2
import numpy as np


def invertHandler(image: np.array, params: dict) -> np.array:
    """Invert Handler

    Args:
        image(np.array): image to change
        params (dict): params has {apply: bool}

    Returns:
        np.array: Inverted Image
    """
    
    if params['apply'] is False:
        return image
    
    new_img = invert(image)
    return new_img

def invert(image: np.array) -> np.array:
    """Inverts the image

    Args:
        image (np.array): image to change

    Returns:
        np.array: New image
    """
    
    retImg = cv2.bitwise_not(image)
    return retImg
