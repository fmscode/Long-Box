//
//  Trade.swift
//  Long Box
//
//  Created by Frank Michael on 11/2/14.
//  Copyright (c) 2014 Frank Michael Sanchez. All rights reserved.
//

import Foundation
import CoreData

class Trade: NSManagedObject {

    @NSManaged var condition: String
    @NSManaged var note: String
    @NSManaged var title: String
    @NSManaged var series: Series
    @NSManaged var storyArc: StoryArc?

}
