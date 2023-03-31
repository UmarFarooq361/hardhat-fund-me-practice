require("@nomicfoundation/hardhat-toolbox");
require("hardhat-deploy")
require("@nomiclabs/hardhat-ethers")

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  // solidity: "0.8.18",
  solidity: {
    compilers: [
      { version: "0.8.18" },
      { version: "0.6.6" }
    ]
  },
  defaultNetwork: "hardhat"
};
