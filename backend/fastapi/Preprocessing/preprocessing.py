# 전처리 총괄 서버
import base64

from fastapi import FastAPI
from CIHP import inference_pgn as cihp
from U2Net.u2net_test import main as u2test
from RemBg.rb import remove_yes_bg, remove_no_bg
import os
import tempfile
from pydantic import BaseModel
import json
import datetime


class Req(BaseModel):
    file_name: str
    file: bytes
    path: str


print("FastAPI Server booting....")
app = FastAPI()
print("FastAPI Server started")

def delete_file(path):
    if os.path.exists(path):
        os.remove(path)
    else:
        print(f"{path} 파일이 존재하지 않습니다.")
        
# 폴더 내의 모든 파일을 삭제
def clear_folder(folder_path):
    for filename in os.listdir(folder_path):
        file_path = os.path.join(folder_path, filename)
        try:
            if os.path.isfile(file_path):
                os.remove(file_path)
#                 print(f"파일 삭제: {file_path}")
        except Exception as e:
            print(f"파일 삭제 실패: {file_path}, 오류: {str(e)}")

@app.get("/")
def welcome():
    print("welcome called")
    return "welcome"


@app.post("/cihp")  #사람부위별 마스킹 # 미완성
def run_cihp(file: dict):
    print(f"run_cihp called at {datetime.datetime.now()}")
    # 0. 폴더를 비운다
    temp_file_path = "./CIHP/datasets/images/"
    clear_folder(temp_file_path)

    # 1. 바이트 코드를 임시 저장한다.
    file_name = "temp"
    with tempfile.NamedTemporaryFile(suffix=".jpg", delete=False, dir=temp_file_path) as temp_file:
        temp_file.write(base64.b64decode(file["file"]))
        file_name, file_extension = os.path.splitext(os.path.basename(temp_file.name))

    # 2. 해당 파일에 대해 CIHP를 돌린다.
    try:
        cihp.main()
    except tensorflow.python.framework.errors_impl.NotFoundError as e:
        print(f"An NotFoundError occurred: {e}")
        return json.dumps({"result": "실패", "cihp": None})
    except Exception as e:
        print(f"An unidentified error occurred: {e}")
        return json.dumps({"result": "실패", "cihp": None})

    # 3. Json으로 변환하여 반환한다.
    try:
        cihpFile = ""
        temp_path = "./CIHP/output/cihp_parsing_maps/" + file_name + ".png"
        if os.path.exists(temp_path):
            with open(temp_path, "rb") as file:
                cihpFile = base64.b64encode(file.read()).decode('utf-8')
        no_bg = ""
        return json.dumps({"result": "성공", "cihp": cihpFile})
    finally:
        # 4. 파일을 삭제한다.
        delete_file(temp_file_path + file_name + ".jpg")
        delete_file(r"./CIHP/output/cihp_edge_maps/" + file_name + ".png")
        delete_file(r"./CIHP/output/cihp_parsing_maps/" + file_name + "_vis.png")
        delete_file(r"./CIHP/output/cihp_parsing_maps/" + file_name + ".png")


@app.post("/u2net")
def run_u2net(file: dict):
    print(f"run_u2net called at {datetime.datetime.now()}")
    # 0. 폴더를 비운다
    temp_file_path = r"./U2Net/test_data/test_images/"
    clear_folder(temp_file_path)
    
    # 1. 바이트 코드를 임시 저장한다.
    file_name = "temp"
    with tempfile.NamedTemporaryFile(suffix=".png", delete=False, dir=temp_file_path) as temp_file:
        temp_file.write(base64.b64decode(file["file"]))
        file_name, file_extension = os.path.splitext(os.path.basename(temp_file.name))

    # 2. 해당 파일에 대해 u2net을 돌린다.
    try:
        u2test()
    except tensorflow.python.framework.errors_impl.NotFoundError as e:
        print(f"An NotFoundError occurred: {e}")
        return json.dumps({"result": "실패", "u2net": None})
    except Exception as e:
        print(f"An unidentified error occurred: {e}")
        return json.dumps({"result": "실패", "u2net": None})

    # 3. Json으로 변환하여 반환한다.
    try:
        u2net = ""
        temp_path = r"./U2Net/test_data/u2net_results/" + file_name + ".jpg"
        if os.path.exists(temp_path):
            with open(temp_path, "rb") as file:
                u2net = base64.b64encode(file.read()).decode('utf-8')
        no_bg = ""
        return json.dumps({"result": "성공", "u2net": u2net})
    finally:
        # 4. 파일을 삭제한다.
        delete_file(temp_file_path + file_name + file_extension)
        delete_file(r"./U2Net/test_data/u2net_results/" + file_name + ".jpg")


@app.post("/rembg")
async def run_rembg(file: dict):
    print(f"run_rembg called at {datetime.datetime.now()}")
    file_name = "temp"

    # 1. 바이트 코드를 임시 저장한다.
    temp_file_path = "./"
    with tempfile.NamedTemporaryFile(suffix=".png", delete=False, dir=temp_file_path) as temp_file:
        temp_file.write(base64.b64decode(file["file"]))
        temp_file_path = temp_file.name

    # 2. 해당 파일에 대해 rembg를 각각 돌린다.
    try:
        remove_yes_bg(temp_file_path, r"./RemBg/yes_bg/" + file_name + ".jpg")
        remove_no_bg(temp_file_path, r"./RemBg/no_bg/" + file_name + ".png")
    except tensorflow.python.framework.errors_impl.NotFoundError as e:
        print(f"An NotFoundError occurred: {e}")
        return json.dumps({"result": "실패", "file_yes_bg": None, "file_no_bg": None})
    except Exception as e:
        print(f"An unidentified error occurred: {e}")
        return json.dumps({"result": "실패", "file_yes_bg": None, "file_no_bg": None})

    # 3. Json으로 변환하여 반환한다.
    try:
        yes_bg = ""
        temp_path = r"./RemBg/yes_bg/" + file_name + ".jpg"
        if os.path.exists(temp_path):
            with open(temp_path, "rb") as file:
                yes_bg = base64.b64encode(file.read()).decode('utf-8')
        no_bg = ""
        temp_path = r"./RemBg/no_bg/" + file_name + ".png"
        if os.path.exists(temp_path):
            with open(temp_path, "rb") as file:
                no_bg = base64.b64encode(file.read()).decode('utf-8')
        return json.dumps({"result": "성공", "file_yes_bg": yes_bg, "file_no_bg": no_bg})

    finally:
        # 4. 파일을 삭제한다.
        delete_file(temp_file_path)
        delete_file(r"./RemBg/yes_bg/" + file_name + ".jpg")
        delete_file(r"./RemBg/no_bg/" + file_name + ".png")

# @app.post("/rembg/cloth")    #옷
# def run_rembg_for_cloth(body:req):
#     print("run_rembg_cloth called")
#     print(body)
#     # 1. req body에서 사진 바이트코드를 받는다.
#     # 2. 바이트 코드를 임시 저장한다.
#
#
#     # 3. 해당 파일에 대해서 rembg를 각각 돌린다.
#     remove_yes_bg(r"cloth/original/" + req.file_name + ".png", r"./cloth/yes_bg/" + req.file_name + ".jpg")
#     remove_no_bg(r"cloth/original/" + req.file_name + ".png", r"./cloth/no_bg/" + req.file_name + ".png")
#
#     # 4. 작업이 끝나면 파일을 S3서버에 올린다
#     try:
#         s3.upload_file(r".cloth/yes_bg/" + req.file_name + ".jpg", bucket_name,
#                        r"cloth/yes_bg/" + req.file_name + ".jpg")
#         s3.upload_file(r".cloth/no_bg/" + req.file_name + ".png", bucket_name,
#                        r"cloth/no_bg/" + req.file_name + ".png")
#     except boto3.exceptions.NoCredentialsError:
#         return "AWS 자격 증명을 찾을 수 없습니다. 자격 증명을 설정하세요."
#     except boto3.exceptions.EndpointConnectionError:
#         return "S3 엔드포인트에 연결할 수 없습니다. 리전을 확인하세요."
#
#     # 6. 다운 받았던 파일과 결과 파일을 삭제한다.
#     try:
#         os.remove(r"./cloth/original/" + req.file_name + ".jpg")
#         os.remove(r"./cloth/yes_bg/" + req.file_name + ".jpg")
#         os.remove(r"./cloth/no_bg/" + req.file_name + ".png")
#     except FileNotFoundError:
#         print(f"파일이 존재하지 않습니다")
#     except Exception as e:
#         print(f"파일 삭제 중 오류 발생: {e}")
#
#     # 7. 호출자에게 완료를 반환한다.
#     return {"result": "성공", "stdout": stdout}
#
#
#
# @app.post("/rembg/photo")    #사람사진 누끼
# def run_rembg_for_photo(body:req):
#     print("run_rembg_photo called")
#     print(body)
#     #file_name은 계속써두 됨 photo_img_name
#     # 1. 요청한 계정에 요청받은 파일명이 존재하는지 DB에서 확인한다
#     sql = ("SELECT photo_img_name, member_seq "
#        "FROM member JOIN photo USING (member_seq) "
#        "WHERE member_id = %s AND photo_img_name = %s")
#     cursor.execute(sql, (req.member_id, req.file_name))
#
#     # 2. 없다면 에러 보내고, 있다면 해당 파일을 다운 받는다.
#     results = cursor.fetchall()
#     if len(results) == 0:
#         return {"result": "실패", "stdout": "검색결과 없음"}    #임시
#     member_seq = results[0][1]
#     s3.download_file(bucket_name, r"photo/original/" + req.file_name + ".png", r"photo/original/" + req.file_name + ".png")
#
#     # 3. 해당 파일에 대해서 rembg를 각각 돌린다.
#     remove_yes_bg(r"photo/original/" + req.file_name + ".png", r"./photo/yes_bg/" + req.file_name + ".jpg")
#     remove_no_bg(r"photo/original/" + req.file_name + ".png", r"./photo/no_bg/" + req.file_name + ".png")
#
#
#     # 4. 작업이 끝나면 파일을 S3서버에 올린다
#     try:
#         s3.upload_file(r".photo/yes_bg/" + req.file_name + ".jpg", bucket_name,
#                        r"photo/yes_bg/" + req.file_name + ".jpg")
#         s3.upload_file(r".photo/no_bg/" + req.file_name + ".png", bucket_name,
#                        r"photo/no_bg/" + req.file_name + ".png")
#     except boto3.exceptions.NoCredentialsError:
#         return "AWS 자격 증명을 찾을 수 없습니다. 자격 증명을 설정하세요."
#     except boto3.exceptions.EndpointConnectionError:
#         return "S3 엔드포인트에 연결할 수 없습니다. 리전을 확인하세요."
#
#     # 5. DB에 작업이 되어 있음으로 업데이트 한다.
#     sql = ("update photo"
#            "set photo_img_no_bg = 1, photo_img_yes_bg = 1"          ###다시보기
#            "where photo_img_name = %s and member_seq = %s")
#     cursor.execute(sql, (req.file_name, member_seq))  #file_name
#
#     # 6. 다운 받았던 파일과 결과 파일을 삭제한다.
#     try:
#         os.remove(r"./photo/original/" + req.file_name + ".jpg")
#         os.remove(r"./photo/yes_bg/" + req.file_name + ".jpg")
#         os.remove(r"./photo/no_bg/" + req.file_name + ".png")
#     except FileNotFoundError:
#         print(f"파일이 존재하지 않습니다")
#     except Exception as e:
#         print(f"파일 삭제 중 오류 발생: {e}")
#
#     # 7. 호출자에게 완료를 반환한다.
#     return {"result": "성공", "stdout": stdout}
