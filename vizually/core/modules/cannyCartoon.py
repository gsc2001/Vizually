import cv2
import numpy as np

from ..modules.cannyEdgeDetection import cannyEDHandler

def cannyCartoonHandler(image: np.array, params: dict) -> np.array:
    """Canny Cartoon Handler

    Args:
        image(np.array): image to change
        params (dict): params has {'strength'}

        strength is used to calculate low and high thresholds
        strength is in range [0, 127]
        step value = 1


    Returns:
        np.array: Image with cartoon effect
    """
    if 'strength' not in params:
        return image

    if params['strength'] > 127 :
        params['strength'] = 127
    elif  params['strength'] < 0 :
        params['strength'] = 0

    new_img = cartoon1(image, float(params['strength']))
    return new_img

def cartoon1(image: np.array, strength: float) -> np.array:
    """Apllies filter to the image

    Args:
        image (np.array): image to change

    Returns:
        np.array: New image
    """
    
    edge_mask = cv2.bitwise_not(cannyEDHandler(image, {'strength': strength}))
    blur = cv2.bilateralFilter(image, 9, 75, 75)
    retImg = cv2.bitwise_and(blur, blur, mask=edge_mask[:,:,0])
    return retImg
