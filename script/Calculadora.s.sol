// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script} from "forge-std/Script.sol";
import {Calculadora} from "../src/Calculadora.sol";

contract CalculadoraScript is Script {

    Calculadora calculadora;

    // function setUp() public {}

    function run() public returns(Calculadora) {
        vm.startBroadcast();

        calculadora = new Calculadora();

        vm.stopBroadcast();

        return calculadora;
    }
}
