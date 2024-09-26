# FROM node:19

# # 작업 디렉토리 설정
# WORKDIR /app

# # 애플리케이션 파일 복사
# COPY . .

# # AWS SDK 설치 및 다른 종속성 설치
# RUN npm install aws-sdk

# # 종속성 설치
# RUN npm install

# # 애플리케이션 실행 명령어
# CMD ["npm", "run", "devStart"]

# # 포트 노출
# EXPOSE 3001

#######
### 여기서 부터 CloudWatch agent 통합
# Node.js 19 이미지 사용
FROM node:19

# 작업 디렉터리 설정
WORKDIR /app

# 소스 코드 복사
COPY . .

# AWS SDK 및 필요한 패키지 설치
RUN npm install aws-sdk

# Prometheus Client 라이브러리 설치
RUN npm install prom-client

# 다른 의존성 설치
RUN npm install

# CloudWatch Agent 설치
RUN apt-get update && \
    apt-get install -y curl && \
    curl -O https://s3.amazonaws.com/amazoncloudwatch-agent/ubuntu/amd64/latest/amazon-cloudwatch-agent.deb && \
    dpkg -i -E ./amazon-cloudwatch-agent.deb && \
    rm amazon-cloudwatch-agent.deb

# CloudWatch Agent 설정 파일 복사
COPY cloudwatch-config.json /opt/aws/amazon-cloudwatch-agent/bin/config.json

# CloudWatch Agent와 애플리케이션을 동시에 실행
CMD /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl -a fetch-config -m ec2 -c file:/opt/aws/amazon-cloudwatch-agent/bin/config.json -s & \
    npm run devStart

# 백엔드 애플리케이션 포트 노출
EXPOSE 3001
