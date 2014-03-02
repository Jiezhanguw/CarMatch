//
//  CarMatchListCell.h
//  CarMatch
//
//  Created by Jie Zhang on 3/2/2014.
//  Copyright (c) 2014 Jie Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CarMatchListCell : UITableViewCell
@property(nonatomic,strong)UIImageView *carImageView;
@property(nonatomic,strong)UILabel *yearLabel;
@property(nonatomic,strong)UILabel *manufacLabel;
@property(nonatomic,strong)UILabel *modelLabel;
@property(nonatomic,strong)UILabel *carClassLabel;
@property(nonatomic,strong)UILabel *engineSizeLabel;
@property(nonatomic,strong)UILabel *cylindersLabel;
@property(nonatomic,strong)UILabel *transmissionLabel;
@property(nonatomic,strong)UILabel *fuelTypeLabel;
@property(nonatomic,strong)UILabel *fuelConSumpLabel;
@property(nonatomic,strong)UILabel *fuelPerYearLabel;
@property(nonatomic,strong)UILabel *emissionLabel;
@property(nonatomic,strong)UIButton *shareButton;
@property(nonatomic,strong)UIButton *bookmarkButton;


@end
