"""
All function mapping to string
"""

import cv2
import numpy as np

# only for now


def gray(img: np.array) -> np.array:
    gray = np.stack((cv2.cvtColor(img, cv2.COLOR_BGR2GRAY),) * 3, axis=-1)
    return gray


functions = {
    'gray': gray
}
