//
//  Publisher.swift
//  Long Box
//
//  Created by Frank Michael on 11/2/14.
//  Copyright (c) 2014 Frank Michael Sanchez. All rights reserved.
//

import Foundation
import CoreData

class Publisher: NSManagedObject {

    @NSManaged var name: String
    @NSManaged var series: NSSet

}
