import cv2
import numpy as np


def sharpenHandler(image: np.array, params: dict) -> np.array:
    """Sharpening Image handler

    Args:
        image (np.array): image to change
        params (dict): params has { kernel_size: int (odd, [1, 3, 5, 7, 9, 11]), strength: float ([0 - 10], step size of 0.5)}

    Returns:
        np.array: Sharpened image
    """


    if 'strength' not in params or 'kernel_size' not in params :
        return image

    if params['strength'] > 10 :
        params['strength'] = 10
    elif  params['strength'] < 0 :
        params['strength'] = 0

    params['kernel_size'] = round(params['kernel_size'])
    params['kernel_size'] += 1 if params['kernel_size'] % 2 == 1 else 0
    
    new_img = sharpenImage(image, params['kernel_size'], float(params['strength']))
    return new_img


def sharpenImage(image: np.array, kernel_size: int, strength: float) -> np.array:
    """Sharpening of the image

    Args:
        image (np.array): image to change
        kernel_size (int): Kernel Size to choose for filter
        strength (float): Strength to choose

    Returns:
        np.array: Sharpened image
    """
    final_img = np.zeros_like(image)
    num_channels = image.shape[2]
    for i in range(num_channels):
        final_img[:,:,i] = unsharp(image[:,:,i], kernel_size, strength)
    
    return final_img

def unsharp(image: np.array, kernel_size: int, strength: float) -> np.array:

#     gauss = cv2.GaussianBlur(image, (kernel_size, kernel_size), sigma)
    mf = cv2.medianBlur(image, kernel_size)
    sharpened_img = cv2.addWeighted(image, 1 + strength, mf, -strength, 0)
    
    return sharpened_img