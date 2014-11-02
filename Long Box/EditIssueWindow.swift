//
//  EditIssueWindow.swift
//  Long Box
//
//  Created by Frank Michael on 10/25/14.
//  Copyright (c) 2014 Frank Michael Sanchez. All rights reserved.
//

import Cocoa

class EditIssueWindow: NSWindowController,NSComboBoxDataSource,NSComboBoxDelegate {

//    MARK: Class Variables
    var managedObjectContext: NSManagedObjectContext!
    var editingIssue: Issue!
    var conditions: NSArray!
//    MARK: UI Variables
    @IBOutlet weak var seriesController: NSArrayController!
    @IBOutlet weak var publisherController: NSArrayController!
    @IBOutlet weak var issueNumber: NSTextField!
    @IBOutlet weak var publishDate: NSTextField!
    @IBOutlet weak var variantCheck: NSButton!
    @IBOutlet weak var seriesBox: NSComboBox!
    @IBOutlet weak var publisherBox: NSComboBox!
    @IBOutlet weak var storyArcBox: NSComboBox!
    @IBOutlet weak var notesField: NSTextView!
    @IBOutlet weak var conditionOptions: NSPopUpButton!
//    MARK: Init
    override init() {
        super.init()
    }
    override init(window: NSWindow?){
        super.init(window: window)
        self.managedObjectContext = CoreDataManager.sharedInstance.managedObjectContext!
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
//    MARK: NSWindowController
    override func windowDidLoad() {
        super.windowDidLoad()
        self.conditionOptions.removeAllItems()
        let conditionsFile = NSBundle.mainBundle().pathForResource("gradescale", ofType: "plist")
        self.conditions = NSArray(contentsOfFile: conditionsFile!)
        for condition in self.conditions{
            let conditionDic = condition as NSDictionary
            let visibleGrade = conditionDic["visibleGrade"] as String
            let gradeNumber = conditionDic["gradeNum"] as String
            let conditionTitle = "\(visibleGrade) (\(gradeNumber))"
            self.conditionOptions .addItemWithTitle(conditionTitle)
        }

        self.issueNumber.stringValue = self.editingIssue.issueNumber
        self.publishDate.stringValue = self.editingIssue.publishDate
        self.seriesBox.stringValue = self.editingIssue.series.title
        self.variantCheck.state = self.editingIssue.variant.integerValue
        self.publisherBox.stringValue = self.editingIssue.series.publisher.name
        if self.editingIssue.storyArc != nil {
            self.storyArcBox.stringValue = self.editingIssue.storyArc!.title
        }
        if self.editingIssue.note != nil && self.editingIssue.note!.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) != 0{
            self.notesField.string = self.editingIssue.note!
        }
        self.conditionOptions.selectItemWithTitle(self.editingIssue.condition)
    }
//    MARK: Class Actions
    @IBAction func cancelUpdate(sender: AnyObject){
        self.editingIssue = nil
        self.window!.sheetParent?.endSheet(self.window!)
    }
    @IBAction func updateIssue(sender: AnyObject) {
        self.editingIssue.issueNumber = self.issueNumber.stringValue;
        self.editingIssue.publishDate = self.publishDate.stringValue;
        self.editingIssue.variant = NSNumber(integer: self.variantCheck.state)
        self.editingIssue.condition = self.conditionOptions.titleOfSelectedItem!
        
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
        
        CoreDataManager.sharedInstance.saveContext()
        self.window!.sheetParent?.endSheet(self.window!)
    }
//    MARK: NSComboBox Delegate
    func updatePublisher(){
        if (self.seriesBox.indexOfSelectedItem != -1){
            self.seriesController.setSelectionIndex(self.seriesBox.indexOfSelectedItem)
            if let selectedSeries = self.seriesController.selectedObjects.last as? Series{
                self.publisherController.setSelectedObjects([selectedSeries.publisher])
                self.publisherBox.stringValue = selectedSeries.publisher.name
            }
        }else{
            self.seriesController.setSelectionIndex(-1)
            self.publisherController.setSelectionIndex(-1)
            self.publisherBox.stringValue = ""
        }
    }
    override func controlTextDidEndEditing(obj: NSNotification) {
        let control = obj.object as NSObject
        if (control === self.seriesBox){
            updatePublisher()
        }else if (control === self.publisherBox){
            if (self.publisherBox.indexOfSelectedItem != -1){
                self.publisherController.setSelectionIndex(self.publisherBox.indexOfSelectedItem)
            }else{
                self.publisherController.setSelectionIndex(-1)
            }
        }
    }
    override func controlTextDidChange(obj: NSNotification) {
        let control = obj.object as NSObject
        if (control === self.seriesBox){
            updatePublisher()
        }else if (control === self.publisherBox){
            if (self.publisherBox.indexOfSelectedItem != -1){
                self.publisherController.setSelectionIndex(self.publisherBox.indexOfSelectedItem)
            }else{
                self.publisherController.setSelectionIndex(-1)
            }
        }
    }
    func comboBoxSelectionDidChange(notification: NSNotification) {
        if (notification.object as NSObject === self.seriesBox){
            updatePublisher()
        }else{
            self.publisherController.setSelectionIndex(self.publisherBox.indexOfSelectedItem)
        }
    }
}
