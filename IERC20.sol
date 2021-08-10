// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

interface IERC20 {
    
    event Transfer(address indexed _from, address indexed _to, uint _value);
    event Approval(address indexed _owner, address indexed _spender, uint256 _value);
    
    function totalSupply() external view returns (uint);
    
    function balanceOf(address account) external view returns (uint);
    
    function transfer(address _to, uint amount) external returns (bool);
    
    function allowance(address owner, address spender) external view returns (uint);
    
    function approve(address spender, uint amount) external returns (bool);
    
    function transferFrom(address _from, address _to, uint amount) external returns (bool);
    
}