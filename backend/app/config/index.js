const config = {
     app: {
          port: process.env.PORT || 8080,
          origins: [
               "http://localhost:8081"
          ]
     },
    jwt: {
     secret: "web-secret-key"
 }

};

module.exports = config;