import cv2
import numpy as np

from ..models.image import Image


def rotateHandler(image: np.array, params: dict) -> np.array:
    """ Rotating Image Handler

    Args:
        image (np.array): image to change
        params (dict): params has { rotation_angle : float}

        THE IMAGE IS ROTATED IN ANTICLOCKWISE DIRECTION
        THE ANGLE MUST BE SPECIFIED IN DEGREES

    Returns:
        np.array: Rotated image

    """


    if 'rotation_angle' not in params:
        return image

    return rotateImage(image, params['rotation_angle'])


def rotateImage(image: np.array, angle: float) -> np.array:
    """ Rotating Image Handler
    Args:
        image (np.array): image to change
        angle (float): the angle by which image will be rotated
    Returns:
        np.array: Rotated image

    """
    height, width = image.shape[:2]
    image_center = (width / 2, height / 2)

    rotation_mat = cv2.getRotationMatrix2D(image_center, angle, 1)

    cos = np.abs(rotation_mat[0, 0])
    sin = np.abs(rotation_mat[0, 1])

    w_bound = int(height * sin + width * cos)
    h_bound = int(height * cos + width * sin)

    rotation_mat[0, 2] += w_bound / 2 - image_center[0]
    rotation_mat[1, 2] += h_bound / 2 - image_center[1]

    return cv2.warpAffine(image, rotation_mat, (w_bound, h_bound))
