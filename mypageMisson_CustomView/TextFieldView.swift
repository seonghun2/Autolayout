//
//  TextFieldView.swift
//  mypageMisson_CustomView
//
//  Created by user on 2022/12/19.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

@IBDesignable
class TextFieldView: UIView, UITextFieldDelegate {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var countLabel: UILabel!
    
    var disposeBag = DisposeBag()
    
    @IBInspectable
    var title: String = "" {
        didSet {
            DispatchQueue.main.async {
                self.titleLabel.text = self.title
            }
        }
    }
    
    @IBInspectable
    var placeholer: String = "" {
        didSet {
            DispatchQueue.main.async {
                self.textField.placeholder = self.placeholer
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        print(#function)
        
        applyNib()
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.systemGray3.cgColor
        textField.layer.cornerRadius = 5
        textField.clipsToBounds = true
        textField.delegate = self
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        textField.leftViewMode = .always
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }
    
    func applyNib() {
        let nibName = String(describing: Self.self)
        let nib = Bundle.main.loadNibNamed(nibName, owner: self)
        guard let view = nib?.first as? UIView else { return }
        
        addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: self.topAnchor),
            view.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            view.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: self.trailingAnchor)])
    }
}
