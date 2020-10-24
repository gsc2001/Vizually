import cv2
import numpy as np

from models.image import Image


def histogramManipulationHandler(image: Image, params: dict) -> Image:
    """Histogram Equalization handler

    Args:
        image (np.array): image to change
        params (dict): params has { clip_limit: float }

    Returns:
        np.array: manipulated image
    """
    
    new_img = contrastManipulation(image.img, params['clip_limit'])
    new_image = Image(path=image.path, img=new_img)
    return new_image


def contrastManipulation(image: np.array, clip_limit: float) -> np.array:
    """Manipulate Histogram of the image

    Args:
        image (np.array): image to change
        clip_limit (float): Clip Limit to choose

    Returns:
        np.array: Manipulated (Changed Contrast) image
    """

    gray = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)
    clahe = cv2.createCLAHE(clipLimit = clip_limit)
    final_img = clahe.apply(gray)
    return final_img
