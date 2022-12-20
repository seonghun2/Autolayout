//
//  WebsiteView.swift
//  mypageMisson_CustomView
//
//  Created by user on 2022/12/19.
//

import UIKit
import SnapKit

class WebsiteView: UIView {
    
    var websiteCount = 0
    
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var websiteAddButton: UIButton!
    
    @IBOutlet weak var warningLabel: UILabel!
    
    let webSiteStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.alignment = .fill
        sv.distribution = .equalSpacing
        sv.spacing = 15
        return sv
    }()
    
    override func awakeFromNib() {
        applyNib()
        
        warningLabel.isHidden = true
        
        addSubview(webSiteStackView)
        webSiteStackView.snp.makeConstraints { make in
            make.top.equalTo(textField.snp.bottom).offset(10)
            make.left.right.equalToSuperview()
        }
        
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.systemGray3.cgColor
        textField.layer.cornerRadius = 5
        
        textField.placeholder = "SNS 또는 홈페이지를 연결해주세요"
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        textField.leftViewMode = .always
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    @IBAction func addBtnTapped(_ sender: UIButton) {
        print(#function)
        if websiteCount > 1 {
            warningLabel.isHidden = false
        } else {
            websiteCount += 1
            let websiteRow = WebsiteRow()
            
            webSiteStackView.addArrangedSubview(websiteRow)
            websiteRow.textField.becomeFirstResponder()
            
            websiteRow.removeClosure = {
                self.websiteCount -= 1
                self.warningLabel.isHidden = true
            }
            
            // 스택뷰 바텀에 제약조건, websiteRow 바텀에 제약조건?
            websiteAddButton.snp.updateConstraints { make in
                make.top.equalTo(webSiteStackView.snp.bottom).offset(10)
            }
            
            warningLabel.snp.updateConstraints { make in
                make.top.equalTo(websiteAddButton.snp.bottom).offset(10)
            }
        }
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
