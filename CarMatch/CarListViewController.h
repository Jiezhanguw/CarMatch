//
//  CarListViewController.h
//  CarMatch
//
//  Created by Jie Zhang on 3/1/2014.
//  Copyright (c) 2014 Jie Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CarListViewCell.h"
#import "Globals.h"
#import "CarDetailsViewController.h"

@interface CarListViewController : UITableViewController<UIPickerViewDataSource,UIPickerViewDelegate>
@property(nonatomic,strong)UIPopoverController *popoverController;
@end
