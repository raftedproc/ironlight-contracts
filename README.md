## IronLight Groth16 verifier contract

IronLight is a provable version RandomX light mode implemeted in Rust. Here is IronLight's repo: 

https://github.com/fluencelabs/randomx-rust-wrapper/tree/randomx-plonky3-sp1

### Deploy Verifier contract

```shell
$ forge build
$ forge create --rpc-url <your_rpc_url> --private-key <your_private_key>  src/SP1VerifierGroth16.sol:SP1Verifier
```

### Verify Groth16 proof produced by SP1 recursion engine

```shell
$ forge script CallVerifyProof --broadcast --private-key <your_private_key>
```

