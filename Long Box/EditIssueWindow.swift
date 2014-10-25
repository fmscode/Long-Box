//
//  EditIssueWindow.swift
//  Long Box
//
//  Created by Frank Michael on 10/25/14.
//  Copyright (c) 2014 Frank Michael Sanchez. All rights reserved.
//

import Cocoa

class EditIssueWindow: NSWindowController {

    //    MARK: Class Variables
    var managedObjectContext: NSManagedObjectContext!
    var editingIssue: Issue!
    //    MARK: UI Variables
    @IBOutlet weak var issueNumber: NSTextField!
    @IBOutlet weak var publishDate: NSTextField!
    @IBOutlet weak var variantCheck: NSButton!
    @IBOutlet weak var seriesBox: NSComboBox!
    @IBOutlet weak var publisherBox: NSComboBox!
    @IBOutlet weak var storyArcBox: NSComboBox!
    @IBOutlet weak var notesField: NSTextView!
    @IBOutlet weak var conditionOptions: NSPopUpButton!
    //    MARK: Init
    override init(window: NSWindow?){
        super.init(window: window)
        self.managedObjectContext = CoreDataManagerX.sharedInstance().managedObjectContext!
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    //    MARK: NSWindowController
    override func windowDidLoad() {
        super.windowDidLoad()
        self.issueNumber.stringValue = self.editingIssue.issueNumber
        self.publishDate.stringValue = self.editingIssue.publishDate
        self.variantCheck.state = self.editingIssue.variant.integerValue
        self.publisherBox.stringValue = self.editingIssue.series.publisher.name
        self.storyArcBox.stringValue = self.editingIssue.storyArc.title
        self.notesField.string = self.editingIssue.note
        self.conditionOptions.selectItemWithTitle(self.editingIssue.condition)
    }

    @IBAction func updateIssue(send: AnyObject) {
        self.editingIssue.issueNumber = self.issueNumber.stringValue;
        self.editingIssue.publishDate = self.publishDate.stringValue;
        self.editingIssue.variant = NSNumber(integer: self.variantCheck.state)
        self.editingIssue.condition = self.conditionOptions.titleOfSelectedItem
        
        let publisherString = self.publisherBox.stringValue
        let seriesString = self.seriesBox.stringValue
        let storyArcString = self.storyArcBox.stringValue
        // Publisher Search/Creation
        let publisher = ModelHelpers.publisherWithName(publisherString)
        // Series Search/Creation
        var series = ModelHelpers.seriesWithName(seriesString)
        series.publisher = publisher
        // Story Arc Search/Creation
        var storyArc = ModelHelpers.storyArcWithName(storyArcString)
        storyArc.series = series
        
        self.editingIssue.series = series
        self.editingIssue.storyArc = storyArc
        
        CoreDataManagerX.sharedInstance().saveContext()
    }
    
}
