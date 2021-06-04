// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.0;

contract MyContract {
    address owner;                          // dirección del dueño (habitual verlo así)
    string internal strTest = "Test";       // internal es el valor por defecto
    uint256 uiNum = 73;                     // 256 bits es el valor mínimo de celdas de Solidity
    int256 iNum = -73;                      // no existen floats en Solidity
    bool flag = false;                      // los bools se suelen llamar banderas
    bytes32 myBytes = "String de bytes";    // una especie de array de bytes
    address myAddress;                      // dirección de una cuenta (0x7a...)
    
    uint256 constant cienPi = 314;          // debe asignársele un valor en la declaración
    uint256 immutable immutNum;             // puede asignársele un valor después de la declaración (en el constructor)      
    
    constructor(uint256 num) {
        owner = msg.sender;
        immutNum = num;        
    }
    
    /*  uint256 public varPublic;
     *  declarar una variable como pública es equivalente a esta función
     *
     *  function varPublic() public view returns (uint256) {
     *      return varPublic;
     *  }
     */
     
    uint256[] arrDynam = [1, 2, 3];                    // array dinámico
    uint256[3] arrStat = [1, 2, 3];                    // array estático
    string[][] arrMult = [["a", "b"], ["c", "d"]];     // array multidimensional
    
    function setStaticArray(uint256 num) public {
     // en un array estático no existe el método push()
     arrStat[1] = num; 
    }
    
    function setDynamicArray(uint256 num) public {
     arrDynam.push(num);
    }
    
    function delLastElement() public {
     // delete no elimina una celda (como pop()), sólo la resetea a 0 o false
     delete arrDynam[arrDynam.length - 1];
    }
    
    function addArrayElement(string memory str1, string memory str2) public {
        arrMult.push([str1, str2]);
    }
     
    function funcArray() public {
        uint256[] memory _arrTest = new uint256[](3);
        _arrTest[0] = 1;
        _arrTest[1] = 2;
        _arrTest[2] = 3;
     }
     
     /***************************************************************************/
     
    enum EnTest {                                      // los enum suelen comenzar con mayúscula
        encendido,
        apagado
    }
     
    EnTest public vehiculo = EnTest.apagado;
     
    function arrancar() public {
        vehiculo = EnTest.encendido;    
    }
}