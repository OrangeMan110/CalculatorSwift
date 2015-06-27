//
//  ViewController.swift
//  CalculatorSwift
//
//  Created by asmi on 15/6/14.
//  Copyright (c) 2015年 Standford University. All rights reserved.
//

import UIKit

class ViewController: UIViewController {


    @IBOutlet weak var display: UILabel!//这是一个指针，对象都存在于heap堆中，所以不需要*也是一个指针,这个变量的类型是UILabel，指向UILabe型对象  使用！对optional对象进行解包
    
    var userIsInTheMiddleOfTypingANumber:Bool = false//对于类中的变量，都必须进行初始化
    
    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!//sender.currentTitle的返回值是optional型，即是可选型，two type：nil/String 需要进行解包
        if (userIsInTheMiddleOfTypingANumber) {
            display.text = display.text! + digit
        }
        else{
            display.text=digit
            userIsInTheMiddleOfTypingANumber=true
        }
    }
    var operandStack = Array<Double>()//创建一个空数组为operandStack赋值  强类型 类型推断 得到operandStack是一个Array<Double>
    @IBAction func enter() {
        userIsInTheMiddleOfTypingANumber=false;
    //    operandStack.append(display.text) display.text是（string？） 不能加入到double的数组中，需要类型转换
        operandStack.append(displayValue)
        println("operandStack = \(operandStack)")
        
    }
    var displayValue : Double{
        get{
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue //numberFromString将string转换为NSNumber类型，
        }
        set{
            display.text = "\(newValue)"
            userIsInTheMiddleOfTypingANumber=false;
        }
    }
    //操作
    @IBAction func operate(sender: UIButton) {
        let operation = sender.currentTitle!
        
        if userIsInTheMiddleOfTypingANumber {
            enter();
        }
        //不好的写法
//        switch operation{
//        case "×":
//            if operandStack.count >= 2{
//                displayValue = operandStack.removeLast() * operandStack.removeLast()
//                enter()
//            }
//        case "÷":
//            if operandStack.count >= 2{
//                displayValue = operandStack.removeLast() / operandStack.removeLast()
//                enter()
//            }
//        case "+":
//            if operandStack.count >= 2{
//                displayValue = operandStack.removeLast() + operandStack.removeLast()
//                enter()
//            }
//        case "−":
//            if operandStack.count >= 2{
//                displayValue = operandStack.removeLast() - operandStack.removeLast()
//                enter()
//            }
//        default:break
//        }
        
        switch operation
        {
        case "x": performOperation {$0 * $1} //最后一个参数可以放在括号外面 ，其他的参数放在括号里面； 只有一个参数时，括号也可以去掉。
            
        case "÷": performOperation {$1 / $0} //注意 x / + -对应的符号
        case "+": performOperation {$0 + $1}
        case "−": performOperation {$1 - $0}
        case "√": performOperation2 {sqrt($0)} //斯坦福教程讲SWIFT可以用同一个变量名，但这里报错？有个object-c selector
        default:break
        }
    }
//    func multiply(op1:Double, op2:Double) -> Double
//    {
//        return op1 * op2
//    }
    
    func performOperation(operation:(Double,Double)->Double)
    {
        if operandStack.count >= 2{
           displayValue = operation(operandStack.removeLast(),operandStack.removeLast())
            enter()
        }
    }
    func performOperation2(operation:Double->Double)
    {
        if operandStack.count >= 1{
            displayValue = operation(operandStack.removeLast())
            enter()
        }
    }
}

