//
//  Utility.h
//  SJMO
//
//  Created by Ramesh Khanna on 9/24/14.
//  Copyright (c) 2014 Satya Bhanu Nayak. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LocationData;
@interface Utility : NSObject

+(instancetype)sharedUtility;
-(NSString *)getNoonStatus:(NSString *)timeString;
-(float)getFloatvalueFromStr:(NSString *)str;
-(NSString *)getStringBetweenBraces:(NSString *)str;
-(NSString *)removeBraces:(NSString *)str;
-(NSString *)getTomorrowDayString:(int)date;
-(NSString *)findAscendingTimeFromNow:(NSDate *)date1 toDate:(NSDate *)date2;
- (NSString *)stringFromTimeInterval:(NSTimeInterval)interval;

-(BOOL)checkDatewithNow:(NSString *)dayName;

//Get the AM-PM string contained with the string
-(float)getAMPM:(NSString *)str;

//get the name of Today
-(NSString *)todayName;

//get all days in the week
-(NSArray *)weekDaysArray;

//get date format now;

-(NSString *)getDateFormat:(NSString *)format date:(NSDate *)date;

//checkiing OpenClose status


-(BOOL)isClinicOpen:(LocationData *)LocationData;

-(NSString *)openingTime:(LocationData *)LocationData;
-(NSString *)hoursAboutToOpenTest:(LocationData *)LocationData;

-(NSArray *)getOpeningDayAndTimings:(LocationData *)LocationData;
@end
