//
//  CoreDataManagerX.h
//
//  Created by Frank Michael on 5/20/14.
//  Copyright (c) 2014 Frank Michael Sanchez. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CoreDataManagerX : NSObject

+ (id)sharedInstance;
- (void)saveContext;

@property (nonatomic) NSManagedObjectContext *managedObjectContext;

@end
