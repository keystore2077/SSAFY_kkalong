from rembg import remove
from PIL import Image


def remove_yes_bg(original_file_path: str, output_yes_bg: str):
    with Image.open(original_file_path) as img:
        result = Image.new("RGB", img.size, "white")
        out = remove(img)
        result.paste(out, mask=out)
        result.save(output_yes_bg, format='JPEG')
        out.close()


def remove_no_bg(original_file_path: str, output_no_bg: str):
    original = Image.open(original_file_path)  # load image
    output_image_transparent_bg = remove(original, alpha=True)  # 투명 배경의 PNG 이미지
    output_image_transparent_bg.save(output_no_bg, format='PNG')
    print(output_no_bg)
    output_image_transparent_bg.close() #작업 끝나면 닫기


