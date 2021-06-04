// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.0;

contract MyContract {
    mapping(address => uint256) balances;                       //mapping (mapeo) o diccionario
    mapping(address => mapping(address => bool)) approved;      //mapping bidimensional
    mapping(address => string[]) vehicles;                      //mapeo a array (e.g.)
    
    function setBalance(address add_) public {
        balances[add_] = 31;
    }
    
    function getBalance(address add_) public view returns (uint256) {
        return balances[add_];
    }
    
    function updateBalance(address add_, uint256 value) public {
        //básicamente es como el setBalance
        balances[add_] = value;
    }
    
    function delBalance(address add_) public {
        //delete lo resetearía a 0
        delete balances[add_];
    }
    
    function setPermission(address owner, address spender) public {
        //tendría más sentido usar msg.sender (owner) como address
        approved[owner][spender] = true;
    }
    
    function getPermission(address owner, address spender) public view returns (bool) {
        return approved[owner][spender];
    }
    
    function updatePermission(address owner, address spender, bool value) public {
        approved[owner][spender] = value;
    }
    
    function delPermission(address owner, address spender) public {
        //delete lo resetearía a false
        delete approved[owner][spender];
    }
    
    function setVehicle(address add_, string memory strMatricula) public {
        vehicles[add_].push(strMatricula);
    }
    
    function getVehicles(address add_) public view returns (string[] memory) {
        return vehicles[add_];
    }
    
    function updateVehicle(address add_, string memory strMatricula) public {
        vehicles[add_][0] = strMatricula;
    }
    
    function delVehicle(address add_) public {
        //delete lo resetearía a ""
        delete vehicles[add_][0];
    }
}