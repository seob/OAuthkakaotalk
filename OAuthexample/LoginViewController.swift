//
//  LoginViewController.swift
//  OAuthexample
//
//  Created by seob on 2018. 7. 26..
//  Copyright © 2018년 seob. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    @IBAction private func loginButtonDidTap(_ sender: Any){
        guard let session = KOSession.shared() else { return }
       
        // Close lod session
        session.isOpen() ? session.close() : ()
        
        session.open(completionHandler: { (error) in
            if !session.isOpen() {
                // 에러코드는 KOErrorCode 참고
                if let error = error as NSError? {
                    switch error.code {
                    case Int(KOErrorCancelled.rawValue):    //에러코드가 열거형으로 들어 있습니다.
                        print("Canceled")
                    default:
                        print(error.localizedDescription)
                    }
                } else {
                    // Session Login 후처리는 KOSessionDidChange Notification을 통해 처리
                    print("Login success")
                }
            }
        })
        // }, authTypes: [NSNumber(value: KOAuthType.account.rawValue)!)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    } 
}
