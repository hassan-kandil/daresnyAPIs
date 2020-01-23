var mysql = require('mysql');
var con = mysql.createConnection({
    host: "localhost",
    port: 3308,
    user: "root",
    password: "",
    database: "daresnydb"
});

con.connect((err) => {
    if (err) {
        console.error("Failed to connect to database- throwing error:");
        throw err;
    }
        console.log("Connected to database succesfully.");
    }
);

module.exports.mycon = con;