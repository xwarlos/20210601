// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.0;

interface ERC20 {
    // https://eips.ethereum.org/EIPS/eip-20
    function name() external view returns (string memory);
    function symbol() external view returns (string memory);
    function decimals() external view returns (uint8);
    function totalSupply() external view returns (uint256 balance);
    function balanceOf(address _owner) external view returns (uint256 balance);
    function transfer(address _to, uint256 _value) external returns (bool success);
    function transferFrom(address _from, address _to, uint256 _value) external returns (bool success);
    function approve(address _spender, uint256 _value) external returns (bool success);
    function allowance(address _owner, address _spender) external view returns (uint256 remaining);
    event Transfer(address indexed _from, address indexed _to, uint256 _value);
    event Approval(address indexed _owner, address indexed _spender, uint256 _value);
}

contract TestToken is ERC20 {
    // el compilador asigna los valores correspondientes a las variables (take the wheel)
    mapping (address => uint256) public override balanceOf;
    mapping (address => mapping (address => uint256)) public override allowance;
    string public override name;
    string public override symbol;
    uint8 public override decimals;
    uint256 public override totalSupply;
    
    constructor(uint256 _supply, string memory _name, string memory _symbol, uint8 _decimals) public {
        balanceOf[msg.sender] = _supply;                                         // se asigna inicialmente todo el supply al msg.sender
        name = _name;
        symbol = _symbol;
        decimals = _decimals;
        totalSupply = _supply;
    }
    
    function transfer(address _to, uint256 _value) public override returns (bool success) {
        require(balanceOf[msg.sender] >= _value, "Saldo insuficiente");
        
        balanceOf[msg.sender] -= _value;
        balanceOf[_to] += _value;
        
        emit Transfer(msg.sender, _to, _value);
        return true;
    }
    
    function transferFrom(address _from, address _to, uint256 _value) public override returns (bool success) {
        // allowed[_from][msg.sender] := cantidad autorizada para manejar de _from a msg.sender
        require(allowance[_from][msg.sender] >= _value && balanceOf[_from] >= _value, "Saldo insuficiente o falta de permisos");
        
        balanceOf[_from] -= _value;
        balanceOf[_to] += _value;
        allowance[_from][msg.sender] -= _value;
        
        emit Transfer(_from, _to, _value);
        return true;
    }
    
    function approve(address _spender, uint256 _value) public override returns (bool success) {
        // da derechos a _spender para operar con tokens del msg.sender
        allowance[msg.sender][_spender] = _value;
        emit Approval(msg.sender, _spender, _value);
        return true;
    }
}