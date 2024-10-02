//module export
const UpdateStockHandler = (app, idcDb) => {
  app.get("/login/emp/ub", (req, res) => {
    //query
    const sqlSelect = "SELECT * FROM blood_stocks;";

    idcDb.query(sqlSelect, (err, result) => {
      if (err) {
        console.log(err);
      } else {
        res.send(result);
      }
    });
  });

  app.put("/login/emp/ub/update", (req, res) => {
    //variables
    const unitUpdate = req.body.unitUpdate;
    const b_id = req.body.b_id;
    //query
    const sqlUpdate = "UPDATE blood_stocks SET unit=? WHERE b_id= ?;";
    //
    idcDb.query(sqlUpdate, [unitUpdate, b_id], (err, result) => {
      // res.send(result);
      if (err) {
        console.log("**ERROR IN UPDATING UNIT VALUE**" + err);
      }
    });
  });

};

export default UpdateStockHandler;