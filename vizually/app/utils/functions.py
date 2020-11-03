"""
All function mapping to string
"""

import cv2
import numpy as np

from ...core.modules.rotate import rotateHandler


def gray(img: np.array, params: dict) -> np.array:
    print(f"In function: {params}")
    gray = np.stack((cv2.cvtColor(img, cv2.COLOR_BGR2GRAY),) * 3, axis=-1)
    return gray


functions = {
    'rotate': rotateHandler
}
