// SPDX-License-Identifier: AGPL-3.0
pragma solidity ^0.8.20;

import {ERC20Upgradeable} from "@openzeppelin/contracts-upgradeable/token/ERC20/ERC20Upgradeable.sol";
import {ERC20CappedUpgradeable} from "@openzeppelin/contracts-upgradeable/token/ERC20/extensions/ERC20CappedUpgradeable.sol";

import {ReentrancyGuardUpgradeable} from "@openzeppelin/contracts-upgradeable/utils/ReentrancyGuardUpgradeable.sol";
import {AccessControlUpgradeable} from "@openzeppelin/contracts-upgradeable/access/AccessControlUpgradeable.sol";

contract HappyCats is ERC20CappedUpgradeable, ReentrancyGuardUpgradeable, AccessControlUpgradeable {
    uint256 public constant INITIAL_SUPPLY = 1_000_000 * 10 ** 18;

    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");

    constructor() {
        _disableInitializers();
    }

    function initialize(address _admin) public initializer {
        __ERC20_init("Happy Cats", "HCAT5");
        __ERC20Capped_init(INITIAL_SUPPLY);
        __ReentrancyGuard_init();
        __AccessControl_init();
        if (_admin != msg.sender) {
            _grantRole(DEFAULT_ADMIN_ROLE, _admin);
            _revokeRole(DEFAULT_ADMIN_ROLE, msg.sender);
        }
    }

    function mint(address _to, uint256 _amount) public onlyRole(MINTER_ROLE) {
        _mint(_to, _amount);
    }
}
