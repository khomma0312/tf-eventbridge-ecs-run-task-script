import logging
import os

import boto3

# log
logger = logging.getLogger()
logger.setLevel(logging.INFO)

S3_BUCKET = os.environ.get("S3_BUCKET")
JOB_NAME = os.environ.get("JOB_NAME")

def upload_to_s3():
    try:
        # S3クライアントを作成
        s3_client = boto3.client("s3")

        # S3にアップロード
        s3_client.put_object(
            Bucket=S3_BUCKET,
            Key=f"jobs/test.txt",
            Body="./test.txt",
        )

        logger.info(f"Data successfully uploaded to S3: {S3_BUCKET}")

    except Exception as e:
        logger.error(f"An error occurred: {e}")

if __name__ == "__main__":
    upload_to_s3()
