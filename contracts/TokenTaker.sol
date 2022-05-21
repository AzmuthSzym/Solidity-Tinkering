////SPDX-License-Identifier: Unlicensed
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
/// @title Contract for tests with ERC20 tokens
/// @author Azmuth
/// @notice I just want to know how to interact with ERC20 (taking them from user, returning)
contract TokenInteraction {

    /* ============= VARIABLES ============= */

    mapping(address => uint256) public balances;
    IERC20 public stakingToken;
    address UST_token = 0xd4BE8544C9126EAc9EffF2eA497CAFa023d6e03F; // UST (useless token) CONTRACT ADDRESS

    /* ============= CONSTRUCTOR ============= */

    constructor() {
        stakingToken = IERC20(UST_token);
    }

    function sendToContract(uint256 amount) public {
        require(amount > 0, "You can't send 0 tokens");
        require(stakingToken.balanceOf(msg.sender) > amount,"You dont have enough tokens");
        require(stakingToken.approve(address(this), amount) == true, "Couldnt approve");
        balances[msg.sender] += amount;
        stakingToken.transferFrom(msg.sender, address(this), amount);
    }

    function see_allowance(address _owner, address _spender) public view returns(uint256){
        return stakingToken.allowance(_owner, _spender);
    }

    function withdraw(uint256 amount) public {
        require(balances[msg.sender] >= amount, "You can't withdraw more than you staked");
        balances[msg.sender] -= amount;
        stakingToken.transferFrom(address(this), msg.sender, amount);
    }

}