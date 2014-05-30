//
//  Issue.h
//  Long Box
//
//  Created by Frank Michael on 5/30/14.
//  Copyright (c) 2014 Frank Michael Sanchez. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Series;

@interface Issue : NSManagedObject

@property (nonatomic, retain) NSString * issueNumber;
@property (nonatomic, retain) NSDate * publishDate;
@property (nonatomic, retain) NSString * note;
@property (nonatomic, retain) Series *series;

@end
