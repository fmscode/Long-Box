//
//  DateTransformer.swift
//  Long Box
//
//  Created by Frank Michael on 10/19/14.
//  Copyright (c) 2014 Frank Michael Sanchez. All rights reserved.
//

import Foundation

class DateTransformer: NSValueTransformer {
    

    override func transformedValue(value: AnyObject?) -> AnyObject? {
        let date = value as NSDate
        var df = NSDateFormatter()
        df.dateFormat = "MM/yyyy"
        return df.stringFromDate(date)
    }
    
    
}