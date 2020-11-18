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

    if 'contrast_limit' not in params:
        return image

    if params['contrast_limit'] > 4:
        params['contrast_limit'] = 4
    elif params['contrast_limit'] < 0:
        params['contrast_limit'] = 4

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
    contrast_limit *= 2.0
    if contrast_limit != 0:
        lab = cv2.cvtColor(image, cv2.COLOR_BGR2LAB)
        clahe = cv2.createCLAHE(clipLimit=contrast_limit, tileGridSize=(4, 4))
        lab[..., 0] = clahe.apply(lab[..., 0])
        return cv2.cvtColor(lab, cv2.COLOR_LAB2BGR)
    return image


def contrastManipulationManual(image: np.array, contrast: int):
    # Scale the contrast value
    contrast *= 10
    f = 131 * (contrast + 127) / (127 * (131 - contrast))
    alpha_c = f
    gamma_c = 127 * (1 - f)

    image = cv2.addWeighted(image, alpha_c, image, 0, gamma_c)
    return image
