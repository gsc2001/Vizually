import cv2
import numpy as np


class Image:
    def __init__(self, path: str, img: np.array = None):
        self.path = path
        if img is not None:
            self.img = img

    def load(self):
        self.img = cv2.imread(self.path)
