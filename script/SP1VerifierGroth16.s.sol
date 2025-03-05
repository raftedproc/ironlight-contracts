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
        uint256 tries = vm.envUint("CALLS_TRIES");
        uint[] memory timings = new uint256[](tries);
        uint start = vm.unixTime();

        for (uint i = 0; i < tries; i++) {
            // uint256 gasBefore = gasleft();
            uint loopStart = vm.unixTime();


            ISP1Verifier(verifierAddress).verifyProof(
                programVKey,
                publicValues,
                proofBytes
            );

            uint loopEnd = vm.unixTime();
            timings[i] = loopEnd - loopStart;
        }
        uint end = vm.unixTime();
        console.log("Total execution time: ", end - start, "milliseconds");

        sort(timings);
        console.log("P75: ", percentile(timings, 75), "milliseconds");
        console.log("P95: ", percentile(timings, 95), "milliseconds");
    }
    function percentile(uint[] memory arr, uint p)
        internal
        pure
        returns (uint)
    {
        require(arr.length > 0, "Empty array");

        if (p >= 100) {
            return arr[arr.length - 1];
        }

        uint index = (p * (arr.length - 1)) / 100; 
        return arr[index];
    }
    
    function sort(uint[] memory arr) internal pure {
        uint length = arr.length;
        for (uint i = 0; i < length - 1; i++) {
            uint minIndex = i;
            for (uint j = i + 1; j < length; j++) {
                if (arr[j] < arr[minIndex]) {
                    minIndex = j;
                }
            }
            if (minIndex != i) {
                (arr[i], arr[minIndex]) = (arr[minIndex], arr[i]);
            }
        }
    }
}
    
