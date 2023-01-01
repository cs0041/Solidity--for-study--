const Dex = artifacts.require('Dex')

module.exports = function (deployer){
    deployer.deploy(Dex)
}

// command
// truffle develop
// compile
// migrate or migrate --reset
// let instance = await HelloWorld.deployed()       ||| HelloWorld = your contract name not filename'
// instance.hello()
 