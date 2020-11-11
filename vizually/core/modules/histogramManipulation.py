import cv2
import numpy as np


def histogramManipulationHandler(image: np.array, params: dict) -> np.array:
    """Histogram Equalization handler

    Args:
        image (np.array): image to change
        params (dict): params has { contrast_limit: float 
                                    ((0, 3], step size of 0.1) }

    Returns:
        np.array: manipulated image
    """
    
    if params['contrast_limit'] > 3 :
        params['contrast_limit'] = 3
    elif  params['contrast_limit'] < 0 :
        params['contrast_limit'] = 0

    new_img = contrastManipulation(image, float(params['contrast_limit']))
    return new_img


def contrastManipulation(image: np.array, contrast_limit: float) -> np.array:
    """Manipulate Histogram of the image

    Args:
        image (np.array): image to change
        contrast_limit (float): Contrast Limit (clip limit) to choose

    Returns:
        np.array: Manipulated (Changed Contrast) image
    """

    gray = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)
    clahe = cv2.createCLAHE(clipLimit = contrast_limit)
    final_img = clahe.apply(gray)
    return cv2.cvtColor(final_img, cv2.COLOR_GRAY2BGR)

