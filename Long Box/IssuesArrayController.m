//
//  IssuesArrayController.m
//  Long Box
//
//  Created by Frank Michael on 6/1/14.
//  Copyright (c) 2014 Frank Michael Sanchez. All rights reserved.
//

#import "IssuesArrayController.h"

@implementation IssuesArrayController

- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self){
        self.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"issueNumber" ascending:YES]];
    }
    return self;
}

@end
