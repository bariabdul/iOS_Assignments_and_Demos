//
//  PickerViewTextField.swift
//  MCU
//
//  Created by Kurt McMahon on 10/16/16.
//  Copyright © 2016 Northern Illinois University. All rights reserved.
//

import UIKit

class PickerViewTextField: UITextField {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

    override func caretRectForPosition(position: UITextPosition) -> CGRect {
        return CGRectZero
    }
}
