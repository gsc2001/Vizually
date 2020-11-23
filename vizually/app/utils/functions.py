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
    'thres': adaptiveThresholding.adaptiveThresholdingHandler,
    'avgBlur': averageBlur.averageBlurringHandler,
    'bilateralBlur': bilateralBlur.bilateralBlurringHandler,
    'blend': blending.blendingHandler,
    'cannyCartoon': cannyCartoon.cannyCartoonHandler,
    'canny': cannyEdgeDetection.cannyEDHandler,
    'colorSheet': colorSheet.colorSheetHandler,
    'contour': contour.contourHandler,
    'corner': cornerDetection.cornerDetectionHandler,
    'dayLight': dayLight.dayLightHandler,
    'embossFilter': embossFilter.embossHandler,
    'flip': flip.flipHandler,
    'gaussianBlur': gaussianBlur.gaussianBlurringHandler,
    'contrast': histogramManipulation.histogramManipulationHandler,
    'hue': hue.hueHandler,
    'interpolation': interpolation.interpolationHandler,
    'invert': invert.invertHandler,
    'masking': masking.maskingHandler,
    'otsuThres': otsuThresholding.OtsuThresholdingHandler,
    'pencilSketch': pencilSketch.pencilSketchHandler,
    'perspective': perspective.perspectiveHandler,
    'ridge': ridgeDetector.ridgeDetectorHandler,
    'rotate': rotate.rotateHandler,
    'sepia': sepia.sepiaHandler,
    'sharpen': sharpening.sharpenHandler,
    'sobel': sobelEdgeDetection.sobelEDHandler,
    'splash': splash.splashHandler,
    'summer': summerFilter.summerHandler,
    'threshCartoon': threshCartoon.threshCartoonHandler,
    'absThres': thresholding.threshHandler,
    'winter': winterFilter.winterHandler,
}
