//
//  EditIssueWindow.m
//  Long Box
//
//  Created by Frank Michael on 9/3/14.
//  Copyright (c) 2014 Frank Michael Sanchez. All rights reserved.
//

#import "EditIssueWindow.h"
#import "CoreDataManagerX.h"
#import "Publisher.h"
#import "StoryArc.h"
#import "Series.h"

@interface EditIssueWindow ()

@property (nonatomic) IBOutlet NSTextField *issueNumber;
@property (nonatomic) IBOutlet NSTextField *publishDate;
@property (nonatomic) IBOutlet NSButton *variantCheck;
@property (nonatomic) IBOutlet NSComboBox *seriesBox;
@property (nonatomic) IBOutlet NSComboBox *publisherBox;
@property (nonatomic) IBOutlet NSComboBox *storyArcBox;
@property (nonatomic) IBOutlet NSTextView *notesField;
@property (nonatomic) IBOutlet NSPopUpButton *conditionOptions;
@property (nonatomic) NSArray *conditions;

- (IBAction)updateIssue:(id)sender;

@end

@implementation EditIssueWindow

- (id)initWithWindowNibName:(NSString *)windowNibName{
    self = [super initWithWindowNibName:windowNibName];
    if (self){
        _managedObjectContext = [[CoreDataManagerX sharedInstance] managedObjectContext];
    }
    return self;
}
- (void)windowDidLoad{
    [super windowDidLoad];
    
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
}
#pragma mark - Class Actions
- (IBAction)updateIssue:(id)sender{
    self.editingIssue.issueNumber = self.issueNumber.stringValue;
    self.editingIssue.publishDate = self.publishDate.stringValue;
    self.editingIssue.variant = @(self.variantCheck.state);
    self.editingIssue.condition = [self.conditionOptions titleOfSelectedItem];
    
    NSManagedObjectContext *context = [[CoreDataManagerX sharedInstance] managedObjectContext];
    NSString *publisher = _publisherBox.stringValue;
    NSString *seriesString = _seriesBox.stringValue;
    NSString *storyString = _storyArcBox.stringValue;

    NSFetchRequest *pubFetch = [NSFetchRequest fetchRequestWithEntityName:@"Publisher"];
    pubFetch.predicate = [NSPredicate predicateWithFormat:@"name LIKE[cd] %@" argumentArray:@[publisher]];
    NSArray *pubFound = [context executeFetchRequest:pubFetch error:nil];
    Publisher *pub;
    if (pubFound.count > 0){
        pub = pubFound.lastObject;
    }else{
        pub = [NSEntityDescription insertNewObjectForEntityForName:@"Publisher" inManagedObjectContext:context];
        pub.name = publisher;
    }
    NSFetchRequest *seriesFetch = [NSFetchRequest fetchRequestWithEntityName:@"Series"];
    seriesFetch.predicate = [NSPredicate predicateWithFormat:@"title LIKE[cd] %@" argumentArray:@[seriesString]];
    NSArray *seriesFound = [context executeFetchRequest:seriesFetch error:nil];
    Series *series;
    if (seriesFound.count > 0){
        series = seriesFound.lastObject;
    }else{
        series = [NSEntityDescription insertNewObjectForEntityForName:@"Series" inManagedObjectContext:context];
        series.title = seriesString;
        series.publisher = pub;
    }
    
    StoryArc *storyArc = nil;
    if (storyString.length > 0){
        NSFetchRequest *storyFetch = [NSFetchRequest fetchRequestWithEntityName:@"StoryArc"];
        storyFetch.predicate = [NSPredicate predicateWithFormat:@"title LIKE[cd] %@" argumentArray:@[storyString]];
        NSArray *storyFound = [context executeFetchRequest:storyFetch error:nil];
        if (storyFound.count > 0){
            storyArc = storyFound.lastObject;
        }else{
            storyArc = [NSEntityDescription insertNewObjectForEntityForName:@"StoryArc" inManagedObjectContext:context];
            storyArc.title = storyString;
            storyArc.series = series;
        }
    }
    
    self.editingIssue.series = series;
    [[CoreDataManagerX sharedInstance] saveContext];
}

@end
