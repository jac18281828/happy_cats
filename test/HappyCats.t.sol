// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {IAccessControl} from "@openzeppelin/contracts/access/IAccessControl.sol";

import {Test, console} from "forge-std/Test.sol";

import {HappyCats} from "../contracts/HappyCats.sol";

contract HappyCatsTest is Test {
    address public TOKEN_ADDRESS;
    address public OWNER;
    address public MINTER;
    address public USER;

    HappyCats public happyCats;

    function setUp() public {
        TOKEN_ADDRESS = vm.addr(0x1);
        OWNER = vm.addr(0x2);
        MINTER = vm.addr(0x3);
        USER = vm.addr(0x4);
        mockToken(TOKEN_ADDRESS);
        happyCats = HappyCats(TOKEN_ADDRESS);
        vm.startPrank(OWNER);
        happyCats.grantRole(happyCats.MINTER_ROLE(), MINTER);
        vm.stopPrank();
        vm.prank(MINTER);
        happyCats.mint(USER, 1000 * 10 ** 18);
    }

    function testSetup() public view {
        assertEq(happyCats.totalSupply(), 1000 * 10 ** 18);
        assertEq(happyCats.balanceOf(USER), 1000 * 10 ** 18);
    }

    function testMint() public {
        vm.prank(MINTER);
        happyCats.mint(USER, 1000 * 10 ** 18);
        assertEq(happyCats.totalSupply(), 2000 * 10 ** 18);
        assertEq(happyCats.balanceOf(USER), 2000 * 10 ** 18);
    }

    function testMinterRequiresMinterRole() public {
        vm.expectRevert(
            abi.encodeWithSelector(
                IAccessControl.AccessControlUnauthorizedAccount.selector, address(this), happyCats.MINTER_ROLE()
            )
        );
        happyCats.mint(USER, 1000 * 10 ** 18);
    }

    function mockToken(address _tokenAddress) internal {
        HappyCats tokenImpl = new HappyCats();
        bytes memory code = address(tokenImpl).code;
        vm.etch(_tokenAddress, code);
        HappyCats token = HappyCats(_tokenAddress);
        token.initialize(OWNER);
    }
}
