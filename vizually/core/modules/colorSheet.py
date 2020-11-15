import cv2
import numpy as np

def colorSheetHandler(image: np.array, params: dict) -> np.array:
    """Canny Cartoon Handler

    Args:
        image(np.array): image to change
        params (dict): params has {'black_screen': bool, 'noRed': bool, 'noGreen': bool, 'noBlue': bool, 
        'redStrength': 0 - 2 (step size of 0.1), 'greenStrength': 0 - 2 (step size of 0.1), 'blueStrength': 0 - 2 (step size of 0.1)}


    Returns:
        np.array: Image with color sheet in front
    """
    if ('blueStrength' or 'greenStrength' or 'redStrength' or 'noRed' or 'noGreen' or 'noBlue' or 'black_screen') not in params:
        return image

    if params['redStrength'] > 2 :
        params['redStrength'] = 2
    elif  params['redStrength'] < 0 :
        params['redStrength'] = 0
        
    if params['greenStrength'] > 2 :
        params['greenStrength'] = 2
    elif  params['greenStrength'] < 0 :
        params['greenStrength'] = 0
        
    if params['blueStrength'] > 2 :
        params['blueStrength'] = 2
    elif  params['blueStrength'] < 0 :
        params['blueStrength'] = 0

    new_img = cartoon1(image, params['black_screen'], params['noRed'], params['noGreen'], params['noBlue'], params['redStrength'], params['greenStrength'], params['blueStrength'])
    return new_img

def cartoon1(image: np.array, black: bool, nor: bool, nog: bool, nob: bool, rstrength: float, gstrength: float, bstrength: float) -> np.array:
    """Apllies filter to the image

    Args:
        image (np.array): image to change

    Returns:
        np.array: New image
    """
    
    rstrength = rstrength / 10
    gstrength = gstrength / 10
    bstrength = bstrength / 10
    
    if black:
        rstrength = rstrength - 0.2
        gstrength = gstrength - 0.2
        bstrength = bstrength - 0.2
        
    rstrength = 1 + rstrength
    gstrength = 1 + gstrength
    bstrength = 1 + bstrength
        
    image[:, :, 0] = exponential_function(image[:, :, 0], bstrength)
    image[:, :, 1] = exponential_function(image[:, :, 1], gstrength)
    image[:, :, 2] = exponential_function(image[:, :, 2], rstrength)
    
    if nob:
        image[:, :, 0] = 0
    if nog:
        image[:, :, 1] = 0
    if nor:
        image[:, :, 2] = 0

    return image

def exponential_function(channel, exp):
    table = np.array([min((i ** exp), 255) for i in np.arange(0, 256)]).astype("uint8")
    channel = cv2.LUT(channel, table)
    return channel
