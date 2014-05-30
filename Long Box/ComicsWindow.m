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

@interface ComicsWindow () {
    NewComicWindow *newWindow;
}
- (IBAction)addComic:(id)sender;

@end


@implementation ComicsWindow

- (id)init{
    self = [super init];
    if (self){
        _managedObjectContext = [[CoreDataManagerX sharedInstance] managedObjectContext];
    }
    return self;
}

- (IBAction)addComic:(id)sender{
    newWindow = [[NewComicWindow alloc] initWithWindowNibName:@"NewComicWindow"];
    [self.window beginSheet:newWindow.window completionHandler:^(NSModalResponse returnCode) {
        
    }];
}

@end
