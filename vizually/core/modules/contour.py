import cv2
import numpy as np


def contourHandler(image: np.array, params: dict) -> np.array:
    """Contour handler

    Args:
        image(np.array): image to change
        params (dict): params has { show_contour, show_bounding_box, show_centroid, thres_strength } first three boolean last one should range in (0, 255)

    Returns:
        np.array: Image with contour, bounding-box or centroid showing if params are true
    """
    if ('show_contour' not in params) or ('show_bounding_box' not in params) or ('show_centroid' not in params) or ('thres_strength' not in params):
        return image

    if params['show_contour'] is False and params['show_bounding_box'] is False and params['show_centroid'] is False:
        return image

    if params['thres_strength'] > 255:
        params['thres_strength'] = 255
    if params['thres_strength'] < 0:
        params['thres_strength'] = 0

    new_img = contour(
        image, params['show_contour'], params['show_bounding_box'], params['show_centroid'], round(params['thres_strength']))
    return new_img


def contour(image: np.array, show_contour: bool, show_bounding_box: bool, show_centroid: bool, thres_strength: float) -> np.array:
    """Apply contour modifications on the image

    Args:
        image (np.array): image to change
        show_contour: To show the contours on the image
        show_bounding_box: To show the bounding boxes on the image
        show_centroid: To show the centroids on the image

    Returns:
        np.array: image with the asked modification
    """
    copy = image.copy()
    gray = cv2.cvtColor(copy, cv2.COLOR_RGB2GRAY)
    ret, thresh = cv2.threshold(
        gray, thres_strength, 255, cv2.THRESH_BINARY_INV)
    contours, hierarchy = cv2.findContours(
        thresh, cv2.RETR_TREE, cv2.CHAIN_APPROX_TC89_KCOS)
    if show_contour is True:
        cv2.drawContours(copy, contours, -1, (0, 255, 0), 2)
    if show_bounding_box is True:
        for i in range(len(contours)):
            x, y, w, h = cv2.boundingRect(contours[i])
            cv2.rectangle(copy, (x, y), (x+w, y+h), (0, 255, 255), 2)
    if show_centroid is True:
        for i in range(len(contours)):
            M = cv2.moments(contours[i])
            if M['m00'] == 0:
                continue
            cx = int(M['m10']/M['m00'])
            cy = int(M['m01']/M['m00'])
            cv2.circle(copy, (cx, cy), 2, (255, 0, 0), -1)

    return copy
