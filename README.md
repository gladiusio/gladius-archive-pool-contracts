# Gladius pool deployment
Deployment for the Gladius pool contract.

## Steps to deploy a new pool
- Pull this repository.
- Run `truffle compile` and then `truffle migrate` in the directory.
    - This will generate your RSA keypair and upload the public key to the blockchain.
- Use your contract browser of choice to view pool information and preform actions.
    - View and accept proposals with `getProposals()` and `acceptNode(address node)`.
    - Get encrypted information about nodes with `getProposedNodeData(address node)`.


## To decrypt the information
- Install the node-rsa library with `npm install node-rsa`.
- Run `node decrypt.js "encrypted_string here"` from the project root directory, it will automatically detect the private key generated when you deployed the pool.
- View this information and contact the potential nodes with it. Only accept trusted nodes.

## To configure DNS
- Currently use the generated IP addresses list to build a zonefile for geoDNS (https://github.com/abh/geodns)
- This is left up to the pool manager in the current implementation as this file will differ significantly per website.
    - In future version this file will be automatically generated based on the client options.

## Notes
- Only HTTP traffic for now
- Payment is not implemented due to the token not being released yet, will be implemented by the end of the token sale.
- DNS will throw as much bandwidth as it needs to towards a node currently, make sure they can handle it for your application.
- **Only accept trusted nodes after careful vetting! (email themetc.)**