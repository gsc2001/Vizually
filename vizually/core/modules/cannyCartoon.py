import cv2
import numpy as np

from ..modules.cannyEdgeDetection import cannyED

def cannyCartoonHandler(image: np.array, params: dict) -> np.array:
    """Canny Cartoon Handler

    Args:
        image(np.array): image to change
        params (dict): params has { min_threshold, max_threshold}

        thresholds is in range [0, 255]
        step value = 1


    Returns:
        np.array: Image with cartoon effect
    """
    if 'min_threshold' not in params or 'max_threshold' not in params:
        return image


    params['min_threshold'] = 255 if params['min_threshold'] > 255 else params['min_threshold']
    params['min_threshold'] = 0 if params['min_threshold'] < 0 else params['min_threshold']

    params['max_threshold'] = 255 if params['max_threshold'] > 255 else params['max_threshold']
    params['max_threshold'] = 0 if params['max_threshold'] < 0 else params['max_threshold']

    new_img = cartoon1(image, round(min(params['max_threshold'], params['min_threshold'])), round(max(params['max_threshold'], params['min_threshold'])))
    return new_img

def cartoon1(image: np.array, min_threshold: int, max_threshold: int) -> np.array:
    """Apllies filter to the image

    Args:
        image (np.array): image to change

    Returns:
        np.array: New image
    """
    
    edge_mask = cv2.bitwise_not(cannyED(image, min_threshold, max_threshold))
    blur = cv2.bilateralFilter(image, 9, 75, 75)
    retImg = cv2.bitwise_and(blur, blur, mask=edge_mask[:,:,0])
    return retImg
