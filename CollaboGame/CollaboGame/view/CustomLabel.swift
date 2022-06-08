//
//  CustomLabel.swift
//  CollaboGame
//
//  Created by 송결 on 2022/05/15.
//

import Foundation
import UIKit

class CustomLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    init(title: String, size: CGFloat = 40) {
        super.init(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        font = UIFont.Pretandard(type: .Bold, size: size)
        backgroundColor = .clear
        clipsToBounds = true
        layer.cornerRadius = 10
        text = title
        textAlignment = .center
        textColor = CustomColor.mainTintColor
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
