//
//  StoryArcsArrayController.m
//  Long Box
//
//  Created by Frank Michael on 8/18/14.
//  Copyright (c) 2014 Frank Michael Sanchez. All rights reserved.
//

#import "StoryArcsArrayController.h"

@implementation StoryArcsArrayController

- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self){
        self.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"title" ascending:YES]];
    }
    return self;
}

@end
