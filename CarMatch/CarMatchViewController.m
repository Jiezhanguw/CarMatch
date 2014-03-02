//
//  CarMatchViewController.m
//  CarMatch
//
//  Created by Jie Zhang on 3/2/2014.
//  Copyright (c) 2014 Jie Zhang. All rights reserved.
//

#import "CarMatchViewController.h"

@interface CarMatchViewController ()

@end

@implementation CarMatchViewController{
    UITextView *titleTextView;
    UIPickerView *pickerView;
    NSMutableArray *pickerViewData;
    UIButton *vihicleClassButton;
    UIButton *submitButton;
    UILabel *vehicleClassLabel;
}
//@synthesize titleTextView;
//@synthesize vihicleClassButton;
@synthesize cityTextField;
@synthesize HWYTextField;
@synthesize popoverController;
@synthesize globals;
//@synthesize submitButton;
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
    if (!globals) {
        globals = [Globals instance];
    }
    //init text view
    titleTextView = [[UITextView alloc]initWithFrame:CGRectMake(0, 65, self.view.frame.size.width, 120)];
    [titleTextView setText:@"Please input the vihicle class you like and your estimated driving miles per year in city and highway respectively. We will find the best matches vihicles for you based on the fuel consumption."];
    [titleTextView setFont:[UIFont systemFontOfSize:16.0f]];
    [titleTextView setEditable:FALSE];
    titleTextView.scrollEnabled = FALSE;
    [self.view addSubview:titleTextView];
    
    vehicleClassLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(titleTextView.frame),self.view.frame.size.width, 30)];
    [vehicleClassLabel setTextAlignment:NSTextAlignmentCenter];
    [self.view addSubview:vehicleClassLabel];

    //init vihicle class button
    vihicleClassButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [vihicleClassButton setFrame:CGRectMake(80, CGRectGetMaxY(vehicleClassLabel.frame), self.view.frame.size.width-160, 30)];
    [vihicleClassButton setTitle:@"Choose Vehicle Class" forState:UIControlStateNormal];
    [vihicleClassButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    vihicleClassButton.layer.borderWidth = 1;
    vihicleClassButton.layer.borderColor = [UIColor blackColor].CGColor;
    vihicleClassButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [vihicleClassButton addTarget:self action:@selector(selectVihicleClass:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:vihicleClassButton];
    
    //init submit button
    submitButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [submitButton setFrame:CGRectMake(0, CGRectGetMaxY(HWYTextField.frame)+30, self.view.frame.size.width, 50)];
    [submitButton setTitle:@"Submit" forState:UIControlStateNormal];
    [submitButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [submitButton.titleLabel setFrame:CGRectMake(0, 0, 200, 60)];
    submitButton.titleLabel.font = [UIFont systemFontOfSize:18];
    [submitButton addTarget:self action:@selector(startToMatch:) forControlEvents:UIControlEventTouchUpInside];
    submitButton.layer.backgroundColor = [UIColor yellowColor].CGColor;
    [self.view addSubview:submitButton];
    
    cityTextField.delegate = self;
    cityTextField.returnKeyType = UIReturnKeyDone;
    
    //Call hideKeyboard action when done button is clicked
    [cityTextField addTarget:self action:@selector(hideKeyboard) forControlEvents:UIControlEventEditingDidEndOnExit];

    HWYTextField.delegate = self;
    HWYTextField.returnKeyType = UIReturnKeyDone;
    
    //Call hideKeyboard action when done button is clicked
    [HWYTextField addTarget:self action:@selector(hideKeyboard) forControlEvents:UIControlEventEditingDidEndOnExit];
    
    
    pickerViewData = [[[globals.CAR_CLASS_DICT allKeys] sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)]mutableCopy];
    [pickerViewData insertObject:@"NULL" atIndex:0];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    if (self.view.frame.origin.y == 0) {
        [self.view setFrame:CGRectMake(self.view.frame.origin.x, -120, self.view.frame.size.width, self.view.frame.size.height)];
    }
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    if (self.view.frame.origin.y != 0) {
        [self.view setFrame:CGRectMake(self.view.frame.origin.x, 0, self.view.frame.size.width, self.view.frame.size.height)];
    }
}

- (void)hideKeyboard {
    
    [cityTextField resignFirstResponder];
    [HWYTextField resignFirstResponder];
}
- (IBAction)selectVihicleClass:(id)sender {
    UIViewController* popoverContent = [[UIViewController alloc] init];
    UIView *popoverView = [[UIView alloc] init];
    
    //init picker view
    pickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 0,popoverView.frame.size.width,popoverView.frame.size.height-20 )];
    [pickerView setDataSource:self];
    [pickerView setDelegate:self];
    pickerView.showsSelectionIndicator = YES;
    [popoverView addSubview:pickerView];
    
    popoverContent.view = popoverView;
    popoverController = [[UIPopoverController alloc]initWithContentViewController:popoverContent];
    [popoverController setPopoverContentSize:CGSizeMake(340, 150) animated:NO];
    [popoverController presentPopoverFromRect:[sender bounds] inView:sender permittedArrowDirections:UIPopoverArrowDirectionUp animated:NO];
}

#pragma mark - picker view

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    return pickerViewData.count;
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    NSString *selectedStr = [pickerViewData objectAtIndex:row];
    if (row == 0) {
        vehicleClassLabel.text = @"Vehicle Class";
    }else{
        vehicleClassLabel.text = selectedStr;
    }
}

-(UIView*)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    
    UILabel* label = (UILabel*)view;
    
    if (view == nil) {
        label = [[UILabel alloc] init];
    }
    
    label.text = [pickerViewData objectAtIndex:row];
    label.font = [UIFont systemFontOfSize:18.0f];
    label.textAlignment = NSTextAlignmentCenter;
    
    return label;
}

-(float)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 40;
}

- (IBAction)startToMatch:(id)sender {
    if (self.view.frame.origin.y != 0) {
        [self.view setFrame:CGRectMake(self.view.frame.origin.x, 0, self.view.frame.size.width, self.view.frame.size.height)];
    }
    [self hideKeyboard];
    if ([cityTextField.text isEqualToString:@""] && [HWYTextField.text isEqualToString:@""]) {
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"CarMatch" message:@"Please input your driving km in the text field." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:Nil, nil];
        [alertView show];
        return;
    }
    
    NSMutableArray *selectedCars;
    if (![vehicleClassLabel.text isEqualToString:@"Vehicle Class"]) {
        selectedCars = [[[globals.CAR_CLASS_DICT objectForKey:vehicleClassLabel.text]allValues]mutableCopy];
    }else{
        selectedCars = [[globals.ALL_CAR_DICT allValues]mutableCopy];
    }
    
    NSArray *tempArr = [selectedCars copy];
    for(NSMutableDictionary *carDict in tempArr){
        int index = [tempArr indexOfObject:carDict];
        float fuelConsumption = ([cityTextField.text floatValue]/100) *[[carDict objectForKey:@"FUEL CONSUMPTION_CITY (L/100 km)"] floatValue] + ([HWYTextField.text floatValue]/100)* [[carDict objectForKey:@"FUEL CONSUMPTION_HWY (L/100 km)"]floatValue];
        NSString *myFuelConsumptionStr = [NSString stringWithFormat:@"%f",fuelConsumption];
        [carDict setObject:myFuelConsumptionStr forKey:@"myfuelconsumption"];
        [selectedCars replaceObjectAtIndex:index withObject:carDict];
    }
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"myfuelconsumption" ascending:YES];
    
    NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    
    NSArray *sortedArray = [selectedCars sortedArrayUsingDescriptors:sortDescriptors];
    
    NSArray *displayArray;
    if (sortedArray.count > 10) {
         displayArray = [sortedArray subarrayWithRange:NSMakeRange(0, 10)];
    }else{
        displayArray = sortedArray;
    }
    CarMatchListViewController *matchListViewController = [[CarMatchListViewController alloc]init];
    [matchListViewController.view setFrame:CGRectMake(0, 65, self.view.frame.size.width, self.view.frame.size.height)];
    matchListViewController.carMatchListData = displayArray;
    //[matchListViewController.view setBackgroundColor:[UIColor yellowColor]];
    [self presentViewController:matchListViewController animated:YES completion:Nil];

}
@end
