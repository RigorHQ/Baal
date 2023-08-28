// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "@openzeppelin/contracts/proxy/ERC1967/ERC1967Proxy.sol";

import "../interfaces/IBaalToken.sol";

contract TokenSummoner {

    event TokenDeployed(address sharesToken);

    /**
     * @dev deployTokens
     */
    function deployTokens(
        address _tokenSingleton,
        string calldata _name,
        string calldata _symbol
    ) external {
        address token = address(
            new ERC1967Proxy(
                _tokenSingleton,
                abi.encodeWithSelector(
                    IBaalToken(_tokenSingleton).setUp.selector,
                    _name,
                    _symbol
                )
            )
        );

        IBaalToken(token).pause();

        IBaalToken(token).transferOwnership(address(msg.sender));

        emit TokenDeployed(token);
    }

}
