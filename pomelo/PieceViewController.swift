//
//  PieceViewController.swift
//  pomelo
//
//  Created by zhouqi on 16/1/10.
//  Copyright © 2016年 zhouqi. All rights reserved.
//

import UIKit

class Piece1ViewController: UITableViewController {
    var piecePrototypeCell:PieceDetailCell!
    var commentPrototypeCell:CommentCell!
    var piece:Piece!
    var comments:[Comment]!

    func reloadDataFromApi() {
        let selfController: Piece1ViewController = self
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
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 44
        tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        tableView.allowsSelection = false
        piecePrototypeCell = tableView.dequeueReusableCellWithIdentifier("PieceDetailCell") as! PieceDetailCell
        commentPrototypeCell = tableView.dequeueReusableCellWithIdentifier("CommentCell") as! CommentCell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if self.comments != nil {
            return self.comments.count + 1
        } else {
            return 1
        }

    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
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
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
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
