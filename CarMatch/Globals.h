//
//  Globals.h
//  CarMatch
//
//  Created by Jie Zhang on 3/1/2014.
//  Copyright (c) 2014 Jie Zhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Globals : NSObject

+(Globals *)instance;

//dictionary for all the cars
@property(nonatomic,strong)NSMutableDictionary *ALL_CAR_DICT;
//dictionary for all the cars with the keys: car's class
@property(nonatomic,strong)NSMutableDictionary *CAR_CLASS_DICT;
//array of all years
@property(nonatomic,strong)NSMutableArray *CAR_YEAR_ARR;
//array of all car models
@property(nonatomic,strong)NSMutableArray *CAR_MODEL_ARR;
//array of all car manufacturers
@property(nonatomic,strong)NSMutableArray *CAR_MANUFAC_ARR;
//dictioanry of all the cars grouped by different key values
@property(nonatomic,strong)NSMutableDictionary *CAR_GROUPED_DICT;
//dictionary for filter information
@property(nonatomic,strong)NSMutableDictionary *FILTER_DICT;
//dictionary of all bookmarked cars
@property(nonatomic,strong)NSMutableDictionary *BOOKMARK_DICT;
//local document path
@property(nonatomic,strong)NSString *LOCAL_DOCS_PATH;
//file path for bookmark plist
@property(nonatomic,strong)NSString *BOOKMARK_PLIST_FILE;

@end
