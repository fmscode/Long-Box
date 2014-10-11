//
//  ComicsWindow.m
//  Long Box
//
//  Created by Frank Michael on 5/30/14.
//  Copyright (c) 2014 Frank Michael Sanchez. All rights reserved.
//

#import "ComicsWindow.h"
#import "NewComicWindow.h"
#import "Series.h"
#import "Publisher.h"
#import "CoreDataManagerX.h"
#import "Issue.h"
#import "EditIssueWindow.h"

@interface ComicsWindow () {
    
}

@property (nonatomic) NewComicWindow *comicNewWindow;
@property (nonatomic) EditIssueWindow *editWindow;
@property (nonatomic) IBOutlet NSTableView *issuesTable;

- (IBAction)addComic:(id)sender;
- (IBAction)editIssue:(id)sender;

@end


@implementation ComicsWindow

- (id)init{
    self = [super init];
    if (self){
        _managedObjectContext = [[CoreDataManagerX sharedInstance] managedObjectContext];
    }
    return self;
}
- (void)windowDidLoad{
    [super windowDidLoad];
}

- (IBAction)addComic:(id)sender{
    self.comicNewWindow = [[NewComicWindow alloc] initWithWindowNibName:@"NewComicWindow"];
    [self.window beginSheet:self.comicNewWindow.window completionHandler:^(NSModalResponse returnCode) {
        
    }];
}
- (IBAction)editIssue:(id)sender{
    self.editWindow = [[EditIssueWindow alloc] initWithWindowNibName:@"EditIssueWindow"];
    [self.window beginSheet:self.editWindow.window completionHandler:^(NSModalResponse returnCode) {
        
    }];
}
- (IBAction)removeComic:(id)sender{
    
}

@end
