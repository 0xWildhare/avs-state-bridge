// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Proof} from "vlayer-0.1.0/Proof.sol";
import {Prover} from "vlayer-0.1.0/Prover.sol";
import {BN254} from "eigenlayer-middleware/src/libraries/BN254.sol";
import {IBLSApkRegistry} from "eigenlayer-middleware/src/interfaces/IBLSApkRegistry.sol";
import {IRegistryCoordinator} from "eigenlayer-middleware/src/interfaces/IRegistryCoordinator.sol";

struct BLSSigSchema {
    BN254.G1Point msgPoint;
    BN254.G1Point apk;
    BN254.G2Point apkG2;
    BN254.G1Point sigma;
    BN254.G1Point[12] nonSignerPubkeys;
}

contract SimpleTeleportProver is Prover {
    using BN254 for BN254.G1Point;

    uint256 internal constant PAIRING_EQUALITY_CHECK_GAS = 120_000;
    IBLSApkRegistry public blsApkRegistry;
    IRegistryCoordinator public registryCoordinator;

    constructor() {
        blsApkRegistry = IBLSApkRegistry(0x2e72a4aECE226985D8A798424778647aEa49bFbE);
        registryCoordinator = IRegistryCoordinator(0xeCd099fA5048c3738a5544347D8cBc8076E76494);
    }

    function checkSignature(BLSSigSchema memory schema) public returns (Proof memory) {
        setChain(1, 21199991);
        BN254.G1Point memory apk = BN254.G1Point(0, 0);
        for (uint256 i = 0; i < schema.nonSignerPubkeys.length; i++) {
            if (schema.nonSignerPubkeys[i].X != 0) {
                BN254.G1Point memory operatorPk = schema.nonSignerPubkeys[i];
                address operator = blsApkRegistry.getOperatorFromPubkeyHash(BN254.hashG1Point(operatorPk));
                // check if the operator is registered to AVS
                if (registryCoordinator.getOperatorStatus(operator) == IRegistryCoordinator.OperatorStatus.REGISTERED) {
                    apk = apk.plus(operatorPk);
                }
            } else {
                break;
            }
        }
        apk = apk.negate();
        apk = apk.plus(BN254.G1Point(blsApkRegistry.getApk(0).X, blsApkRegistry.getApk(0).Y));

        (bool pairingSuccessful, bool siganatureIsValid) =
            trySignatureAndApkVerification(schema.msgPoint, apk, schema.apkG2, schema.sigma);
        assert(pairingSuccessful && siganatureIsValid);

        return (proof());function onAttest(Attestation calldata attestation, uint256 /*value*/ ) internal view override returns (bool) {
        require(msg.sender == address(_eas), "OpacityResolver: Only EAS can call this function");
        Proof memory proof = abi.decode(attestation, (Proof));
        return verify(proof);
    }
    }

    function trySignatureAndApkVerification(
        BN254.G1Point memory msgPoint,
        BN254.G1Point memory apk,
        BN254.G2Point memory apkG2,
        BN254.G1Point memory sigma
    ) internal view returns (bool pairingSuccessful, bool siganatureIsValid) {
        uint256 gamma = uint256(
            keccak256(abi.encodePacked(apk.X, apk.Y, apkG2.X[0], apkG2.X[1], apkG2.Y[0], apkG2.Y[1], sigma.X, sigma.Y))
        ) % BN254.FR_MODULUS;
        // verify the signature
        (pairingSuccessful, siganatureIsValid) = BN254.safePairing(
            BN254.plus(sigma, BN254.scalar_mul(apk, gamma)),
            BN254.negGeneratorG2(),
            BN254.plus(msgPoint, BN254.scalar_mul(BN254.generatorG1(), gamma)),
            apkG2,
            PAIRING_EQUALITY_CHECK_GAS
        );
    }
}
