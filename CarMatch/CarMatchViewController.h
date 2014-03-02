//
//  CarMatchViewController.h
//  CarMatch
//
//  Created by Jie Zhang on 3/2/2014.
//  Copyright (c) 2014 Jie Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CarMatchListViewController.h"
#import "Globals.h"
@interface CarMatchViewController : UIViewController<UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate>
//@property (strong, nonatomic) IBOutlet UITextView *titleTextView;
@property (strong, nonatomic) IBOutlet UITextField *cityTextField;
@property (strong, nonatomic) IBOutlet UITextField *HWYTextField;
//@property (strong, nonatomic) IBOutlet UIButton *submitButton;
//@property (strong, nonatomic) IBOutlet UIButton *vihicleClassButton;
//- (IBAction)selectVihicleClass:(id)sender;
//- (IBAction)startToMatch:(id)sender;

@property(nonatomic,strong)Globals *globals;
@property(nonatomic,strong)UIPopoverController *popoverController;
@end
