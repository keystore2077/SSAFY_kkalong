import argparse
import os
from fastapi import FastAPI
import torch
from torch import nn
from torch.nn import functional as F
import torchgeometry as tgm

from datasets import VITONDataset, VITONDataLoader
from networks import SegGenerator, GMM, ALIASGenerator
from utils import gen_noise, load_checkpoint, save_images

import base64
import os
import json
import uvicorn


app = FastAPI()  # FastAPI 애플리케이션을 생성합니다.


@app.get("/")
async def read_root():
    # 이 부분은 FastAPI 서버의 루트 엔드포인트입니다.
    # 필요한 로직을 추가하세요.
    return "Welcome to the FastAPI server!"

@app.post("/viton")
async def run_viton_hd(file: dict):
    print("run_viton_hd called")
    # 1. 바이트 코드를 임시 저장한다.
    file_path = r"./datasets/test/"
    cloth_name = file["cloth_name"]
    print(cloth_name)

    cloth_path = file_path + r"cloth/" + cloth_name + ".jpg"
    cloth_mask_path = file_path + r"cloth-mask/" + cloth_name + ".jpg"

    image_name = file["image_name"]
    print(image_name)

    image_path = file_path + r"image/" + image_name + ".jpg"
    image_parse_path = file_path + r"image-parse/" + image_name + ".png"
    openpose_img_path = file_path + r"openpose-img/" + image_name + "_rendered.png"
    openpose_json_path = file_path + r"openpose-json/" + image_name + "_keypoints.json"

    # 1.1. 옷 사진 저장
    with open(cloth_path, "wb") as temp_file:
        temp_file.write(base64.b64decode(file["cloth"]))
    # with tempfile.NamedTemporaryFile(prefix="", suffix=".jpg", delete=False, dir=cloth_path) as temp_file:
    #     temp_file.write(base64.b64decode(file["cloth"]))

    # 1.2. 옷 마스킹 사진 저장
    with open(cloth_mask_path, "wb") as temp_file:
        temp_file.write(base64.b64decode(file["cloth_mask"]))
    # with tempfile.NamedTemporaryFile(suffix=".jpg", delete=False, dir=cloth_mask_path) as temp_file:
    #     temp_file.write(base64.b64decode(file["cloth_mask"]))

    # 1.3. 사람 사진 저장
    with open(image_path, "wb") as temp_file:
        temp_file.write(base64.b64decode(file["image"]))
    # with tempfile.NamedTemporaryFile(suffix=".jpg", delete=False, dir=image_path) as temp_file:
    #     temp_file.write(base64.b64decode(file["image"]))

    # 1.4. 사람 파싱 이미지 저장
    with open(image_parse_path, "wb") as temp_file:
        temp_file.write(base64.b64decode(file["image_parse"]))
    # with tempfile.NamedTemporaryFile(suffix=".png", delete=False, dir=image_parse_path) as temp_file:
    #     temp_file.write(base64.b64decode(file["image_parse"]))

    # 1.5. 사람 openpose 사진 저장
    with open(openpose_img_path, "wb") as temp_file:
        temp_file.write(base64.b64decode(file["openpose_img"]))
    # with tempfile.NamedTemporaryFile(suffix=".png", delete=False, dir=openpose_img_path) as temp_file:
    #     temp_file.write(base64.b64decode(file["openpose_img"]))

    # 1.6. 사람 openpose json 저장
    with open(openpose_json_path, "wb") as temp_file:
        temp_file.write(base64.b64decode(file["openpose_json"]))
    # with tempfile.NamedTemporaryFile(suffix=".json", delete=False, dir=openpose_json_path) as temp_file:
    #     temp_file.write(base64.b64decode(file["openpose_json"]))

    print("전처리 파일 저장 완료")

    # 1.7. test_pairs.txt를 수정한다.
    with open(r"./datasets/test_pairs.txt", 'w') as file:
        file.write(f"{image_name}.jpg {cloth_name}.jpg")
    print("test_pairs 수정 완료")

    # 2. 해당 파일에 대해 CIHP를 돌린다.
    main()
    print("viton 처리 완료")

    # 3. Json으로 변환하여 반환한다.
    result_file = ""
    temp_path = "./results/test/" + image_name + "_" + cloth_name + ".jpg"
    try:
        if os.path.exists(temp_path):
            with open(temp_path, "rb") as file:
                result_file = base64.b64encode(file.read()).decode('utf-8')
        return json.dumps({"result": "성공", "viton": result_file})
    finally:
        print("!!!")
#         # 4. 파일을 삭제한다.
#         os.remove(temp_path)
#         os.remove(cloth_path)
#         os.remove(cloth_mask_path)
#         os.remove(image_path)
#         os.remove(image_parse_path)
#         os.remove(openpose_img_path)
#         os.remove(openpose_json_path)

def get_opt():
    parser = argparse.ArgumentParser()
    # parser.add_argument('--name', type=str, required=True)
    parser.add_argument('--name', type=str, default='test')

    parser.add_argument('-b', '--batch_size', type=int, default=1)
    parser.add_argument('-j', '--workers', type=int, default=1)
    parser.add_argument('--load_height', type=int, default=1024)
    parser.add_argument('--load_width', type=int, default=768)
    parser.add_argument('--shuffle', action='store_true')

    parser.add_argument('--dataset_dir', type=str, default='./datasets/')
    parser.add_argument('--dataset_mode', type=str, default='test')
    parser.add_argument('--dataset_list', type=str, default='test_pairs.txt')
    parser.add_argument('--checkpoint_dir', type=str, default='./checkpoints/')
    parser.add_argument('--save_dir', type=str, default='./results/')

    parser.add_argument('--display_freq', type=int, default=1)

    parser.add_argument('--seg_checkpoint', type=str, default='seg_final.pth')
    parser.add_argument('--gmm_checkpoint', type=str, default='gmm_final.pth')
    parser.add_argument('--alias_checkpoint', type=str, default='alias_final.pth')

    # common
    parser.add_argument('--semantic_nc', type=int, default=13, help='# of human-parsing map classes')
    parser.add_argument('--init_type', choices=['normal', 'xavier', 'xavier_uniform', 'kaiming', 'orthogonal', 'none'], default='xavier')
    parser.add_argument('--init_variance', type=float, default=0.02, help='variance of the initialization distribution')

    # for GMM
    parser.add_argument('--grid_size', type=int, default=5)

    # for ALIASGenerator
    parser.add_argument('--norm_G', type=str, default='spectralaliasinstance')
    parser.add_argument('--ngf', type=int, default=64, help='# of generator filters in the first conv layer')
    parser.add_argument('--num_upsampling_layers', choices=['normal', 'more', 'most'], default='most',
                        help='If \'more\', add upsampling layer between the two middle resnet blocks. '
                             'If \'most\', also add one more (upsampling + resnet) layer at the end of the generator.')

    opt = parser.parse_args()
    return opt

def test(opt, seg, gmm, alias):
    up = nn.Upsample(size=(opt.load_height, opt.load_width), mode='bilinear')
    gauss = tgm.image.GaussianBlur((15, 15), (3, 3))
    gauss.cuda()

    test_dataset = VITONDataset(opt)
    test_loader = VITONDataLoader(opt, test_dataset)

    with torch.no_grad():
        for i, inputs in enumerate(test_loader.data_loader):
            img_names = inputs['img_name']
            c_names = inputs['c_name']['unpaired']

            img_agnostic = inputs['img_agnostic'].cuda()
            parse_agnostic = inputs['parse_agnostic'].cuda()
            pose = inputs['pose'].cuda()
            c = inputs['cloth']['unpaired'].cuda()
            cm = inputs['cloth_mask']['unpaired'].cuda()
            if cm.dim() > 4:
                cm = cm[:, :, :, :, 1]

            # Part 1. Segmentation generation
            parse_agnostic_down = F.interpolate(parse_agnostic, size=(256, 192), mode='bilinear')
            pose_down = F.interpolate(pose, size=(256, 192), mode='bilinear')
            c_masked_down = F.interpolate(c * cm, size=(256, 192), mode='bilinear')
            cm_down = F.interpolate(cm, size=(256, 192), mode='bilinear')
            seg_input = torch.cat((cm_down, c_masked_down, parse_agnostic_down, pose_down, gen_noise(cm_down.size()).cuda()), dim=1)

            parse_pred_down = seg(seg_input)
            parse_pred = gauss(up(parse_pred_down))
            parse_pred = parse_pred.argmax(dim=1)[:, None]

            parse_old = torch.zeros(parse_pred.size(0), 13, opt.load_height, opt.load_width, dtype=torch.float).cuda()
            parse_old.scatter_(1, parse_pred, 1.0)

            labels = {
                0:  ['background',  [0]],
                1:  ['paste',       [2, 4, 7, 8, 9, 10, 11]],
                2:  ['upper',       [3]],
                3:  ['hair',        [1]],
                4:  ['left_arm',    [5]],
                5:  ['right_arm',   [6]],
                6:  ['noise',       [12]]
            }
            parse = torch.zeros(parse_pred.size(0), 7, opt.load_height, opt.load_width, dtype=torch.float).cuda()
            for j in range(len(labels)):
                for label in labels[j][1]:
                    parse[:, j] += parse_old[:, label]

            # Part 2. Clothes Deformation
            agnostic_gmm = F.interpolate(img_agnostic, size=(256, 192), mode='nearest')
            parse_cloth_gmm = F.interpolate(parse[:, 2:3], size=(256, 192), mode='nearest')
            pose_gmm = F.interpolate(pose, size=(256, 192), mode='nearest')
            c_gmm = F.interpolate(c, size=(256, 192), mode='nearest')
            gmm_input = torch.cat((parse_cloth_gmm, pose_gmm, agnostic_gmm), dim=1)

            _, warped_grid = gmm(gmm_input, c_gmm)
            warped_c = F.grid_sample(c, warped_grid, padding_mode='border')
            warped_cm = F.grid_sample(cm, warped_grid, padding_mode='border')

            # Part 3. Try-on synthesis
            misalign_mask = parse[:, 2:3] - warped_cm
            misalign_mask[misalign_mask < 0.0] = 0.0
            parse_div = torch.cat((parse, misalign_mask), dim=1)
            parse_div[:, 2:3] -= misalign_mask

            output = alias(torch.cat((img_agnostic, pose, warped_c), dim=1), parse, parse_div, misalign_mask)

            unpaired_names = []
            for img_name, c_name in zip(img_names, c_names):
                unpaired_names.append('{}_{}'.format(img_name.split('.')[0], c_name))
            print("==============================================================")
            print(unpaired_names)

            save_images(output, unpaired_names, os.path.join(opt.save_dir, opt.name))

            if (i + 1) % opt.display_freq == 0:
                print("step: {}".format(i + 1))


def main():
    opt = get_opt()
    print(opt)

    if not os.path.exists(os.path.join(opt.save_dir, opt.name)):
        os.makedirs(os.path.join(opt.save_dir, opt.name))

    seg = SegGenerator(opt, input_nc=opt.semantic_nc + 8, output_nc=opt.semantic_nc)
    gmm = GMM(opt, inputA_nc=7, inputB_nc=3)
    opt.semantic_nc = 7
    alias = ALIASGenerator(opt, input_nc=9)
    opt.semantic_nc = 13

    load_checkpoint(seg, os.path.join(opt.checkpoint_dir, opt.seg_checkpoint))
    load_checkpoint(gmm, os.path.join(opt.checkpoint_dir, opt.gmm_checkpoint))
    load_checkpoint(alias, os.path.join(opt.checkpoint_dir, opt.alias_checkpoint))

    seg.cuda().eval()
    gmm.cuda().eval()
    alias.cuda().eval()
    test(opt, seg, gmm, alias)

if __name__ == '__main__':
    uvicorn.run(app, host="0.0.0.0", port=4051)
