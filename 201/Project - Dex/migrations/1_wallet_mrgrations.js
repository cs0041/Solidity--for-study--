const Wallet = artifacts.require('Wallet')

module.exports = function (deployer){
    deployer.deploy(Wallet)
}

// command
// truffle develop
// compile
// migrate or migrate --reset
// let instance = await HelloWorld.deployed()       ||| HelloWorld = your contract name not filename'
// instance.hello()
 