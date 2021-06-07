// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.0;

contract conValores {
    uint256[] public arrGlobal;
    
    constructor() {
        arrGlobal.push(31);
    }
    
    function ejemploByVal() public view returns (uint256, uint256) {
        // memory guarda el valor asignado a la variable en la memoria temporal
        uint256[] memory arrFuncion = arrGlobal;                        // asignación por valor (byVal)
        arrFuncion[0] = 73;                                             // es posible variar el valor de forma independiente
        return (arrFuncion[0], arrGlobal[0]);
    }
    
    function ejemploByRef() external returns (uint256, uint256) {       // external obliga a ser llamado por un contrato externo (no puede ser view ahora)
        // storage guarda el valor asignado a la variable en el almacenamiento
        uint256[] storage arrFuncion = arrGlobal;                       // asignación por referencia (byRef)
        arrFuncion[0] = 73;                                             // cambiar el valor de una variable afecta a la otra
        return (arrFuncion[0], arrGlobal[0]);
    }
}

contract conErrores {
    /* throw.- lanza excepción (deprecated)
     * require.- revierte cambios y sólo consume gas hasta ese punto de ejecución
     * revert.- idéntico a require (para otras situaciones)
     * assert.- revierte cambios y consume la totalidad del gas
     */
     
    constructor() payable {}                                        // payable indica que puede recibir pagos (weis)
     
    function handleRequireError() public payable {
     // usado para evaluar aspectos de la transacción
        bool error = msg.value >= 1 ether;                          // valor de la transacción >= 1 ether
        require(error, "Valor inferior a 1 ETH");                   // dos parámetros: condición y mensaje
    }
     
    function handleRequireError2() public payable {
        bool error = msg.value >= 5 ether;
        require(error, "Valor inferior a 5 ETH");
    }
     
    function handleRevertError() public view {
        // usado para evaluar estados internos del contrato
        if (address(this).balance > 2 ether) {                      // address(this) hace referencia al saldo del contrato
            revert("Balance superior a 2 ETH");                     // un parámetro: mensaje de error
        }
    }
     
    function handleRevertError2() public view {
        if (address(this).balance < 5 ether) {
            revert("Balance inferior a 5 ETH");
        }
    }
     
    function handleAssertError() public view {
        assert(address(this).balance < 5 ether);                    // un parámetro: condición
    }
}

contract conModifiers {
    address public owner;
    uint256 public num;
    
    modifier onlyOwner {
        require(msg.sender == owner, "Sin derechos");
        _;                                                          // _; indica que la función debe seguir ejecutándose (obligatorio)
    }
    
    constructor() {
        owner = msg.sender;
        num = 0;
    }
    
    function setNum(uint256 num_) public onlyOwner {                // llama al modifier antes de entrar a la función
        num = num_;
    }
}

contract conBorrar {
    address public owner;
    string public txt = "Texto prueba";
    bool stop = false;
    
    modifier onlyOwner {
        require(msg.sender == owner, "Sin derechos");
        _;
    }
    
    modifier onlyStopFalse {
        require(!stop, "Contrato en modo stop");
        _;
    }
    
    constructor() payable {
        owner = msg.sender;
    }
    
    function getBalance() public view onlyStopFalse returns (uint256, uint256) {
        return (msg.sender.balance, address(this).balance);
    }
    
    function setStop(bool value) public onlyOwner {
        stop = value;
    }
    
    function delContract() public onlyOwner {                       // deja el contrato inservible, necesario castear el address a payable
        selfdestruct(payable(msg.sender));                          // equivalente a suicide(address);
    }
    
    function liquidate() public onlyOwner {
        // similar al selfdestruct pero sin destruír el contrato
        stop = true;                                                // deja el contrato en stop (reversible)
        payable(msg.sender).transfer(address(this).balance);        // transfiere el saldo del contrato al owner
    }
}