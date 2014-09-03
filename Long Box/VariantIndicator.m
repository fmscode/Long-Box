//
//  VariantIndicator.m
//  Long Box
//
//  Created by Frank Michael on 9/1/14.
//  Copyright (c) 2014 Frank Michael Sanchez. All rights reserved.
//

#import "VariantIndicator.h"

@implementation VariantIndicator

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
    }
    return self;
}

- (void)drawRect:(NSRect)dirtyRect
{
    //    	return [[self class] colorWithR:77 G:226 B:140 A:1.0];

    [[NSColor colorWithRed:77.0/255.0 green:226.0/255.0 blue:140.0/255.0 alpha:1.0] setFill];
    NSRectFill(dirtyRect);

    [super drawRect:dirtyRect];
    
    // Drawing code here.
}

@end
