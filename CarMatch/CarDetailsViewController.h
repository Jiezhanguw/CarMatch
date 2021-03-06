//
//  CarDetailsViewController.h
//  CarMatch
//
//  Created by Jie Zhang on 3/2/2014.
//  Copyright (c) 2014 Jie Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Globals.h"
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>
#import <MessageUI/MFMessageComposeViewController.h>

@interface CarDetailsViewController : UIViewController<MFMailComposeViewControllerDelegate,MFMessageComposeViewControllerDelegate>
@property (strong, nonatomic) IBOutlet UIImageView *carImageView;
@property(strong, nonatomic) NSDictionary *carDict;
@property(strong, nonatomic) Globals *globals;
@property(strong, nonatomic) UIPopoverController *popOverController;
@property(nonatomic)BOOL isBookmark;
@end
