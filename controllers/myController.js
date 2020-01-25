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


router.get('/getCategories',function(req,res){
    console.log("got getCategories get request");
    db.mycon.query("SELECT * FROM Category", function(err, result){
      if(err){
        res.send(err);
      }else{
        res.json(result);
      }
    });
});


router.get('/getCourses',function(req,res){
  console.log("got getCourses get request");
  db.mycon.query("SELECT * FROM Course", function(err, result){
    if(err){
      res.send(err);
    }else{
      res.json(result);
    }
  });
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
  var password=req.body.Password;
  console.log("got login request");

 
 
  db.mycon.query('SELECT * FROM user WHERE Email = ?',[email], function (error, results, fields) {
    if (error) {
        res.json({
          status:false,
          message:'there are some error with query'
          })
    }else{
     
      if(results.length >0){
        // decryptedString = cryptr.decrypt(results[0].password);
        console.log("password results "+ results[0].Pass)
        console.log("password sent "+ password)
          if(password==results[0].Pass){
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

router.get('/',function(req,res){
	res.end("Node-File-Upload");

});
router.post('/upload', function(req, res) {
	console.log(req.files.image.originalFilename);
	console.log(req.files.image.path);
		fs.readFile(req.files.image.path, function (err, data){
		var dirname = "/home/rajamalw/Node/file-upload";
		var newPath = dirname + "/uploads/" + 	req.files.image.originalFilename;
		fs.writeFile(newPath, data, function (err) {
		if(err){
		res.json({'response':"Error"});
		}else {
		res.json({'response':"Saved"});
}
});
});
});



router.get('/uploads/:file', function (req, res){
		file = req.params.file;
		var dirname = "/home/rajamalw/Node/file-upload";
		var img = fs.readFileSync(dirname + "/uploads/" + file);
		res.writeHead(200, {'Content-Type': 'image/jpg' });
		res.end(img, 'binary');

});





module.exports = router;
