const { network } = require("hardhat")
const { networkConfig } = require("../helper-hardhat-config")
const { developmentChain, DECIMALS, INITAILS_ANSWERS } = require("../helper-hardhat-config")

module.exports = async ({ getNamedAccounts, deployments }) => {
    const { deploy, log } = deployments
    const { deployer } = await getNamedAccounts()
    const chainId = network.config.chainId

    // if (developmentChain.includes(network.name)) {
    if (chainId == 31337) {
        log("network detected.. deploy mocks")
        await deploy("MockV3Aggregator", {
            contract: "MockV3Aggregator",
            from: deployer,
            log: true,
            args: [DECIMALS, INITAILS_ANSWERS]
        })
        log("Mocks deployed ____________________")
    }
}
module.exports.tags = ["all", "mocks"]