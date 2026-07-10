// SPDX-License-Identifier: MIT
pragma solidity 0.8.30;

/**
 * @title Calculadora
 * @author Carlos Gutiérrez
 * @notice Math functions
 */
contract Calculadora {
    // Custom errors
    error Calculadora__CannotDivideZeroValue();
    
    // Variables
    /**
     * @dev Used to store the result of an operation
     */
    int256 private s_resultado;

    // Modifiers
    modifier checkZero(int256 _num) {
        _checkZero(_num);
        _;
    }

    // Events
    event Add(int256 num1, int256 num2, int256 resultado);
    event Substract(int256 num1, int256 num2, int256 resultado);
    event Multiply(int256 num1, int256 num2, int256 resultado);
    event Divide(int256 num1, int256 num2, int256 resultado);

    // functions
    // External functions
    /**
     * @dev Used to get the result of an operation, it returns the variable s_resultado
     * @return result Result of the operaton
     */
    function getResult() external view returns(int256 result) {
        result = s_resultado;
    }

    /**
     * @dev adding function
     * @param _num1 First number to add
     * @param _num2 Second number to add
     * @return _resultado Result
     */ 
    function add(int256 _num1, int256 _num2) external returns(int256 _resultado) {
        _resultado = _num1 + _num2;
        s_resultado = _resultado;

        emit Add(_num1, _num2, s_resultado);
    }

    /**
     * @dev substraction function
     * @param _num1 First number to substract
     * @param _num2 Second number to substract
     * @return _resultado Result
     */
    function substraction(int256 _num1, int256 _num2) external returns(int256 _resultado) {
        _resultado = _num1 - _num2;
        s_resultado = _resultado;
        emit Substract(_num1, _num2, s_resultado);
    }

    /**
     * @dev Multiplication function
     * @param _num1 First number to multiply
     * @param _num2 Second number to multiply
     * @return _resultado Result
     */
    function multiplication(int256 _num1, int256 _num2) external returns(int256 _resultado) {
        _resultado = _num1 * _num2;
        s_resultado = _resultado;
        emit Multiply(_num1, _num2, s_resultado);
    }

    /**
     * @dev division function
     * @param _num1 Dividend
     * @param _num2 Divisor
     * @return _resultado Result
     */
    function division(int256 _num1, int256 _num2) external checkZero(_num2) returns(int256 _resultado) {
        _resultado = _num1 / _num2;

        s_resultado = _resultado;
        emit Divide(_num1, _num2, s_resultado);
    }

    // private functions
    /**
     * @dev function to check zero value in division
     * @param _num Divisor to check if it is zero
     */
    function _checkZero(int256 _num) private pure {
        if (_num == 0) revert Calculadora__CannotDivideZeroValue();
    }

}
