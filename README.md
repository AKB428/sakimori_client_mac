#SAKIMORI Client for mac

## 概要

チャットボットで監視カメラサービスする「SAKIMORI」のmac clientです

```
ruby sakimori_client [client_keyword] [AWS SQS URL (recv)] [Image Folder] [SAKIMORI image server] [AWS SQS URL (send)]
```

```
ruby sakimori_client mac1 https://sqs.ap-northeast-1.amazonaws.com/XXXXXX/bot_camera  ~/image/ http://hogehoge.com/image-upload https://sqs.ap-northeast-1.amazonaws.com/XXXXXX/image_url
```

## 必要なもの

* Mac imagesnap コマンドライン
* AWS SQS アカウント
