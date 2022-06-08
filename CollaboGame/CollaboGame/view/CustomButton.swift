//
//  CustomButton.swift
//  CollaboGame
//
//  Created by 송결 on 2022/05/15.
//

import Foundation
import UIKit

class CustomButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setImage(UIImage(named: "시작하기"), for: .normal)
    }
    init(title: String, size: CGFloat = 20) {
        super.init(frame: .zero)
//        setTitle(title, for: .normal)
//        backgroundColor = CustomColor.mainTintColor
//        setTitleColor(CustomColor.btnTextColor, for: .normal)
//        titleLabel?.font = UIFont.Pretandard(type: .Regular, size: size)
//        layer.cornerRadius = 20
//        clipsToBounds = true
//        layer.borderWidth = 2
//        layer.borderColor = myColor.deepPurple.cgColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class CustomPassButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setImage(UIImage(named: "정답확인"), for: .normal)
    }
    init(title: String, size: CGFloat = 20) {
        super.init(frame: .zero)
//        setTitle(title, for: .normal)
//        backgroundColor = CustomColor.passBtnColor
//        setTitleColor(CustomColor.btnTextColor, for: .normal)
//        titleLabel?.font = UIFont.Pretandard(type: .Regular, size: size)
//        layer.cornerRadius = 20
//        layer.borderWidth = 2
//        layer.borderColor = myColor.green.cgColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

