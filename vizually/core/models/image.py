import cv2
import numpy as np


class Image:
    def __init__(self, img: np.array = None):
        self.path = None
        self.img = None
        if img is not None:
            self.img = img

    def load(self, path):
        self.path = path[7:]
        self.img = cv2.imread(self.path)
