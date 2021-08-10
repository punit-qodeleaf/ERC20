// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "./IERC20.sol";

contract ERC20 is IERC20{
    string private _name;
    string private _symbol;
    uint private _totalSupply;
    
    mapping (address => uint) private _balance;
    mapping (address => mapping(address => uint)) private _allowances;
    
    constructor(string memory name, string memory symbol){
        _name = name;
        _symbol = symbol;
    }
    
    function totalSupply() override external view returns (uint){
        return _totalSupply;
    }
    
    function balanceOf(address account) override external view returns (uint){
        return _balance[account];
    }
    
    function transfer(address _to, uint amount) override external returns (bool){
        _transfer(msg.sender, _to, amount);
        return true;
    }
    
    function allowance(address owner, address spender) override external view returns (uint){
        return _allowances[owner][spender];
    }
    
    function approve(address spender, uint amount) override external returns (bool){
        _approveAllowance(msg.sender,spender,amount);
        return true;
    }
    
    function transferFrom(address _from, address _to, uint amount) override external returns (bool){
        uint256 currentAllowance = _allowances[_from][msg.sender];
        require(currentAllowance >= amount, "Transfer amount exceeds allowance");
        
        unchecked {
            _approveAllowance(_from, msg.sender, currentAllowance - amount);
        }
        _transfer(_from, _to, amount);
        
        return true;
    }
    
    function _transfer(address _from, address _to, uint amount) internal{
        require(_from != address(0), "transfer from the zero address");
        require(_to != address(0), "transfer to the zero address");
        
        uint senderBalance = _balance[_from];
        require(senderBalance < amount, 'Insufficient Balance');
        
        unchecked{
            _balance[_from] -= amount;
            _balance[_to] += amount;
        }
        
        emit Transfer(_from,_to,amount);
    }
    
    function _approveAllowance(address _owner, address _recipient, uint amount) internal{
        require(_owner != address(0), "transfer from the zero address");
        require(_recipient != address(0), "transfer to the zero address");
        
        _allowances[_owner][_recipient] = amount;
        emit Approval(_owner,_recipient,amount);
    }
    
    function _mint(address account, uint amount) internal {
        require(account != address(0), "transfer to zero address");
        
        _totalSupply += amount;
        _balance[account] += amount;
        emit Transfer(address(0), account, amount);
    }
    
}