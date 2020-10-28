use DB_NAME;
db.dropDatabase();

db.dropUser("DB_USER");
db.createUser(
    {
        user: "DB_USER", 
        pwd: "DB_PASSWORD", 
        roles:[
            {
                role:"readWrite", 
                db:"DB_NAME"
            },
            {
                role:"dbAdmin", 
                db:"DB_NAME"
            }
        ]
    }
);

show dbs;