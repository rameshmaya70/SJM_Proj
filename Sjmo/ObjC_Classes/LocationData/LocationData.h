//
//  LocationData.h
//  SJMO
//
//  Created by Ramesh Khanna on 9/18/14.
//  Copyright (c) 2014 Satya Bhanu Nayak. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LocationData : NSObject
@property(strong,nonatomic)NSString *IDVAL;
@property(strong,nonatomic)NSString *name;
@property(strong,nonatomic)NSString *category;
@property(strong,nonatomic)NSString *address;
@property(strong,nonatomic)NSString *latitude;
@property(strong,nonatomic)NSString *longitude;
@property(strong,nonatomic)NSString *phone;
@property(strong,nonatomic)NSString *street;
@property(strong,nonatomic)NSString *city;
@property(strong,nonatomic)NSString *state;
@property(strong,nonatomic)NSString *zip;
@property(strong,nonatomic)NSString *days;
@property(strong,nonatomic)NSString *normalTime;
@property(strong,nonatomic)NSString *holidays;
@property(strong,nonatomic)NSString *holidaysTime;
@property(strong,nonatomic)NSString *url;

@property(nonatomic,assign)NSInteger section;
@property(nonatomic,assign)NSInteger row;
@property(nonatomic,assign)NSInteger Index;

-(id)initWithDictionary:(NSDictionary *)dic;
-(NSString *)getCombinedString;
@end
