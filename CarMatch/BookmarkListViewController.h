//
//  BookmarkListViewController.h
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
#import "CarListViewCell.h"
#import "CarDetailsViewController.h"

@interface BookmarkListViewController : UITableViewController<MFMailComposeViewControllerDelegate,MFMessageComposeViewControllerDelegate>
@property(strong, nonatomic) Globals *globals;
@property(strong, nonatomic) UIPopoverController *popOverController;


@end
