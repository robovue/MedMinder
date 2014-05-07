//
//  History.h
//  MedMinder
//
//  Created by Leo Chan on 3/5/14.
//  Copyright (c) 2014 Leo Chan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Prescription, Schedule;

@interface History : NSManagedObject

@property (nonatomic, retain) NSString * notes;
@property (nonatomic, retain) NSDate * timeTaken;
@property (nonatomic, retain) Prescription *whichPrescription;
@property (nonatomic, retain) Schedule *whichSchedule;

@end
