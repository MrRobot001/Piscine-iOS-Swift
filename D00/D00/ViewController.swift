//
//  ViewController.swift
//  D00
//
//  Created by Bogdan DEOMIN on 2/3/20.
//  Copyright © 2020 Bogdan DEOMIN. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var NumberScreen:Double = 0
    var FirstNumber:Double = 0
    var Sign:Bool = false;
    var PressEqual:Bool = false;
    var Operation:Int = 0
    
    
    func Print(Tag:Int){
        if Tag >= 0 && Tag <= 9 {
            print(Tag)
        }
        else if (Tag == 10){
            print("AC")
        }else if (Tag == 11) {
            print("NEG")
        }else if (Tag == 12) {
            print("÷")
        }else if (Tag == 13) {
            print("×")
        }else if (Tag == 14) {
            print("-")
        }else if (Tag == 15) {
            print("+")
        }else if (Tag == 16) {
            print("=")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ButtonType.forEach{
            $0.layer.cornerRadius = 10
        }
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var ViewLabel: UILabel!
    
    
    @IBAction func DigitNumbers(_ sender: UIButton) {
        Print(Tag: sender.tag)
        let numb:Int? = Int(ViewLabel.text!)
        if (numb! > 2147483647){
            ViewLabel.text = "2147483647"
        }
        else if (numb! < -2147483648){
            ViewLabel.text = "-2147483648"
        }
        if Sign == true || numb == 0 || ViewLabel.text == "Not a number" {
            ViewLabel.text = "\(sender.tag)"
            Sign = false
        }else if PressEqual == true && Operation == 0{
            PressEqual = false
            ViewLabel.text = "\(sender.tag)"
        } else{
            ViewLabel.text! += "\(sender.tag)"
        }
        NumberScreen = Double(ViewLabel.text!)!
        
    }
    
    func Equal(){
        if Operation == 12{//Division
            if NumberScreen == 0{
                print("Division by zero")
                ViewLabel.text = "Not a number"
            }
            else
            {
                if ((FirstNumber / NumberScreen) - Double(Int(FirstNumber / NumberScreen))) == 0{
                    ViewLabel.text = "\(Int(FirstNumber / NumberScreen))"
                }else{
                    ViewLabel.text = "\(FirstNumber / NumberScreen)"
                }
                FirstNumber /= NumberScreen
            }
        }
        else if Operation == 13{//Multiply
            if ((FirstNumber * NumberScreen) - Double(Int(FirstNumber * NumberScreen))) == 0{
                ViewLabel.text = "\(Int(FirstNumber * NumberScreen))"
            }
            else{
                ViewLabel.text = "\(FirstNumber * NumberScreen)"
            }
            FirstNumber *= NumberScreen
        }
        else if Operation == 14{//Minus
            if ((FirstNumber - NumberScreen) - Double(Int(FirstNumber - NumberScreen))) == 0{
                ViewLabel.text = "\(Int(FirstNumber - NumberScreen))"
            }
            else{
                ViewLabel.text = "\(FirstNumber - NumberScreen)"
            }
            FirstNumber -= NumberScreen
        }
        else if Operation == 15{//Plus
            if ((FirstNumber + NumberScreen) - Double(Int(FirstNumber + NumberScreen))) == 0{
                ViewLabel.text = "\(Int(FirstNumber + NumberScreen))"
            }
            else{
                ViewLabel.text = "\(FirstNumber + NumberScreen)"
            }
            FirstNumber += NumberScreen
        }
    }
    
    @IBAction func Buttons(_ sender: UIButton) {
        Print(Tag: sender.tag)
        if sender.tag != 10 && sender.tag != 11 && sender.tag != 16{
            NumberScreen = Double(ViewLabel.text!)!
            if FirstNumber != 0{
                Equal()
            }
            FirstNumber = Double(ViewLabel.text!)!
            Operation = sender.tag
            Sign = true
        }
        else if sender.tag == 16{ //Equal
            Equal()
            PressEqual = true
            FirstNumber = 0
        }else if sender.tag == 10 { //Clean
            ViewLabel.text = "0"
            FirstNumber = 0
            NumberScreen = 0
            Operation = 0
        }else if sender.tag == 11 { //ChangeSign
            if NumberScreen > 0 {
                ViewLabel.text! = "-" + ViewLabel.text!
            }else if NumberScreen < 0 {
                ViewLabel.text?.remove(at: ViewLabel.text!.startIndex)
            }
            NumberScreen *= -1
        }
    }
    
    
    @IBOutlet var ButtonType: [UIButton]!
}
