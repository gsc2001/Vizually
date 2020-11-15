import cv2
import numpy as np

from ..modules.AdaptiveThresholding import medianAdaptiveImageBinarizer

def threshCartoonHandler(image: np.array, params: dict) -> np.array:
    """Threshold Cartoon Handler

    Args:
        image(np.array): image to change
        params (dict): params has { threshold_value } range(about): (0, 10) with step size of 1


    Returns:
        np.array: Image with cartoon effect
    """
    if 'threshold_value' not in params:
        return image

    if params['threshold_value'] > 10 :
        params['threshold_value'] = 10
    elif  params['threshold_value'] < 0 :
        params['threshold_value'] = 0

    new_img = cartoon1(image, float(params['threshold_value']))
    return new_img

def cartoon2(image: np.array, threshold_value: float) -> np.array:
    """Apllies filter to the image

    Args:
        image (np.array): image to change

    Returns:
        np.array: New image
    """
    
    edge_mask = medianAdaptiveImageBinarizer(image, threshold_value)
    blur = cv2.bilateralFilter(image, 9, 75, 75)
    retImg = cv2.bitwise_and(blur, blur, mask=edge_mask)
    return retImg
