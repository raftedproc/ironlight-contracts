// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {ISP1Verifier} from "../src/ISP1Verifier.sol";

contract CallVerifyProof is Script {
    function run() external view {
        bytes32 programVKey = 0x00;
        bytes memory publicValues = hex"e9dd3d644b83597d866984bd922327a7";
        bytes
            memory proofBytes = hex"873b89730e84116525ebaf39569563801c67eafd1f5fe9dd3d644b83597d866984bd922327a7a90c4cd5453c90779f1ec6506c4f652ae3730c27e00e1f77ca98c0ccff2f1ee77e7f02c85c82c89b8e176829ba03983d20c7f820ce14ef97393dfff185a30dd519bc5cc132378afafaa6cc8ea1511c0b6977a42eb7c3faad7fef6a40a63d0cc15ecf90c6dcb8cb5d2562391ebd6c8626e04702623950c02efaa190a9dd742a7de3ad8d042d8c0f78b1c62516ee962448533728946b3f95df642af25e337d1da74b4bc60e30d56ce4df7196d94397fd70027d962b8f4b26c756a827dba328303dc8c5e5be918462946585cc8440871bc950c3c3e12576d1313036484bb290";

        address verifierAddress = 0x7732bD52f863F34501D3048733Af77d2EB2e5c7f;

        uint start = vm.unixTime();
        uint256 gasBefore = gasleft();

        ISP1Verifier(verifierAddress).verifyProof(
            programVKey,
            publicValues,
            proofBytes
        );

        uint256 gasAfter = gasleft();
        uint end = vm.unixTime();
        console.log("Execution time: ", end - start, "milliseconds");
        console.log("Gas used:", gasBefore - gasAfter);
    }
}
