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
    'thres': AdaptiveThresholding.adaptiveThresholdingHandler,
    'avgBlur': averageBlur.averageBlurringHandler,
    'bilateralBlur': bilateralBlur.bilateralBlurringHandler,
    'canny': cannyEdgeDetection.cannyEDHandler,
    'corner': cornerDetection.cornerDetectionHandler,
    'flip': flip.flipHandler,
    'gaussianBlur': gaussianBlur.gaussianBlurringHandler,
    'contrast': histogramManipulation.histogramManipulationHandler,
    'otsuThres': otsuThresholding.OtsuThresholdingHandler,
    'ridge': ridgeDetector.ridgeDetectorHandler,
    'rotate': rotate.rotateHandler,
    'sharpen': sharpening.sharpenHandler,
    'sobel': sobelEdgeDetection.sobelEDHandler,
    'thres': thresholding.threshHandler,
}
