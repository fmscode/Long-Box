//
//  ComicsWindow.swift
//  Long Box
//
//  Created by Frank Michael on 10/19/14.
//  Copyright (c) 2014 Frank Michael Sanchez. All rights reserved.
//

import Cocoa

class ComicsWindow: NSWindowController {
//    MARK: Variables
    var managedObjectContext: NSManagedObjectContext!
    @IBOutlet weak var dataControl: NSSegmentedControl!
    @IBOutlet weak var dataTabView: NSTabView!
    @IBOutlet weak var issuesController: NSArrayController!
    @IBOutlet weak var seriesController: NSArrayController!
    
    var comicNewWindow: NewComicWindow!
    var editWindow: EditIssueWindow!
//    MARK: Init
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    override init(window: NSWindow?) {
        super.init(window: window)
    }
    override init() {
        super.init()
        self.managedObjectContext = CoreDataManagerX.sharedInstance().managedObjectContext!
    }
//    MARK: NSWindowController
    override func windowDidLoad() {
        super.windowDidLoad()
    }
//    MARK: Class Actions
    @IBAction func addComic(AnyObject){
        self.comicNewWindow = NewComicWindow(windowNibName: "NewComicWindow")
        self.window?.beginSheet(self.comicNewWindow.window!, completionHandler: { (NSModalResponse) -> Void in

        })
    }
    @IBAction func changeInformation(AnyObject){
        self.dataTabView.selectTabViewItemAtIndex(self.dataControl.selectedSegment)
    }
//    MARK: Editing/Removal Issue
    @IBAction func editIssue(AnyObject){
        print(issuesController.selectedObjects.first)
        self.editWindow = EditIssueWindow(windowNibName: "EditIssueWindow")
        self.editWindow.editingIssue = issuesController.selectedObjects.first as Issue
        self.window?.beginSheet(self.editWindow.window!, completionHandler: { (NSModalResponse) -> Void in
            
        })
    }
    @IBAction func removeIssue(AnyObject){
        let issue = issuesController.selectedObjects.first as Issue
        var confirmRemoveAlert = NSAlert()
        confirmRemoveAlert.messageText = "Are you sure you want to delete issue #\(issue.issueNumber) of \(issue.series.title)?"
        confirmRemoveAlert.addButtonWithTitle("Delete")
        confirmRemoveAlert.addButtonWithTitle("Cancel")
        let response = confirmRemoveAlert.runModal()
        if (response == NSAlertFirstButtonReturn){
            issuesController.remove(self)
        }
    }
//    MARK: Editing/Removal Series
    @IBAction func removeSeries(AnyObject){
        let series = seriesController.selectedObjects.first as Series
        var confirmRemoveAlert = NSAlert()
        confirmRemoveAlert.messageText = "Are you sure you want to remove the \(series.title) series? All of its issues and trade records will be removed as well."
        confirmRemoveAlert.addButtonWithTitle("Delete")
        confirmRemoveAlert.addButtonWithTitle("Cancel")
        let response = confirmRemoveAlert.runModal()
        if (response == NSAlertFirstButtonReturn){
            seriesController.remove(self)
        }
    }

}
