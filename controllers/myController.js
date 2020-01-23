var express = require('express');
var router = express.Router();
var bodyParser = require('body-parser');
var db = require('../db');
//var cryptr = require('crypter');

router.use(bodyParser.urlencoded({ extended: true }));
router.use(bodyParser.json());

router.post('/registerUser', function (req, res) {
  console.log("got post request"); 
  var sql = "INSERT INTO user (Fname, Lname, Email, Pass, PhoneNo) VALUES (?, ?,?,?,?);"
  var sql2 = "INSERT INTO usercategory(UID, CatName) VALUES (?,?)"
  let body = req.body;
  let Fname = body.Fname;
  let Lname = body.Lname;
  let Email = body.Email;

  let Pass = body.Pass;
  //var encryptedString = cryptr.encrypt(body.Pass);

  let PhoneNo = body.PhoneNo;
  let Perferences = body.Categories;
  let userId;

  db.mycon.query(sql, [Fname,Lname,Email,Pass, PhoneNo],function (err, result) {
    console.log("Result: " + result.insertId);
    userId = result.insertId
    console.log("userId 1 " + userId);
    if(err){
      res.send(err);
    }else{
      

      for(var i = 0; i < Perferences.length; i++) {

 
         db.mycon.query(sql2, [userId,Perferences[i]], function(err,result2){
           console.log("Perferences Query: "+ JSON.stringify(result2))
           if(err){
             //res.send(err);
           }
         });
 
       }
    }
      });

      console.log("userId outside " + userId);


  

    return res.json({"result":"Done"});
  });
  

router.get('/getSMS', function (req, res) {
  console.log("got get request"); 
  let sql = "SELECT id, Phone, Body FROM Message WHERE `SentFlag` = 0 ORDER BY `ts` LIMIT 1;"
  db.mycon.query(sql, function (err, result) {
    console.log("Result: " + JSON.stringify(result));
    if(err){
      res.send(err);
    } else {
      res.json(result[0]); 
    }
  });
});


router.get('/sentSMS', function (req, res) {
  console.log("got sentSMS GET request"); 
  let id =req.query.id;
  let sql = "UPDATE Message SET SentFlag = 1 WHERE id=?;";
  db.mycon.query(sql,[id] ,function (err, result) {
    console.log("Result: " + JSON.stringify(result));
    if(err){
      res.send(err);
    } else {
      res.json({"result": "Flag updated!"}); 
    }
  });
});

router.post('/login', function (req, res) {

  var email=req.body.Email;
  var password=req.body.password;
 
 
  db.mycon.query('SELECT * FROM user WHERE Email = ?',[email], function (error, results, fields) {
    if (error) {
        res.json({
          status:false,
          message:'there are some error with query'
          })
    }else{
     
      if(results.length >0){
        // decryptedString = cryptr.decrypt(results[0].password);
          if(password==results[0].password){
              res.json({
                  status:true,
                  message:'successfully authenticated'
              })
          }else{
              res.json({
                status:false,
                message:"Incorrect Password"
               });
          }
        
      }
      else{
        res.json({
            status:false,    
          message:"Incorrect Email"
        });
      }
    }
  });

});

router.get('/hw', function(req,res){
  console.log("got hw request")
});





module.exports = router;
