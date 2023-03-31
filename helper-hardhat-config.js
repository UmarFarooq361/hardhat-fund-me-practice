const networkConfig = {
    11155111: {
        name: "sepolia",
        ethUsdPriceFeed: 0x694AA1769357215DE4FAC081bf1f309aDC325306

    }
    // further add networks
}
const developmentChain = ["hardhat, localhost"]
const DECIMALS = 8
const INITAILS_ANSWERS = 200000000
module.exports = {
    networkConfig,
    developmentChain,
    DECIMALS,
    INITAILS_ANSWERS
}