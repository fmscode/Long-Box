//
//  IssuesController.swift
//  Long Box
//
//  Created by Frank Michael on 10/25/14.
//  Copyright (c) 2014 Frank Michael Sanchez. All rights reserved.
//

import Cocoa

class IssuesController: NSArrayController {
   
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.sortDescriptors = [NSSortDescriptor(key: "issueNumber", ascending: true, selector: "localizedStandardCompare:")]
    }
    
    
}
