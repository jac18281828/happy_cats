// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {ProxyAdmin} from "@openzeppelin/contracts/proxy/transparent/ProxyAdmin.sol";
import {
    ITransparentUpgradeableProxy,
    TransparentUpgradeableProxy
} from "@openzeppelin/contracts/proxy/transparent/TransparentUpgradeableProxy.sol";

import {Script, console} from "forge-std/Script.sol";

import {HappyCats} from "../contracts/HappyCats.sol";

contract HappyCatsScript is Script {
    event HappyCatsDeployed(address indexed proxyAddress, address indexed implementation);
    event HappyCatsUpgraded(address indexed proxyAddress, address indexed implementation);

    function deployTransparentProxy() public {
        address admin = vm.envAddress("TOKEN_ADMIN");
        address minterAdmin = vm.envAddress("TOKEN_MINTER");
        address deploymentAdmin = msg.sender;
        bytes memory initializationData = abi.encodeWithSelector(HappyCats.initialize.selector, admin);
        vm.startBroadcast();
        address implementation = address(new HappyCats());
        TransparentUpgradeableProxy proxy = new TransparentUpgradeableProxy(implementation, admin, initializationData);
        address proxyAddress = address(proxy);
        console.log("TransparentUpgradeableProxy deployed at: ", proxyAddress);
        emit HappyCatsDeployed(proxyAddress, implementation);
        HappyCats happyCats = HappyCats(proxyAddress);

        happyCats.grantRole(happyCats.MINTER_ROLE(), minterAdmin);
        console.log("Minter admin role is ", minterAdmin);
        if (admin != deploymentAdmin) {
            happyCats.renounceRole(happyCats.DEFAULT_ADMIN_ROLE(), deploymentAdmin);
            console.log("Pool admin role is ", admin);
            console.log("Deployment role has been renounced ", deploymentAdmin);
        } else {
            console.log("Pool admin role is ", admin);
        }

        happyCats.mint(minterAdmin, 1000 * 10 ** 18);
        vm.stopBroadcast();
    }

    function upgradeTransparentProxy() public {
        address proxyAdmin = vm.envAddress("PROXY_ADMIN");
        address proxyAddress = vm.envAddress("HAPPY_CATS_PROXY");
        vm.startBroadcast();
        address implementation = address(new HappyCats());
        ITransparentUpgradeableProxy poolProxy = ITransparentUpgradeableProxy(proxyAddress);
        ProxyAdmin(proxyAdmin).upgradeAndCall(poolProxy, implementation, "");
        console.log("TransparentUpgradeableProxy upgraded to: ", implementation);
        emit HappyCatsUpgraded(proxyAddress, implementation);
        vm.stopBroadcast();
    }
}
