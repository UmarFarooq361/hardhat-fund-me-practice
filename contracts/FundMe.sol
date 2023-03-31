// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;
import "./PriceConverter.sol";

error notOwner();

contract FundMe {
    using PriceConverter for uint;
    uint public constant MinimunUSD = 50 * 1e18;
    address[] public funders;
    address public immutable owner;
    mapping(address => uint) public AmountSendedByFunder;

    AggregatorV3Interface public priceFeed;

    constructor(address priceFeedAddress) {
        owner = msg.sender;
        priceFeed = AggregatorV3Interface(priceFeedAddress);
    }

    function Fund() public payable {
        // require(conversionRate(msg.value) >= MinimunUSD, "Not Enought Amount to send");
        require(
            msg.value.conversionRate(priceFeed) >= MinimunUSD,
            "Not Enought Amount to send"
        ); //this syntex as we use library
        funders.push(msg.sender);
        AmountSendedByFunder[msg.sender] = msg.value;
    }

    function withdraw() public onlyOwner {
        for (uint i = 0; i < funders.length; i++) {
            address funderAddr = funders[i];
            AmountSendedByFunder[funderAddr] = 0; // reset the value i address

            // resetting the array
            funders = new address[](0);
        }
        // //funding transfer by three ways
        // // 1 transfer : it will send 2300 gas and (cons if it fails it will throw error)
        // payable(msg.sender).transfer(address(this).balance);

        // // 2 send  : it will return boolean and send 2300 gas
        // bool sendSuccess = payable(msg.sender).send(address(this).balance);
        // require(sendSuccess, "send fail");

        // 3 call  : it will return boolean and data of the function and forward all gas or setted amount of gas
        (bool callSuccess, ) = payable(msg.sender).call{
            value: address(this).balance
        }("");
        require(callSuccess, "call fail");
    }

    modifier onlyOwner() {
        // require(msg.sender == owner, "only owner can withdraw");
        if (msg.sender != owner) {
            revert notOwner();
        }
        _; // of we reverse these 2 lines this means we want to excute function first then check require
    }

    // what if someone send funds without calling fund functions we have two builtin function for this
    receive() external payable {
        // this will receive amount if there is no calldata
        Fund();
        // if there is no msg.data and receive function exists then this will run
        // but is if there is no msg.data and no receive function exists then fallback function will run
    }

    fallback() external payable {
        // this will run when we have some data then receive will not run , fallback will execute
        Fund();
        // if there is msg.data this will run
    }
}
