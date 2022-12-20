//
//  WebsiteRow.swift
//  mypageMisson_CustomView
//
//  Created by user on 2022/12/20.
//

import UIKit

class WebsiteRow: UIView {

    var removeClosure: (() -> ())?
    
    let textField: UITextField = {
        let tf = UITextField()
        tf.layer.cornerRadius = 5
        tf.layer.borderWidth = 1
        tf.layer.borderColor = UIColor.systemGray3.cgColor
        //tf.font = UIFont(name: "", size: 14)
        tf.placeholder = "SNS 또는 홈페이지를 연결해주세요"
        tf.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        tf.leftViewMode = .always
        return tf
    }()
    
    let removeButton: UIButton = {
        let btn = UIButton()
        btn.layer.borderWidth = 1
        btn.layer.borderColor = UIColor.systemGray3.cgColor
        btn.layer.cornerRadius = 5
        btn.setImage(UIImage(systemName: "trash"), for: .normal)
        btn.addTarget(self, action: #selector(removeButtonTapped), for: .touchUpInside)
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(textField)
        addSubview(removeButton)
        
        textField.snp.makeConstraints { make in
            make.top.left.bottom.equalToSuperview()
            make.height.equalTo(45)
            make.width.equalTo(300)
        }
        
        removeButton.snp.makeConstraints { make in
            make.left.equalTo(textField.snp.right).offset(10)
            make.height.width.equalTo(45)
            make.right.equalToSuperview()
        }
    }
    
    @objc func removeButtonTapped() {
        self.removeFromSuperview()
        removeClosure?()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

