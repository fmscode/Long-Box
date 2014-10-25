//
//  SeriesArrayController.swift
//  Long Box
//
//  Created by Frank Michael on 10/21/14.
//  Copyright (c) 2014 Frank Michael Sanchez. All rights reserved.
//

import Cocoa

class SeriesArrayController: NSArrayController {
    var searchString = ""
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true, selector: "localizedStandardCompare:")]
    }
    
    @IBAction func search(sender: AnyObject){
        self.searchString = sender.stringValue
        self.rearrangeObjects()
    }
    
    override func arrangeObjects(objects: [AnyObject]) -> [AnyObject] {
        if self.searchString.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) == 0{
            return super.arrangeObjects(objects)
        }
        
        var filteredObjects = [Series]()
        
        for series in objects{
            if (series.valueForKeyPath("title")?.rangeOfString(searchString).location != NSNotFound){
                filteredObjects.append(series as Series)
            }
        }
        
        return super.arrangeObjects(filteredObjects)
    }
    
}
