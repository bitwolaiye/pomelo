//
//  ChannelViewController.swift
//  pomelo
//
//  Created by zhouqi on 16/1/9.
//  Copyright © 2016年 zhouqi. All rights reserved.
//

import UIKit

class Channel1ViewController: UITableViewController {
    var prototypeCell:PieceListCell!
    var channel:Channel!
    var pieces:[Piece]!
    
    func reloadDataFromApi() {
        let selfController: Channel1ViewController = self
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
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 44
        tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        
        prototypeCell = tableView.dequeueReusableCellWithIdentifier("PieceListCell") as! PieceListCell
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
        if (self.pieces != nil) {
            return self.pieces.count
        } else {
            return 0
        }
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("PieceListCell", forIndexPath: indexPath) as! PieceListCell
        cell.piece = self.pieces[indexPath.row]
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let cell = self.prototypeCell
        cell.piece = self.pieces[indexPath.row]
        cell.layoutSubviews()
        let size = cell.contentView.systemLayoutSizeFittingSize(UILayoutFittingCompressedSize)
        return 1  + size.height;
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "PushPieceDetail") {
            let controller = segue.destinationViewController as! Piece1ViewController
            controller.piece = self.pieces[self.tableView.indexPathForSelectedRow!.row]
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
