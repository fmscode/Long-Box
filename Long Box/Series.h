//
//  Series.h
//  Long Box
//
//  Created by Frank Michael on 5/30/14.
//  Copyright (c) 2014 Frank Michael Sanchez. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Issue, Publisher;

@interface Series : NSManagedObject

@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSSet *issues;
@property (nonatomic, retain) Publisher *publisher;
@end

@interface Series (CoreDataGeneratedAccessors)

- (void)addIssuesObject:(Issue *)value;
- (void)removeIssuesObject:(Issue *)value;
- (void)addIssues:(NSSet *)values;
- (void)removeIssues:(NSSet *)values;

@end
