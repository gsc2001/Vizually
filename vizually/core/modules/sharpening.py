import cv2
import numpy as np

from models.image import Image


def sharpenHandler(image: Image, params: dict) -> Image:
    """Sharpening Image handler

    Args:
        image (np.array): image to change
        params (dict): params has { kernel_size: int (odd), sigma: float (> 0), strength: float}

    Returns:
        np.array: Sharpened image
    """
    
    new_img = sharpenImage(image.img, params['kernel_size'], params['sigma'], params['strength'])
    new_image = Image(path=image.path, img=new_img)
    return new_image


def sharpenImage(image: np.array, kernel_size: int, sigma: float, strength: float) -> np.array:
    """Sharpening of the image

    Args:
        image (np.array): image to change
        kernel_size (int): Kernel Size to choose for filter
        sigma (float): Sigma to choose for filter
        strength (float): Strength to choose

    Returns:
        np.array: Sharpened image
    """
    final_img = np.zeros_like(image)
    num_channels = image.shape[2]
    for i in range(num_channels):
        final_img[:,:,i] = unsharp(image[:,:,i], kernel_size, sigma, strength)
    
    return final_img

def unsharp(image, kernel_size, sigma, strength):

    gauss = cv2.GaussianBlur(image, (kernel_size, kernel_size), sigma)
    sharpened_img = cv2.addWeighted(image, 1 + strength, gauss, -strength, 0)
    
    return sharpened_img