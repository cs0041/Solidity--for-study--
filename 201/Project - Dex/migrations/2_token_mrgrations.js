const Link = artifacts.require('Link')
const Dex = artifacts.require('Wallet')

module.exports = async function (deployer,network,accounts){
    await deployer.deploy(Link);
   

};



