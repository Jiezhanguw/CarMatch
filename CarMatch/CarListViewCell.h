//
//  CarListViewCell.h
//  CarMatch
//
//  Created by Jie Zhang on 3/1/2014.
//  Copyright (c) 2014 Jie Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CarListViewCell : UITableViewCell

//image view for car image
@property(nonatomic,strong)UIImageView *carImageView;
//label for car's year
@property(nonatomic,strong)UILabel *carYearLabel;
//label for car's brand
@property(nonatomic,strong)UILabel *carBrandLabel;
//label for car's model
@property(nonatomic,strong)UILabel *carModelLabel;
//label for car's class
@property(nonatomic,strong)UILabel *carClassLabel;
//label for emission value
@property(nonatomic,strong)UILabel *emissionLabel;
//label for fuel consumption
@property(nonatomic,strong)UILabel *fuelLabel;
@end
