//
//  ViewController.swift
//  BasicCalculator2
//
//  Created by Fani Hamdani on 08/02/18.
//  Copyright © 2018 Fani Hamdani. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var collectionView: UICollectionView!

    let buttons: [[String]] = [
        ["7", "8", "9", "+"],
        ["4", "5", "6", "-"],
        ["1", "2", "3", "*"],
        ["AC", "0", "=", "/"]
    ]
    
    var num1: String = "0", num2: String = ""
    var op: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return buttons.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return buttons[0].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCell", for: indexPath) as! CollectionViewCell
        
        cell.button.setTitle(buttons[indexPath.section][indexPath.row], for: .normal)
        cell.button.addTarget(self, action: #selector(buttonPressed(x:)), for: .touchUpInside)
        
        return cell
    }
    
    func buttonPressed(x: UIButton) -> Void {
        switch x.currentTitle! {
        case "+", "-", "*", "/", "=", "AC":
            operatorButtonPressed(x)
        default:
            numberButtonPressed(x)
        }
    }

    func numberButtonPressed(_ x: UIButton) -> Void {
        num2 = num2.appending(x.currentTitle!)
        textField?.text = num2
    }
    
    func operatorButtonPressed(_ x: UIButton) -> Void {
        if num2 != "" {
            switch op {
            case "+":
                num1 = String(Double(num1)?.adding(Double(num2) ?? 0) ?? 0)
            case "-":
                num1 = String(Double(num1)?.subtracting(Double(num2) ?? 0) ?? 0)
            case "*":
                num1 = String(Double(num1)?.multiplied(by: Double(num2) ?? 0) ?? 0)
            case "/":
                num1 = String(Double(num1)?.divided(by: Double(num2) ?? 0) ?? 0)
            case "=":
                break
            default:
                num1 = num2
            }
        }
        if num1 != num2 && op != "" {
            textField?.text = num1
        }
        op = x.currentTitle!
        num2 = ""
        if op == "AC" {
            num1 = "0"
            textField?.text = num1
        }
    }

}

