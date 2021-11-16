//
//  Calculator - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

class ViewController: UIViewController {
    private var calculatorManager = CalculatorManager(calculatingFinish: false, isTypingOperand: false)
    
    private var displayOperator: String {
        get {
            guard let `operator` = operatorLabel.text else {
                return ""
            }
            return `operator`
        }
        set {
            operatorLabel.text = newValue
        }
    }
    
    private var displayOperand: String {
        get {
            guard let operand = operandLabel.text else {
                return ""
            }
            return operand
        }
        set {
            operandLabel.text = calculatorManager.format(of: newValue)
        }
    }
    
    @IBOutlet weak var formulasScrollView: UIScrollView!
    @IBOutlet weak var formulasStackView: UIStackView!
    @IBOutlet weak var operatorLabel: UILabel!
    @IBOutlet weak var operandLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initDisplayOperand()
        initDisplayOperator()
        initDisplayFormulas()
    }
}

// MARK: - Actions

extension ViewController {
    @IBAction private func touchUpDigit(_ sender: UIButton) {
        guard let currentOperandButtonTitle = sender.currentTitle else {
            return
        }
        
        calculatorManager.setIsTypingOperandStatus(to: true)
        
        if displayOperand == "0" {
            guard currentOperandButtonTitle != "00" else {
                return
            }
            displayOperand = currentOperandButtonTitle
        } else {
            displayOperand = displayOperand + currentOperandButtonTitle
        }
    }
    
    @IBAction private func touchUpDecimalPoint(_ sender: UIButton) {
        guard let decimalPointButtonTitle = sender.currentTitle else {
            return
        }
        
        calculatorManager.setIsTypingOperandStatus(to: true)
        
        guard !displayOperand.contains(".") else { return }
        
        displayOperand = displayOperand + decimalPointButtonTitle
    }
    
    @IBAction private func touchUpOperator(_ sender: UIButton) {
        guard let currentOperandButtionTitle = sender.currentTitle else {
            return
        }
        
        guard Double(displayOperand) != 0.0 else {
            displayOperator = currentOperandButtionTitle
            return
        }
        
        appendFormulaToformulas(operator: displayOperator, operand: displayOperand)
        
        displayOperator = currentOperandButtionTitle
        initDisplayOperand()
        scrollToBottom(in: formulasScrollView)
    }
    
    @IBAction private func touchUpAllClear(_ sender: UIButton) {
        initAllDisplay()
    }
    
    @IBAction private func touchUpClearError(_ sender: UIButton) {
        initDisplayOperand()
    }
    
    @IBAction private func touchUpSignConversion(_ sender: UIButton) {
        guard Double(displayOperand) != 0.0 else {
            return
        }
        
        let convertedOperand = convertSign(from: displayOperand)
        displayOperand = convertedOperand
    }
    
    @IBAction private func touchUpEqualSign(_ sender: UIButton) {
        guard displayOperator != "" && displayOperand != "" else {
            return
        }
        
        appendFormulaToformulas(operator: displayOperator, operand: displayOperand)
        
        let formulaString: String = assembleFormula()
        var formula: Formula = ExpressionParser.parse(from: formulaString)
        
        do {
            displayOperand = String(try formula.result())
        } catch OperationError.devidedByZero {
            displayOperand = "NaN"
        } catch {
            print(error.localizedDescription)
        }
        
        initDisplayOperator()
    }
}

// MARK: - private Methods

extension ViewController {
    func initDisplayOperator() {
        displayOperator = ""
    }
    
    func initDisplayOperand() {
        displayOperand = "0"
    }
    
    func initDisplayFormulas() {
        formulasStackView.arrangedSubviews.forEach { $0.removeFromSuperview()}
    }
    
    func initAllDisplay() {
        initDisplayOperator()
        initDisplayOperand()
        initDisplayFormulas()
    }
    
    func scrollToBottom(in scrollView: UIScrollView) {
        let bottomOffset = CGPoint(x: 0,y: scrollView.contentSize.height
                                    - scrollView.bounds.size.height)
        print(bottomOffset)
        scrollView.setContentOffset(bottomOffset, animated: true)
    }
    
    func appendFormulaToformulas(`operator`: String, operand: String) {
        let formulaRowStackView: UIStackView = UIStackView()
        let operatorLabel: UILabel = UILabel()
        let operandLabel: UILabel = UILabel()
        
        calculatorManager.setIsTypingOperandStatus(to: false)
        
        operatorLabel.text = `operator`
        operandLabel.text = calculatorManager.format(of: operand)
        operatorLabel.textColor = .white
        operandLabel.textColor = .white
        
        formulaRowStackView.axis = .horizontal
        formulaRowStackView.alignment = .fill
        formulaRowStackView.spacing = 8
        
        formulaRowStackView.addArrangedSubview(operatorLabel)
        formulaRowStackView.addArrangedSubview(operandLabel)
        
        formulasStackView.addArrangedSubview(formulaRowStackView)
    }
    
    func convertSign(from operand: String) -> String {
        guard let sign = operand.first, sign == "-" else {
            return "-" + operand
        }
        let signIndex: String.Index = operand.index(operand.startIndex, offsetBy: 1)
        return String(operand[signIndex...])
    }
    
    func assembleFormula() -> String {
        var result: [String] = []
        
        formulasStackView.arrangedSubviews.forEach {
            let smallStackView = $0 as? UIStackView
            smallStackView?.arrangedSubviews.forEach {
                let label = $0 as? UILabel
                guard let text = label?.text, text != "" else { return }
                result.append(text)
            }
        }
        
        return result.joined(separator: " ")
    }
    
}
