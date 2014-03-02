//
//  CarListViewCell.m
//  CarMatch
//
//  Created by Jie Zhang on 3/1/2014.
//  Copyright (c) 2014 Jie Zhang. All rights reserved.
//

#import "CarListViewCell.h"

#define CELL_HEIGHT 100

@implementation CarListViewCell
@synthesize carImageView;
@synthesize carYearLabel;
@synthesize carBrandLabel;
@synthesize carModelLabel;
@synthesize carClassLabel;
@synthesize emissionLabel;
@synthesize fuelLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self setupView];
    }
    return self;
}

//init cell's subviews
-(void)setupView{
    //init car image view
    carImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, CELL_HEIGHT,CELL_HEIGHT)];
    [carImageView setContentMode:UIViewContentModeScaleToFill];
    [self addSubview:carImageView];
    
    //init car year label
    carYearLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(carImageView.frame), carImageView.frame.origin.y, carImageView.frame.size.width, carImageView.frame.size.height/4)];
    [carYearLabel setText:@"Year"];
    [carYearLabel setFont:[UIFont systemFontOfSize:12.0f]];
    [self addSubview:carYearLabel];
    
    //init car brand label
    carBrandLabel = [[UILabel alloc]initWithFrame:CGRectMake(carYearLabel.frame.origin.x, CGRectGetMaxY(carYearLabel.frame), carYearLabel.frame.size.width, carYearLabel.frame.size.height)];
    [carBrandLabel setText:@"Brand"];
    [carBrandLabel setFont:[UIFont systemFontOfSize:12.0f]];
    [self addSubview:carBrandLabel];
    
    //init car model label
    carModelLabel = [[UILabel alloc]initWithFrame:CGRectMake(carBrandLabel.frame.origin.x, CGRectGetMaxY(carBrandLabel.frame), carBrandLabel.frame.size.width, carBrandLabel.frame.size.height)];
    [carModelLabel setText:@"Model"];
    [carModelLabel setFont:[UIFont systemFontOfSize:12.0f]];
    [self addSubview:carModelLabel];
    
    //init car class label
    carClassLabel = [[UILabel alloc]initWithFrame:CGRectMake(carModelLabel.frame.origin.x, CGRectGetMaxY(carModelLabel.frame), carModelLabel.frame.size.width, carModelLabel.frame.size.height)];
    [carClassLabel setText:@"Class"];
    [carClassLabel setFont:[UIFont systemFontOfSize:12.0f]];
    [self addSubview:carClassLabel];
    
    //init emission label
    emissionLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(carYearLabel.frame), CELL_HEIGHT/4, CELL_HEIGHT/2,CELL_HEIGHT/2)];
    [emissionLabel setText:@"Em"];
    [self addSubview:emissionLabel];
    
    //init fuel label
    fuelLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(emissionLabel.frame), CELL_HEIGHT/4,self.frame.size.width - CGRectGetMaxX(emissionLabel.frame),CELL_HEIGHT/2)];
    [fuelLabel setText:@"Fuel"];
    [fuelLabel setTextAlignment:NSTextAlignmentCenter];
    [self addSubview:fuelLabel];
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
