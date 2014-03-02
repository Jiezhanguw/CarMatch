//
//  HelpViewController.m
//  CarMatch
//
//  Created by Jie Zhang on 3/2/2014.
//  Copyright (c) 2014 Jie Zhang. All rights reserved.
//

#import "HelpViewController.h"

@interface HelpViewController ()

@end

@implementation HelpViewController

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
	
    UITextView *helpTextView = [[UITextView alloc]initWithFrame:CGRectMake(0, 65, self.view.frame.size.width, self.view.frame.size.height)];
    NSString *textStr = @"Model:\n4WD/4X4 = Four-wheel drive; \nAWD = All-wheel drive; \nFFV = Flexible-fuel vehicle. \n\nTransmission:\nA = Automatic; \nAM = Automated manual; \nAS = Automatic with select shift; \nAV = Continuously variable; \nM = Manual. \n\nFuel Type:\nX = Regular gasoline; \nZ = Premium gasoline; \nD = Diesel; \nE = Ethanol (E85). \n\nFuel Consumption:\nFuel consumption ratings are shown in litres per 100 kilometres (L/100 km) and in miles per imperial gallon (mi/gal). \nFuel (L) / Year: Estimated annual fuel use is based on 20 000 km driven and a combined rating of 55 percent city and 45 percent highway.\n\nCO2 Emissions (g/km),Estimated tailpipe carbon dioxide emissions (in grams per kilometre) are based on fuel type and the combined fuel consumption rating.\nTo convert the annual CO2 values used in previous years to g/km, divide the kilograms per year by 20.";
    [helpTextView setText:textStr];
    helpTextView.editable = FALSE;
    [helpTextView setFont:[UIFont systemFontOfSize:16.f]];
    [self.view addSubview:helpTextView];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
