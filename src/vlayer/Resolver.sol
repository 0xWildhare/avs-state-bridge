pragma solidity ^0.8.23;

import {WhaleBadgeNFT} from "./WhaleBadgeNFT.sol";

import {SimpleTeleportProver} from "./SimpleTeleportProver.sol";
import {IEAS, Attestation} from "@eas-contracts/IEAS.sol";
import {SchemaResolver} from "@eas-contracts/resolver/SchemaResolver.sol";

import {Proof} from "vlayer-0.1.0/Proof.sol";
import {Verifier} from "vlayer-0.1.0/Verifier.sol";
import {SimpleTeleportVerifier} from "./SimpleTeleportVerifier.sol";

contract Resolver is SchemaResolver {
    SimpleTeleportVerifier public verifier;

    constructor(address _verifier, address easAddrs) SchemaResolver(IEAS(easAddrs)) {
        verifier = SimpleTeleportVerifier(_verifier);
    }

    function onAttest(Attestation calldata attestation, uint256 /*value*/ ) internal view override returns (bool) {
        require(msg.sender == address(_eas), "OpacityResolver: Only EAS can call this function");
        Proof memory proof = abi.decode(attestation.data, (Proof));
        return verifier.verify(proof);
        // return true;
    }

    function onRevoke(Attestation calldata, /*attestation*/ uint256 /*value*/ ) internal view override returns (bool) {
        require(msg.sender == address(_eas), "OpacityResolver: Only EAS can call this function");

        // Does not support revocation.
        return false;
    }
}
