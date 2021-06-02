const assert = require('assert');
const ganache = require('ganache-cli');
// Web3 en mayúscula porque es una clase de JS, en minúscula cuando es una instancia
const Web3 = require('web3')                // Consultar ether.js (más ligero)
const web3 = new Web3(ganache.provider());
const compile = require('../compile');
const abi = compile.abi;
const bytecode = compile.evm.bytecode.object;

let accounts;
let contractInstance;