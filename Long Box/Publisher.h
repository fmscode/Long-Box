//
//  Publisher.h
//  Long Box
//
//  Created by Frank Michael on 6/1/14.
//  Copyright (c) 2014 Frank Michael Sanchez. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Series;

@interface Publisher : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *series;
@end

@interface Publisher (CoreDataGeneratedAccessors)

- (void)addSeriesObject:(Series *)value;
- (void)removeSeriesObject:(Series *)value;
- (void)addSeries:(NSSet *)values;
- (void)removeSeries:(NSSet *)values;

@end
