//
//  NewComicWindow.m
//  Long Box
//
//  Created by Frank Michael on 5/27/14.
//  Copyright (c) 2014 Frank Michael Sanchez. All rights reserved.
//

#import "NewComicWindow.h"
#import "CoreDataManagerX.h"
#import "Issue.h"
#import "Publisher.h"
#import "Series.h"
#import "Trade.h"

@interface NewComicWindow () <NSComboBoxDataSource,NSComboBoxDelegate,NSTokenFieldDelegate>{

}
@property (nonatomic) IBOutlet NSArrayController *seriesController;
@property (nonatomic) IBOutlet NSArrayController *publisherController;
@property (nonatomic) IBOutlet NSTextField *issueNumber;
@property (nonatomic) IBOutlet NSTextField *publishDate;
@property (nonatomic) IBOutlet NSButton *variantCheck;
@property (nonatomic) IBOutlet NSComboBox *seriesBox;
@property (nonatomic) IBOutlet NSComboBox *publisherBox;
@property (nonatomic) IBOutlet NSTextView *notesField;
@property (nonatomic) IBOutlet NSTextField *tpbTitleField;
@property (nonatomic) IBOutlet NSTabView *tabView;

- (IBAction)cancelNew:(id)sender;
- (IBAction)saveComic:(id)sender;
- (IBAction)addSecondComic:(id)sender;

@end

@implementation NewComicWindow

- (id)initWithWindowNibName:(NSString *)windowNibName{
    self = [super initWithWindowNibName:windowNibName];
    if (self){
        _managedObjectContext = [[CoreDataManagerX sharedInstance] managedObjectContext];
    }
    return self;
}
- (void)windowDidLoad{
    [super windowDidLoad];    

}
#pragma mark - Class
- (void)clearUI{
    _issueNumber.stringValue = @"";
    _seriesBox.stringValue = @"";
    _publisherBox.stringValue = @"";
    [_seriesController setSelectionIndex:-1];
    [_publisherController setSelectionIndex:-1];
    _publishDate.stringValue = @"";
    _notesField.string = @"";
    _tpbTitleField.stringValue = @"";
}
- (void)updatePublisher{
    if ([_seriesBox indexOfSelectedItem] != -1){
        [_seriesController setSelectionIndex:[_seriesBox indexOfSelectedItem]];
        Series *selectedSeries = [[_seriesController selectedObjects] lastObject];
        [_publisherController setSelectedObjects:@[selectedSeries.publisher]];
        [_publisherBox setStringValue:selectedSeries.publisher.name];
    }else{
        [_seriesController setSelectionIndex:-1];
        [_publisherController setSelectionIndex:-1];
        [_publisherBox setStringValue:@""];
    }
}
- (void)saveComicData{
    NSManagedObjectContext *context = [[CoreDataManagerX sharedInstance] managedObjectContext];
    NSString *publisher = _publisherBox.stringValue;
    NSString *seriesString = _seriesBox.stringValue;
    
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

    if ([_tabView.selectedTabViewItem.identifier isEqualToString:@"1"]){
        Issue *newIssue = [NSEntityDescription insertNewObjectForEntityForName:@"Issue" inManagedObjectContext:context];
        newIssue.issueNumber = _issueNumber.stringValue;
        newIssue.publishDate = _publishDate.stringValue;
        newIssue.series = series;
        newIssue.note = _notesField.string;
        newIssue.variant = @(_variantCheck.state);
    }else{
        Trade *newTrade = [NSEntityDescription insertNewObjectForEntityForName:@"Trade" inManagedObjectContext:context];
        newTrade.title = _tpbTitleField.stringValue;
        newTrade.series = series;
        newTrade.note = _notesField.string;
    }
    
    [[CoreDataManagerX sharedInstance] saveContext];
}
#pragma mark - Class Actions
- (IBAction)saveComic:(id)sender{
    [self saveComicData];
    [self clearUI];
}
- (IBAction)addSecondComic:(id)sender{
    [self saveComicData];
    _issueNumber.stringValue = @"";
    _publishDate.stringValue = @"";
    _tpbTitleField.stringValue = @"";
}
- (IBAction)cancelNew:(id)sender{
    [self clearUI];
    [self.window.sheetParent endSheet:self.window];
}
#pragma mark - NSTextField Delegate
- (void)controlTextDidEndEditing:(NSNotification *)obj{
    if (obj.object == _seriesBox){
        [self updatePublisher];
    }else if (obj.object == _publisherBox){
        if ([_publisherBox indexOfSelectedItem] != -1){
            [_publisherController setSelectionIndex:_publisherBox.indexOfSelectedItem];
        }else{
            [_publisherController setSelectionIndex:-1];
        }
    }
}
- (void)controlTextDidChange:(NSNotification *)obj{
    if (obj.object == _seriesBox){
        [self updatePublisher];
    }else if (obj.object == _publisherBox){
        if ([_publisherBox indexOfSelectedItem] != -1){
            [_publisherController setSelectionIndex:_publisherBox.indexOfSelectedItem];
        }else{
            [_publisherController setSelectionIndex:-1];
        }
    }
}
- (void)comboBoxSelectionDidChange:(NSNotification *)notification{
    if (notification.object == _seriesBox){
        [self updatePublisher];
    }else{
        [_publisherController setSelectionIndex:_publisherBox.indexOfSelectedItem];
    }
}
@end
