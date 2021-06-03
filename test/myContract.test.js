const assert = require('assert');
// Ganache provee cuentas (testnet?)
const ganache = require('ganache-cli');
// Web3 en mayúscula porque es una clase de JS, en minúscula cuando es una instancia
const Web3 = require('web3');                                   // Consultar ether.js (más ligero)
const web3 = new Web3(ganache.provider());                      // Ganache es el nodo de conexión aquí
const compile = require('../compile');
const abi = compile.abi;                                        // Esquema de las funciones del contrato
const bytecode = compile.evm.bytecode.object;                   // Código del EVM (Ethereum Virtual Machine)

let accounts;
let contractInstance;

// ReferenceError: beforeEach is not defined
beforeEach(async () => {
    // Obtenemos las cuentas del nodo (Ganache)
    accounts = await web3.eth.getAccounts();                    // await espera antes de ejecutar el código siguiente (async)
    // Instanciamos el contrato con los parámetros necesarios
    contractInstance = await new web3.eth.Contract(abi)
    .deploy({
        data: bytecode,
        arguments: ['argNombreContrato']
    })
    .send({
        from: accounts[0],
        gas: '1000000'
    });
});s

// Tests de Mocha
describe('StorageName', () => {
    it('Deploys a contract', () => {
        console.log(contractInstance.__address);
    });
    it('Origin name', async () => {
        // Retorna el nombre del contrato sin transacción (call en vez de send)
        const name = await contractInstance.methods.getName().call();
        assert.strictEqual('argNombreContrato', name);
    });
    it('Can change name', async () => {
        await contractInstance.methods.setName('argNuevoNombre').send({from: accounts[0]});
        const name = await contractInstance.methods.getName().call();
        assert.strictEqual('argNuevoNombre', name);
    });
});