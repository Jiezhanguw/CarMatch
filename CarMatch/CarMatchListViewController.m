//
//  CarMatchListViewController.m
//  CarMatch
//
//  Created by Jie Zhang on 3/2/2014.
//  Copyright (c) 2014 Jie Zhang. All rights reserved.
//

#import "CarMatchListViewController.h"
#define CAR_LIST_CELL_HEIGHT 520
#define CAR_HEADER_HEIGHT 60
#define LABEL_HEIGHT 25
#define BUTTON_WIDTH 50
@interface CarMatchListViewController ()

@end

@implementation CarMatchListViewController{
    NSDictionary *carDict;
}
@synthesize carMatchListData;
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
    return carMatchListData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CarMatchListCell";
    CarMatchListCell *cell = (CarMatchListCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[CarMatchListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSDictionary *carInfo = [carMatchListData objectAtIndex:indexPath.row];
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

    [cell.yearLabel setText:[NSString stringWithFormat:@"Year: %@",yearStr]];
    [cell.manufacLabel setText:[NSString stringWithFormat:@"Manufacturer: %@",[carInfo objectForKey:@"MANUFACTURER"]]];
    [cell.modelLabel setText:[NSString stringWithFormat:@"Model: %@",[carInfo objectForKey:@"MODEL"]]];
    [cell.carClassLabel setText:[NSString stringWithFormat:@"Vehicle Class: %@",[carInfo objectForKey:@"VEHICLE CLASS"]]];
    [cell.engineSizeLabel setText:[NSString stringWithFormat:@"Engine Size: %@",[carInfo objectForKey:@"ENGINE SIZE"]]];
    [cell.cylindersLabel setText:[NSString stringWithFormat:@"Cylinders: %@",[carInfo objectForKey:@"CYLINDERS"]]];
    [cell.transmissionLabel setText:[NSString stringWithFormat:@"Transmission: %@",[carInfo objectForKey:@"TRANSMISSION"]]];
    [cell.fuelTypeLabel setText:[NSString stringWithFormat:@"Fuel Type: %@",[carInfo objectForKey:@"FUEL TYPE"]]];
    [cell.fuelConSumpLabel setText:[NSString stringWithFormat:@"Fuel Consumption: City: %@L/100KM or %@MI./GAL., Hwy: %@L/KM or %@MI./GAL.",[carInfo objectForKey:@"FUEL CONSUMPTION_CITY (L/100 km)"],[carInfo objectForKey:@"FUEL CONSUMPTION_CITY (mi./gal.)"],[carInfo objectForKey:@"FUEL CONSUMPTION_HWY (L/100 km)"],[carInfo objectForKey:@"FUEL CONSUMPTION_HWY (mi./gal.)"]]];
    [cell.fuelPerYearLabel setText:[NSString stringWithFormat:@"Fuel: %@L/YEAR",[carInfo objectForKey:@"FUEL_(L) / YEAR"]]];
    [cell.emissionLabel setText:[NSString stringWithFormat:@"CO2 Emission: %@KG/YEAR",[carInfo objectForKey:@"CO2 EMISSIONS_(kg) / YEAR"]]];

    if ([[globals.BOOKMARK_DICT allKeys] containsObject:[carInfo objectForKey:@"id"]]) {
        cell.bookmarkButton .selected = TRUE;
    }else{
        cell.bookmarkButton.selected = FALSE;
    }
    [cell.bookmarkButton addTarget:self action:@selector(bookmarkItem:event:) forControlEvents:UIControlEventTouchUpInside];
    [cell.shareButton addTarget:self action:@selector(shareItem:event:) forControlEvents:UIControlEventTouchUpInside];
    cell.userInteractionEnabled = TRUE;
    return cell;

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
    
    //init done button
    UIButton *donebutton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [donebutton setFrame:CGRectMake(self.view.frame.size.width/2 - 30, 20, 60, 40)];
    [donebutton setTitle:@"Done" forState:UIControlStateNormal];
    [donebutton addTarget:self action:@selector(dismissCurrentView) forControlEvents:UIControlEventTouchUpInside];
    [customView addSubview:donebutton];
    return customView;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
  
    carDict = [carMatchListData objectAtIndex:indexPath.row];
    
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

//dismiss current view, go back to car match view
-(void)dismissCurrentView{
    [self dismissViewControllerAnimated:YES completion:Nil];
}

//share current view content
-(void)shareItem:(id)sender event:(UIEvent *)event{
     NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:[[[event touchesForView:sender] anyObject] locationInView:self.tableView]];
    carDict = [carMatchListData objectAtIndex:indexPath.row];
    
    UIViewController *popOverContent = [[UIViewController alloc]init];
    UIView *popoverView = [[UIView alloc]init];
    
    //create email button
    UIButton *emailButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [emailButton setFrame:CGRectMake(10, 10, BUTTON_WIDTH, BUTTON_WIDTH)];
    [emailButton setImage:[UIImage imageNamed:@"email.png"] forState:UIControlStateNormal];
    [emailButton addTarget:self action:@selector(emailItem) forControlEvents:UIControlEventTouchUpInside];
    [emailButton setContentMode:UIViewContentModeCenter];
    [popoverView addSubview:emailButton];
    //label for email
    UILabel *emailLabel = [[UILabel alloc]initWithFrame:CGRectMake(emailButton.frame.origin.x, CGRectGetMaxY(emailButton.frame), emailButton.frame.size.width, 30)];
    [emailLabel setText:@"Email"];
    [emailLabel setTextAlignment:NSTextAlignmentCenter];
    [emailLabel setFont:[UIFont systemFontOfSize:10.0]];
    [popoverView addSubview:emailLabel];
    
    //create message button
    UIButton *messageButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [messageButton setFrame:CGRectMake(CGRectGetMaxX(emailButton.frame)+25, 10, BUTTON_WIDTH, BUTTON_WIDTH)];
    [messageButton setImage:[UIImage imageNamed:@"message.png"] forState:UIControlStateNormal];
    [messageButton addTarget:self action:@selector(sendMessage) forControlEvents:UIControlEventTouchUpInside];
    [messageButton setContentMode:UIViewContentModeCenter];
    [popoverView addSubview:messageButton];
    //label for message
    UILabel *msgLabel = [[UILabel alloc]initWithFrame:CGRectMake(messageButton.frame.origin.x, CGRectGetMaxY(messageButton.frame), messageButton.frame.size.width, 30)];
    [msgLabel setText:@"Message"];
    [msgLabel setTextAlignment:NSTextAlignmentCenter];
    [msgLabel setFont:[UIFont systemFontOfSize:12.0]];
    [popoverView addSubview:msgLabel];
    
    popOverContent.view = popoverView;
    popOverController = [[UIPopoverController alloc]initWithContentViewController:popOverContent];
    popOverController.popoverContentSize = CGSizeMake(150, 100);
    [popOverController presentPopoverFromRect:[sender bounds] inView:sender permittedArrowDirections:UIPopoverArrowDirectionDown animated:YES];
    
}

//email current view content
-(void)emailItem{
    MFMailComposeViewController *mailController = [[MFMailComposeViewController alloc]init];
    mailController.mailComposeDelegate = self;
    //    NSString *mimeType;
    //    NSString *dataPath;
    //    NSString *fileName;
    NSString *emailBody = [NSString stringWithFormat:@"Year: %@ \nManufacturer: %@ \nModel: %@ \nVehicle Class: %@ \nEngine Size: %@ \nCylinders: %@ \nTransmission: %@ \nFuel Type: %@ \nFuel Consumption: City: %@L/100KM or %@MI./GAL., Hwy: %@L/KM or %@MI./GAL. \nFuel: %@L/YEAR \nCO2 Emission: %@KG/YEAR \n",[carDict objectForKey:@"year"],[carDict objectForKey:@"MANUFACTURER"],[carDict objectForKey:@"MODEL"],[carDict objectForKey:@"VEHICLE CLASS"],[carDict objectForKey:@"ENGINE SIZE"],[carDict objectForKey:@"CYLINDERS"],[carDict objectForKey:@"TRANSMISSION"],[carDict objectForKey:@"FUEL TYPE"],[carDict objectForKey:@"FUEL CONSUMPTION_CITY (L/100 km)"],[carDict objectForKey:@"FUEL CONSUMPTION_CITY (mi./gal.)"],[carDict objectForKey:@"FUEL CONSUMPTION_HWY (L/100 km)"],[carDict objectForKey:@"FUEL CONSUMPTION_HWY (mi./gal.)"],[carDict objectForKey:@"FUEL_(L) / YEAR"],[carDict objectForKey:@"CO2 EMISSIONS_(kg) / YEAR"]];
    //        NSData *myData;
    //        if(funType == IMAGE)
    //        {
    //            mimeType=@"image/png";
    //            //dataPath = [NSString stringWithFormat:@"%@/images1/%@.jpg",globals.URL,imageName];//[[NSBundle mainBundle] pathForResource:@"funnyimage" ofType:@".jpg"];
    //            myData = imageData;
    //            fileName = imageName;
    //        [mailController addAttachmentData:myData mimeType:mimeType fileName:fileName];
    
    
    [mailController setSubject:@"CarMatch --- Have Fun!"];
    [mailController setMessageBody:emailBody isHTML:NO];
    
    if (mailController){
        [self presentViewController:mailController animated:YES completion:nil];
        [popOverController dismissPopoverAnimated:YES];
    }
}

-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error{
    NSString *msg;
    switch (result) {
        case MFMailComposeResultCancelled:
            //NSLog(@"mail cancelled.");
            msg = @"Mail cancelled.";
            break;
        case MFMailComposeResultSent:
            //NSLog(@"mail sent");
            msg = @"Mail sent.";
            break;
        case MFMailComposeResultSaved:
            //NSLog(@"mail saved.");
            msg = @"Mail saved.";
            break;
        default:
            msg = @"Mail failed. Please try it again later.";
            //////////NSLog(@"mail failed.");
            
            break;
    }
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"amuseMe" message:msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

//message funny stuff
-(void)sendMessage{
    MFMessageComposeViewController *messageController = [[MFMessageComposeViewController alloc] init];
    messageController.messageComposeDelegate = self;
    
    NSString *msg = [NSString stringWithFormat:@"Year: %@ \nManufacturer: %@ \nModel: %@ \nVehicle Class: %@ \nEngine Size: %@ \nCylinders: %@ \nTransmission: %@ \nFuel Type: %@ \nFuel Consumption: City: %@L/100KM or %@MI./GAL., Hwy: %@L/KM or %@MI./GAL. \nFuel: %@L/YEAR \nCO2 Emission: %@KG/YEAR \n",[carDict objectForKey:@"year"],[carDict objectForKey:@"MANUFACTURER"],[carDict objectForKey:@"MODEL"],[carDict objectForKey:@"VEHICLE CLASS"],[carDict objectForKey:@"ENGINE SIZE"],[carDict objectForKey:@"CYLINDERS"],[carDict objectForKey:@"TRANSMISSION"],[carDict objectForKey:@"FUEL TYPE"],[carDict objectForKey:@"FUEL CONSUMPTION_CITY (L/100 km)"],[carDict objectForKey:@"FUEL CONSUMPTION_CITY (mi./gal.)"],[carDict objectForKey:@"FUEL CONSUMPTION_HWY (L/100 km)"],[carDict objectForKey:@"FUEL CONSUMPTION_HWY (mi./gal.)"],[carDict objectForKey:@"FUEL_(L) / YEAR"],[carDict objectForKey:@"CO2 EMISSIONS_(kg) / YEAR"]];
    messageController.body = msg;
    
    
    //        BOOL didAttachImage = [messageController addAttachmentData:imageData typeIdentifier:@"public.data" filename:[NSString stringWithFormat:@"%@.jpg",imageName]];
    //
    //        messageController.body = @"---amuseMe";
    //        if (!didAttachImage){
    //            UIAlertView *warningAlert = [[UIAlertView alloc] initWithTitle:@"Error"
    //                                                                   message:@"Failed to attach image"
    //                                                                  delegate:nil
    //                                                         cancelButtonTitle:@"OK"
    //                                                         otherButtonTitles:nil];
    //            [warningAlert show];
    
    if (messageController) {
        [self presentViewController:messageController animated:YES completion:nil];
        [popOverController dismissPopoverAnimated:YES];
    }
    
    
}

-(void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result{
    
    NSString *msg;
    switch (result)
    {
        case MessageComposeResultCancelled:
            msg = @"Message canceled.";
            NSLog(@"Result: canceled");
            break;
        case MessageComposeResultSent:
            msg = @"Result: sent.";
            NSLog(@"Message sent");
            break;
        case MessageComposeResultFailed:
            msg = @"Message failed.";
            NSLog(@"Result: failed");
            break;
        default:
            msg = @"Message not sent.";
            NSLog(@"Result: not sent");
            break;
    }
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"amuseMe" message:msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)bookmarkItem:(id)sender event:(UIEvent *)event{
    
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:[[[event touchesForView:sender] anyObject] locationInView:self.tableView]];
    carDict = [carMatchListData objectAtIndex:indexPath.row];

    UIButton *button = (UIButton*)sender;
    if (!button.selected) {
        //bookmark item
        if (!globals.BOOKMARK_DICT) {
            globals.BOOKMARK_DICT = [NSMutableDictionary dictionaryWithObject:carDict forKey:[carDict objectForKey:@"id"]];
        }else{
            [globals.BOOKMARK_DICT setObject:carDict forKey:[carDict objectForKey:@"id"]];
        }
        button.selected = TRUE;
    }else{
        [globals.BOOKMARK_DICT removeObjectForKey:[carDict objectForKey:@"id"]];
        button.selected = FALSE;
    }
    
    //save bookmark items information to local plist file
    [globals.BOOKMARK_DICT writeToFile:globals.BOOKMARK_PLIST_FILE atomically:YES];
}


@end
