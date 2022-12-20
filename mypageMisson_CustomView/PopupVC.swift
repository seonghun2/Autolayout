//
//  PopupVC.swift
//  mypageMisson_CustomView
//
//  Created by user on 2022/12/20.
//

import UIKit

class PopupVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        UserDefaults.standard.set(true, forKey: "showPopup")
        // Do any additional setup after loading the view.
    }

    @IBAction func detailBtnTapped(_ sender: Any) {
        
    }
    
    @IBAction func neverShowBtnTapped(_ sender: Any) {
        UserDefaults.standard.set(false, forKey: "showPopup")
        dismiss(animated: false)
    }
    
    @IBAction func closeBtnTapped(_ sender: Any) {
        dismiss(animated: false)
    }
}
