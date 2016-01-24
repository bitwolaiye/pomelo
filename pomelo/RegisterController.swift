//
//  RegisterController.swift
//  pomelo
//
//  Created by zhouqi on 16/1/20.
//  Copyright © 2016年 zhouqi. All rights reserved.
//

import UIKit
import SnapKit
import Toast

class RegisterController: UIViewController {
    
    @IBOutlet weak var userNameTextField:UITextField!
    @IBOutlet weak var passwordTextField:UITextField!

    @IBAction func register(sender: AnyObject) {
        UserApi.sharedInstance.register(self.userNameTextField.text!, password: self.passwordTextField.text!, callback: { () -> Void in
            let rootController = UIApplication.sharedApplication().delegate!.window!?.rootViewController as! RootController
            rootController.registerSuccessed()
            }) { () -> Void in
                self.view.makeToast("Login Failed", duration: 0.5, position: CSToastPositionTop, style: nil)
        }
    }
    
    @IBAction func login(sender: AnyObject) {
        UserApi.sharedInstance.login(self.userNameTextField.text!, password: self.passwordTextField.text!, callback: { () -> Void in
                let rootController = UIApplication.sharedApplication().delegate!.window!?.rootViewController as! RootController
                rootController.registerSuccessed()
            }) { () -> Void in
                self.view.makeToast("Register Failed", duration: 0.5, position: CSToastPositionTop, style: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let container:UIStackView = {
            let stackView = UIStackView()
            self.view.addSubview(stackView)
            
            stackView.axis = UILayoutConstraintAxis.Vertical
            stackView.alignment = UIStackViewAlignment.Center
            stackView.distribution = UIStackViewDistribution.FillEqually
            
            stackView.snp_makeConstraints(closure: { (make) -> Void in
                make.width.equalTo(self.view.snp_width)
                make.height.equalTo(200)
                make.top.equalTo(self.topLayoutGuide).offset(40)
                make.left.equalTo(0)
            })
            
            return stackView
        } ()
        
        let rowUserName:UIStackView = {
            let stackView = UIStackView()
            container.addArrangedSubview(stackView)
            
            stackView.axis = UILayoutConstraintAxis.Horizontal
            stackView.alignment = UIStackViewAlignment.Center
            stackView.distribution = UIStackViewDistribution.Fill
            
            let spacerFront = UIView()
            spacerFront.snp_makeConstraints(closure: { (make) -> Void in
                make.height.equalTo(30)
            })
            stackView.addArrangedSubview(spacerFront)
            
            let label = UILabel()
            
            stackView.addArrangedSubview(label)
            label.text = "用户名"
            label.font = UIFont(name: label.font.fontName, size: 14)
            label.backgroundColor = UIColor.grayColor()
            label.snp_makeConstraints(closure: { (make) -> Void in
                make.height.equalTo(30)
                make.width.equalTo(50)
            })
            
            self.userNameTextField = {
                let textField = UITextField()
                stackView.addArrangedSubview(textField)
                
                textField.autocorrectionType = UITextAutocorrectionType.No
                textField.autocapitalizationType = UITextAutocapitalizationType.None
                textField.borderStyle = UITextBorderStyle.None
                textField.clearButtonMode = UITextFieldViewMode.WhileEditing
                textField.clearsOnBeginEditing = true
                textField.font = UIFont(name: textField.font!.fontName, size: 14)
                textField.backgroundColor = UIColor.grayColor()
                
                textField.snp_makeConstraints(closure: { (make) -> Void in
                    make.width.equalTo(240)
                    make.height.equalTo(30)
                })
                
                return textField
                } ()
            
            let spacerBack = UIView()
            stackView.addArrangedSubview(spacerBack)
            spacerBack.snp_makeConstraints(closure: { (make) -> Void in
                make.height.equalTo(30).priorityLow()
                make.width.equalTo(spacerFront.snp_width)
            })

            
            stackView.snp_makeConstraints(closure: { (make) -> Void in
                make.width.equalTo(container.snp_width)
                make.left.equalTo(0)
            })
            
            return stackView
        } ()
        
        let rowPassword:UIStackView = {
            let stackView = UIStackView()
            container.addArrangedSubview(stackView)
            
            stackView.axis = UILayoutConstraintAxis.Horizontal
            stackView.alignment = UIStackViewAlignment.Center
            stackView.distribution = UIStackViewDistribution.Fill
            
            let spacerFront = UIView()
            spacerFront.snp_makeConstraints(closure: { (make) -> Void in
                make.height.equalTo(30)
            })
            stackView.addArrangedSubview(spacerFront)
            
            let label = UILabel()
            
            stackView.addArrangedSubview(label)
            label.text = "密码"
            label.font = UIFont(name: label.font.fontName, size: 14)
            label.backgroundColor = UIColor.grayColor()
            label.snp_makeConstraints(closure: { (make) -> Void in
                make.height.equalTo(30)
                make.width.equalTo(50)
            })
            
            self.passwordTextField = {
                let textField = UITextField()
                stackView.addArrangedSubview(textField)
                
                textField.autocorrectionType = UITextAutocorrectionType.No
                textField.autocapitalizationType = UITextAutocapitalizationType.None
                textField.borderStyle = UITextBorderStyle.None
                textField.clearButtonMode = UITextFieldViewMode.WhileEditing
                textField.clearsOnBeginEditing = true
                textField.font = UIFont(name: textField.font!.fontName, size: 14)
                textField.backgroundColor = UIColor.grayColor()
                
                textField.snp_makeConstraints(closure: { (make) -> Void in
                    make.width.equalTo(240)
                    make.height.equalTo(30)
                })
                
                return textField
                } ()
            
            let spacerBack = UIView()
            stackView.addArrangedSubview(spacerBack)
            spacerBack.snp_makeConstraints(closure: { (make) -> Void in
                make.height.equalTo(30).priorityLow()
                make.width.equalTo(spacerFront.snp_width)
            })

            
            stackView.snp_makeConstraints(closure: { (make) -> Void in
                make.width.equalTo(container.snp_width)
                make.left.equalTo(0)
            })
            
            return stackView
        } ()
        
        let rowButton:UIStackView = {
            let stackView = UIStackView()
            container.addArrangedSubview(stackView)
            
            stackView.axis = UILayoutConstraintAxis.Horizontal
            stackView.alignment = UIStackViewAlignment.Center
            stackView.distribution = UIStackViewDistribution.EqualSpacing
            
            let spacerFront = UIView()
            spacerFront.snp_makeConstraints(closure: { (make) -> Void in
                make.height.equalTo(30)
            })
            stackView.addArrangedSubview(spacerFront)
            
            let registerBtn:UIButton = {
                let button = UIButton(type: UIButtonType.System)
                stackView.addArrangedSubview(button)
                button.setTitle("注册", forState: UIControlState.Normal)
                button.snp_makeConstraints(closure: { (make) -> Void in
                    make.width.equalTo(100)
                    make.height.equalTo(40)
                })
                
                button.addTarget(self, action: "register:", forControlEvents: UIControlEvents.TouchUpInside)
                
                return button
            } ()
            
            let loginBtn:UIButton = {
                let button = UIButton(type: UIButtonType.System)
                stackView.addArrangedSubview(button)
                button.setTitle("登录", forState: UIControlState.Normal)
                button.snp_makeConstraints(closure: { (make) -> Void in
                    make.width.equalTo(100)
                    make.height.equalTo(40)
                })
                
                button.addTarget(self, action: "login:", forControlEvents: UIControlEvents.TouchUpInside)
                
                return button
            } ()
            
            let spacerBack = UIView()
            stackView.addArrangedSubview(spacerBack)
            spacerBack.snp_makeConstraints(closure: { (make) -> Void in
                make.height.equalTo(30).priorityLow()
                make.width.equalTo(spacerFront.snp_width)
            })
            
            return stackView
        } ()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
