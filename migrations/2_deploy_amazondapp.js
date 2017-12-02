// exports and deploys greeter
// DO NOT EDIT THE CODE IN THIS FILE
var Amazon = artifacts.require("./AmazonDapp.sol");

module.exports = function(deployer) {
    deployer.deploy(Amazon);
};
