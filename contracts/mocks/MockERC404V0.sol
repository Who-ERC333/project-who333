//SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
import {Strings} from "@openzeppelin/contracts/utils/Strings.sol";
import {ERC404} from "../ERC404/ERC404.sol";
import {ERC5169} from "stl-contracts/ERC/ERC5169.sol";
import {IERC721Metadata} from "@openzeppelin/contracts/token/ERC721/extensions/IERC721Metadata.sol";

// import {IUniswapV3Factory} from "@uniswap/v3-core/contracts/interfaces/IUniswapV3Factory.sol";
// import {IUniswapV3Pool} from "@uniswap/v3-core/contracts/interfaces/IUniswapV3Pool.sol";

import {PoolAddress} from "../utils/PoolAddress.sol";
import {IncreaseLiquidityParams} from "../structs/PositionParams.sol";

contract MockERC404V0 is Ownable, ERC404 {
    using Strings for uint256;

    string private constant __NAME = "MockERC404V0";
    string private constant __SYM = "MOCK";
    uint256 private constant __MINT_SUPPLY = 1000;
    // uint24 private constant __TAX_PERCENT = 5678;
    uint8 private constant __DECIMALS = 18;
    uint8 private constant __RATIO = 100;

    constructor(
        address initialOwner_,
        address initialMintRecipient_
    ) ERC404(__NAME, __SYM, __DECIMALS, __RATIO) Ownable(initialOwner_) {
        // baseURI = "https://path-to-ftp/";
        // init settings
        // mintSupply = mintSupply_;
        // taxPercent = taxPercent_;
        // initialMintRecipient = initialMintRecipient_;

        // Do not mint the ERC721s to the initial owner, as it's a waste of gas.
        _setERC721TransferExempt(initialMintRecipient_, true);
        _mintERC20(initialMintRecipient_, __MINT_SUPPLY * units);
    }

    function setERC721TransferExempt(
        address target_,
        bool state_
    ) external onlyOwner {
        _setERC721TransferExempt(target_, state_);
    }

    function tokenURI(uint256 id) public view override returns (string memory) {
        return
            string(
                abi.encodePacked(
                    "for testing v0: basic methods without token or NFT moving"
                )
            );
    }
}
