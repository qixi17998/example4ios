//
//  MasterViewController.h
//  example4ios
//
//  Created by 宣 云辉 on 11-10-31.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DetailViewController;

@interface MasterViewController : UITableViewController {
}

@property (strong, nonatomic) DetailViewController *detailViewController;

@end
