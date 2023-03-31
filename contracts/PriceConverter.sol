// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;
import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

library PriceConverter {
    function getPrice(
        AggregatorV3Interface priceFeed
    ) internal view returns (uint) {
        // AggregatorV3Interface priceFeed = AggregatorV3Interface(
        //     0x1b44F3514812d835EB1BDB0acB33d3fA3351Ee43
        // );
        (, int price, , , ) = priceFeed.latestRoundData();
        return uint(price * 1e10);
    }

    function getVersion() internal view returns (uint) {
        AggregatorV3Interface priceFeed = AggregatorV3Interface(
            0x1b44F3514812d835EB1BDB0acB33d3fA3351Ee43
        );
        return priceFeed.version();
    }

    function conversionRate(
        uint ethAmount,
        AggregatorV3Interface priceFeed
    ) internal view returns (uint) {
        uint ethers = getPrice(priceFeed);
        uint ethInUSD = (ethers * ethAmount) / 1e18;
        return ethInUSD;
    }
}
