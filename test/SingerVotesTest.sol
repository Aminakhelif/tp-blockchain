// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;
import "forge-std/Test.sol";
import "src/SingingVotes.sol";

contract SingingVotesTest is Test {
    SingingVotes singingVotes;

    function setUp() public {
        bytes32[] memory singerNames = new bytes32[](3);
        singerNames[0] = "Alice";
        singerNames[1] = "Bob";
        singerNames[2] = "Charlie";
        singingVotes = new SingingVotes(singerNames);
    }

    function testInitialVoteCounts() public {
        assertEq(singingVotes.totalVotesFor("Alice"), 0);
        assertEq(singingVotes.totalVotesFor("Bob"), 0);
        assertEq(singingVotes.totalVotesFor("Charlie"), 0);
        assertEq(singingVotes.totalVotesFor("InvalidSinger"), 0);
    }

    function testVotingForSinger() public {
        singingVotes.voteForSinger("Alice");
        assertEq(singingVotes.totalVotesFor("Alice"), 1);

        singingVotes.voteForSinger("Bob");
        singingVotes.voteForSinger("Bob");
        assertEq(singingVotes.totalVotesFor("Bob"), 2);
    }

   
    function testVotingForInvalidSinger() public {
        singingVotes.voteForSinger("InvalidSinger");
        assertEq(singingVotes.totalVotesFor("InvalidSinger"), 0);
    }
}