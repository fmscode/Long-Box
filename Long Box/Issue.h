//
//  Issue.h
//  Long Box
//
//  Created by Frank Michael on 8/19/14.
//  Copyright (c) 2014 Frank Michael Sanchez. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Series, StoryArc;

@interface Issue : NSManagedObject

@property (nonatomic, retain) NSString * issueNumber;
@property (nonatomic, retain) NSString * note;
@property (nonatomic, retain) NSString * publishDate;
@property (nonatomic, retain) NSNumber * variant;
@property (nonatomic, retain) Series *series;
@property (nonatomic, retain) StoryArc *storyArc;

@end
