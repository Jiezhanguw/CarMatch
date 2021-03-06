//
//  CarDetailsViewController.m
//  CarMatch
//
//  Created by Jie Zhang on 3/2/2014.
//  Copyright (c) 2014 Jie Zhang. All rights reserved.
//

#import "CarDetailsViewController.h"
#define LABEL_HEIGHT 25
#define BUTTON_WIDTH 50

@interface CarDetailsViewController ()
@end

@implementation CarDetailsViewController{
    UIButton *bookmarkButton;
    UIButton *shareButton;
}
@synthesize carDict;
@synthesize carImageView;
@synthesize globals;
@synthesize popOverController;
@synthesize isBookmark;
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
    [self setupView];
    
    
}
-(void)viewWillAppear:(BOOL)animated{
    //if it from bookmark view, hide the bookmark button
    if (isBookmark) {
        bookmarkButton.hidden = TRUE;
    }else{
        bookmarkButton.hidden = FALSE;
    }
}
-(void)setupView{
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
            carImageView.image = [UIImage imageNamed:@"test.jpg"];
        }else{
            carImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.jpeg",imageStr2]];
        }
        
    }else{
        carImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.jpg",imageStr1]];
    }
    

    [carImageView setContentMode:UIViewContentModeScaleAspectFit];
    
    UILabel *yearLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(carImageView.frame), self.view.frame.size.width, LABEL_HEIGHT)];
    [yearLabel setText:[NSString stringWithFormat:@"Year: %@",yearStr]];
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
    [fuelConSumpLabel setText:[NSString stringWithFormat:@"Fuel Consumption: City: %@L/100KM or %@MI./GAL., Hwy: %@L/KM or %@MI./GAL.",[carDict objectForKey:@"FUEL CONSUMPTION_CITY (L/100 km)"],[carDict objectForKey:@"FUEL CONSUMPTION_CITY (mi./gal.)"],[carDict objectForKey:@"FUEL CONSUMPTION_HWY (L/100 km)"],[carDict objectForKey:@"FUEL CONSUMPTION_HWY (mi./gal.)"]]];
    fuelConSumpLabel.numberOfLines = 0;
    [self.view addSubview:fuelConSumpLabel];
    
    UILabel *fuelPerYearLabel = [[UILabel alloc]initWithFrame:CGRectMake(yearLabel.frame.origin.x, CGRectGetMaxY(fuelConSumpLabel.frame), yearLabel.frame.size.width, LABEL_HEIGHT)];
    [fuelPerYearLabel setText:[NSString stringWithFormat:@"Fuel: %@L/YEAR",[carDict objectForKey:@"FUEL_(L) / YEAR"]]];
    [self.view addSubview:fuelPerYearLabel];
    
    UILabel *emissionLabel = [[UILabel alloc]initWithFrame:CGRectMake(yearLabel.frame.origin.x, CGRectGetMaxY(fuelPerYearLabel.frame), yearLabel.frame.size.width, LABEL_HEIGHT)];
    [emissionLabel setText:[NSString stringWithFormat:@"CO2 Emission: %@KG/YEAR",[carDict objectForKey:@"CO2 EMISSIONS_(kg) / YEAR"]]];
    [self.view addSubview:emissionLabel];
 
    //init share button
    shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [shareButton setBackgroundImage:[UIImage imageNamed:@"share.png"] forState:UIControlStateNormal];
    [shareButton setFrame:CGRectMake(100, CGRectGetMaxY(emissionLabel.frame), BUTTON_WIDTH, BUTTON_WIDTH)];
    [shareButton addTarget:self action:@selector(shareItem:) forControlEvents:UIControlEventTouchUpInside];
    [shareButton setContentMode:UIViewContentModeScaleToFill];
    [self.view addSubview:shareButton];
    
    //init bookmark button
    bookmarkButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [bookmarkButton setBackgroundImage:[UIImage imageNamed:@"bookmarkunselected.png"] forState:UIControlStateNormal];
    [bookmarkButton setBackgroundImage:[UIImage imageNamed:@"bookmarkselected.png"] forState:UIControlStateSelected];
    [bookmarkButton setFrame:CGRectMake(CGRectGetMaxX(shareButton.frame)+30, shareButton.frame.origin.y, BUTTON_WIDTH, BUTTON_WIDTH)];
    [bookmarkButton addTarget:self action:@selector(bookmarkItem:) forControlEvents:UIControlEventTouchUpInside];
    [bookmarkButton setContentMode:UIViewContentModeScaleToFill];
    //check current displaying content has been bookmarked or not, and update bookmarkButton background image according to the current content
    if ([[globals.BOOKMARK_DICT allKeys] containsObject:[carDict objectForKey:@"id"]]) {
        [bookmarkButton setSelected:TRUE];
    }else{
        [bookmarkButton setSelected:FALSE];
    }
    [self.view addSubview:bookmarkButton];
    
}

//share current view content
-(void)shareItem:(id)sender{
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
    [msgLabel setFont:[UIFont systemFontOfSize:10.0]];
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

-(void)bookmarkItem:(id)sender{
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



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
