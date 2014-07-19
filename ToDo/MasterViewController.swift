//
//  MasterViewController.swift
//  ToDo
//
//  Created by Ben Lindsey on 7/19/14.
//  Copyright (c) 2014 Ben Lindsey. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController, UITextViewDelegate {

    var objects = [String]()

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.tableFooterView = UIView()
        self.navigationItem.leftBarButtonItem = self.editButtonItem()

        let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "insertNewObject:")
        self.navigationItem.rightBarButtonItem = addButton
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func insertNewObject(sender: AnyObject) {
        objects.insert("", atIndex: 0)
        self.tableView.reloadData()
        let indexPath = NSIndexPath(forRow: 0, inSection: 0)
        let cell = self.tableView.cellForRowAtIndexPath(indexPath)
        let textView = cell.contentView.subviews[0] as UITextView
        textView.becomeFirstResponder()
    }

    // #pragma mark - Table View

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
        let textView = cell.contentView.subviews[0] as UITextView
        textView.tag = indexPath.row
        textView.text = objects[indexPath.row]
        return cell
    }

    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            objects.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }

    override func tableView(tableView: UITableView!, moveRowAtIndexPath sourceIndexPath: NSIndexPath!, toIndexPath destinationIndexPath: NSIndexPath!) {
        let item = objects.removeAtIndex(sourceIndexPath.row)
        objects.insert(item, atIndex: destinationIndexPath.row)
        self.tableView.reloadData()
    }

    override func tableView(tableView: UITableView!, heightForRowAtIndexPath indexPath: NSIndexPath!) -> CGFloat {
        let string = objects[indexPath.row]

        let attributes = [ NSFontAttributeName: UIFont.systemFontOfSize(18.0)]
        let size = string.bridgeToObjectiveC().boundingRectWithSize(CGSize(width: 310, height: CGFLOAT_MAX), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: attributes, context: nil)
        return max(44.0, size.height)
    }

    // #pragma mark - UITextViewDelegate

    func textView(textView: UITextView!, shouldChangeTextInRange range: NSRange, replacementText text: String!) -> Bool {
        let string = textView.text.bridgeToObjectiveC().stringByReplacingCharactersInRange(range, withString: text)
        objects[textView.tag] = string

        self.tableView.beginUpdates()
        self.tableView.endUpdates()

        return true
    }
}

