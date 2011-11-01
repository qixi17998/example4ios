//
//  DetailViewController.h
//  example4ios
//
//  Created by 宣 云辉 on 11-10-31.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController <UISplitViewControllerDelegate> {
    UISlider *slider;
    UILabel *label;
}

@property (strong, nonatomic) id detailItem;

@property (strong, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@property (retain, nonatomic) IBOutlet UISlider *slider;

@property (retain,nonatomic) IBOutlet UILabel *label;

- (IBAction)sliderChange:(id)sender;

@end
