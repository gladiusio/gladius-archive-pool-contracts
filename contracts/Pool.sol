pragma solidity ^0.4.0;


contract Pool {

    // Data about a pool
    struct PoolData {
    mapping (address => string) encryptedPoolData;
    mapping (address => Node) members;
    bytes32[] nameservers;
    string publicKey;
    address[] membersList;
    address owner;
    }

    // Struct to store node data
    struct Node {
    string encryptedData; //Data to pool
    string publicKey;
    }

    struct Client {
    string encryptedData; //Data to pool
    string publicKey;
    }

    PoolData data;

    Client client; // Later versions will support multiple clients
    string clientData = ""; // Encrypted data for the client
    mapping (address => Node) proposals;

    mapping (address => Client) clientRequests;

    address[] private proposedAddresses;

    /// Create a new pool
    function Pool(string publicKey) public {
        data.owner = msg.sender;
        data.publicKey = publicKey;
    }

    function getPoolPublicKey() public constant returns (string){
        return data.publicKey;
    }

    function setNameservers(bytes32[] ns) public {
        require(msg.sender == data.owner);
        data.nameservers = ns;
    }

    function getMemberPublicKey(address node) public constant returns (string){
        return data.members[node].publicKey;
    }

    function clientRequest(string encryptedData, string publicKey) public {
        clientRequests[msg.sender] = Client({encryptedData : encryptedData, publicKey : publicKey});
    }

    function authorizeClient(address clientAddress) public {
        require(msg.sender == data.owner);
        client = clientRequests[clientAddress];
    }

    // Set the encrypted data for the client to decrypt
    function setClientData(string clientDataIn) public {
        require(msg.sender == data.owner);
        clientData = clientDataIn;
    }

    function getClientData() constant public returns (string) {
        return clientData;
    }

    function getProposalPublicKey(address node) constant public returns (string){
        return proposals[node].publicKey;
    }

    function getMemberData(address node) constant public returns (string){
        return data.members[node].encryptedData;
    }

    function getProposalData(address node) constant public returns (string){
        return proposals[node].encryptedData;
    }

    function getPoolDataForNode(address node) constant public returns (string){
        return data.encryptedPoolData[node];
    }

    /// Update the pool data assosiated with the Node node with data newData
    /// Must be owner to execute
    function updateEncryptedPoolData(address node, string newData) public {
        require(msg.sender == data.owner);
        data.encryptedPoolData[node] = newData;
    }

    /// Update the encrypted member data assosiated with the Node node
    /// Must be that member to execute
    function updateEncryptedMemberData(address node, string newData) public {
        require(msg.sender == node);
        data.members[node].encryptedData = newData;
    }

    // Get the data about a proposed node
    function getProposedNodeData(address node) constant public returns (string) {
        return proposals[node].encryptedData;
    }

    /// Make proposal
    function proposeNode(address node, string publicKey, string eData) public {
        proposals[node] = (Node({
        encryptedData : eData,
        publicKey : publicKey
        }));
        proposedAddresses.push(node);
    }

    /// Return a list of addresses of the proposals
    function getProposals() constant public returns (address[]) {
        return proposedAddresses;
    }

    /// Update a member's key. Owner or that member can do it.
    function updateMemberPublicKey(address node, string newKey) public {
        require(msg.sender == node || msg.sender == data.owner);
        data.members[node].publicKey = newKey;
    }

    /// Accept a node to the pool (can only be done by the owner)
    function acceptNode(address node) public {
        require(msg.sender == data.owner);
        data.members[node] = (proposals[node]);

    }

    // Remove a node from the pool
    function removeNode(address node) public {
        require(msg.sender == data.owner);
        delete data.members[node];
    }
}