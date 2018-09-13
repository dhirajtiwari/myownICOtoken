var DhirajToken = artifacts.require("./DhirajToken.sol");
var DhirajTokenSale = artifacts.require("./DhirajTokenSale.sol");

module.exports = function(deployer) {
  deployer.deploy(DhirajToken, 1000000).then(function() {
    // Token price is 0.001 Ether
    var tokenPrice = 1000000000000000;
    return deployer.deploy(DhirajTokenSale, DhirajToken.address, tokenPrice);
  });
};