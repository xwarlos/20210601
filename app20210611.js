// en esencia idéntico al deploy.js pero explicado con más calma
const Web3 = require("web3");
const web3 = new Web3("https://mainnet.infura.io/v3/2414458dd7314a0aacec8eabc02c452f");

const compile = require('./compile');                               // aquí ya deberíamos meter algo de Ganache o similar

const abiContract = compile.abi;
var addContract = "0x47f...";                                       // error porque no es un address real (evidentemente)
addContract = "0xBE0eB53F46cd790Cd13851d5EFf43D12404d33E8";         // address de ejemplo

const contrInstance = new web3.eth.Contract(abiContract, addContract);
contrInstance.methods.name().call().then(res => console.log(res));  // aquí ya falla

// https://medium.com/finnovate-io/how-do-i-sign-transactions-with-web3-f90a853904a2
const privateKey = Buffer.from("aquí iría la clave privada", "hex");// etc

// se acabó el tiempo
// el juego de los despropósitos