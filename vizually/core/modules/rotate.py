import math

import cv2
import numpy as np


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
        params['rotation_angle'] = 0

    if params['90Rotation'] < 0:
        params['90Rotation'] = -(abs(params['90Rotation']) % 4)
    else:
        params['90Rotation'] %= 4

    return rotateImage(image, params['rotation_angle'], params['90Rotation'] % 4)


def rotateImage(image: np.array, angle: float, rotation_90: int) -> np.array:
    """ Rotating Image Handler
    Args:
        image (np.array): image to change
        angle (float): the angle by which image will be rotated
    Returns:
        np.array: Rotated image

    """
    if rotation_90 >= 0:
        for i in range(rotation_90):
            image = cv2.rotate(image, cv2.ROTATE_90_CLOCKWISE)

    else:
        for i in range(-rotation_90):
            image = cv2.rotate(image, cv2.ROTATE_90_COUNTERCLOCKWISE)

    height, width = image.shape[:2]
    image_center = (width / 2, height / 2)

    rotation_mat = cv2.getRotationMatrix2D(image_center, angle, 1)

    alpha = math.degrees(math.fabs(math.atan(height / width)))
    alpha2 = alpha
    if (height > width):
        alpha2 = 90 - alpha

    scale = (min(height, width) * math.sin(math.radians(alpha))) / \
        (math.sin(math.fabs(math.radians(angle)) + math.radians(alpha2)) * height)

    w_bound = width * scale
    h_bound = height * scale

    rotation_mat[0, 2] += int(w_bound / 2 - image_center[0])
    rotation_mat[1, 2] += int(h_bound / 2 - image_center[1])

    if angle != 0:  # small correction factor to combat precision issues
        rotation_mat[:, 2] -= int(2)

    warped = cv2.warpAffine(image, rotation_mat, (int(w_bound), int(h_bound)))
    return cv2.resize(warped, (width, height), interpolation=cv2.INTER_CUBIC)
