//
//  MSFStaircase.h
//  MySanFrancisco
//
//  Created by Jordan Zucker on 8/16/16.
//  Copyright © 2016 Jordan Zucker. All rights reserved.
//

#import <Realm/Realm.h>
#import <CoreLocation/CoreLocation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MSFStaircase : RLMObject

// stored properties
@property NSString *formalName;
@property NSString *nickname;
@property double latitude;
@property double longitude;
@property NSDate *creationDate;
@property NSString *identifier;
@property NSString *info;

// convenience
@property (nonatomic, assign, readonly) CLLocationCoordinate2D location;

// constructors
- (instancetype)initWithFormalName:(nullable NSString *)name location:(CLLocationCoordinate2D)location;
+ (instancetype)staircaseWithFormalName:(nullable NSString *)name location:(CLLocationCoordinate2D)location;

@end

NS_ASSUME_NONNULL_END
