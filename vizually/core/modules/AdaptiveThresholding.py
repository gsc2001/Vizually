import cv2
import numpy as np

from models.image import Image


def adaptiveThresholdingHandler(image: Image, params: dict) -> Image:
    """Adaptive Thresholding Handler

    Args:
        image(np.array): image to change
        params (dict): params has { threshold_value } range(about): (0, 10)

    Returns:
        np.array: thresholded image
    """
    new_img = medianAdaptiveImageBinarizer(
        image.img, params['threshold_value'])
    new_image = Image(path=image.path, img=new_img)
    return new_image


def medianAdaptiveImageBinarizer(image: np.array, thresh_value: float) -> np.array:
    """Binarize the image

    Args:
        image (np.array): image to change
        thresh_value (float): Threshold Value to choose

    Returns:
        np.array: binarized image
    """

    gray = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)
    medianGray = cv2.medianBlur(gray, 5)

    retImg = cv2.adaptiveThreshold(gray, 255, cv2.ADAPTIVE_THRESH_GAUSSIAN_C,
                                   cv2.THRESH_BINARY, 11, thresh_value)

    return retImg
