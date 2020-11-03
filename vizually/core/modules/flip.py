import cv2
import numpy as np

from ..models.image import Image


def flipHandler(image: Image, params : dict)-> Image:
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

    new_img = flipImage(image.img, params['flipCode'])
    new_image = Image(path=image.path, img=new_img)
    return new_image


def flipImage(image:Image, flipCode: int)-> Image:
    """Flipping image
    Args:
        image (np.array): image to change
        flipCode (int) : the type of flip

    Returns:
        np.array: Flipped image
    """
    return cv2.flip(image, flipCode)
