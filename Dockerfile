FROM node:19

# 작업 디렉토리 설정
WORKDIR /app

# 애플리케이션 파일 복사
COPY . .

# AWS SDK 설치 및 다른 종속성 설치
RUN npm install aws-sdk

# 종속성 설치
RUN npm install

# 애플리케이션 실행 명령어
CMD ["npm", "run", "devStart"]

# 포트 노출
EXPOSE 3001