# tf-eventbridge-ecs-run-task-script

tf-eventbridge-ecs-run-task リポジトリで使うサンプル用イメージ。

このリポジトリを使うことで、簡単にサンプル用のイメージを ECR にプッシュ、ECR のイメージを使ったタスク定義をプッシュすることができる。

## コンテナイメージをプッシュするまでの手順

1. AWS アカウント内で ECR を作成し、ECR のイメージ URI を控えておく。
2. 以下コマンドで ECR にプッシュできるよう、Docker にログインする。

```
aws ecr get-login-password --region ap-northeast-1 | docker login --username AWS --password-stdin <ECR のイメージ URI>
```

3. 以下コマンドを実行してイメージをビルド、ECR にプッシュする。

```
cd tf-eventbridge-run-ecs-task-script
echo "ECR_IMAGE_URI=ECRのイメージURI:latest" > .env
# イメージをプッシュ
scripts/build-and-push-image.sh
```

## タスク定義をプッシュするまでの手順

1. S3 バケットを作成する。
2. 以下のコマンドを実行する。(ECS のタスク実行ロール、タスクロールは仮で入れておいて、後から作るでも OK)

```
# プロジェクトルートに移動
cd tf-eventbridge-run-ecs-task-script
echo "ECS_ROLE_ARN=arn:aws:iam::アカウントID:role/ecs-scheduler-example-ecs-task-role" >> .env
echo "ECS_EXECUTION_ROLE_ARN=arn:aws:iam::アカウントID:role/ecs-scheduler-example-ecs-task-execution-role" >> .env
echo "S3_BUCKET=結果格納先バケット名" >> .env
# タスク定義をプッシュ
scripts/push-task-definition.sh
```
