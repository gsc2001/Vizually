import cv2
import numpy as np

from models.image import Image


def averageBlurringHandler(image: Image, params: dict) -> Image:
    """Adaptive Thresholding Handler

    Args:
        image(np.array): image to change
        params (dict): params has { 'Blur amount' }, range (1, 20) step size of 1 (integer values only)

    Returns:
        np.array: Blurred image (without edge preservation)
    """
    new_img = averageBlur(
        image.img, params['Blur amount'])
    new_image = Image(path=image.path, img=new_img)
    return new_image


def averageBlur(image: np.array, blurValue: int) -> np.array:
    """Blurs the image

    Args:
        image (np.array): image to change

    Returns:
        np.array: blurred image
    """
    retImg = cv2.blur(image, (blurValue, blurValue))
    return retImg
