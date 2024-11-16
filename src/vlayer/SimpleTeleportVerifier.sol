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

pragma solidity ^0.8.23;

import {SimpleTeleportProver} from "./SimpleTeleportProver.sol";

import {Proof} from "vlayer-0.1.0/Proof.sol";
import {Verifier} from "vlayer-0.1.0/Verifier.sol";

contract SimpleTeleportVerifier is Verifier {
    address public prover;
    WhaleBadgeNFT public reward;

    constructor(address _prover) {
        prover = _prover;
    }

    function verify(Proof memory)
        public
        view
        onlyVerified(prover, SimpleTeleportProver.checkSignature.selector)
        returns (bool)
    {
        return true;
    }
}
