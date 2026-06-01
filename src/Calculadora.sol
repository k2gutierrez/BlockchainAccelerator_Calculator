// SPDX-License-Identifier: MIT
pragma solidity 0.8.30;

contract Calculadora {

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
     * Used to get the result of an operation, it returns the variable s_resultado
     */
    function getResult() external view returns(int256 result) {
        result = s_resultado;
    }

    /**
     * 
     * @param _num1 First number to add.
     * @param _num2 Second number to add.
     */
    function add(int256 _num1, int256 _num2) external returns(int256 _resultado) {
        _resultado = _num1 + _num2;
        s_resultado = _resultado;

        emit Add(_num1, _num2, s_resultado);
    }

    /**
     * 
     * @param _num1 First number to substract
     * @param _num2 Second number to substract
     */
    function substraction(int256 _num1, int256 _num2) external returns(int256 _resultado) {
        _resultado = _num1 - _num2;
        s_resultado = _resultado;
        emit Substract(_num1, _num2, s_resultado);
    }

    /**
     * 
     * @param _num1 First number to multiply
     * @param _num2 Second number to multiply
     */
    function multiplication(int256 _num1, int256 _num2) external returns(int256 _resultado) {
        _resultado = _num1 * _num2;
        s_resultado = _resultado;
        emit Multiply(_num1, _num2, s_resultado);
    }

    /**
     * 
     * @param _num1 Dividend
     * @param _num2 Divisor
     */
    function division(int256 _num1, int256 _num2) external checkZero(_num2) returns(int256 _resultado) {
        _resultado = _num1 / _num2;

        s_resultado = _resultado;
        emit Divide(_num1, _num2, s_resultado);
    }

    // private functions

    function _checkZero(int256 _num) private pure {
        if (_num == 0) revert Calculadora__CannotDivideZeroValue();
    }

}
