// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./../lib/openzeppelin-contracts/contracts/token/ERC721/ERC721.sol";
import "./../lib/openzeppelin-contracts/contracts/access/Ownable.sol";

contract BullMoonNFT is ERC721, Ownable {
    uint256 public currentTokenId = 0;
    uint256 public constant MAX_SUPPLY = 3500;
    uint256 public mintPrice = 0.01 ether;
    string private _baseTokenURI;
    bool public mintingEnabled = false;

    constructor(string memory baseURI) ERC721("BullMoon", "BMN") Ownable(msg.sender) {
        _baseTokenURI = baseURI;
    }

    function mintNFT() public payable returns (uint256) {
        require(mintingEnabled, "Minting is not enabled");
        require(currentTokenId < MAX_SUPPLY, "Max supply reached");
        require(msg.value >= mintPrice, "Not enough ETH to mint NFT");

        currentTokenId++;
        uint256 newItemId = currentTokenId;

        _safeMint(msg.sender, newItemId);

        return newItemId;
    }

    function _baseURI() internal view virtual override returns (string memory) {
        return _baseTokenURI;
    }

    function setBaseURI(string memory baseURI) external onlyOwner {
        _baseTokenURI = baseURI;
    }

    function setMintPrice(uint256 newPrice) external onlyOwner {
        require(newPrice > 0, "Price must be greater than 0");
        mintPrice = newPrice;
    }

    function toggleMinting(bool enabled) external onlyOwner {
        mintingEnabled = enabled;
    }

    function withdraw() external onlyOwner {
        payable(owner()).transfer(address(this).balance);
    }
}