import "./IERC20.sol";
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


contract ERC20 is IERC20 {

    uint256 public _totalSupply;
    mapping(address => uint) public _balanceOf;
    mapping(address => mapping(address => uint)) public _allowance;
    string public _name;
    string public _symbol;
    uint8 public decimals;

     constructor(string memory name, string memory symbol) {
        _name = name;
        _symbol = symbol;
    }

    function totalSupply() external view override returns (uint256){
        return _totalSupply;
    }
    function balanceOf(address account) external view override returns(uint256){
        return _balanceOf[account];
    }
    function transfer(address recipient, uint256 amount) external override returns (bool){
        _balanceOf[msg.sender] -= amount;
        _balanceOf[recipient] += amount;
        emit Transfer(msg.sender, recipient, amount);
        return true;
    }
    function allowance(address owner, address sender) external view override returns (uint256){
        return _allowance[owner][sender];

    }
    function approve(address spender, uint256 amount) external override returns (bool){
        _allowance[msg.sender][spender] = amount;
        emit Approval(msg.sender, spender, amount);
        return true;
    }
    function transferFrom(address sender, address recipient, uint256 amount) external override returns(bool){
        _allowance[sender][msg.sender] -= amount;
        _balanceOf[sender] -= amount;
        _balanceOf[recipient] += amount;
        emit Transfer(sender, recipient, amount);
        return true;

    }

    function mint(uint amount) external {
        _balanceOf[msg.sender] += amount;
        _totalSupply += amount;
        emit Transfer(address(0), msg.sender, amount);
    }

    function burn(uint amount) external {
        _balanceOf[msg.sender] -= amount;
        _totalSupply -= amount;
        emit Transfer(msg.sender, address(0), amount);
    }
    
}