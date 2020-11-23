import cv2
import numpy as np


def blendingHandler(primary_image: np.array, params: dict) -> np.array:
    """ Blending Image Handler

    Args:
        primary_image and secondary_image (np.array): images to blend
        params (dict): params has {secondary_image, alpha , contrast}

        secondary_image str (path of the image)
        alpha has range [0, 1] with STEP = 0.01
        contrast has range [-50, 50] with STEP = 0.1

    Returns:
        np.array: Blended image
    """
    if 'secondary_image' not in params or 'alpha' not in params or 'contrast' not in params:
        return primary_image
    if params['alpha'] > 1:
        params['alpha'] = 1
    elif params['alpha'] < 0:
        params['alpha'] = 0

    if params['contrast'] > 50:
        params['contrast'] = 50
    elif params['contrast'] < -50:
        params['contrast'] = -50
    new_img = blendImages(primary_image, cv2.imread(params['secondary_image'][7:]), float(
        params['alpha']), float(params['contrast']))
    return new_img


def blendImages(primary_image: np.array, secondary_image: np.array, alpha: float, contrast: float) -> np.array:
    """Blend 2 images

    Args:
        primary_image and secondary_image (np.array): images to blend
        alpha (float) : this is percentage of first image taken during blending
        contrast (float) : add this to increase/decrease pixel value for each cell in image (darken or brighten image)

    Returns:
        np.array: Blended image
    """
    secondary_image = cv2.resize(secondary_image, (primary_image.shape[1], primary_image.shape[0]))
    return cv2.addWeighted(primary_image, alpha, secondary_image, 1 - alpha, contrast)
