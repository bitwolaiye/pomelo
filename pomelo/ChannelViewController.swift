//
//  ChannelViewController.swift
//  pomelo
//
//  Created by zhouqi on 16/1/25.
//  Copyright © 2016年 zhouqi. All rights reserved.
//

import UIKit
import YYText
import SnapKit

class ChannelViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, YYTextKeyboardObserver {
    @IBOutlet weak var tableView:UITableView!
    @IBOutlet weak var addPieceView:AddPieceView!
    var addPieceViewBottomConstraint: Constraint? = nil
    
    var prototypeCell:PieceListCell!
    var channel:Channel!
    var pieces:[Piece]!
    
    func reloadDataFromApi() {
        let selfController: ChannelViewController = self
        PieceApi.sharedInstance.getChannelPieceList(self.channel.channelId, callback: { (pieces: [Piece]) -> Void in
            selfController.pieces = pieces
            selfController.tableView.reloadData()
        })
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController!.navigationBar.translucent = false;
        
        if (self.pieces == nil && self.channel != nil) {
            self.reloadDataFromApi()
        }
        if let selectedRow = self.tableView.indexPathForSelectedRow {
            self.tableView.deselectRowAtIndexPath(selectedRow, animated: false)
        }
        self.addPieceView.channel = self.channel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        self.hidesBottomBarWhenPushed = true
        
        self.tableView = {
            let tableView = UITableView()
            
            self.view.addSubview(tableView)
            
            tableView.delegate = self
            tableView.dataSource = self
            
            tableView.rowHeight = UITableViewAutomaticDimension
            tableView.estimatedRowHeight = 44
            tableView.separatorStyle = UITableViewCellSeparatorStyle.None
            
            tableView.snp_makeConstraints(closure: { (make) -> Void in
                make.top.equalTo(self.topLayoutGuide)
                make.left.equalTo(0)
                make.right.equalTo(self.view)
                make.bottom.equalTo(self.view).offset(-40)
            })
            
            tableView.registerClass(PieceListCell.self, forCellReuseIdentifier: "PieceListCell")
            
            return tableView
            } ()

        self.addPieceView = {
            let addPieceView = AddPieceView()
            
            addPieceView.initSubviews()
            self.view.addSubview(addPieceView)
            
            addPieceView.snp_makeConstraints(closure: { (make) -> Void in
                self.addPieceViewBottomConstraint = make.bottom.equalTo(self.view.snp_bottom).constraint
                make.height.equalTo(40)
                make.left.equalTo(0)
                make.right.equalTo(self.view)
            })
            
            return addPieceView
            } ()
        
        
        prototypeCell = tableView.dequeueReusableCellWithIdentifier("PieceListCell") as! PieceListCell
        
        YYTextKeyboardManager.defaultManager().addObserver(self)
    }
    
    deinit {
        YYTextKeyboardManager.defaultManager().removeObserver(self)
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
        if (self.pieces != nil) {
            return self.pieces.count
        } else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("PieceListCell", forIndexPath: indexPath) as! PieceListCell
        cell.piece = self.pieces[indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let cell = self.prototypeCell
        cell.piece = self.pieces[indexPath.row]
        cell.layoutSubviews()
        let size = cell.contentView.systemLayoutSizeFittingSize(UILayoutFittingCompressedSize)
        return 1  + size.height;
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("PushPieceDetail", sender: self)
    }
    
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        self.addPieceView.endEditing(true)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        self.addPieceView.endEditing(true)
        if (segue.identifier == "PushPieceDetail") {
            let controller = segue.destinationViewController as! PieceViewController
            controller.piece = self.pieces[self.tableView.indexPathForSelectedRow!.row]
        }
    }
    
    func keyboardChangedWithTransition(transition: YYTextKeyboardTransition) {
        UIView.animateWithDuration(transition.animationDuration) { () -> Void in
            let kbFrame = YYTextKeyboardManager.defaultManager().convertRect(transition.toFrame, toView: self.view)
            self.addPieceViewBottomConstraint?.updateOffset(kbFrame.origin.y - self.view.frame.size.height)
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
