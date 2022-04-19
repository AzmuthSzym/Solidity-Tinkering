////SPDX-License-Identifier: Unlicensed
pragma solidity ^0.8.0;

/// @title A contract to see how MerkleTree works
/// @author Azmuth
/// @notice Just a few simple exercises using openzeppelin library

import "@openzeppelin/contracts/utils/cryptography/MerkleProof.sol";

contract MerkleTest {
    bytes32 public merkleRoot = 0x0821bd02648ece087f32e3654e1a0289eeb7406d3652b477063dc91056f8fc8f;

    function treeCheck(bytes32[] calldata _merkeProof, string memory input) public view returns(bool){
        bytes32 leaf = keccak256(abi.encodePacked(input));
        return MerkleProof.verify(_merkeProof, merkleRoot, leaf);
    }
}