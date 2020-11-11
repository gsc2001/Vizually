"""
All function mapping to string
"""

import cv2
import numpy as np
from ...core.modules import *

def gray(img: np.array, params: dict) -> np.array:
    print(f"In function: {params}")
    gray = np.stack((cv2.cvtColor(img, cv2.COLOR_BGR2GRAY),) * 3, axis=-1)
    return gray


functions = {
    'gray': gray,
    'rotate': rotate.rotateHandler,
    'avgBlur': averageBlur.averageBlurringHandler,
    'gaussianBlur': gaussianBlur.gaussianBlurringHandler,
    'bilateralBlur': bilateralBlur.bilateralBlurringHandler,
    'thres': AdaptiveThresholding.adaptiveThresholdingHandler,
    'sharpen': sharpening.sharpenHandler,
}
