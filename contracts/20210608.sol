// SPDX-License-Identifier: UNLICENSED
// versión vulnerable al código posterior (c/ compilador adecuado)
pragma solidity >=0.4.0;

library SafeMath8 {
    // biblioteca de OpenZeppelin
    function suma(uint8 a, uint8 b) internal pure returns (uint8) {         // si no es internal necesita su propio deploy
        uint8 c = a + b;
        require(c >= a, "Overflow");
        return c;
    }
    
    function resta(uint8 a, uint8 b) internal pure returns (uint8) {
        require(b <= a, "Underflow");
        uint8 c = a - b;
        return c;
    }
}

// ej. clásico de patrones de seguridad (overflow, underflow)
contract conSeguridad {
    // uint8 en rango [0 - 255] (vulnerable)
    mapping (address => uint8) public candidatos;
    
    function increment(address add, uint8 val) public {
        // para ataque overflow
        candidatos[add] += val;
    }
    
    function safeIncrement(address add, uint8 val) public {
        // evita overflow
        candidatos[add] = SafeMath8.suma(candidatos[add], val);
    }
    
    function decrement(address add, uint8 val) public {
        // para ataque underflow
        candidatos[add] -= val;
    }
    
    function safeDecrement(address add, uint8 val) public {
        // evita underflow
        candidatos[add] = SafeMath8.resta(candidatos[add], val);
    }
}

/*********************************************************************/

library L {
    function returnAddress() public view returns (address) {                // al ser public hace dos deploy
        return address(this);
    }
}

contract conLibraryTest {
    function addNormal() public view returns (address) {
        return address(this);
    }
    
    function addLibrary() public view returns (address) {
        return L.returnAddress();
    }
}

/*********************************************************************/

library Contador {
    struct Counter {
        uint256 i;
    }
    
    function increment(Counter storage cont) internal returns (uint256) {
        return ++cont.i;
    }
}

contract conLibrary {
    // llamada a biblioteca
    using Contador for Contador.Counter;
    
    Contador.Counter public counter;
    
    function increment() public returns (uint256) {
        return counter.increment();
    }
}