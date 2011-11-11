//
//  AppDelegate.m
//  example4ios
//
//  Created by 宣 云辉 on 11-10-31.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"
#import "Building.h"
#import <sqlite3.h>

@implementation AppDelegate

@synthesize window = _window;
@synthesize databaseName, databasePath, items;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        UISplitViewController *splitViewController = (UISplitViewController *)self.window.rootViewController;
        UINavigationController *navigationController = [splitViewController.viewControllers lastObject];
        splitViewController.delegate = (id)navigationController.topViewController;
    }
    
    databaseName = @"building.sqlite";
    NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDir = [documentPaths objectAtIndex:0];
    databasePath = [documentDir stringByAppendingPathComponent:databaseName];
    [self checkAndCreateDatabase];
    [self readBuildingsFromDatabase];
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

- (void) checkAndCreateDatabase{
    BOOL success;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    success = [fileManager fileExistsAtPath:databasePath];
    if (success) return;
    NSString *databasePathFromApp = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:databaseName];
    [fileManager copyItemAtPath:databasePathFromApp toPath:databasePath error:nil];
}

- (void) readBuildingsFromDatabase{
    sqlite3 *database;
    items = [[NSMutableArray alloc]init];
    if (sqlite3_open([databasePath UTF8String], &database)==SQLITE_OK) {
        const char *sqlStatement = "select * from buildings";
        sqlite3_stmt *compiledStatement;
        if (sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL)==SQLITE_OK) {
            while (sqlite3_step(compiledStatement)==SQLITE_OK) {
                NSMutableString *bUniqueID = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 0)];
                NSMutableString *bName = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 1)];
                NSMutableString *bAddress = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 2)];
                
                // Latitude Field
                NSMutableString *bLatitude = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 3)];
                
                // Longitude Field
                NSMutableString *bLongitude = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 4)];
                
                // Type Field
				NSMutableString *bType = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 5)];
                
                // This is to remove the double quotes at the beginning and end of line
                NSString *UniqueID = [bUniqueID substringWithRange:NSMakeRange(1, bUniqueID.length -2)];
                NSString *name =  [bName substringWithRange:NSMakeRange(1, bName.length -2)];
                NSString *address = [bAddress substringWithRange:NSMakeRange(1, bAddress.length -2)];
                NSString *latitude =  [bLatitude substringWithRange:NSMakeRange(1, bLatitude.length -2)];
                NSString *longitude =  [bLongitude substringWithRange:NSMakeRange(1, bLongitude.length -2)];
                NSString *type =  [bType substringWithRange:NSMakeRange(1, bType.length -2)];
                
                
                // Important To Print Out Values To Ensure Correctness
                // Debugging Step 1 
                
                // My Error 1
                // %g is for type double
                NSLog(@"Name: %@ Latitude: %g Longitude: %g", name, latitude, longitude);
                
                // Corect Output
                // I converted to double since CLLocationCoordinates2D are of type double
                NSLog(@"Name: %@ Latitude: %g Longitude: %g", name, [latitude doubleValue], [longitude doubleValue]);
                
                
                
                // Create new building object and then add it to the items array. 
                [items addObject:[Building buildingWithID:UniqueID name:name address:address latitude:latitude type:type]];
            }
        }
        sqlite3_finalize(compiledStatement);
    }
    for (Building *theBuilding in items) {
        NSLog(@"Name: %@ Latitude: %g Longitude: %g", theBuilding.name, [theBuilding.latitude doubleValue], [theBuilding.longitude doubleValue]);
    }
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    NSArray *sortedArray = [items sortedArrayUsingDescriptors:sortDescriptors];
    self.items = [sortedArray mutableCopy];
    sqlite3_close(database);
}

@end
