//
//  VariantIndicator.swift
//  Long Box
//
//  Created by Frank Michael on 10/21/14.
//  Copyright (c) 2014 Frank Michael Sanchez. All rights reserved.
//

import Cocoa

class VariantIndicator: NSView {

    override func drawRect(dirtyRect: NSRect) {
        NSColor(calibratedRed: 77.0/255.0, green: 226.0/255.0, blue: 140.0/255.0, alpha: 1.0).setFill()
        NSRectFill(dirtyRect)
        super.drawRect(dirtyRect)
        // Drawing code here.
    }
    
}
