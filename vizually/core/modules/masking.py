import cv2
import numpy as np


def maskingHandler(primary_image: np.array, params: dict) -> np.array:
    """ Masking Image Handler

    Args:
        primary_image and secondary_image (np.array): images to blend
        params (dict): params has {top_left_x, top_left_y, bottom_right_y, bottom_right_x, apply}

        secondary_image str (path of the image)
        top_left_x, top_left_y, bottom_right_y, bottom_right_x are coordinates of major diagonal of rectangle formed
        through selection box

    Returns:
        np.array: Masked image

    """
    if 'apply' not in params or params['apply'] is False or 'secondary_image' not in params or 'top_left_x' not in params or 'top_left_y' not in params or 'bottom_right_x' not in params or 'bottom_right_y' not in params:
        return primary_image

    if params['secondary_image'] == '':
        return primary_image

    params['top_left_x'] = 0 if params['top_left_x'] < 0 else params['top_left_x']
    params['top_left_y'] = 0 if params['top_left_y'] < 0 else params['top_left_y']
    params['top_left_x'] = primary_image.shape[1] if params['top_left_x'] > primary_image.shape[1] else params['top_left_x']
    params['top_left_y'] = primary_image.shape[0] if params['top_left_y'] > primary_image.shape[0] else params['top_left_y']

    params['bottom_right_x'] = 0 if params['bottom_right_x'] < 0 else params['bottom_right_x']
    params['bottom_right_y'] = 0 if params['bottom_right_y'] < 0 else params['bottom_right_y']
    params['bottom_right_x'] = primary_image.shape[1] if params['bottom_right_x'] > primary_image.shape[1] else params['bottom_right_x']
    params['bottom_right_y'] = primary_image.shape[0] if params['bottom_right_y'] > primary_image.shape[0] else params['bottom_right_y']

    new_img = maskImages(primary_image.copy(), cv2.imread(
        params['secondary_image'][7:]), round(params['top_left_x']), round(params['top_left_y']), round(params['bottom_right_x']), round(params['bottom_right_y']))
    return new_img


def get_background_type(image: np.array) -> bool:

    b, g, r, a = cv2.mean(cv2.blur(image, (7, 7)))
    avg = (b + g + r) / 3
    return True if avg > 170 else False


def maskImages(primary_image: np.array, secondary_image: np.array, tlx: int, tly: int, brx: int, bry: int) -> np.array:
    """Masking one image on another

        Args:
            primary_image and secondary_image (np.array): images to blend
            tlx, tly, brx, bry

        Returns:
            np.array: Masked image
    """
    is_light = get_background_type(secondary_image)

    secondary_image = cv2.resize(secondary_image, (brx - tlx, bry - tly))

    rows, cols, channels = secondary_image.shape
    roi = primary_image[tly:(tly + rows), tlx:(tlx+cols)]

    textGray = cv2.cvtColor(secondary_image, cv2.COLOR_BGR2GRAY)
    ret, mask = cv2.threshold(textGray, 220, 255, cv2.THRESH_BINARY)
    mask_inv = ~ mask

    if not is_light:
        mask, mask_inv = mask_inv, mask

    bg = cv2.bitwise_and(roi, roi, mask=mask)
    fg = cv2.bitwise_and(secondary_image, secondary_image, mask=mask_inv)
    out_img = cv2.add(fg, bg)

    primary_image[tly:(tly + rows), tlx:(tlx+cols)] = out_img
    return primary_image
