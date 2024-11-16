// // SPDX-License-Identifier: UNLICENSED
// pragma solidity ^0.8.23;

// import {SimpleTeleportProver} from "./SimpleTeleportProver.sol";
// import {WhaleBadgeNFT} from "./WhaleBadgeNFT.sol";

// import {Proof} from "vlayer-0.1.0/Proof.sol";
// import {Verifier} from "vlayer-0.1.0/Verifier.sol";

// contract SimpleTeleportVerifier is Verifier {
//     address public prover;
//     mapping(address => bool) public claimed;
//     WhaleBadgeNFT public reward;

//     constructor(address _prover, WhaleBadgeNFT _nft) {
//         prover = _prover;
//         reward = _nft;
//     }

//     function claim(Proof calldata) public onlyVerified(prover, SimpleTeleportProver.checkSignature.selector) {
//         address claimer = msg.sender;
//         require(!claimed[claimer], "Already claimed");
//         claimed[claimer] = true;
//         reward.mint(claimer);
//     }
// }

// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.23;

import {SimpleTeleportProver} from "./SimpleTeleportProver.sol";
import {IEAS, Attestation} from "@eas-contracts/IEAS.sol";
import {SchemaResolver} from "@eas-contracts/resolver/SchemaResolver.sol";

import {Proof} from "vlayer-0.1.0/Proof.sol";
import {Verifier} from "vlayer-0.1.0/Verifier.sol";

contract SimpleTeleportVerifier is Verifier {
    address public prover;

    constructor(address _prover, address easAddrs) SchemaResolver(IEAS(easAddrs)) {
        prover = _prover;
    }

    function verify(Proof calldata)
        public
        onlyVerified(prover, SimpleTeleportProver.checkSignature.selector)
        returns (bool)
    {
        return true;
    }

    function onAttest(Attestation calldata attestation, uint256 /*value*/ ) internal view override returns (bool) {
        require(msg.sender == address(_eas), "OpacityResolver: Only EAS can call this function");
        Proof memory proof = abi.decode(attestation, (Proof));
        return verify(proof);
    }

    function onRevoke(Attestation calldata, /*attestation*/ uint256 /*value*/ ) internal view override returns (bool) {
        require(msg.sender == address(_eas), "OpacityResolver: Only EAS can call this function");

        // Does not support revocation.
        return false;
    }
}
