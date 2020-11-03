import numpy as np

import cv2

from ..models.image import Image

def perspectiveHandler(image: Image, params : dict)-> Image:
    """
    Args:
        image (np.array): image to change
        params (dict): params has { point_list}

        point_list is a list containing four 2D coordinates in ANY order
        taken as input from user

    Returns:
        np.array: transformed image

    """

    new_img = transformImage(image.img, params['rotation_angle'])
    new_image = Image(path=image.path, img=new_img)
    return new_image


def transformImage(image:Image, points: list)->Image:
    """
    Args:
        image (np.array): image to change
        points (list): points chosen by user

        point_list is a list containing four 2D coordinates in ANY order
        taken as input from user

    Returns:
        np.array: transformed image

    """

    point_list =  np.array(points, dtype = "float32")
    rect = order_points(point_list)
    (tl, tr, br, bl) = rect

    maxWidth = max(getDist(br,bl), getDist(tr, tl))
    maxHeight = max(getDist(tl, bl), getDist(tr, br))

    # order
    dst = np.array([
        [0, 0],
        [maxWidth - 1, 0],
        [maxWidth - 1, maxHeight - 1],
        [0, maxHeight - 1]], dtype = "float32")

    matrix = cv2.getPerspectiveTransform(rect, dst)
    return cv2.warpPerspective(image, matrix, (maxWidth, maxHeight))

def getDist(A, B):
    return int(np.sqrt(((A[0] - B[0]) ** 2) + ((A[1] - B[1]) ** 2)))


def order_points(point_list):
	# initialzie a list of coordinates that will be ordered
	# such that the first entry in the list is the top-left,
	# the second entry is the top-right, the third is the
	# bottom-right, and the fourth is the bottom-left
	rect = np.zeros((4, 2), dtype = "float32")
	# the top-left point will have the smallest sum, whereas
	# the bottom-right point will have the largest sum
	s = point_list.sum(axis = 1)
	rect[0] = point_list[np.argmin(s)]
	rect[2] = point_list[np.argmax(s)]
	# now, compute the difference between the points, the
	# top-right point will have the smallest difference,
	# whereas the bottom-left will have the largest difference
	diff = np.diff(point_list, axis = 1)
	rect[1] = point_list[np.argmin(diff)]
	rect[3] = point_list[np.argmax(diff)]
	# return the ordered coordinates
	return rect