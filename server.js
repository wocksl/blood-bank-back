import mysql from 'mysql'
import express from 'express'
import bodyParser from 'body-parser';
import cors from 'cors'
import AWS from 'aws-sdk'

//controllers
//user function handlers
import UserLoginHandler from "./controllers_before_cognito/user/userLoginHandler.js";
import UserRegisterHandler from './controllers_before_cognito/user/UserRegisterHandler.js';
import RequestClassHandler from './controllers_before_cognito/bloodbank/RequestClassHandler.js';



//employee function handlers
// import EmployeeLoginHandler from './controllers/employee/EmployeeLoginHandler.js';
// import EmployeeRegisterHandler from './controllers/employee/EmployeeRegisterHandler.js';
import UpdateBlood from './controllers_before_cognito/bloodbank/UpdateStockHandler.js'
import UpdateHealthHandler from './controllers_before_cognito/bloodbank/UpdateHealthHandler.js';
import HandleRequestHandler from './controllers_before_cognito/bloodbank/HandleRequestHandler.js';

//dashboard
import DashboardHandler from './controllers_before_cognito/dashboard/DashboardHandler.js';
import SearchHandler from './controllers_before_cognito/bloodbank/SearchHandler.js';

//create the app
var app = express();

// middilewares set app to use the body-parser
app.use(cors());
app.use(bodyParser.urlencoded({ extended: true }));
app.use(express.json());

// connect to RDS with Secret Manager
const secretsManager = new AWS.SecretsManager({
  region: 'ap-northeast-2'  // AWS 리전 설정
});

const getSecret = async (secretName) => {
  return new Promise((resolve, reject) => {
    secretsManager.getSecretValue({ SecretId: secretName }, (err, data) => {
      if (err) {
        console.error(err);
        reject(err);
      } else {
        if ('SecretString' in data) {
          resolve(JSON.parse(data.SecretString));
        } else {
          reject('No secret string found');
        }
      }
    });
  });
};

// 서버 시작 시 Secrets Manager에서 DB 연결 정보 가져오기
// 서버 시작 시 Secrets Manager에서 DB 연결 정보 가져오기
(async () => {
  try {
    // AWS Secrets Manager에서 설정한 비밀 이름
    const secretName = "bbms/mysql";  // AWS Secrets Manager에 저장한 비밀 이름
    const secret = await getSecret(secretName);

    // AWS RDS MySQL 연결 설정
    var db = mysql.createConnection({
      host: secret.host,
      user: secret.username,
      password: secret.password,
      database: secret.dbname,
    });
    
    // IDC MySQL 연결 설정
    var idcDb = mysql.createConnection({
      host: 'dbsrv.bbidc.internal',  // IDC MySQL 서버 DNS
      user: secret.username,  // 동일한 사용자명 사용 또는 변경
      password: secret.password,  // 동일한 비밀번호 사용 또는 변경
      database: secret.dbname,  // 동일한 데이터베이스 사용 또는 변경
    });
    idcDb.connect((err) => {
      if (err) throw err;
      console.log("Connected to the IDC database!");
    
      // IDC MySQL 연결을 사용하여 UserRegisterHandler 호출
      UserRegisterHandler(app, idcDb);
    });
    
    db.connect((err) => {
      if (err) throw err;
      console.log("Connected to the RDS database!");

      // 이후 라우팅 및 핸들러 등록
      // user functionalities
      // UserRegisterHandler(app, db);
      UserLoginHandler(app, db);
      RequestClassHandler(app, db);

      // employee functionalities
      // EmployeeRegisterHandler(app, db);
      // EmployeeLoginHandler(app, db);
      UpdateHealthHandler(app, db);
      HandleRequestHandler(app, db);

      // bloodbank functionalities
      DashboardHandler(app, db);
      UpdateBlood(app, db);
      SearchHandler(app, db);

      // Health check endpoint
      app.get('/health', (req, res) => {
        res.status(200).send('Healthy');
      });      

      // 서버 리스닝
      app.listen(3001, (err) => {
        if (err) throw err;
        else console.log("Listening to port 3001");
      });
    });
  } catch (error) {
    console.error('Error fetching secrets from AWS Secrets Manager:', error);
  }
})();