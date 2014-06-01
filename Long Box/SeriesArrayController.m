//
//  SeriesArrayController.m
//  Long Box
//
//  Created by Frank Michael on 5/30/14.
//  Copyright (c) 2014 Frank Michael Sanchez. All rights reserved.
//

#import "SeriesArrayController.h"

@interface SeriesArrayController () {
    NSString *searchString;
}

- (IBAction)search:(id)sender;

@end

@implementation SeriesArrayController

- (id)init{
    self = [super init];
    if (self){
        self.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"title" ascending:YES]];
    }
    return self;
}

- (IBAction)search:(id)sender{
    searchString = [sender stringValue];
    [self rearrangeObjects];
}
- (NSArray *)arrangeObjects:(NSArray *)objects{
    if (searchString == nil || searchString.length == 0){
        return [super arrangeObjects:objects];
    }
    
    NSMutableArray *filteredObjects = [NSMutableArray arrayWithCapacity:[objects count]];
    [objects enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([[obj valueForKeyPath:@"title"] rangeOfString:searchString options:NSCaseInsensitiveSearch].location != NSNotFound){
            [filteredObjects addObject:obj];
        }
    }];
    return [super arrangeObjects:filteredObjects];
}
@end
