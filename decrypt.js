NodeRSA = require('node-rsa');
fs = require('fs');

function decryptData(data, privateKey) {
    let key = new NodeRSA();
    key.importKey(privateKey, 'pkcs1-private-pem');
    return key.decrypt(data, 'utf8');
}

let key = fs.readFileSync('./keys/PrivateKey.txt').toString();

if (process.argv[2] !== undefined)
    console.log(decryptData(process.argv[2], key));
else
    console.log("Please supply a string to decrypt.");