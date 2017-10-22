var Pool = artifacts.require("./Pool.sol");
fs = require('fs');
NodeRSA = require('node-rsa');

var baseKey = new NodeRSA({b: 512});


function getPublicKey() {
    var key = "ERROR";

    if (fs.existsSync("../keys/PublicKey.txt")) {
        key = fs.readFileSync("../keys/PublicKey.txt").toString();
    }
    else {
        fs.writeFileSync("../keys/PublicKey.txt", baseKey.exportKey("pkcs1-public-pem"));
        key = fs.readFileSync("../keys/PublicKey.txt").toString();
    }

    getPrivateKey();

    return key;
}

function getPrivateKey() {
    var key = "ERROR";

    if (fs.existsSync("../keys/PrivateKey.txt")) {
        key = fs.readFileSync("../keys/PrivateKey.txt").toString();
    }
    else {
        fs.writeFileSync("../keys/" +
            "PrivateKey.txt", baseKey.exportKey("pkcs1-private-pem"));
        key = fs.readFileSync("../keys/PrivateKey.txt").toString();
    }
    return key;
}

var publicKey = getPublicKey();


module.exports = function (deployer) {
    deployer.deploy(Pool, publicKey);
};
