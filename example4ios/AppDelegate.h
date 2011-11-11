//
//  AppDelegate.h
//  example4ios
//
//  Created by 宣 云辉 on 11-10-31.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>{
    NSString *databaseName;
    NSString *databasePath;
    NSMutableArray *items;
}

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, copy) NSString *databaseName, *databasePath;
@property (nonatomic, retain) NSMutableArray *items;

- (void)checkAndCreateDatabase;
- (void)readBuildingsFromDatabase;

@end
