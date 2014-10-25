//
//  SeriesTable.swift
//  Long Box
//
//  Created by Frank Michael on 10/25/14.
//  Copyright (c) 2014 Frank Michael Sanchez. All rights reserved.
//

import Cocoa

class SeriesTable: NSTableView {
    
    @IBOutlet var editingDelegate: ComicsWindow!

    override func drawRect(dirtyRect: NSRect) {
        super.drawRect(dirtyRect)
    }
    
    func removeSeries(){
        editingDelegate.removeSeries(self)
    }
    
    override func rightMouseDown(theEvent: NSEvent) {
        let point = self.convertPoint(theEvent.locationInWindow, fromView: nil)
        let i = self.rowAtPoint(point)
        self.selectRowIndexes(NSIndexSet(index: i), byExtendingSelection: false)
        
        var issuesPopUpMenu = NSMenu()
        issuesPopUpMenu.addItem(NSMenuItem(title: "Edit", action: "editIssue", keyEquivalent: ""))
        issuesPopUpMenu.addItem(NSMenuItem(title: "Remove", action: "removeSeries", keyEquivalent: ""))
        NSMenu.popUpContextMenu(issuesPopUpMenu, withEvent: theEvent, forView: self)
    }
    override func keyDown(theEvent: NSEvent) {
        if (Int(theEvent.keyCode) == 51){
            self.removeSeries()
        }
    }

}
