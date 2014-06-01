//
//  AppDelegate.m
//  Long Box
//
//  Created by Frank Michael on 5/27/14.
//  Copyright (c) 2014 Frank Michael Sanchez. All rights reserved.
//

#import "AppDelegate.h"
#import "CoreDataManagerX.h"
#import "Trade.h"

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification{
    /*
    _managedObjectContext = [[CoreDataManagerX sharedInstance] managedObjectContext];
    
//    Series *newSeries = [NSEntityDescription insertNewObjectForEntityForName:@"Series" inManagedObjectContext:_managedObjectContext];
//    newSeries.title = @"Superman";
//    
//    Publisher *pub = [NSEntityDescription insertNewObjectForEntityForName:@"Publisher" inManagedObjectContext:_managedObjectContext];
//    pub.name = @"DC Comics";
//    newSeries.publisher = pub;
//    
//    
//    Issue *newIssue = [NSEntityDescription insertNewObjectForEntityForName:@"Issue" inManagedObjectContext:_managedObjectContext];
//    newIssue.issueNumber = @"1";
//    newIssue.series = newSeries;
//    [[CoreDataManagerX sharedInstance] saveContext];
    
    */

    NSFetchRequest *issues = [NSFetchRequest fetchRequestWithEntityName:@"Trade"];
    NSArray *issuesArray = [[[CoreDataManagerX sharedInstance] managedObjectContext] executeFetchRequest:issues error:nil];
//    NSLog(@"%@",[(Trade *)issuesArray[0] series]);
}
- (NSApplicationTerminateReply)applicationShouldTerminate:(NSApplication *)sender
{
    // Save changes in the application's managed object context before the application terminates.
    
    if (![[CoreDataManagerX sharedInstance] managedObjectContext]) {
        return NSTerminateNow;
    }
    
    if (![[[CoreDataManagerX sharedInstance] managedObjectContext] commitEditing]) {
        NSLog(@"%@:%@ unable to commit editing to terminate", [self class], NSStringFromSelector(_cmd));
        return NSTerminateCancel;
    }
    
    if (![[[CoreDataManagerX sharedInstance] managedObjectContext] hasChanges]) {
        return NSTerminateNow;
    }
    
    NSError *error = nil;
    if (![[[CoreDataManagerX sharedInstance] managedObjectContext] save:&error]) {
        
        // Customize this code block to include application-specific recovery steps.
        BOOL result = [sender presentError:error];
        if (result) {
            return NSTerminateCancel;
        }
        
        NSString *question = NSLocalizedString(@"Could not save changes while quitting. Quit anyway?", @"Quit without saves error question message");
        NSString *info = NSLocalizedString(@"Quitting now will lose any changes you have made since the last successful save", @"Quit without saves error question info");
        NSString *quitButton = NSLocalizedString(@"Quit anyway", @"Quit anyway button title");
        NSString *cancelButton = NSLocalizedString(@"Cancel", @"Cancel button title");
        NSAlert *alert = [[NSAlert alloc] init];
        [alert setMessageText:question];
        [alert setInformativeText:info];
        [alert addButtonWithTitle:quitButton];
        [alert addButtonWithTitle:cancelButton];
        
        NSInteger answer = [alert runModal];
        
        if (answer == NSAlertAlternateReturn) {
            return NSTerminateCancel;
        }
    }
    return NSTerminateNow;
}

@end
