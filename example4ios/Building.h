//
//  Building.h
//  example4ios
//
//  Created by 云辉 宣 on 11-11-10.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Building : NSObject {
    NSString *UniqueID;
    NSString *name;
    NSString *address;
    NSString *latitude;
    NSString *longitude;
    NSString *type;
}

@property (nonatomic, copy) NSString *UniqueID, *name, *address, *latitude, *longitude, *type;

+ (id)buildingWithID:(NSString *)UniqueID name:(NSString *)name address:(NSString *)address latitude:(NSString *)latitude type:(NSString *)type;

@end
