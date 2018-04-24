//
//  LBCheckBox.swift
//  LBCheckBox
//
//  Created by Justin Ji on 15/04/2018.
//  Copyright © 2018 Justin Ji. All rights reserved.
//

import UIKit

enum CheckBoxBorderStyle {
    case square
    case circle 
}

struct BoxDimension {
    var width: CGFloat = 0
    var height: CGFloat = 0
}


class LBCheckBox: UIControl {
    
    // determines spacing between check mark box and title label
    public var spacingWidth: CGFloat = 10 {
        didSet {
            titleTrailingContraint?.constant = spacingWidth
            self.layoutIfNeeded()
        }
    }
    
    //Determines width and height of check mark box
    public var checkMarkBoxDimension: BoxDimension = BoxDimension(width: 20, height: 20) {
        didSet {
            checkMarkBoxHeightContraint?.constant = checkMarkBoxDimension.height
            checkMarkBoxWidthContraint?.constant = checkMarkBoxDimension.width
            self.layoutIfNeeded()
        }
    }
    
    // determines width of check mark box's border
    public var checkMarkBoxBorderWidth: CGFloat = 1 {
        didSet {
            self.checkMarkBox.borderWidth = checkMarkBoxBorderWidth
        }
    }
    
    // determines width of check mark box's border colour
    public var checkMarkBoxBorderColour = UIColor.red {
        didSet {
            self.checkMarkBox.borderColour = checkMarkBoxBorderColour
        }
    }
    
    // determines width of check mark box's inner background colour
    public var checkBoxBackgroundColour = UIColor.white {
        didSet {
            checkMarkBox.boxBackgroundColour = checkBoxBackgroundColour
        }
    }
    
    
    // determines type of check mark box
    public var checkBoxBorderStyle: CheckBoxBorderStyle = .square {
        didSet {
            checkMarkBox.checkBoxType = checkBoxBorderStyle
        }
    }
    
    // determines the inner colour of the check mark box when checked.
    public var checkedCircleColour = UIColor.black {
        didSet {
            self.checkMarkBox.checkedCircleColour = checkedCircleColour
        }
    }
    
    public var valueChanged: ((_ isChecked: Bool) -> Void)?
    public var isChecked: Bool = false { didSet { setNeedsDisplay() } }
    public var useHapticFeedback: Bool = true //To allow Haptic Engine to give a selection feedback
    
    private var feedbackGenerator: UISelectionFeedbackGenerator?
    private let titleLB: UILabel = {
        let label = UILabel()
        label.sizeToFit()
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let checkMarkBox = CheckMarkBox()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupDefaults()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupDefaults()
    }
    
    var checkMarkBoxWidthContraint: NSLayoutConstraint?
    var checkMarkBoxHeightContraint: NSLayoutConstraint?
    var titleTrailingContraint: NSLayoutConstraint?
    
    private func setupDefaults() {
        
        addSubview(checkMarkBox)
        addSubview(titleLB)
        
        checkMarkBoxWidthContraint = checkMarkBox.widthAnchor.constraint(equalToConstant: self.checkMarkBoxDimension.width)
        checkMarkBoxHeightContraint = checkMarkBox.heightAnchor.constraint(equalToConstant: self.checkMarkBoxDimension.height)
        checkMarkBoxHeightContraint?.isActive = true
        checkMarkBoxWidthContraint?.isActive = true
        
        titleTrailingContraint = titleLB.leadingAnchor.constraint(equalTo: checkMarkBox.trailingAnchor, constant: spacingWidth)
        titleTrailingContraint?.isActive = true
        NSLayoutConstraint.activate([
         
            checkMarkBox.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            checkMarkBox.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            
            titleLB.topAnchor.constraint(equalTo: self.topAnchor),
            titleLB.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            titleLB.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            
            ])
        
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTapGesture(_:))))
        if useHapticFeedback {
            feedbackGenerator = UISelectionFeedbackGenerator()
            feedbackGenerator?.prepare()
        }
    }
    
    @objc private func handleTapGesture(_ recogniser: UITapGestureRecognizer) {
        isChecked = !isChecked
        valueChanged?(isChecked)
        sendActions(for: .valueChanged)
        
        if useHapticFeedback {
            // Trigger impact feedback.
            feedbackGenerator?.selectionChanged()
        }
        
        if isChecked && checkBoxBorderStyle == .square {
            checkMarkBox.selectSquareBox()
            makeViewBounce(titleLB)
        } else if !isChecked && checkBoxBorderStyle == .square {
            checkMarkBox.deselectSquareBox()
        } else if isChecked && checkBoxBorderStyle == .circle {
            checkMarkBox.selectCircleBox()
            makeViewBounce(titleLB)
        } else if !isChecked && checkBoxBorderStyle == .circle {
            checkMarkBox.deselectCircleBox()
        }
 
        setNeedsDisplay()
    }
    
    private func makeViewBounce(_ view: UIView) {
        UIView.animate(withDuration: 0.5) {
            view.transform = CGAffineTransform(scaleX: 1.8, y: 1.8)
            view.transform = .identity
        }
    }
    
}


extension LBCheckBox {
    
    public var title: NSAttributedString? {
        get {
            return self.title
        }
        set {
            self.titleLB.attributedText = newValue
        }
    }
    
}









































































































