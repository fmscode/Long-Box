//
//  StoryArc.h
//  Long Box
//
//  Created by Frank Michael on 8/19/14.
//  Copyright (c) 2014 Frank Michael Sanchez. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Issue, Series, Trade;

@interface StoryArc : NSManagedObject

@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSSet *issues;
@property (nonatomic, retain) Series *series;
@property (nonatomic, retain) NSSet *trades;
@end

@interface StoryArc (CoreDataGeneratedAccessors)

- (void)addIssuesObject:(Issue *)value;
- (void)removeIssuesObject:(Issue *)value;
- (void)addIssues:(NSSet *)values;
- (void)removeIssues:(NSSet *)values;

- (void)addTradesObject:(Trade *)value;
- (void)removeTradesObject:(Trade *)value;
- (void)addTrades:(NSSet *)values;
- (void)removeTrades:(NSSet *)values;

@end