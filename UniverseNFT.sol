// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Address.sol";

contract UniverseNFT is ERC721Enumerable, Ownable {
    using Address for address;
    using Strings for uint256;

    string private _baseTokenURI;

    function _baseURI() internal view override returns (string memory) {
        return _baseTokenURI;
    }

    function setBaseURI(string memory baseURI) public onlyOwner {
        _baseTokenURI = baseURI;
    }

    function listNFTForSale(uint256 tokenId, uint256 price) public {
        require(ownerOf(tokenId) == msg.sender, "Only the NFT owner can list it for sale.");
        _approve(address(this), tokenId);
        emit Approval(msg.sender, address(this), tokenId);

        // Call the OpenSea marketplace contract to list the NFT for sale
        // Implement this function according to the OpenSea marketplace integration specifications
    }

    function cancelNFTSale(uint256 tokenId) public {
        require(ownerOf(tokenId) == msg.sender, "Only the NFT owner can cancel the sale.");
        _approve(address(0), tokenId);
        emit Approval(msg.sender, address(0), tokenId);

        // Call the OpenSea marketplace contract to cancel the NFT sale
        // Implement this function according to the OpenSea marketplace integration specifications
    }

    function purchaseNFT(uint256 tokenId) public payable {
        address owner = ownerOf(tokenId);
        require(owner != address(0), "Invalid tokenId.");
        require(msg.value > 0, "Insufficient payment.");
        require(msg.value >= getPrice(tokenId), "Insufficient payment for the NFT.");

        address payable seller = payable(owner);
        _transfer(seller, msg.sender, tokenId);
        seller.transfer(msg.value);

        // Call the OpenSea marketplace contract to complete the NFT purchase
        // Implement this function according to the OpenSea marketplace integration specifications
    }

    function getPrice(uint256 tokenId) public view returns (uint256) {
        // Return the price set by the NFT owner for the given tokenId
        // Implement this function according to your marketplace integration or pricing mechanism
    }
}
