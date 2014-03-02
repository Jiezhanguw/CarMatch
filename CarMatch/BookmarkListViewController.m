//
//  BookmarkListViewController.m
//  CarMatch
//
//  Created by Jie Zhang on 3/2/2014.
//  Copyright (c) 2014 Jie Zhang. All rights reserved.
//

#import "BookmarkListViewController.h"
#define CAR_LIST_CELL_HEIGHT 100
#define CAR_HEADER_HEIGHT 40

@interface BookmarkListViewController ()

@end

@implementation BookmarkListViewController{
    NSArray *bookmarkData;
}
@synthesize globals;
@synthesize popOverController;
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
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
-(void)viewWillAppear:(BOOL)animated{
    //get bookmarked data
    bookmarkData = [globals.BOOKMARK_DICT allValues];
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    return bookmarkData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CarListViewCell";
    CarListViewCell *cell = (CarListViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[CarListViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSDictionary *carDict = [bookmarkData objectAtIndex:indexPath.row];
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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self performSegueWithIdentifier:@"bookmarkedcar" sender:Nil];
}
-(float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return CAR_LIST_CELL_HEIGHT;
}

-(float)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return CAR_HEADER_HEIGHT;
}


//custom header view
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *customView = [[UIView alloc]init];

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
    
    return customView;
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


#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    CarDetailsViewController *destViewController = [segue destinationViewController];
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    NSDictionary *carDict = [bookmarkData objectAtIndex:indexPath.row];
    destViewController.carDict = carDict;
    destViewController.isBookmark = TRUE;

}



@end
