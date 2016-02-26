var express = require('express');
var app = express();
var fs = require("fs");

var bodyParser = require('body-parser');
//var multer  = require('multer');

app.use(express.static('public'));
app.use(bodyParser.urlencoded({ extended: false }));

//app.use(multer({ dest: '/tmp/'}));
//var upload = multer({dest: './public/images/'});

// 文件上传插件
var multer = require('multer');
var storage = multer.diskStorage({
  destination: function (req, file, cb) {
    cb(null, './public/images')
  },
  filename: function (req, file, cb) {
    cb(null, file.originalname)
  }
});
var upload = multer({ storage: storage });
var cpUpload = upload.any();
app.use(cpUpload);

//--------------------
app.get('/index.htm', function (req, res) {
   res.sendFile( __dirname + "/" + "express_6_index.html" );
})

app.post('/file_upload', function (req, res) {
    console.log(req.files.file);
   //console.log(req.files.file.name);
   //console.log(req.files.file.path);
   //console.log(req.files.file.type);

   var file = __dirname + "/" + req.files.file.name;
   fs.readFile( req.files.file.path, function (err, data) {
        fs.writeFile(file, data, function (err) {
         if( err ){
              console.log( err );
         }else{
               response = {
                   message:'File uploaded successfully',
                   filename:req.files.file.name
              };
          }
          console.log( response );
          res.end( JSON.stringify( response ) );
       });
   });
})

var server = app.listen(8081, function () {

  var host = server.address().address
  var port = server.address().port

  console.log("Example app listening at http://%s:%s", host, port)

})