from fastapi import FastAPI
from fastapi import HTTPException
from decouple import config
import pymysql
import boto3
from botocore.exceptions import NoCredentialsError
import os
import random
from datetime import datetime

from test import main as viton
from request_body import rb

app = FastAPI()

# DB 설정
connection = pymysql.connect(
    host=config('MYSQL_HOST'),
    user=config('MYSQL_USER'),
    password=config('MYSQL_PASSWORD'),
    database=config('MYSQL_DB'),
    charset='utf-8'
)

# DB 커서 생성
cursor = connection.cursor()

# AWS 자격 증명 및 S3 클라이언트 생성
s3 = boto3.client('s3',
                  aws_access_key_id=config('AWS_ACCESS_KEY'),
                  aws_secret_access_key=config('AWS_SECRET_KEY'),
                  region_name=config('AWS_REGION')  # AWS 리전 설정
                  )
bucket_name = config('AWS_BUCKET')


@app.get("/")
def welcome():
    print("welcome called")
    return "welcome to server for openpose"


@app.post("/")
async def run_viton_hd(body: rb):
    print("run_viton_hd called")
    # 1. DB에 모든 전처리가 되어 있는지 확인한다.
    sql_photo = ("select member_seq, cloth_img_yes_bg, cloth_img_masking"
                 "from member join photo using member_seq"
                 "where member_id = %s and photo_img_name = %s")
    cursor.execute(sql_photo, (body.member_id, body.photo_img_name))
    result_photo = cursor.fetchall()

    sql_cloth = ("select member_seq, cloth_img_yes_bg, cloth_img_masking"
                 "from member join cloth using member_seq"
                 "where member_id = %s and cloth_img_name = %s")
    cursor.execute(sql_cloth, (body.member_id, body.cloth_img_name))
    result_cloth = cursor.fetchall()

    # 1.1. 전처리가 하나라도 안되어 있으면 종료한다
    if len(result_cloth) == 0 or len(result_photo) == 0:
        return "전처리 안되어 있음"

    # 2. S3서버에서 전처리 파일들을 전부 받아온다
    input_path_prefix = r"./datasets/test/"
    try:
        # 옷 사진
        s3.download_file(bucket_name, r"cloth/yes_bg/" + rb.cloth_img_name + ".jpg",
                         input_path_prefix + r"cloth/" + rb.cloth_img_name + ".jpg")
        # 옷 마스킹 사진
        s3.download_file(bucket_name, r"cloth/masking/" + rb.cloth_img_name + ".jpg",
                         input_path_prefix + r"cloth-mask/" + rb.cloth_img_name + ".jpg")
        # 사람 사진
        s3.download_file(bucket_name, r"photo/yes_bg/" + rb.photo_img_name + ".jpg",
                         input_path_prefix + r"image/" + rb.photo_img_name + ".jpg")
        # 사람 사진 파싱
        s3.download_file(bucket_name, r"photo/masking/" + rb.photo_img_name + ".png",
                         input_path_prefix + r"image-parse/" + rb.photo_img_name + ".png")
        # 사람 사진 openpose 이미지
        s3.download_file(bucket_name, r"photo/openpose/img/" + rb.photo_img_name + ".png",
                         input_path_prefix + r"openpose-img/" + rb.photo_img_name + "_rendered.png")
        # 사람 사진 openpose json
        s3.download_file(bucket_name, r"photo/openpose/json/" + rb.photo_img_name + ".json",
                         input_path_prefix + r"openpose-json/" + rb.photo_img_name + "_keypoints.json")
    except boto3.exceptions.NoCredentialsError:
        return "AWS 자격 증명을 찾을 수 없습니다. 자격 증명을 설정하세요."
    except boto3.exceptions.EndpointConnectionError:
        return "S3 엔드포인트에 연결할 수 없습니다. 리전을 확인하세요."

    # 2.1. 서버 소통 실패하면 다운 받은 파일 지우고 종료

    # 3. test_pairs.txt를 수정하고 viton을 돌린다
    with open(input_path_prefix + "test_pairs.txt", "w") as file:
        file.write(f"{rb.photo_img_name} {rb.cloth_img_name}\n")
    viton()

    # 4. 임시용 S3서버에 저장한다.
    try:
        # 현재 시간을 YYMMDD_HHMMSS 형식으로 가져오기
        current_time = datetime.now().strftime("%y%m%d_%H%M%S")

        # 6자리의 무작위 난수 생성
        random_number = str(random.randint(0, 999999)).zfill(6)

        temp_file_name = f"fashion_{body.member_id}_{current_time}_{random_number}.jpg"

        s3.upload_file(r"./results/test/" + f"{rb.photo_img_name}_{rb.cloth_img_name}.jpg", bucket_name,
                       f"fashion_temp/{temp_file_name}")
    except boto3.exceptions.NoCredentialsError:
        return "AWS 자격 증명을 찾을 수 없습니다. 자격 증명을 설정하세요."
    except boto3.exceptions.EndpointConnectionError:
        return "S3 엔드포인트에 연결할 수 없습니다. 리전을 확인하세요."

    # 5. 사용자에게 성공을 반환 한다.
    url = s3.generate_presigned_url(
        ClientMethod='get_object',
        Params={'Bucket': bucket_name, 'Key': r"fashion_temp/" + temp_file_name},
        ExpiresIn=3600
    )
    return {"message": "success", "url": url}


@app.get("/download/{file_name}")
async def get_fashion(file_name: str):
    try:
        # S3에서 파일 다운로드 URL 생성
        url = s3.generate_presigned_url(
            ClientMethod='get_object',
            Params={'Bucket': bucket_name, 'Key': r"fashion/" + file_name},
            ExpiresIn=3600
        )
        return {"download_link": url}
    except NoCredentialsError:
        return {"error": "AWS credentials not available"}
