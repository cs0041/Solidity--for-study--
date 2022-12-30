const HelloWorld = artifacts.require('HelloWorld')

module.exports = function (deployer){
    deployer.deploy(HelloWorld)
}

// command
// truffle develop
// compile
// migrate or migrate --reset
// let instance = await HelloWorld.deployed()       ||| HelloWorld = your contract name not filename'
// instance.hello()
 