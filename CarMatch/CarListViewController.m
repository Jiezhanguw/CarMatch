//
//  CarListViewController.m
//  CarMatch
//
//  Created by Jie Zhang on 3/1/2014.
//  Copyright (c) 2014 Jie Zhang. All rights reserved.
//

#import "CarListViewController.h"

#define SECTION_NUMBER 2
#define FILTER_CELL_HEIGHT 40
#define CAR_LIST_CELL_HEIGHT 100
#define FILTER_HEADER_HEIGHT 1
#define CAR_HEADER_HEIGHT 40
@interface CarListViewController ()

@end

@implementation CarListViewController{
    NSMutableArray *filterSetArray;
    NSArray *carListData;
    Globals *globals;
    NSMutableArray *yearArray;
    NSMutableArray *manufacArray;
    NSMutableArray *modelArray;
    NSArray *pickerViewData;
    UIPickerView *pickerView;
    int indexOfTableViewCell;
}
@synthesize popoverController;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
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
    filterSetArray = [@[@"Year",@"Manufacturer",@"Model"]mutableCopy];
    carListData = [globals.ALL_CAR_DICT allValues];

    yearArray = [@[@"NULL",@"2000",@"2001",@"2002",@"2003",@"2004",@"2005",@"2006",@"2007",@"2008",@"2009",@"2010",@"2011",@"2012",@"2013",@"2014"]mutableCopy];
    manufacArray = [[globals.CAR_MANUFAC_ARR sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)]mutableCopy];
    [manufacArray insertObject:@"NULL" atIndex:0];
    modelArray = [[globals.CAR_MODEL_ARR  sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)]mutableCopy];
    [modelArray insertObject:@"NULL" atIndex:0];
    
    pickerViewData = yearArray;
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return SECTION_NUMBER;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    
    if (section == 0) {
        return filterSetArray.count;
    }else{
        return carListData.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        static NSString *CellIdentifier = @"Cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        //cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.text = [filterSetArray objectAtIndex:indexPath.row];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        //UIColor * color = [UIColor colorWithRed:69/255.0f green:227/255.0f blue:221/255.0f alpha:1.0f];
        cell.backgroundColor = [UIColor yellowColor];
        return cell;
    }else{
        
        static NSString *CellIdentifier = @"CarListViewCell";
        CarListViewCell *cell = (CarListViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[CarListViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSDictionary *carDict = [carListData objectAtIndex:indexPath.row];
        
        NSString *yearStr = [carDict objectForKey:@"year"];
        if ([yearStr isEqualToString:@"2104"]) {
            yearStr = @"2014";
        }

        NSString *imageStr1 = [[NSString stringWithFormat:@"%@_%@_%@",yearStr,[carDict objectForKey:@"MANUFACTURER"],[carDict objectForKey:@"MODEL"]]lowercaseString];
        NSString *imageStr2;
        NSString *imagePath = [[NSBundle mainBundle]pathForResource:imageStr1 ofType:@"jpg"];
        if (imagePath.length < 1) {
            imageStr2 = [[NSString stringWithFormat:@"%@_%@_%@",yearStr,[carDict objectForKey:@"MANUFACTURER"],[carDict objectForKey:@"MODEL"]]lowercaseString];
            imagePath = [[NSBundle mainBundle]pathForResource:imageStr2 ofType:@"jpeg"];
            
            if (imagePath.length < 1) {
                cell.carImageView.image = [UIImage imageNamed:@"test.jpg"];
            }else{
                cell.carImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.jpeg",imageStr2]];
            }
            
        }else{
            cell.carImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.jpg",imageStr1]];
        }
        
        [cell.carYearLabel setText:yearStr];
        [cell.carBrandLabel setText:[carDict objectForKey:@"MANUFACTURER"]];
        [cell.carModelLabel setText:[carDict objectForKey:@"MODEL"]];
        [cell.carClassLabel setText:[carDict objectForKey:@"VEHICLE CLASS"]];
        
        [cell.emissionLabel setText:[carDict objectForKey:@"CO2 EMISSIONS_(kg) / YEAR"]];
        [cell.fuelLabel setText:[carDict objectForKey:@"FUEL_(L) / YEAR"]];
        return cell;
        
    }
    
    // Configure the cell...
}

-(float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return FILTER_CELL_HEIGHT;
    }else{
        return CAR_LIST_CELL_HEIGHT;
    }
}

-(float)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return FILTER_HEADER_HEIGHT;
    }else{
        return CAR_HEADER_HEIGHT;
    }
}


//custom header view
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *customView = [[UIView alloc]init];
    if (section == 0) {
        [customView setFrame:CGRectMake(0, 0, self.view.frame.size.width, FILTER_HEADER_HEIGHT)];
    }else{
        [customView setFrame:CGRectMake(0, 0, self.view.frame.size.width, CAR_HEADER_HEIGHT)];
        [customView setBackgroundColor:[UIColor colorWithWhite:0.9 alpha:1.0]];
        
        //label for car
        UILabel *carLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, CAR_LIST_CELL_HEIGHT, CAR_HEADER_HEIGHT)];
        [carLabel setText:@"Car"];
        [carLabel setTextAlignment:NSTextAlignmentCenter];
        [carLabel setTextColor:[UIColor blueColor]];
        [customView addSubview:carLabel];
        //label for emission
        UILabel *emissionLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(carLabel.frame)+70, 0, CAR_LIST_CELL_HEIGHT-10, CAR_HEADER_HEIGHT)];
        [emissionLabel setText:@"CO2 Emission(kg/year)"];
        [emissionLabel setFont:[UIFont systemFontOfSize:11.0f]];
        [emissionLabel setTextAlignment:NSTextAlignmentCenter];
        [emissionLabel setTextColor:[UIColor blueColor]];
        emissionLabel.numberOfLines = 0;
        [customView addSubview:emissionLabel];
        //label for fuel
        UILabel *fuelLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(emissionLabel.frame), 0, tableView.frame.size.width - CGRectGetMaxX(emissionLabel.frame), CAR_HEADER_HEIGHT)];
        [fuelLabel setText:@"Fuel Consumption(l/year)"];
        [fuelLabel setTextAlignment:NSTextAlignmentCenter];
        [fuelLabel setTextColor:[UIColor blueColor]];
        [fuelLabel setFont:[UIFont systemFontOfSize:11.0f]];
        fuelLabel.numberOfLines = 0;
        [customView addSubview:fuelLabel];
    }
    return customView;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //showcardetails
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            pickerViewData = yearArray;
        }else if (indexPath.row == 1){
            pickerViewData = manufacArray;
        }else{
            pickerViewData = modelArray;
        }
        indexOfTableViewCell = indexPath.row;
        UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
        [self showPopOverView:cell];
    }else{
        [self performSegueWithIdentifier:@"showcardetails" sender:Nil];
    }
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

- (void)showPopOverView:(id)sender{
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
        //if people selecrt NULL
        if (indexOfTableViewCell == 0) {
            [filterSetArray replaceObjectAtIndex:indexOfTableViewCell withObject:@"Year"];
            [globals.FILTER_DICT removeObjectForKey:@"year"];
        }else if (indexOfTableViewCell == 1){
            [filterSetArray replaceObjectAtIndex:indexOfTableViewCell withObject:@"Manufacturer"];
            [globals.FILTER_DICT removeObjectForKey:@"MANUFACTURER"];
        }else if (indexOfTableViewCell == 2){
            [filterSetArray replaceObjectAtIndex:indexOfTableViewCell withObject:@"Model"];
            [globals.FILTER_DICT removeObjectForKey:@"MODEL"];
        }
        
    }else{
        [filterSetArray replaceObjectAtIndex:indexOfTableViewCell withObject:selectedStr];
        
        if (indexOfTableViewCell == 0) {
            if ([selectedStr isEqualToString:@"2014"]) {
                selectedStr = @"2104";
            }
            [globals.FILTER_DICT setObject:selectedStr forKey:@"year"];
        }else if (indexOfTableViewCell == 1){
            [globals.FILTER_DICT setObject:selectedStr forKey:@"MANUFACTURER"];
        }else if (indexOfTableViewCell == 2){
            [globals.FILTER_DICT setObject:selectedStr forKey:@"MODEL"];
        }

    }
    //[self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:tableViewPath] withRowAnimation:UITableViewRowAnimationFade];
    NSRange range = NSMakeRange(1, 1);
    NSIndexSet *sectionToReload = [NSIndexSet indexSetWithIndexesInRange:range];
    [self.tableView reloadSections:sectionToReload withRowAnimation:UITableViewRowAnimationFade];
    [self filterCars];
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
    return FILTER_CELL_HEIGHT;
}

#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    CarDetailsViewController *destViewController = [segue destinationViewController];
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    NSDictionary *carDict = [carListData objectAtIndex:indexPath.row];
    destViewController.carDict = carDict;
    destViewController.isBookmark = FALSE;
}

//filter the cars based on user's selection
-(void)filterCars{
    NSMutableArray *filteredArray = [[NSMutableArray alloc]init];
    
    for(NSDictionary *carDict in [globals.ALL_CAR_DICT allValues]){
        //check year
        BOOL doesContainYear = ![globals.FILTER_DICT objectForKey:@"year"]||[[globals.FILTER_DICT objectForKey:@"year"]isEqualToString:[carDict objectForKey:@"year"]];
        //check manufacturer
         BOOL doesContainManufac = ![globals.FILTER_DICT objectForKey:@"MANUFACTURER"]||[[globals.FILTER_DICT objectForKey:@"MANUFACTURER"]isEqualToString:[carDict objectForKey:@"MANUFACTURER"]];
        //check model
         BOOL doesContainModel = ![globals.FILTER_DICT objectForKey:@"MODEL"]||[[globals.FILTER_DICT objectForKey:@"MODEL"]isEqualToString:[carDict objectForKey:@"MODEL"]];
        if (doesContainYear&&doesContainModel&&doesContainManufac) {
            [filteredArray addObject:carDict];
        }
    }
    carListData = filteredArray;
    [self.tableView reloadData];
}

@end
