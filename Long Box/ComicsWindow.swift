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
        self.comicNewWindow = NewComicWindow(windowNibName:"NewComicWindow")
        self.window?.beginSheet(self.comicNewWindow.window!, completionHandler: { (NSModalResponse) -> Void in

        })
    }
    @IBAction func changeInformation(AnyObject){
        self.dataTabView.selectTabViewItemAtIndex(self.dataControl.selectedSegment)
    }

}
