//
//  CarDetailsViewController.h
//  CarMatch
//
//  Created by Jie Zhang on 3/2/2014.
//  Copyright (c) 2014 Jie Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CarDetailsViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIImageView *carImageView;
@property(strong, nonatomic) NSDictionary *carDict;
@end
