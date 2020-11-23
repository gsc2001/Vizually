import cv2
import numpy as np


def embossHandler(image: np.array, params: dict) -> np.array:
    """Emboss Filter Handler

    Args:
        image(np.array): image to change
        params (dict): params has { bottom_left: bool, bottom_right: bool, top_left:bool, top_right:bool }

    Returns:
        np.array: Image with emboss filter on it
    """
    if 'bottom_left' not in params or 'bottom_right' not in params or 'top_left' not in params or 'top_right' not in params:
        return image

    if params['bottom_left'] is False and params['bottom_right'] is False and params['top_left'] is False and params['top_right'] is False:
        return image

    new_img = emboss(
        image, params['bottom_left'], params['bottom_right'], params['top_left'], params['top_right'])
    return new_img


def emboss(image: np.array, bottom_left: bool, bottom_right: bool, top_left: bool, top_right: bool) -> np.array:
    """Embosses the image

    Args:
        image (np.array): image to change
        bottom_left(bool): emboss from bottom left
        bottom_right(bool): emboss from bottom right
        top_left(bool): emboss from top left
        top_right(bool): emboss from top right

    Returns:
        np.array: Embossed image
    """
    gray = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)
    height, width = image.shape[:2]
    base = np.ones((height, width), np.uint8) * 128
    retImg = np.zeros((height, width), np.uint8)
    output_bl = np.zeros((height, width), np.uint8)
    output_br = np.zeros((height, width), np.uint8)
    output_tr = np.zeros((height, width), np.uint8)
    output_tl = np.zeros((height, width), np.uint8)
    if bottom_left is True:
        kernel_bl = np.array([[0, -1, -1],
                              [1, 0, -1],
                              [1, 1, 0]])
        output_bl = cv2.add(cv2.filter2D(gray, -1, kernel_bl), base)
    if bottom_right is True:
        kernel_br = np.array([[-1, -1, 0],
                              [-1, 0, 1],
                              [0, 1, 1]])
        output_br = cv2.add(cv2.filter2D(gray, -1, kernel_br), base)
    if top_left is True:
        kernel_tl = np.array([[1, 1, 0],
                              [1, 0, -1],
                              [0, -1, -1]])
        output_tl = cv2.add(cv2.filter2D(gray, -1, kernel_tl), base)
    if top_right is True:
        kernel_tr = np.array([[0, 1, 1],
                              [-1, 0, 1],
                              [-1, -1, 0]])
        output_tr = cv2.add(cv2.filter2D(gray, -1, kernel_tr), base)
    retImg = np.maximum(output_bl, np.maximum(
        output_br, np.maximum(output_tl, output_tr)))
    retImg = cv2.cvtColor(retImg, cv2.COLOR_GRAY2BGR)
    return retImg
