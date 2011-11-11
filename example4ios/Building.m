//
//  Building.m
//  example4ios
//
//  Created by 云辉 宣 on 11-11-10.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "Building.h"

@implementation Building

@synthesize UniqueID,name, address, latitude, longitude, type;
    
+ (id)buildingWithID:(NSString *)UniqueID name:(NSString *)name address:(NSString *)address latitude:(NSString *)latitude longitude:(NSString *)longitude type:(NSString *)type
{
    
    Building *newBuilding = [[self alloc] init];
    newBuilding.UniqueID = UniqueID;
    newBuilding.name = name;
    newBuilding.address = address;
    newBuilding.latitude = latitude;
    newBuilding.longitude = longitude;
    newBuilding.type = type;
    return newBuilding;
}

@end
