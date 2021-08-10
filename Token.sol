// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract Token {
    
    string tokenName;
    mapping (address => uint) balance;
    mapping (address => mapping(address => uint)) allowedTrfr;
    
    event Transfer(address indexed _from, address indexed _to, uint _value);
    event Approval(address indexed _owner, address indexed _spender, uint256 _value);
    
    error InsufficientBalance(uint available, uint required);
    
    constructor(uint256 initialSupply, string memory _name) {
        tokenName = _name;
        balance[msg.sender]= initialSupply;
    }
    
    function balanceOf(address _add) public view returns(uint){
        return balance[_add];
    }
    
    function transfer(address _to, uint amount) public returns(bool success){
        if(balanceOf(msg.sender) >= amount){
            balance[_to] += amount;
            balance[msg.sender] -= amount;
            emit Transfer(msg.sender, _to, amount);
            success = true;
        }else{
            success = false;
            revert InsufficientBalance(balanceOf(msg.sender), amount);
        }
    }
    
    function transferFrom(address _from, address _to, uint amount) public returns(bool success){
        if(balanceOf(_from) >= amount && allowedTrfr[_from][_to] >= amount){
            balance[_to] += amount;
            balance[_from] -= amount;
            emit Transfer(msg.sender, _to, amount);
            success = true;
        }else if(balanceOf(_from) < amount){
            success = false;
            revert InsufficientBalance(balanceOf(msg.sender), amount);
        }else{
            success = false;
            revert('not allowed');
        }
    }
    
    function approve(address _spender, uint amount) public returns (bool success){
        allowedTrfr[msg.sender][_spender] = amount;
        emit Approval(msg.sender, _spender, amount);
        success = true;
    }
    
    function allowance(address _owner, address _spender) public view returns(uint value){
        return allowedTrfr[_owner][_spender];
    }
}