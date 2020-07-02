//
//  LoginViewController.swift
//  iOSAnimationSample
//
//  Created by Jake Lin on 5/17/15.
//  Copyright (c) 2015 JakeLin. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var bubble1: UIImageView!
    @IBOutlet weak var bubble2: UIImageView!
    @IBOutlet weak var bubble3: UIImageView!
    @IBOutlet weak var bubble4: UIImageView!
    @IBOutlet weak var bubble5: UIImageView!
    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var dot: UIImageView!
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var login: UIButton!
    
    // Customer UI
    let spinner = UIActivityIndicatorView(style: .whiteLarge)
    let warningMessage = UIImageView(image: UIImage(named: "Warning"))
    var loginPosition = CGPoint.zero
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bubble1.transform = CGAffineTransform(scaleX: 0, y: 0)
        self.bubble2.transform = CGAffineTransform(scaleX: 0, y: 0)
        self.bubble3.transform = CGAffineTransform(scaleX: 0, y: 0)
        self.bubble4.transform = CGAffineTransform(scaleX: 0, y: 0)
        self.bubble5.transform = CGAffineTransform(scaleX: 0, y: 0)
        
        self.logo.center.x -= self.view.bounds.width
        self.dot.center.x -= self.view.bounds.width/2
        
        let paddingViewForUsername = UIView(frame: CGRect(x: 0, y: 0, width: 44, height: self.username.frame.height))
        self.username.leftView = paddingViewForUsername
        self.username.leftViewMode = .always
        
        let paddingViewForPassword = UIView(frame: CGRect(x: 0, y: 0, width: 44, height: self.password.frame.height))
        self.password.leftView = paddingViewForPassword
        self.password.leftViewMode = .always

        let userImageView = UIImageView(image: UIImage(named: "User"))
        userImageView.frame.origin = CGPoint(x: 13, y: 10)
        self.username.addSubview(userImageView)
        
        let passwordImageView = UIImageView(image: UIImage(named: "Key"))
        passwordImageView.frame.origin = CGPoint(x: 12, y: 9)
        self.password.addSubview(passwordImageView)
        
        self.username.center.x -= self.view.bounds.width
        self.password.center.x -= self.view.bounds.width
        
        self.loginPosition = self.login.center
        self.login.center.x -= self.view.bounds.width
        
        self.view.addSubview(self.warningMessage)
        self.warningMessage.isHidden = true
        self.warningMessage.center = self.loginPosition
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        UIView.animate(withDuration: 0.3, delay: 0.3, usingSpringWithDamping: 0.4, initialSpringVelocity: 0, options: [], animations: {
            self.bubble1.transform = CGAffineTransform(scaleX: 1, y: 1)
            self.bubble4.transform = CGAffineTransform(scaleX: 1, y: 1)
            self.bubble5.transform = CGAffineTransform(scaleX: 1, y: 1)
        }, completion: nil)
        
        UIView.animate(withDuration: 0.3, delay: 0.4, usingSpringWithDamping: 0.4, initialSpringVelocity: 0, options: [], animations: {
            self.bubble2.transform = CGAffineTransform(scaleX: 1, y: 1)
            self.bubble3.transform = CGAffineTransform(scaleX: 1, y: 1)
            }, completion: nil)
        
        UIView.animate(withDuration: 0.5, delay: 0.5, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.5, options: [], animations: {
            self.logo.center.x += self.view.bounds.width
            }, completion: nil)
        
//        UIView.animateWithDuration(0.5, delay: 0.5, options: .CurveEaseOut, animations: {
//            self.logo.center.x += self.view.bounds.width
//        }, completion: nil)
//        
        UIView.animate(withDuration: 5, delay: 1, usingSpringWithDamping: 0.1, initialSpringVelocity: 1, options: [], animations: {
            self.dot.center.x += self.view.bounds.width/2
            }, completion: nil)
        
        UIView.animate(withDuration: 0.4, delay: 0.6, options: .curveEaseOut, animations: {
            self.username.center.x += self.view.bounds.width
            }, completion: nil)
        
        UIView.animate(withDuration: 0.4, delay: 0.7, options: .curveEaseOut, animations: {
            self.password.center.x += self.view.bounds.width
            }, completion: nil)
        
        UIView.animate(withDuration: 0.4, delay: 0.8, options: .curveEaseOut, animations: {
            self.login.center.x += self.view.bounds.width
            }, completion: nil)

    }

    @IBAction func loginTapped(sender: AnyObject) {
        self.login.addSubview(self.spinner)
        self.spinner.frame.origin = CGPoint(x: 12, y: 12)
        self.spinner.startAnimating()
        
        UIView.transition(with: self.warningMessage,
            duration: 0.3,
            options: .transitionFlipFromTop,
            animations: {
                self.warningMessage.isHidden = true
            }, completion: nil)
        
        UIView.animate(withDuration: 0.3, animations: {
            self.login.center = self.loginPosition
            }, completion: { _ in
                self.login.center.x -= 30
                UIView.animate(withDuration: 1.5, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 0, options: [], animations: {
                    self.login.center.x += 30
                    }, completion: {finished in
                        UIView.animate(withDuration: 0.3, animations: {
                            self.login.center.y += 90
                            self.spinner.removeFromSuperview()
                            }, completion: { _ in
                                UIView.transition(with: self.warningMessage,
                                    duration: 0.3,
                                    options: [.transitionFlipFromTop, .curveEaseOut],
                                    animations: {
                                        self.warningMessage.isHidden = false
                                    }, completion: nil)
                        })
                })
            })
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
