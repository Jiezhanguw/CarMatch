//
//  CarMatchAppDelegate.m
//  CarMatch
//
//  Created by Jie Zhang on 3/1/2014.
//  Copyright (c) 2014 Jie Zhang. All rights reserved.
//

#import "CarMatchAppDelegate.h"

@implementation CarMatchAppDelegate
@synthesize globals;
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    if (!globals) {
        globals = [Globals instance];
    }
    globals.FILTER_DICT = [[NSMutableDictionary alloc]init];
    NSString *carDataFile = [[NSBundle mainBundle]pathForResource:@"totalcars" ofType:@"plist"];
    globals.ALL_CAR_DICT = [NSMutableDictionary dictionaryWithContentsOfFile:carDataFile];
    globals.CAR_CLASS_DICT = [[NSMutableDictionary alloc]init];
    globals.CAR_YEAR_ARR = [[NSMutableArray alloc]init];
    globals.CAR_MANUFAC_ARR = [[NSMutableArray alloc]init];
    globals.CAR_MODEL_ARR = [[NSMutableArray alloc]init];
    globals.CAR_GROUPED_DICT = [[NSMutableDictionary alloc]init];
    for(NSDictionary *carDict in [globals.ALL_CAR_DICT allValues]){
        
        //grouped by vihical class
        if (![[globals.CAR_CLASS_DICT allKeys] containsObject:[carDict objectForKey:@"VEHICLE CLASS"]]) {
            NSMutableDictionary *tempDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:carDict,[NSString stringWithFormat:@"%@",[carDict objectForKey:@"id"]], nil];
            [globals.CAR_CLASS_DICT setObject:tempDict forKey:[carDict objectForKey:@"VEHICLE CLASS"]];
        }else{
            [[globals.CAR_CLASS_DICT objectForKey:[carDict objectForKey:@"VEHICLE CLASS"]] setObject:carDict forKey:[NSString stringWithFormat:@"%@",[carDict objectForKey:@"id"]]];
        }
        
        //grouped by year
        if (![globals.CAR_YEAR_ARR containsObject:[carDict objectForKey:@"year"]]) {
           [globals.CAR_YEAR_ARR addObject: [carDict objectForKey:@"year"]];
        }

        //grouped by model
        if (![globals.CAR_MODEL_ARR containsObject:[carDict objectForKey:@"MODEL"]]){
           
            [globals.CAR_MODEL_ARR addObject: [carDict objectForKey:@"MODEL"]];
            
        }
        //grouped by manufacturer
        if (![globals.CAR_MANUFAC_ARR containsObject:[carDict objectForKey:@"MANUFACTURER"]]) {
            [globals.CAR_MANUFAC_ARR addObject:[carDict objectForKey:@"MANUFACTURER"]];

        }


        
        if (![[globals.CAR_GROUPED_DICT allKeys] containsObject:[carDict objectForKey:@"year"]]) {
            NSMutableDictionary *tempDict = [NSMutableDictionary dictionaryWithObject:carDict forKey:[NSString stringWithFormat:@"%@",[carDict objectForKey:@"id"]]];
            NSMutableDictionary *modelDict = [NSMutableDictionary dictionaryWithObject:tempDict forKey:[NSString stringWithFormat:@"%@",[carDict objectForKey:@"MODEL"]]];
            NSMutableDictionary *manufacDict = [NSMutableDictionary dictionaryWithObject:modelDict forKey:[NSString stringWithFormat:@"%@",[carDict objectForKey:@"MANUFACTURER"]]];
            [globals.CAR_GROUPED_DICT setObject:manufacDict forKey:[NSString stringWithFormat:@"%@",[carDict objectForKey:@"year"]]];
        }else if(![[[globals.CAR_GROUPED_DICT objectForKey:[carDict objectForKey:@"year"]]allKeys] containsObject:[carDict objectForKey:@"MANUFACTURER"]]){
            NSMutableDictionary *tempDict = [NSMutableDictionary dictionaryWithObject:carDict forKey:[NSString stringWithFormat:@"%@",[carDict objectForKey:@"id"]]];
            NSMutableDictionary *modelDict = [NSMutableDictionary dictionaryWithObject:tempDict forKey:[NSString stringWithFormat:@"%@",[carDict objectForKey:@"MODEL"]]];
            [[globals.CAR_GROUPED_DICT objectForKey:[carDict objectForKey:@"year"]] setObject:modelDict forKey:[NSString stringWithFormat:@"%@",[carDict objectForKey:@"MANUFACTURER"]]];
        }else if (![[[[globals.CAR_GROUPED_DICT objectForKey:[carDict objectForKey:@"year"]]objectForKey:[carDict objectForKey:@"MANUFACTURER"]] allKeys] containsObject:[carDict objectForKey:@"MODEL"]]){
             NSMutableDictionary *tempDict = [NSMutableDictionary dictionaryWithObject:carDict forKey:[NSString stringWithFormat:@"%@",[carDict objectForKey:@"id"]]];
            [[[globals.CAR_GROUPED_DICT objectForKey:[carDict objectForKey:@"year"]]objectForKey:[carDict objectForKey:@"MANUFACTURER"]]setObject:tempDict forKey:[NSString stringWithFormat:@"%@",[carDict objectForKey:@"MODEL"]]];
        }else{
            [[[[globals.CAR_GROUPED_DICT objectForKey:[carDict objectForKey:@"year"]]objectForKey:[carDict objectForKey:@"MANUFACTURER"]]objectForKey:[carDict objectForKey:@"MODEL"]] setObject:carDict forKey:[NSString stringWithFormat:@"%@",[carDict objectForKey:@"id"]]];
        }
        
    }
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
