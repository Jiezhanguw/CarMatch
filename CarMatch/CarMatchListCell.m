//
//  CarMatchListCell.m
//  CarMatch
//
//  Created by Jie Zhang on 3/2/2014.
//  Copyright (c) 2014 Jie Zhang. All rights reserved.
//

#import "CarMatchListCell.h"
#define LABEL_HEIGHT 25
#define BUTTON_WIDTH 50

@implementation CarMatchListCell
@synthesize carImageView;
@synthesize yearLabel;
@synthesize manufacLabel;
@synthesize modelLabel;
@synthesize carClassLabel;
@synthesize engineSizeLabel;
@synthesize cylindersLabel;
@synthesize transmissionLabel;
@synthesize fuelTypeLabel;
@synthesize fuelConSumpLabel;
@synthesize fuelPerYearLabel;
@synthesize emissionLabel;
@synthesize shareButton;
@synthesize bookmarkButton;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self setupView];
    }
    return self;
}

-(void)setupView{
    carImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 150)];
    [carImageView setContentMode:UIViewContentModeScaleAspectFit];
    [self addSubview:carImageView];
    
    yearLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(carImageView.frame), self.frame.size.width, LABEL_HEIGHT)];
    [self addSubview:yearLabel];
    
    manufacLabel = [[UILabel alloc]initWithFrame:CGRectMake(yearLabel.frame.origin.x, CGRectGetMaxY(yearLabel.frame), yearLabel.frame.size.width, LABEL_HEIGHT)];
    [self addSubview:manufacLabel];
    
    modelLabel = [[UILabel alloc]initWithFrame:CGRectMake(yearLabel.frame.origin.x, CGRectGetMaxY(manufacLabel.frame), yearLabel.frame.size.width, LABEL_HEIGHT)];
    [self addSubview:modelLabel];
    
    carClassLabel = [[UILabel alloc]initWithFrame:CGRectMake(yearLabel.frame.origin.x, CGRectGetMaxY(modelLabel.frame), yearLabel.frame.size.width, LABEL_HEIGHT)];
    [self addSubview:carClassLabel];
    
    engineSizeLabel = [[UILabel alloc]initWithFrame:CGRectMake(yearLabel.frame.origin.x, CGRectGetMaxY(carClassLabel.frame), yearLabel.frame.size.width, LABEL_HEIGHT)];
    [self addSubview:engineSizeLabel];
    
    cylindersLabel = [[UILabel alloc]initWithFrame:CGRectMake(yearLabel.frame.origin.x, CGRectGetMaxY(engineSizeLabel.frame), yearLabel.frame.size.width, LABEL_HEIGHT)];
    [self addSubview:cylindersLabel];
    
    transmissionLabel = [[UILabel alloc]initWithFrame:CGRectMake(yearLabel.frame.origin.x, CGRectGetMaxY(cylindersLabel.frame), yearLabel.frame.size.width, LABEL_HEIGHT)];
    [self addSubview:transmissionLabel];
    
    fuelTypeLabel = [[UILabel alloc]initWithFrame:CGRectMake(yearLabel.frame.origin.x, CGRectGetMaxY(transmissionLabel.frame), yearLabel.frame.size.width, LABEL_HEIGHT)];
    [self addSubview:fuelTypeLabel];
    
    fuelConSumpLabel = [[UILabel alloc]initWithFrame:CGRectMake(yearLabel.frame.origin.x, CGRectGetMaxY(fuelTypeLabel.frame), yearLabel.frame.size.width, LABEL_HEIGHT*2)];
    fuelConSumpLabel.numberOfLines = 0;
    [self addSubview:fuelConSumpLabel];
    
    fuelPerYearLabel = [[UILabel alloc]initWithFrame:CGRectMake(yearLabel.frame.origin.x, CGRectGetMaxY(fuelConSumpLabel.frame), yearLabel.frame.size.width, LABEL_HEIGHT)];
    [self addSubview:fuelPerYearLabel];
    
    emissionLabel = [[UILabel alloc]initWithFrame:CGRectMake(yearLabel.frame.origin.x, CGRectGetMaxY(fuelPerYearLabel.frame), yearLabel.frame.size.width, LABEL_HEIGHT)];
    [self addSubview:emissionLabel];
    
    shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [shareButton setBackgroundImage:[UIImage imageNamed:@"share.png"] forState:UIControlStateNormal];
    [shareButton setFrame:CGRectMake(100, CGRectGetMaxY(emissionLabel.frame), BUTTON_WIDTH, BUTTON_WIDTH)];
    [shareButton setContentMode:UIViewContentModeScaleToFill];
    [self addSubview:shareButton];

    //init bookmark button
    bookmarkButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [bookmarkButton setBackgroundImage:[UIImage imageNamed:@"bookmarkunselected.png"] forState:UIControlStateNormal];
    [bookmarkButton setBackgroundImage:[UIImage imageNamed:@"bookmarkselected.png"] forState:UIControlStateSelected];
    [bookmarkButton setFrame:CGRectMake(CGRectGetMaxX(shareButton.frame)+30, shareButton.frame.origin.y, BUTTON_WIDTH, BUTTON_WIDTH)];
    [bookmarkButton setContentMode:UIViewContentModeScaleToFill];
    [self addSubview:bookmarkButton];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
