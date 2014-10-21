//
//  NewComicWindow.swift
//  Long Box
//
//  Created by Frank Michael on 10/19/14.
//  Copyright (c) 2014 Frank Michael Sanchez. All rights reserved.
//

import Cocoa

class NewComicWindow: NSWindowController,NSComboBoxDataSource,NSComboBoxDelegate {
//    MARK: Class Variables
    var managedObjectContext: NSManagedObjectContext!
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
    @IBOutlet var notesField: NSTextView!
    @IBOutlet weak var tradeTitleField: NSTextField!
    @IBOutlet weak var tabView: NSTabView!
    @IBOutlet weak var conditionOptions: NSPopUpButton!
//    MARK: Init
    override init() {
        super.init()
    }
    
    override init(window: NSWindow?) {
        super.init(window: window)
        self.managedObjectContext = CoreDataManagerX.sharedInstance().managedObjectContext!
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
    }
//    MARK: Class
    func clearUI(){
        self.issueNumber.stringValue = ""
        self.seriesBox.stringValue = ""
        self.publisherBox.stringValue = ""
        self.publishDate.stringValue = ""
        self.notesField.string = ""
        self.tradeTitleField.stringValue = ""
        self.seriesController.setSelectionIndex(-1)
        self.publisherController.setSelectionIndex(-1)
    }
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
    func saveComicData(){
        let context = CoreDataManagerX.sharedInstance().managedObjectContext!
        
        let publisherString = self.publisherBox.stringValue
        let seriesString = self.seriesBox.stringValue
        let storyString = self.storyArcBox.stringValue
        
        // Publisher Search/Creation
        var pubFetch = NSFetchRequest(entityName: "Publisher")
        pubFetch.predicate = NSPredicate(format: "name LIKE[cd] %@", argumentArray: [publisherString])
        let publishersFound = context.executeFetchRequest(pubFetch, error: nil)
        var publisher: Publisher
        if (publishersFound?.count > 0){
            publisher = publishersFound?.last as Publisher
        }else{
            publisher = NSEntityDescription.insertNewObjectForEntityForName("Publisher", inManagedObjectContext: context) as Publisher
            publisher.name = publisherString
        }
        // Series Search/Creation
        var seriesFetch = NSFetchRequest(entityName: "Series")
        seriesFetch.predicate = NSPredicate(format: "title LIKE[cd] %@", argumentArray: [seriesString])
        let seriesFound = context.executeFetchRequest(seriesFetch, error: nil)
        var series: Series
        if (seriesFound?.count > 0){
            series = seriesFound?.last as Series
        }else{
            series = NSEntityDescription.insertNewObjectForEntityForName("Series", inManagedObjectContext: context) as Series
            series.title = seriesString
            series.publisher = publisher
        }
        // Story Arc Search/Creation
        var storyArc: StoryArc?
        if (storyString.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) > 0){
            var storyFetch = NSFetchRequest(entityName: "StoryArc")
            storyFetch.predicate = NSPredicate(format: "title LIKE[cd] %@", argumentArray: [storyString])
            let storiesFound = context.executeFetchRequest(storyFetch, error: nil)
            var storyArc: StoryArc
            if (storiesFound?.count > 0){
                storyArc = storiesFound?.last as StoryArc
            }else{
                storyArc = NSEntityDescription.insertNewObjectForEntityForName("StoryArc", inManagedObjectContext: context) as StoryArc
                storyArc.title = storyString
                storyArc.series = series
            }
        }
        // Issue creation
        let selectedTabId = self.tabView.selectedTabViewItem!.identifier as String
        if (selectedTabId == "1"){
            // New Issue
            var newIssue = NSEntityDescription.insertNewObjectForEntityForName("Issue", inManagedObjectContext: context) as Issue
            newIssue.issueNumber = self.issueNumber.stringValue
            newIssue.publishDate = self.publishDate.stringValue
            newIssue.series = series
            newIssue.note = self.notesField.string
            newIssue.variant = NSNumber(integer: self.variantCheck.state)
            newIssue.condition = self.conditionOptions.titleOfSelectedItem?
            if (storyArc != nil){
                newIssue.storyArc = storyArc
            }
        }else{
            // New Trade
            var newTrade = NSEntityDescription.insertNewObjectForEntityForName("Trade", inManagedObjectContext: context) as Trade
            newTrade.title = self.tradeTitleField.stringValue
            newTrade.series = series
            newTrade.note = self.notesField.string
            newTrade.condition = self.conditionOptions.titleOfSelectedItem?
            if (storyArc != nil){
                newTrade.storyArc = storyArc
            }
        }
        CoreDataManagerX.sharedInstance().saveContext()
    }
//    MARK: Class Actions
    @IBAction func cancelNew(id: AnyObject){
        clearUI()
        self.window!.sheetParent?.endSheet(self.window!)
    }
    @IBAction func saveComic(id: AnyObject){
        saveComicData()
        clearUI()
    }
    @IBAction func addSecondComic(id: AnyObject){
        saveComicData()
        self.issueNumber.stringValue = ""
        self.publishDate.stringValue = ""
        self.tradeTitleField.stringValue = ""
        self.storyArcBox.stringValue = ""
    }
//    MARK: NSTextField Delegate
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
//    MARK: NSComboBox Delegate
    func comboBoxSelectionDidChange(notification: NSNotification) {
        if (notification.object as NSObject === self.seriesBox){
            updatePublisher()
        }else{
            self.publisherController.setSelectionIndex(self.publisherBox.indexOfSelectedItem)
        }
    }
}
