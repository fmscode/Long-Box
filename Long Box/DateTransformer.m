//
//  DateTransformer.m
//  Long Box
//
//  Created by Frank Michael on 5/30/14.
//  Copyright (c) 2014 Frank Michael Sanchez. All rights reserved.
//

#import "DateTransformer.h"

@implementation DateTransformer

+ (Class)transformedValueClass{
    return [NSString class];
}
+ (BOOL)allowsReverseTransformation{
    return NO;
}
- (id)transformedValue:(NSDate *)value{
    NSDateFormatter *df = [NSDateFormatter new];
    [df setDateFormat:@"MM/yyyy"];
    return [df stringFromDate:value];
}


@end
