//
//  CarDetailsViewController.m
//  CarMatch
//
//  Created by Jie Zhang on 3/2/2014.
//  Copyright (c) 2014 Jie Zhang. All rights reserved.
//

#import "CarDetailsViewController.h"
#define LABEL_HEIGHT 25

@interface CarDetailsViewController ()
@end

@implementation CarDetailsViewController
@synthesize carDict;
@synthesize carImageView;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self setupView];
    
    
}

-(void)setupView{
    [carImageView setImage:[UIImage imageNamed:@"test.jpeg"]];
    [carImageView setContentMode:UIViewContentModeScaleAspectFit];
    
    UILabel *yearLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(carImageView.frame), self.view.frame.size.width, LABEL_HEIGHT)];
    [yearLabel setText:[NSString stringWithFormat:@"Year: %@",[carDict objectForKey:@"year"]]];
    [self.view addSubview:yearLabel];
    
    UILabel *manufacLabel = [[UILabel alloc]initWithFrame:CGRectMake(yearLabel.frame.origin.x, CGRectGetMaxY(yearLabel.frame), yearLabel.frame.size.width, LABEL_HEIGHT)];
    [manufacLabel setText:[NSString stringWithFormat:@"Manufacturer: %@",[carDict objectForKey:@"MANUFACTURER"]]];
    [self.view addSubview:manufacLabel];
    
    UILabel *modelLabel = [[UILabel alloc]initWithFrame:CGRectMake(yearLabel.frame.origin.x, CGRectGetMaxY(manufacLabel.frame), yearLabel.frame.size.width, LABEL_HEIGHT)];
    [modelLabel setText:[NSString stringWithFormat:@"Model: %@",[carDict objectForKey:@"MODEL"]]];
    [self.view addSubview:modelLabel];
    
    UILabel *carClassLabel = [[UILabel alloc]initWithFrame:CGRectMake(yearLabel.frame.origin.x, CGRectGetMaxY(modelLabel.frame), yearLabel.frame.size.width, LABEL_HEIGHT)];
    [carClassLabel setText:[NSString stringWithFormat:@"Vehicle Class: %@",[carDict objectForKey:@"VEHICLE CLASS"]]];
    [self.view addSubview:carClassLabel];
    
    UILabel *engineSizeLabel = [[UILabel alloc]initWithFrame:CGRectMake(yearLabel.frame.origin.x, CGRectGetMaxY(carClassLabel.frame), yearLabel.frame.size.width, LABEL_HEIGHT)];
    [engineSizeLabel setText:[NSString stringWithFormat:@"Engine Size: %@",[carDict objectForKey:@"ENGINE SIZE"]]];
    [self.view addSubview:engineSizeLabel];
    
    UILabel *cylindersLabel = [[UILabel alloc]initWithFrame:CGRectMake(yearLabel.frame.origin.x, CGRectGetMaxY(engineSizeLabel.frame), yearLabel.frame.size.width, LABEL_HEIGHT)];
    [cylindersLabel setText:[NSString stringWithFormat:@"Cylinders: %@",[carDict objectForKey:@"CYLINDERS"]]];
    [self.view addSubview:cylindersLabel];
    
    UILabel *transmissionLabel = [[UILabel alloc]initWithFrame:CGRectMake(yearLabel.frame.origin.x, CGRectGetMaxY(cylindersLabel.frame), yearLabel.frame.size.width, LABEL_HEIGHT)];
    [transmissionLabel setText:[NSString stringWithFormat:@"Transmission: %@",[carDict objectForKey:@"TRANSMISSION"]]];
    [self.view addSubview:transmissionLabel];
    
    UILabel *fuelTypeLabel = [[UILabel alloc]initWithFrame:CGRectMake(yearLabel.frame.origin.x, CGRectGetMaxY(transmissionLabel.frame), yearLabel.frame.size.width, LABEL_HEIGHT)];
    [fuelTypeLabel setText:[NSString stringWithFormat:@"Fuel Type: %@",[carDict objectForKey:@"FUEL TYPE"]]];
    [self.view addSubview:fuelTypeLabel];
    
    UILabel *fuelConSumpLabel = [[UILabel alloc]initWithFrame:CGRectMake(yearLabel.frame.origin.x, CGRectGetMaxY(fuelTypeLabel.frame), yearLabel.frame.size.width, LABEL_HEIGHT*2)];
    [fuelConSumpLabel setText:[NSString stringWithFormat:@"Fuel Consumption: City: %@L/100KM / %@MI./GAL., Hwy: %@L/KM / %@MI./GAL.",[carDict objectForKey:@"FUEL CONSUMPTION_CITY (L/100 km)"],[carDict objectForKey:@"FUEL CONSUMPTION_CITY (mi./gal.)"],[carDict objectForKey:@"FUEL CONSUMPTION_HWY (L/100 km)"],[carDict objectForKey:@"FUEL CONSUMPTION_HWY (mi./gal.)"]]];
    fuelConSumpLabel.numberOfLines = 0;
    [self.view addSubview:fuelConSumpLabel];
    
    UILabel *fuelPerYearLabel = [[UILabel alloc]initWithFrame:CGRectMake(yearLabel.frame.origin.x, CGRectGetMaxY(fuelConSumpLabel.frame), yearLabel.frame.size.width, LABEL_HEIGHT)];
    [fuelPerYearLabel setText:[NSString stringWithFormat:@"Fuel: %@L/YEAR",[carDict objectForKey:@"FUEL_(L) / YEAR"]]];
    [self.view addSubview:fuelPerYearLabel];
    
    UILabel *emissionLabel = [[UILabel alloc]initWithFrame:CGRectMake(yearLabel.frame.origin.x, CGRectGetMaxY(fuelPerYearLabel.frame), yearLabel.frame.size.width, LABEL_HEIGHT)];
    [emissionLabel setText:[NSString stringWithFormat:@"CO2 Emission: %@KG/YEAR",[carDict objectForKey:@"CO2 EMISSIONS_(kg) / YEAR"]]];
    [self.view addSubview:emissionLabel];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
