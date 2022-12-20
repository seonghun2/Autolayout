//
//  IntroduceView.swift
//  mypageMisson_CustomView
//
//  Created by user on 2022/12/19.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class IntroduceView: UIView {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var countLable: UILabel!
    
    let disposeBag = DisposeBag()
    override func awakeFromNib() {
        super.awakeFromNib()
        applyNib()
        
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor.systemGray3.cgColor
        textView.layer.cornerRadius = 5
        textView.clipsToBounds = true
        //textView.delegate = self
        
        textView.rx.text.orEmpty
            .subscribe(on: MainScheduler.instance)
            .map { "\($0.count) / 1000" }
            .bind(to: countLable.rx.text)
            .disposed(by: disposeBag)
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

//delegate는 하나만 지정할수있나?
extension IntroduceView: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        print(textView.text)
        return true
    }
    func textViewDidChange(_ textView: UITextView) {
        print(#function)
    }
}

