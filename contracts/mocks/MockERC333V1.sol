//SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
import {Strings} from "@openzeppelin/contracts/utils/Strings.sol";
import {ERC333} from "../ERC333/ERC333.sol";
import {ERC5169} from "stl-contracts/ERC/ERC5169.sol";
import {IERC721Metadata} from "@openzeppelin/contracts/token/ERC721/extensions/IERC721Metadata.sol";

// import {IUniswapV3Factory} from "@uniswap/v3-core/contracts/interfaces/IUniswapV3Factory.sol";
// import {IUniswapV3Pool} from "@uniswap/v3-core/contracts/interfaces/IUniswapV3Pool.sol";

import {PoolAddress} from "../utils/PoolAddress.sol";
import {IncreaseLiquidityParams} from "../structs/PositionParams.sol";

contract MockERC333V1 is ERC333 {
    using Strings for uint256;

    string private constant __NAME = "MockERC333V1";
    string private constant __SYM = "MOCK";
    uint256 private constant __MINT_SUPPLY = 10000;
    uint24 private constant __TAX_PERCENT = 80000;
    uint8 private constant __DECIMALS = 18;
    uint8 private constant __RATIO = 100;

    constructor(
        address initialOwner_,
        address initialMintRecipient_
    )
        ERC333(
            initialOwner_,
            initialMintRecipient_,
            __MINT_SUPPLY,
            __TAX_PERCENT,
            __NAME,
            __SYM,
            __DECIMALS,
            __RATIO
        )
    {
        baseURI = "https://path-to-ftp/";
    }

    function initialize() external payable override onlyOwner {
        _registerAll();
    }

    function tokenURI(uint256 id) public pure override returns (string memory) {
        return
            string(abi.encodePacked("for testing v2, with higher tokenTick"));
    }

    // ======================================================================================================
    //
    // test mock functions
    //
    // ======================================================================================================
    function _approveUniswap(
        address token,
        uint256 amount
    ) internal pure override returns (bool) {
        return true;
    }

    function _initializePool(
        address token0,
        address token1,
        uint24 fee,
        uint160 sqrtPriceX96
    )
        internal
        pure
        override
        returns (address poolAddress, int24 tick, int24 tickSpacing)
    {
        poolAddress = address(0);
    }

    function _initializeObservations(
        address poolAddress,
        uint16 observationCardinalityNext
    ) internal pure override returns (bool) {
        return true;
    }

    function _initializeLiquidity(
        address token0,
        address token1,
        uint24 fee,
        uint256 amount0,
        uint256 amount1,
        int24 tickLower,
        int24 tickUpper,
        address recipient
    )
        internal
        pure
        override
        returns (
            uint256 positionId,
            uint128 liquidity,
            uint256 amount0Used,
            uint256 amount1Used
        )
    {
        positionId = 0;
    }

    function _exactInputSingle(
        address tokenIn,
        address tokenOut,
        address recipient,
        uint256 amountIn
    ) internal pure override returns (uint256 amountOut) {
        return 0;
    }

    function _increaseLiquidity(
        uint256 positionId,
        uint256 amount0,
        uint256 amount1
    )
        internal
        pure
        override
        returns (uint128 liquidity, uint256 amount0Used, uint256 amount1Used)
    {}

    function _getCurrentTokenTick() internal view override returns (int24) {
        // return a fixed value for test
        if (_thisIsToken0()) {
            return tickThreshold + 60;
        }
        return tickThreshold - 60;
    }
}
