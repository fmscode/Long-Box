//
//  ModelHelpers.swift
//  Long Box
//
//  Created by Frank Michael on 10/25/14.
//  Copyright (c) 2014 Frank Michael Sanchez. All rights reserved.
//

import Cocoa

class ModelHelpers: NSObject {

    
    class func publisherWithName(publisherName: String) -> Publisher {
        let context = CoreDataManagerX.sharedInstance().managedObjectContext!
        
        var pubFetch = NSFetchRequest(entityName: "Publisher")
        pubFetch.predicate = NSPredicate(format: "name LIKE[cd] %@", argumentArray: [publisherName])
        let publishersFound = context!.executeFetchRequest(pubFetch, error: nil)
        var publisher: Publisher
        if (publishersFound?.count > 0){
            publisher = publishersFound?.last as Publisher
        }else{
            publisher = NSEntityDescription.insertNewObjectForEntityForName("Publisher", inManagedObjectContext: context!) as Publisher
            publisher.name = publisherName
        }
        
        return publisher
    }
    
    class func seriesWithName(seriesName: String) -> Series {
        let context = CoreDataManagerX.sharedInstance().managedObjectContext!
        
        var seriesFetch = NSFetchRequest(entityName: "Series")
        seriesFetch.predicate = NSPredicate(format: "title LIKE[cd] %@", argumentArray: [seriesName])
        let seriesFound = context!.executeFetchRequest(seriesFetch, error: nil)
        var series: Series
        if (seriesFound?.count > 0){
            series = seriesFound?.last as Series
        }else{
            series = NSEntityDescription.insertNewObjectForEntityForName("Series", inManagedObjectContext: context!) as Series
            series.title = seriesName
        }
        
        return series
    }
    
    class func storyArcWithName(storyArcName: String) -> StoryArc {
        let context = CoreDataManagerX.sharedInstance().managedObjectContext!

        var storyFetch = NSFetchRequest(entityName: "StoryArc")
        storyFetch.predicate = NSPredicate(format: "title LIKE[cd] %@", argumentArray: [storyArcName])
        let storiesFound = context!.executeFetchRequest(storyFetch, error: nil)
        var storyArc: StoryArc
        if (storiesFound?.count > 0){
            storyArc = storiesFound?.last as StoryArc
        }else{
            storyArc = NSEntityDescription.insertNewObjectForEntityForName("StoryArc", inManagedObjectContext: context!) as StoryArc
            storyArc.title = storyArcName
        }
        return storyArc
    }
    
}
