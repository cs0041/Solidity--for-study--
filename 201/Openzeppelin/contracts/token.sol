pragma solidity =0.8.17;

import "../node_modules/@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "../node_modules/@openzeppelin/contracts/token/ERC20/extensions/ERC20Capped.sol";
import "../node_modules/@openzeppelin/contracts/access/Ownable.sol";
contract MyToken is ERC20Capped, Ownable{
    constructor() ERC20("MyToken","MTK") ERC20Capped(10000){
        _mint(msg.sender,100);

    }

      function burn(uint256 amount) public virtual {
        _burn(_msgSender(), amount);
    }

     function burnFrom(address account, uint256 amount) public virtual {
        _spendAllowance(account, _msgSender(), amount);
        _burn(account, amount);
    }
}