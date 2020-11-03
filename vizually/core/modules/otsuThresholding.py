import cv2
import numpy as np

from ..models.image import Image


def OstuThresholdingHandler(image: Image, params: dict) -> Image:
    """Adaptive Thresholding Handler

    Args:
        image(np.array): image to change
        params (dict): params has { }

    Returns:
        np.array: thresholded image
    """
    new_img = GaussianOtsuImageBinarizer(
        image.img)
    new_image = Image(path=image.path, img=new_img)
    return new_image


def GaussianOtsuImageBinarizer(image: np.array) -> np.array:
    """Binarize the image

    Args:
        image (np.array): image to change

    Returns:
        np.array: binarized image
    """

    gray = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)
    gaussianImg = cv2.GaussianBlur(gray, (5, 5), 0)

    ret, retImg = cv2.threshold(
        gaussianImg, 127, 255, cv2.THRESH_TOZERO+cv2.THRESH_OTSU)

    return retImg
