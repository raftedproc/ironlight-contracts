// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {ISP1Verifier} from "../src/ISP1Verifier.sol";

contract CallVerifyProof is Script {
    function run() external view {
        bytes32 programVKey = 0x00;
        bytes memory publicValues = vm.envBytes("PUBLIC_VALUES_AS_BYTES");
        bytes memory proofBytes = vm.envBytes("PROOF_AS_BYTES");
        address verifierAddress = vm.envAddress("VERIFIER_ADDRESS");

        uint start = vm.unixTime();
        uint256 gasBefore = gasleft();

        ISP1Verifier(verifierAddress).verifyProof(
            programVKey,
            publicValues,
            proofBytes
        );

        uint256 gasAfter = gasleft();
        uint end = vm.unixTime();
        console.log("Groth16 proof is valid");
        console.log("Execution time: ", end - start, "milliseconds");
        console.log("Gas used:", gasBefore - gasAfter);
    }
}
