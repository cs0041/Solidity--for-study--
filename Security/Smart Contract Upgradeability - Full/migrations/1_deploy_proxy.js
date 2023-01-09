const Dogs = artifacts.require('Dogs')
const Proxy = artifacts.require('Proxy')

module.exports = async function (deployer, network, accounts) {
  //Deploy Contracts
  const dogs = await Dogs.new()
  const proxy = await Proxy.new(dogs.address)

  //Create Proxy Dog to Fool Truffle
  var proxyDog = await Dogs.at(proxy.address)

  //Set the nr of dogs through the proxy
  await proxyDog.setNumberOfDogs(10)

  //Tested
  var nrOfDogs = await proxyDog.getNumberOfDogs()
  console.log('Before update: ' + nrOfDogs.toNumber())


}
