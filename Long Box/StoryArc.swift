//
//  StoryArc.swift
//  Long Box
//
//  Created by Frank Michael on 11/2/14.
//  Copyright (c) 2014 Frank Michael Sanchez. All rights reserved.
//

import Foundation
import CoreData

class StoryArc: NSManagedObject {

    @NSManaged var title: String
    @NSManaged var issues: NSSet
    @NSManaged var series: Series
    @NSManaged var trades: NSSet

}
