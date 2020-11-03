import cv2
import numpy as np

from models.image import Image
from modules.sharpening import sharpenHandler

def cornerDetectionHandler(image: Image, params: dict) -> Image:
    """Corner Detection Handler

    Args:
        image(np.array): image to change
         params (dict): params has { kernel_size: int (odd, [1, 3, 5, 7, 9, 11]), sharpen_strength: float ([0 - 10], step size of 0.5)}

    Returns:
        np.array: Image with corners
    """
    new_img = cornerDetect(image, params['kernel_size'], params['sharpen_strength'])
    new_image = Image(path=image.path, img=new_img)
    return new_image


def cornerDetect(image: Image, kernel_size: int, strength: float) -> np.array:
    """Detect corners in the image

    Args:
        image (np.array): image to change

    Returns:
        np.array: corners in image
    """
    #Make copy to display corners
    n_image = image.img
    copy = n_image.copy()
    
    # Sharpen The Image
    sharpened_img = sharpenHandler(image, {'kernel_size': kernel_size, 'strength': strength})
    sharpened_img = sharpened_img.img
    
    # Find Corners
    gray = cv2.cvtColor(sharpened_img, cv2.COLOR_BGR2GRAY)
    gray = np.float32(gray)
    dst = cv2.cornerHarris(gray, 2, 3, 0.04)
    dst = cv2.dilate(dst, None)
    thresh = 0.1 * dst.max()
    
    #Display Corners
    for j in range(0, dst.shape[0]):
        for i in range(0, dst.shape[1]):
            if dst[j,i] > thresh:
                cv2.circle(copy, (i, j), 1, (0,255,0), -1)
    
    return copy
