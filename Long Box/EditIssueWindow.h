//
//  EditIssueWindow.h
//  Long Box
//
//  Created by Frank Michael on 9/3/14.
//  Copyright (c) 2014 Frank Michael Sanchez. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Issue.h"

@interface EditIssueWindow : NSWindowController

@property (nonatomic) Issue *editingIssue;
@property (nonatomic) NSManagedObjectContext *managedObjectContext;

@end
