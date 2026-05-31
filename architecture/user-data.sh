#!/bin/bash

dnf install -y python3 python3-pip

pip3 install flask boto3

cat > /opt/app.py <<'EOF'
from flask import Flask
import boto3

app = Flask(__name__)

@app.route("/")
def index():
    try:
        content = boto3.client("s3").get_object(
            Bucket="inc-002-s3",
            Key="content.txt"
        )["Body"].read().decode()

        return f"<h1>S3 Content:</h1><pre>{content}</pre>"

    except Exception:
        return "<h1>S3 Content:</h1><pre>Unable to load content.</pre>"

app.run(host="0.0.0.0", port=80)
EOF

cat > /etc/systemd/system/inc002.service <<'EOF'
[Unit]
Description=INC-002 Flask Application

[Service]
ExecStart=/usr/bin/python3 /opt/app.py
Restart=always

[Install]
WantedBy=multi-user.target
EOF

systemctl enable --now inc002.service
