//
//  Prescription.h
//  MedMinder
//
//  Created by Leo Chan on 3/5/14.
//  Copyright (c) 2014 Leo Chan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class History, Schedule;

@interface Prescription : NSManagedObject

@property (nonatomic, retain) NSString * commonName;
@property (nonatomic, retain) NSString * directions;
@property (nonatomic, retain) NSDecimalNumber * dosesPerDay;
@property (nonatomic, retain) NSString * doseStrength;
@property (nonatomic, retain) NSString * drugName;
@property (nonatomic, retain) NSString * imageURL;
@property (nonatomic, retain) NSSet *whenTaken;
@property (nonatomic, retain) NSSet *whenToTake;
@end

@interface Prescription (CoreDataGeneratedAccessors)

- (void)addWhenTakenObject:(History *)value;
- (void)removeWhenTakenObject:(History *)value;
- (void)addWhenTaken:(NSSet *)values;
- (void)removeWhenTaken:(NSSet *)values;

- (void)addWhenToTakeObject:(Schedule *)value;
- (void)removeWhenToTakeObject:(Schedule *)value;
- (void)addWhenToTake:(NSSet *)values;
- (void)removeWhenToTake:(NSSet *)values;

@end
