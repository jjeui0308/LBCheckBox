//
//  ViewController.swift
//  LBCheckBox
//
//  Created by Justin Ji on 15/04/2018.
//  Copyright © 2018 Justin Ji. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let squareCB: LBCheckBox = {
        let checkBox = LBCheckBox()
        checkBox.spacingWidth = 10
        checkBox.checkMarkBoxBorderWidth = 1
        checkBox.checkMarkBoxDimension = BoxDimension(width: 20, height: 20)
        checkBox.checkMarkBoxBorderColour = .red
        checkBox.checkBoxBackgroundColour = .yellow
        checkBox.checkBoxBorderStyle = .square
        checkBox.title = NSAttributedString(string: "개인정보 수집에 동의합니다.", attributes: [NSAttributedStringKey.foregroundColor: UIColor.darkGray, .font: UIFont.systemFont(ofSize: 17, weight: .light)])
        checkBox.translatesAutoresizingMaskIntoConstraints = false
        return checkBox
    }()
    
    let circleCB: LBCheckBox = {
        let checkBox = LBCheckBox()
        checkBox.spacingWidth = 10
        checkBox.addTarget(self, action: #selector(handleCircleCB(_:)), for: .valueChanged)
        checkBox.checkMarkBoxBorderWidth = 1
        checkBox.checkMarkBoxDimension = BoxDimension(width: 20, height: 20)
        checkBox.checkMarkBoxBorderColour = .black
        checkBox.checkBoxBackgroundColour = .white
        checkBox.checkBoxBorderStyle = .circle
        checkBox.checkedCircleColour = .darkGray
        checkBox.title = NSAttributedString(string: "약관에 동의합니다.", attributes: [NSAttributedStringKey.foregroundColor: UIColor.darkGray, .font: UIFont.systemFont(ofSize: 17, weight: .light)])
        checkBox.translatesAutoresizingMaskIntoConstraints = false
        return checkBox
    }()
    
    @objc func handleCircleCB(_ sender: LBCheckBox) {
        print("isChecked:", sender.isChecked)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        view.addSubview(squareCB)
        view.addSubview(circleCB)
        
        NSLayoutConstraint.activate([
            
            squareCB.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            squareCB.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            squareCB.heightAnchor.constraint(equalToConstant: 30),
            squareCB.widthAnchor.constraint(equalToConstant: 250),
            
            circleCB.topAnchor.constraint(equalTo: squareCB.bottomAnchor, constant: 12),
            circleCB.centerXAnchor.constraint(equalTo: squareCB.centerXAnchor),
            circleCB.heightAnchor.constraint(equalToConstant: 30),
            circleCB.widthAnchor.constraint(equalToConstant: 250),
            
            
            ])
    }

    

}



































































