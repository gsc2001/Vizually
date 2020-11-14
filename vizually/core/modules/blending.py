import cv2
import numpy as np


def BlendingHandler(image1: np.array, image2: np.array, params: dict) -> np.array:
    """ Blending Image Handler

    Args:
        image1 and image2 (np.array): images to blend
        params (dict): params has { alpha , contrast}

        alpha has range [0, 1] with STEP = 0.01
        contrast has range [-50, 50] with STEP = 0.1 or 1 (you decide)

        I have chosen contrast range to be this because i only want 
        to have subtle contrast changes in blending by user 

    Returns:
        np.array: Blended image


    NOTE : I dont know what to return if params are absent
    """

    if params['alpha'] > 1:
        params['alpha'] = 1
    elif params['alpha'] < 0:
        params['alpha'] = 0

    if params['contrast'] > 50:
        params['contrast'] = 50
    elif params['contrast'] < -50:
        params['contrast'] = -50

    new_img = blendImages(image1, image2, float(
        params['alpha']), float(params['contrast']))
    return new_img


def blendImages(image1: np.array, image2: np.array, alpha: float, contrast: float) -> np.array:
    """Blend 2 images

    Args:
        image1 and image2 (np.array): images to blend
        alpha (float) : this is percentage of first image taken during blending
        contrast (float) : add this to increase/decrease pixel value for each cell in image (darken or brighten image)

    Returns:
        np.array: Blended image
    """

    return cv2.addWeighted(image1, alpha, image2, 1 - alpha, contrast)
