//
//  Schedule.h
//  MedMinder
//
//  Created by Leo Chan on 2/28/14.
//  Copyright (c) 2014 Leo Chan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Prescription;

@interface Schedule : NSManagedObject

@property (nonatomic, retain) NSString * timeOfDay;
@property (nonatomic, retain) NSDate * time;
@property (nonatomic, retain) NSString * sortBy;
@property (nonatomic, retain) NSSet *whichPrescription;
@end

@interface Schedule (CoreDataGeneratedAccessors)

- (void)addWhichPrescriptionObject:(Prescription *)value;
- (void)removeWhichPrescriptionObject:(Prescription *)value;
- (void)addWhichPrescription:(NSSet *)values;
- (void)removeWhichPrescription:(NSSet *)values;

@end
