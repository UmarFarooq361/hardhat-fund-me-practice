const { assert, expect } = require("chai")
const { deployments } = require("hardhat")

describe("FundMe", async function () {
    let fundMe, deployer, mockV3Aggregator

    beforeEach(async function () {

        deployer = (await getNamedAccounts().deployer)
        await deployments.fixture("all")
        fundMe = await ethers.getContract("FundMe", deployer)
        mockV3Aggregator = await ethers.getContract("MockV3Aggregator", deployer)

    })
    describe("Constructor", async function () {
        it("it set the aggregators", async function () {
            const response = await fundMe.priceFeed()
            assert.equal(response, mockV3Aggregator.address)
        })

    })
    describe("fund", async function () {
        it("it will fail if not enough eth send", async function () {
            await expect(fundMe.fund()).to.be.revertedWith("fail because not enough eth sended")
        })

    })
})