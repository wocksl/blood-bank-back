// //module export
// const UserRegisterHandler = (app, db) => {
//   app.post("/reg/usr", (req, res) => {
//     //variables
//     const userFName = req.body.userFName;
//     const userAge = req.body.userAge;
//     const userGender = req.body.userGender;
//     const userBloodGroup = req.body.userBloodGroup;
//     const userPhone = req.body.userPhone;
//     const userMail = req.body.userMail;
//     const userPlace = req.body.userPlace;
//     const userUserName = req.body.userUserName;
//     const userPassword = req.body.userPassword;

//     //query
//     const sqlInsert1 =
//       "INSERT INTO user_details (userFName,userAge,userGender,userBloodGroup,userPhone,userMail,userPlace) VALUES (?,?,?,?,?,?,?)";

//     const sqlInsert2 =
//       "INSERT INTO user_login (user_id,userUserName,userPassword) VALUES (?,?,?)";

//     const sqlInsert3 = "INSERT INTO user_health (user_id) VALUES(?)";

//     const sqlDelete1 = "DELETE  FROM user_details WHERE user_id= ?";

//     const sqlDelete2 = "DELETE FROM user_health WHERE user_id=?";
//     /////
//     db.query(
//       sqlInsert1,
//       [
//         userFName,
//         userAge,
//         userGender,
//         userBloodGroup,
//         userPhone,
//         userMail,
//         userPlace,
//       ],
//       (err, result) => {
//         if (err) console.log(err + " **ERROR  INSERTING USER** ");
//         else {
//           var user_id = result.insertId;
//           //////
//           db.query(
//             sqlInsert2,
//             [user_id, userUserName, userPassword],
//             (err, result1) => {
//               if (err) {
//                 console.log(err + "**ERROR INSERTING TO USER-LOGIN**");
//                 //////
//                 db.query(sqlDelete1, [user_id], (err, result2) => {
//                   if (err) console.log(err);
//                   else {
//                     console.log("**DELETED DUE TO DUPLICATION**");
//                     res.send({ message: "Username already exist" });
//                   }
//                 });
//               } else {
//                 //res.send({ message: "User Registration Successfull!" });
//                 //console.log("**USER REGISTRATION SUCCESSFULL**");
//                 ///////
//                 db.query(sqlInsert3, [user_id], (err, result1) => {
//                   if (err) {
//                     console.log(err + "**ERROR INSERTING TO USER-LOGIN**");
//                     //////
//                     db.query(sqlDelete2, [user_id], (err, result2) => {
//                       if (err) console.log(err);
//                       else {
//                         console.log("**DELETED DUE TO DUPLICATION**");
//                         res.send({ message: "Username already exist" });
//                       }
//                     });
//                   } else {
//                     res.send({ message: "User Registration Successfull!" });
//                     console.log("**USER REGISTRATION SUCCESSFULL**");
//                   }
//                 });
//               }
//             }
//           );
//         }
//       }
//     );
//   });
// };


// export default UserRegisterHandler;

// const UserRegisterHandler = (app, idcDb) => {
//   app.post("/reg/usr", (req, res) => {
//     // 받은 데이터
//     const userFName = req.body.userFName;
//     const userAge = req.body.userAge;
//     const userGender = req.body.userGender;
//     const userBloodGroup = req.body.userBloodGroup;
//     const userPhone = req.body.userPhone;
//     const userMail = req.body.userMail;
//     const userPlace = req.body.userPlace;

//     // Step 1: user_details 테이블에 추가 정보 저장
//     const sql1 = `
//       INSERT INTO user_details (userFName, userAge, userGender, userBloodGroup, userPhone, userMail, userPlace)
//       VALUES (?, ?, ?, ?, ?, ?, ?)
//     `;

//     idcDb.query(sql1, [userFName, userAge, userGender, userBloodGroup, userPhone, userMail, userPlace], (err, result) => {
//       if (err) {
//         console.error('Error saving user details:', err);
//         res.status(500).send('Error saving user details');
//         return;
//       }

//       res.status(200).send('User registration successful');
//     });
//   });
// };

// export default UserRegisterHandler;


// const UserRegisterHandler = (app, idcDb) => {
//   app.post("/reg/usr", (req, res) => {
//     // 받은 데이터
//     const userPlace = req.body.userPlace;
//     const userBloodGroup = req.body.userBloodGroup;

//     // Step 1: user_details 테이블에 userPlace와 userBloodGroup만 저장
//     const sql1 = `
//       INSERT INTO user_details (userPlace, userBloodGroup)
//       VALUES (?, ?)
//     `;

//     idcDb.query(sql1, [userPlace, userBloodGroup], (err, result) => {
//       if (err) {
//         console.error('Error saving user details:', err);
//         res.status(500).send('Error saving user details');
//         return;
//       }

//       res.status(200).send('User registration successful');
//     });
//   });
// };

// export default UserRegisterHandler;


import AWS from 'aws-sdk';  // EMS 방식으로 aws-sdk import

const cognitoISP = new AWS.CognitoIdentityServiceProvider();

const UserRegisterHandler = (app, idcDb) => {
  app.post("/reg/usr", (req, res) => {
    const { userPlace, userBloodGroup, cognitoSub } = req.body;

    // DB에 user_details 저장할 때 sub도 함께 저장
    const sql1 = `
      INSERT INTO user_details (userPlace, userBloodGroup, cognito_sub)
      VALUES (?, ?, ?)
    `;
    idcDb.query(sql1, [userPlace, userBloodGroup, cognitoSub], (err, result) => {
      if (err) {
        console.error('Error saving user details:', err);
        return res.status(500).send('Error saving user details');
      }

      res.status(200).send('User registration successful');
    });
  });
};

export default UserRegisterHandler;




