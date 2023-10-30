from rembg import remove
from PIL import Image


def remove_bg(original_file_path: str, output_path: str):
    original = Image.open(original_file_path)  # load image
    output = remove(original)  # remove background
    output.save(output_path)  # save image

