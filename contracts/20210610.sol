// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.0;

contract SendEther {
    /* receive y fallback son funciones reservadas de Solidity
     * si existe msg.data se ejecuta fallback, si no receive
     */
    
    receive() external payable {}
    
    fallback() external payable {}
    
    function getBalance() public view returns (uint) {
        return address(this).balance;
    }
}

contract TransferEther {
    // tres formas de mandar fondos: send, transfer y call (bajo nivel)
    
    function funcSend(address payable to) public payable {
        // 2300 gas (seguridad contra ataques de reentrada (consultar))
        bool success = to.send(address(this).balance);                      // devuelve un booleano indicando éxito / error
        require(success, "No transferido");                                 // require revierte la transacción en caso de error
    }
    
    function funcTransfer(address payable to) public payable {
        // 2300 gas (seguridad contra ataques de reentrada)
        to.transfer(1 ether);                                               // revierte la transacción en caso de error sin necesidad de require (preferible a send generalmente)
    }
    
    
    function funcCall(address to) public payable {
        // envía todo el gas salvo que se especifique lo contrario
        // https://github.com/ethereum/solidity/issues/2884#issuecomment-329169020
        (bool success, bytes memory data) = to.call{value: 1 ether}("");         // llamada de bajo nivel, toma parámetros opcionalmente y devuelve dos valores
        require(success, "No transferido");
    }
}// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.0;

contract SendEther {
    /* receive y fallback son funciones reservadas de Solidity
     * si existe msg.data se ejecuta fallback, si no receive
     */
    
    receive() external payable {}
    
    fallback() external payable {}
    
    function getBalance() public view returns (uint) {
        return address(this).balance;
    }
}

contract TransferEther {
    // tres formas de mandar fondos: send, transfer y call (bajo nivel)
    
    function funcSend(address payable to) public payable {
        // 2300 gas (seguridad contra ataques de reentrada (consultar))
        bool success = to.send(address(this).balance);                      // devuelve un booleano indicando éxito / error
        require(success, "No transferido");                                 // require revierte la transacción en caso de error
    }
    
    function funcTransfer(address payable to) public payable {
        // 2300 gas (seguridad contra ataques de reentrada)
        to.transfer(1 ether);                                               // revierte la transacción en caso de error sin necesidad de require (preferible a send generalmente)
    }
    
    
    function funcCall(address to) public payable {
        // envía todo el gas salvo que se especifique lo contrario
        // https://github.com/ethereum/solidity/issues/2884#issuecomment-329169020
        (bool success, bytes memory data) = to.call{value: 1 ether}("");         // llamada de bajo nivel, toma parámetros opcionalmente y devuelve dos valores
        require(success, "No transferido");
    }
}