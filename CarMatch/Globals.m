//
//  Globals.m
//  CarMatch
//
//  Created by Jie Zhang on 3/1/2014.
//  Copyright (c) 2014 Jie Zhang. All rights reserved.
//

#import "Globals.h"

@implementation Globals

static Globals *_instance = nil;

+(Globals*)instance{
    if (_instance) {
        return _instance;
    }
    @synchronized([Globals class]){
        if (!_instance) {
            _instance = [[self alloc]init];
        }
        return _instance;
    }
    return nil;
}
@synthesize ALL_CAR_DICT;
@synthesize CAR_CLASS_DICT;
@synthesize CAR_GROUPED_DICT;
@synthesize CAR_MANUFAC_ARR;
@synthesize CAR_MODEL_ARR;
@synthesize CAR_YEAR_ARR;
@synthesize FILTER_DICT;
@end
