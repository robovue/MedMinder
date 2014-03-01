//
//  History.h
//  MedMinder
//
//  Created by Leo Chan on 2/28/14.
//  Copyright (c) 2014 Leo Chan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Prescription;

@interface History : NSManagedObject

@property (nonatomic, retain) NSDate * timeTaken;
@property (nonatomic, retain) NSString * notes;
@property (nonatomic, retain) Prescription *whichPrescription;

@end
