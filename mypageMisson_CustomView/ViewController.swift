//
//  ViewController.swift
//  mypageMisson_CustomView
//
//  Created by user on 2022/12/19.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {

    @IBOutlet weak var nicknameView: TextFieldView!
    
    @IBOutlet weak var profileView: TextFieldView!
    
    @IBOutlet weak var introduceView: IntroduceView!
    
    @IBOutlet weak var profileImage: UIImageView!
    
    let imagePicker = UIImagePickerController()
    
    let disposeBag  = DisposeBag()
    
    let textViewPlaceHolder = "다른 사람에게 나를 소개할 수 있도록\n자신의 활동을 자세하게 적어주세요."
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(#function)
        // Do any additional setup after loading the view.
        profileImage.backgroundColor = .white
        profileImage.layer.cornerRadius = 35
        profileImage.contentMode = .scaleAspectFit
        //nicknameView.countLabel.text = "0 / 20"
        profileView.titleLabel.text = "한 줄 프로필"
        //profileView.countLabel.text = "0 / 30"
        profileView.textField.placeholder = "자신을 표현할 한 줄 소개 입니다."
        
        nicknameView.textField.delegate = self
        profileView.textField.delegate = self
        introduceView.textView.delegate = self
        
        setTextFieldCount(textField: nicknameView.textField, maxCount: 20, label: nicknameView.countLabel)
        setTextFieldCount(textField: profileView.textField, maxCount: 30, label: profileView.countLabel)
        
        introduceView.textView.text = textViewPlaceHolder
        introduceView.textView.textColor = .systemGray3
        introduceView.textView.textContainerInset = .init(top: 20, left: 15, bottom: 10, right: 15)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let vc = PopupVC()
        vc.modalPresentationStyle = .overCurrentContext
        if UserDefaults.standard.bool(forKey: "showPopup") {
            present(vc, animated: false)
        }
    }
    
    //텍스트 필드의 글자수를 레이블에 표시해주는 함수
    func setTextFieldCount(textField: UITextField, maxCount: Int, label: UILabel) {
        let nicknameCount = textField.rx.text.orEmpty
            .subscribe(on: MainScheduler.instance)
            .map { "\($0.count) / \(maxCount)" }
        
        nicknameCount
            .bind(to: label.rx.text)
            .disposed(by: disposeBag)
    }
    
    @IBAction func profileTapped(_ sender: Any) {
        print("프로필 이미지 탭")
        let bottomSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let cameraAction = UIAlertAction(title: "카메라", style: .default) { _ in
            print("카메라 액션")
            self.imagePicker.sourceType = .camera
            self.present(self.imagePicker, animated: true)
            
        }
        let albumAction = UIAlertAction(title: "앨범", style: .default) { _ in
            print("앨범 액션")
            self.imagePicker.sourceType = .photoLibrary
            self.present(self.imagePicker, animated: true)
        }
        let cancelAction = UIAlertAction(title: "취소", style: .cancel)
        
        bottomSheet.addAction(cameraAction)
        bottomSheet.addAction(albumAction)
        bottomSheet.addAction(cancelAction)
    
        present(bottomSheet, animated: true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
}
extension ViewController: UITextFieldDelegate, UITextViewDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderColor = UIColor.blue.cgColor
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.layer.borderColor = UIColor.systemGray3.cgColor
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == nicknameView.textField {
            let updateString = (textField.text! as NSString).replacingCharacters(in: range, with: string)
            return updateString.count <= 20
        } else {
            let updateString = (textField.text! as NSString).replacingCharacters(in: range, with: string)
            return updateString.count <= 30
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.layer.borderColor = UIColor.blue.cgColor
        textView.text = ""
        textView.textColor = .black
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        textView.layer.borderColor = UIColor.systemGray3.cgColor
        textView.text = textViewPlaceHolder
        textView.textColor = .systemGray3
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let updateString = (textView.text! as NSString).replacingCharacters(in: range, with: text)
        return updateString.count <= 1000
    }
}

extension ViewController: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            profileImage.image = image
        }
        dismiss(animated: true)
    }
}
