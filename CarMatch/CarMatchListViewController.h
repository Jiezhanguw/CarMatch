//
//  CarMatchListViewController.h
//  CarMatch
//
//  Created by Jie Zhang on 3/2/2014.
//  Copyright (c) 2014 Jie Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CarMatchListCell.h"
#import "CarDetailsViewController.h"
#import "Globals.h"
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>
#import <MessageUI/MFMessageComposeViewController.h>

@interface CarMatchListViewController : UITableViewController<MFMailComposeViewControllerDelegate,MFMessageComposeViewControllerDelegate>

@property(nonatomic,strong)NSArray *carMatchListData;
@property(nonatomic,strong)Globals *globals;
@property(nonatomic,strong)UIPopoverController *popOverController;
@end
