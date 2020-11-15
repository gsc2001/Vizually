import cv2
import numpy as np


def sepiaHandler(image: np.array, params: dict) -> np.array:
    """Sepia Filter Handler

    Args:
        image(np.array): image to change
        params (dict): params has {apply: bool}

    Returns:
        np.array: Image with sepia effect
    """
    
    if params['apply'] is False:
        return image
    
    new_img = sepia(image)
    return new_img

def sepia(image: np.array) -> np.array:
    """Apllies filter to the image

    Args:
        image (np.array): image to change

    Returns:
        np.array: New image
    """
    kernel = np.array([[0.272, 0.534, 0.131],
                       [0.349, 0.686, 0.168],
                       [0.393, 0.769, 0.189]])
    retImg = cv2.transform(image, kernel)
    return retImg
