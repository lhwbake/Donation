var Donation = artifacts.require("./Donation.sol");

module.exports = function(deployer) {
  deployer.deploy(Donation,"0xb1bc47eb7ac6cf62b39fe389de189e6779a394b9");
};
