//
//  RootController.swift
//  pomelo
//
//  Created by zhouqi on 16/1/20.
//  Copyright © 2016年 zhouqi. All rights reserved.
//

import UIKit

class RootController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func toRegister() {
        if self.topViewController != nil && !(self.topViewController is RegisterController) {
            let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
            let registerController = storyboard.instantiateViewControllerWithIdentifier("RegisterController") as! RegisterController
            self.pushViewController(registerController, animated: true)
        }
    }
    
    func registerSuccessed() {
        if self.topViewController != nil && self.topViewController is RegisterController {
            self.popViewControllerAnimated(true)
        }
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
