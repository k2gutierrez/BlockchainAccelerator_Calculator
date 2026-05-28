// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console2} from "forge-std/Test.sol";
import {Calculadora} from "../src/Calculadora.sol";
import {CalculadoraScript} from "../script/Calculadora.s.sol";

contract CalculadoraTest is Test {

    CalculadoraScript deployer;
    Calculadora public calculadora;

    address USER = makeAddr("user");

    uint256 constant STARTING_BALANCE = 400 ether;

    function setUp() public {
        deployer = new CalculadoraScript();
        calculadora = deployer.run();

        vm.deal(USER, STARTING_BALANCE);
    }

    function testAddOperation() public {
        int256 add = calculadora.add(10, 5);
        int256 result = calculadora.getResult();
        console2.log("Resultado: ", result);
        assertEq(result, add);
    }

    function testAddOperationWithNegativeValue() public {
        int256 add = calculadora.add(-5, -6);
        int256 result = calculadora.getResult();
        console2.log("Resultado: ", result);
        assertEq(result, add);
    }

    function testSubstractOperation() public {
        int256 sub = calculadora.substraction(250, 130);
        int256 result = calculadora.getResult();
        console2.log("Resultado: ", result);
        assertEq(result, sub);
    }

    function testSubstractOperationWithNegativeValue() public {
        int256 sub = calculadora.substraction(-5, -2);
        int256 result = calculadora.getResult();
        console2.log("Resultado: ", result);
        assertEq(result, sub);
    }

    function testMultiplyOperation() public {
        int256 multiply = calculadora.multiplication(7, 4);
        int256 result = calculadora.getResult();
        console2.log("Resultado: ", result);
        assertEq(result, multiply);
    }

    function testMultiplyOperationWithNegativeValue() public {
        int256 multiply = calculadora.multiplication(-100, -75);
        int256 result = calculadora.getResult();
        console2.log("Resultado: ", result);
        assertEq(result, multiply);
    }

    function testDivideOperation() public {
        int256 divide = calculadora.division(120, 55);
        int256 result = calculadora.getResult();
        console2.log("Resultado: ", result);
        assertEq(result, divide); // int value, it does not give decimals values.
    }

    function testDivideOperationWithNegativeValue() public {
        int256 divide = calculadora.division(-100, 75);
        int256 result = calculadora.getResult();
        console2.log("Resultado: ", result);
        assertEq(result, divide);
    }

    function testRevertOnZeroValueInDvision() public {
        vm.expectRevert(Calculadora.Calculadora__CannotDivideZeroValue.selector);
        calculadora.division(-100, 0);
    }

    // Fuzz tests
    function testFuzz_Add(int256 _num1, int256 _num2) public {
        // Debemos prevenir el overflow y underflow
        _num1 = bound(_num1, -100, 2000);
        _num2 = bound(_num2, -200, 1000);
        int256 add = calculadora.add(_num1, _num2);
        int256 result = calculadora.getResult();
        assertEq(add, result, "Addition failed");
    }

    function testFuzz_Sub(int256 _num1, int256 _num2) public {
        // Debemos prevenir el overflow y underflow
        _num1 = bound(_num1, -100, 2000);
        _num2 = bound(_num2, -200, 1000);
        int256 sub = calculadora.substraction(_num1, _num2);
        int256 result = calculadora.getResult();
        assertEq(sub, result, "Substraction failed");
    }

    function testFuzz_Multiply(int256 _num1, int256 _num2) public {
        // Debemos prevenir el overflow y underflow
        _num1 = bound(_num1, -100, 2000);
        _num2 = bound(_num2, -200, 1000);
        int256 multiply = calculadora.multiplication(_num1, _num2);
        int256 result = calculadora.getResult();
        assertEq(multiply, result, "Multiply failed");
    }

    function testFuzz_Division(int256 _num1, int256 _num2) public {
        // Debemos prevenir el overflow y underflow
        _num1 = bound(_num1, -100, 2000);
        _num2 = bound(_num2, -200, 1000);
        vm.assume(_num2 != 0); // we better prevent it from reverting.
        int256 divide = calculadora.division(_num1, _num2);
        int256 result = calculadora.getResult();
        assertEq(divide, result, "Division failed");
    }

}
