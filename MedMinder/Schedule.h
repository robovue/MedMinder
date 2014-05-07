//
//  Schedule.h
//  MedMinder
//
//  Created by Leo Chan on 3/5/14.
//  Copyright (c) 2014 Leo Chan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class History, Prescription;

@interface Schedule : NSManagedObject

@property (nonatomic, retain) NSString * sortBy;
@property (nonatomic, retain) NSDate * time;
@property (nonatomic, retain) NSString * timeOfDay;
@property (nonatomic, retain) NSSet *whichPrescription;
@property (nonatomic, retain) NSSet *whenTaken;
@end

@interface Schedule (CoreDataGeneratedAccessors)

- (void)addWhichPrescriptionObject:(Prescription *)value;
- (void)removeWhichPrescriptionObject:(Prescription *)value;
- (void)addWhichPrescription:(NSSet *)values;
- (void)removeWhichPrescription:(NSSet *)values;

- (void)addWhenTakenObject:(History *)value;
- (void)removeWhenTakenObject:(History *)value;
- (void)addWhenTaken:(NSSet *)values;
- (void)removeWhenTaken:(NSSet *)values;

@end
