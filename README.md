#SAKIMORI Client for mac

## 概要

チャットボットで監視カメラサービスする「SAKIMORI」のmac clientです

```
ruby sakimori_client [client_keyword] [AWS SQS URL] [Image Folder] [SAKIMORI image server]
```

```
ruby sakimori_client mac1 https://sqs.ap-northeast-1.amazonaws.com/XXXXXX/bot_camera  ~/image/ http://hogehoge.com/image-upload
```

## 必要なもの

* Mac imagesnap コマンドライン
* AWS SQS アカウント
