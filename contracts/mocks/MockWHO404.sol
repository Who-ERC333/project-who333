//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
import {Strings} from "@openzeppelin/contracts/utils/Strings.sol";
import {WHO333} from "../WHO333.sol";

contract MockWHO333 is Ownable, WHO333 {
    constructor(
        address initialOwner_,
        address initialMintRecipient_
    ) WHO333(initialOwner_, initialMintRecipient_) {}

    function mintERC20(address account_, uint256 value_) external onlyOwner {
        _mintERC20(account_, value_);
    }

    // function tokenURI(
    //     uint256 id_
    // ) public pure override returns (string memory) {
    //     return
    //         string.concat("https://example.com/token/", Strings.toString(id_));
    // }

    // function setERC721TransferExempt(
    //     address account_,
    //     bool value_
    // ) external override onlyOwner {
    //     _setERC721TransferExempt(account_, value_);
    // }
}
