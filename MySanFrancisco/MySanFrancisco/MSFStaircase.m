//
//  MSFStaircase.m
//  MySanFrancisco
//
//  Created by Jordan Zucker on 8/16/16.
//  Copyright © 2016 Jordan Zucker. All rights reserved.
//

#import "MSFStaircase.h"

@implementation MSFStaircase

#pragma mark - Constructors

- (instancetype)initWithFormalName:(NSString *)name location:(CLLocationCoordinate2D)location {
    NSMutableDictionary *value = [@{
                                    @"formalName": name,
                                    @"latitude": @(location.latitude),
                                    @"longitude": @(location.longitude),
                                    } mutableCopy];
    self = [super initWithValue:value.copy];
    return self;
}

+ (instancetype)staircaseWithFormalName:(NSString *)name location:(CLLocationCoordinate2D)location {
    return [[self alloc] initWithFormalName:name location:location];
}

#pragma mark - RLMObject

+ (nullable NSDictionary *)defaultPropertyValues {
    return @{
             @"creationDate": [NSDate date],
             @"identifier": [NSUUID UUID].UUIDString,
             };
}

+ (nullable NSString *)primaryKey {
    return @"identifier";
}

+ (nullable NSArray<NSString *> *)ignoredProperties {
    return @[
             @"location",
             ];
}

+ (NSArray *)indexedProperties {
    return @[
             @"creationDate",
             ];
}

+ (NSArray<NSString *> *)requiredProperties {
    return @[
             @"identifier",
             @"creationDate",
             @"latitude",
             @"longitude",
             ];
}

#pragma mark - Convenience

- (CLLocationCoordinate2D)location {
    return CLLocationCoordinate2DMake(self.latitude, self.longitude);
}

@end
