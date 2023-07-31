// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "https://github.com/UnvsCom/UniverseRegistry/blob/main/ERC721.sol";

/**
 * @dev Extension of {ERC721} that allows token holders to destroy their own tokens.
 */
abstract contract ERC721Burnable is ERC721 {
    /**
     * @dev Destroys `tokenId`.
     * The approval is cleared when the token is burned.
     *
     * Requirements:
     *
     * - The caller must own `tokenId` or be an approved operator.
     */
    function burn(uint256 tokenId) public virtual {
        //solhint-disable-next-line max-line-length
        require(_isApprovedOrOwner(_msgSender(), tokenId), "ERC721Burnable: caller is not owner nor approved");
        _burn(tokenId);
    }
}
