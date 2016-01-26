//
//  Piece2ViewController.swift
//  pomelo
//
//  Created by zhouqi on 16/1/25.
//  Copyright © 2016年 zhouqi. All rights reserved.
//

import UIKit
import YYText
import SnapKit

class Piece2ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, YYTextKeyboardObserver {
    @IBOutlet weak var tableView:UITableView!
    @IBOutlet weak var addCommentView:AddCommentView!
    var addCommentViewBottomConstraint: Constraint? = nil
    
    var piecePrototypeCell:PieceDetailCell!
    var commentPrototypeCell:CommentCell!
    var piece:Piece!
    var comments:[Comment]!
    
    func reloadDataFromApi() {
        let selfController:Piece2ViewController = self
        CommentApi.sharedInstance.getCommentList(self.piece.pieceId, callback: { (comments: [Comment]) -> Void in
            selfController.comments = comments
            selfController.tableView.reloadData()
        })
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController!.navigationBar.translucent = false;
        
        if (self.comments == nil) {
            self.reloadDataFromApi()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        self.tableView.registerClass(PieceDetailCell.classForCoder(), forCellReuseIdentifier: "PieceDetailCell")
        //        self.tableView.registerNib(UINib(nibName: "PieceDetailCell", bundle: nil), forCellReuseIdentifier: "PieceDetailCell")
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        self.tableView = {
            let tableView = UITableView()
            
            self.view.addSubview(tableView)
            
            tableView.delegate = self
            tableView.dataSource = self
            
            tableView.rowHeight = UITableViewAutomaticDimension
            tableView.estimatedRowHeight = 44
            tableView.separatorStyle = UITableViewCellSeparatorStyle.None
            tableView.allowsSelection = false
            
            tableView.snp_makeConstraints(closure: { (make) -> Void in
                make.top.equalTo(self.topLayoutGuide)
                make.left.equalTo(0)
                make.right.equalTo(self.view)
                make.bottom.equalTo(self.view).offset(-40)
            })
            
            tableView.registerClass(PieceDetailCell.self, forCellReuseIdentifier: "PieceDetailCell")
            tableView.registerClass(CommentCell.self, forCellReuseIdentifier: "CommentCell")
            
            return tableView
            } ()
        
        self.addCommentView = {
            let addCommentView = AddCommentView()
            
            self.view.addSubview(addCommentView)
            addCommentView.initSubviews()
            addCommentView.piece = self.piece
            addCommentView.callback = { (comment) -> Void in
                self.comments.insert(comment, atIndex: 0)
                self.tableView.reloadData()
            }
            addCommentView.snp_makeConstraints(closure: { (make) -> Void in
                self.addCommentViewBottomConstraint = make.bottom.equalTo(self.view.snp_bottom).constraint
                make.height.equalTo(40)
                make.left.equalTo(0)
                make.right.equalTo(self.view)
            })
            
            return addCommentView
            } ()

        
        piecePrototypeCell = tableView.dequeueReusableCellWithIdentifier("PieceDetailCell") as! PieceDetailCell
        commentPrototypeCell = tableView.dequeueReusableCellWithIdentifier("CommentCell") as! CommentCell
        
        YYTextKeyboardManager.defaultManager().addObserver(self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if self.comments != nil {
            return self.comments.count + 1
        } else {
            return 1
        }
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if (indexPath.row == 0) {
            let cell = tableView.dequeueReusableCellWithIdentifier("PieceDetailCell", forIndexPath: indexPath) as! PieceDetailCell
            cell.piece = self.piece
            return cell
            
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier("CommentCell", forIndexPath: indexPath) as! CommentCell
            cell.comment = self.comments[indexPath.row - 1]
            // Configure the cell...
            
            return cell
        }
    }
    
    //    override func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    //        if indexPath.row == 0 {
    //            return 100
    //        } else {
    //            return 40
    //        }
    //    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row == 0 {
            let cell = self.piecePrototypeCell
            cell.piece = self.piece
            cell.layoutSubviews()
            let size = cell.contentView.systemLayoutSizeFittingSize(UILayoutFittingCompressedSize)
            return 1  + size.height;
        } else {
            let cell = self.commentPrototypeCell
            cell.comment = self.comments[indexPath.row - 1]
            cell.layoutSubviews()
            let size = cell.contentView.systemLayoutSizeFittingSize(UILayoutFittingCompressedSize)
            return 1  + size.height;
            
            //            return 40
        }
    }
    
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        self.addCommentView.endEditing(true)
    }
    
    func keyboardChangedWithTransition(transition: YYTextKeyboardTransition) {
        UIView.animateWithDuration(transition.animationDuration) { () -> Void in
            let kbFrame = YYTextKeyboardManager.defaultManager().convertRect(transition.toFrame, toView: self.view)
            self.addCommentViewBottomConstraint?.updateOffset(kbFrame.origin.y - self.view.frame.size.height)
            self.view.layoutIfNeeded()
        }
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return false if you do not want the specified item to be editable.
    return true
    }
    */
    
    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    if editingStyle == .Delete {
    // Delete the row from the data source
    tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
    } else if editingStyle == .Insert {
    // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
    }
    */
    
    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
    
    }
    */
    
    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return false if you do not want the item to be re-orderable.
    return true
    }
    */
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
}
