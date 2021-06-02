const path = require('path');
const fs = require('fs');
const solc = require('solc');

const storageName = path.resolve(__dirname, 'contracts', 'storageName.sol');
const source = fs.readFileSync(storageName, 'utf8');

const input = {
    language: 'Solidity',
    sources: {
        'storageName.sol': {
            content: source
        }
    },
    settings: {
        outputSelection: {
            '*': {
                '*': ['*']
            }
        }
    }
};

const output = JSON.parse(solc.compile(JSON.stringify(input)));

module.export = output.contracts['storageName.sol'].StorageName;
// Retorna un ABI y un EVM bytecode