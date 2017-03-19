//
//  Utility.m
//  SJMO
//
//  Created by Ramesh Khanna on 9/24/14.
//  Copyright (c) 2014 Satya Bhanu Nayak. All rights reserved.
//

#import "Utility.h"
#import "LocationData.h"

@implementation Utility


+(instancetype)sharedUtility{
    static Utility *sharedUtility = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedUtility = [[self alloc] init];
    });
    return sharedUtility;
}

-(id)init
{
    if(self == [super init]){
        
    }
    return self;
}

-(NSString *)getNoonStatus:(NSString *)timeString{
    if([timeString rangeOfString:@"a.m" options:NSCaseInsensitiveSearch].location != NSNotFound || [timeString rangeOfString:@"am" options:NSCaseInsensitiveSearch].location != NSNotFound){
        return @"AM";
    }else{
        return @"PM";
    }
}

-(float)getFloatvalueFromStr:(NSString *)str{
    if([str rangeOfString:@":" options:NSCaseInsensitiveSearch].location != NSNotFound){
        str = [str stringByReplacingOccurrencesOfString:@":" withString:@"."];
    }
    return [str floatValue];
}
-(NSString *)getStringBetweenBraces:(NSString *)str{
    
    NSString *betweenBraces;
    
    NSRange start = [str rangeOfString:@"("];
    NSRange end = [str rangeOfString:@")"];
    if (start.location != NSNotFound && end.location != NSNotFound && end.location > start.location) {
        betweenBraces = [str substringWithRange:NSMakeRange(start.location+1, end.location-(start.location+1))];
        
        
    }
    
    if([betweenBraces rangeOfString:@"Closed" options:NSCaseInsensitiveSearch].location != NSNotFound ){
        betweenBraces = [betweenBraces stringByReplacingOccurrencesOfString:@"Closed" withString:@""];
    }
    
    return betweenBraces;
    
}

-(NSString *)removeBraces:(NSString *)str{
    NSString *res = str;
    NSRange start = [str rangeOfString:@"("];
    NSRange end = [str rangeOfString:@")"];
    
    if (start.location != NSNotFound && end.location != NSNotFound && end.location > start.location) {
        NSString *betweenBraces = [str substringWithRange:NSMakeRange(start.location+1, end.location-(start.location+1))];
        res =[str stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"(%@)",betweenBraces] withString:@""];
        
    }
    return res;
}

-(NSString *)getTomorrowDayString:(int)date{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"EEEE:HH.mm a"];
    
    NSTimeInterval secondsPerDay = 24 * 60 * 60 *date;
    NSDate *tomorrow = [[NSDate alloc]
                        initWithTimeIntervalSinceNow:secondsPerDay];
    NSString *nowStr = [formatter stringFromDate:tomorrow];
    
    NSString *day = [[nowStr componentsSeparatedByString:@":"] firstObject];
    return day;
}

-(NSString *)findAscendingTimeFromNow:(NSDate *)date1 toDate:(NSDate *)date2{
    
    NSDateFormatter *nowForm = [[NSDateFormatter alloc] init];
    [nowForm setDateFormat:@"hh.mm a"];
    
//    //NSLog(@"date1-%@",[nowForm stringFromDate:date1]);
//    //NSLog(@"date2-%@",[nowForm stringFromDate:date2]);
    NSString *result;
    
    
    
    NSString * now = [nowForm stringFromDate:[NSDate date]];
    NSDate *nowDate = [nowForm dateFromString:now];
    
    
    NSDate *arg1 = [nowForm dateFromString:[nowForm stringFromDate:date1]];
    
    NSDate *arg2 = [nowForm dateFromString:[nowForm stringFromDate:date2]];
    NSTimeInterval intervel1 = [arg1 timeIntervalSinceDate:nowDate];
    NSTimeInterval intervel2 = [arg2 timeIntervalSinceDate:nowDate];
    if((intervel1 < 0) && (intervel2 < 0)){
        result = (intervel1<intervel2) ? [nowForm stringFromDate:arg1] : [nowForm stringFromDate:arg2];
    }else if((intervel1 > 0) && (intervel2 > 0)){
        result = (intervel1<intervel2) ? [nowForm stringFromDate:arg1] : [nowForm stringFromDate:arg2];
    }else{
        result = (intervel1>intervel2) ? [nowForm stringFromDate:arg1] : [nowForm stringFromDate:arg2];
    }
    
    
    NSString *final = [NSString stringWithFormat:@"%@-%@",[[result componentsSeparatedByString:@" "]firstObject],[[result componentsSeparatedByString:@" "]lastObject]];
    
    return final;
}

- (NSString *)stringFromTimeInterval:(NSTimeInterval)interval {
    NSInteger ti = (NSInteger)interval;
    NSInteger minutes = (ti / 60) % 60;
    NSInteger hours = (ti / 3600);
    return [NSString stringWithFormat:@"%02ld.%02ld", (long)hours, (long)minutes];
}

-(BOOL)checkDatewithNow:(NSString *)dayName{
    
    __block BOOL result = NO;
    
    NSArray *daysArray = @[@"Monday",@"Tuesday",@"Wednesday",@"Thursday",@"Friday",@"Saturdat",@"Sunday"];
    
    NSArray *daysArray2 = @[@"Mon",@"Tues",@"Wed",@"Thur",@"Fri",@"Sat",@"Sun"];
    
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"EEEE"];
    NSString *today = [formatter stringFromDate:[NSDate date]];
    [daysArray2 enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if([obj isEqualToString:dayName]){
            
            result = [[daysArray objectAtIndex:idx] isEqualToString:today] ? 1 : 0;
        }
    }];
    
    return result;
}

-(float)getAMPM:(NSString *)str{
    
    float res = 0;
    
    
    
    if([str rangeOfString:@"Closed" options:NSCaseInsensitiveSearch].location != NSNotFound ){
        
        str = [str stringByReplacingOccurrencesOfString:@"Closed" withString:@""];
        
    }
    
    if([str rangeOfString:@"a.m" options:NSCaseInsensitiveSearch].location != NSNotFound || [str rangeOfString:@"am" options:NSCaseInsensitiveSearch].location != NSNotFound ){
        
        
        
        str = [str stringByReplacingOccurrencesOfString:@":" withString:@"."];
        
        res= [str floatValue];
        
    }else{
        
        str = [str stringByReplacingOccurrencesOfString:@":" withString:@"."];
        
        float multiplier = [str floatValue];
        
        res = multiplier;
        
        if(multiplier<12){
            
            res= 12.0+res;
            
        }
        
    }
    
    return res;
    
}

-(NSString *)todayName{
    
    NSDateFormatter *newForm = [[NSDateFormatter alloc] init];
    [newForm setDateFormat:@"EEEE hh.mm a"];
    NSString *str = [newForm stringFromDate:[NSDate date]];
    
    return [[str componentsSeparatedByString:@" "] firstObject];
    
}

-(NSArray *)weekDaysArray{
    return @[@"Monday",@"Tuesday",@"Wednesday",@"Thursday",@"Friday",@"Saturday",@"Sunday"];
}

-(NSString *)getDateFormat:(NSString *)format date:(NSDate *)date{
    NSDateFormatter *form = [[NSDateFormatter alloc]init];
    [form setDateFormat:format];
    NSString *str = [form stringFromDate:date];
    return str;
}
//to check the hospital whether opend or closed, for updating the Background image in the Carousel

-(BOOL)isClinicOpen:(LocationData *)LocationData{
    BOOL result = NO;
    
    BOOL isValidDay = [self isOpeningDay:LocationData];
    BOOL isValidTime = [self isOpeningTime:LocationData];
    
    if (isValidDay && isValidTime) {
        result = YES;
    }
    return result;
}

//checking holidays

-(BOOL)isOpeningDay:(LocationData *)LocationData
{
    
    NSString *currrentDay = [self todayName];
    
    __block BOOL result = YES;
    
    NSArray *daysArray = [self weekDaysArray];
    
    NSMutableArray *arr = [NSMutableArray  new];
    if(LocationData.holidays != nil && [LocationData.holidays class] != [NSNull class]){
        for(int i=0; i<[daysArray count]; i++){
            // //NSLog(@"%@",[daysArray objectAtIndex:i] );
            if([LocationData.holidays rangeOfString:[daysArray objectAtIndex:i] options:NSCaseInsensitiveSearch].location != NSNotFound ){
                [arr addObject:[daysArray objectAtIndex:i]];
            }
        }
  
    }
    
    [arr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if([currrentDay isEqualToString:obj]){
            result = NO;
        }
    }];
    
    return result;
}

//checking the time

-(BOOL)isOpeningTime:(LocationData *)LocationData{
    
    BOOL flag = NO;
    
    float fromTime;
    float toTime;
    
    float closedFrom;
    float cloasedTo;
    
    NSString *timeDiff = [self getProperNormalTime:LocationData.normalTime];
    NSArray *arr = [timeDiff componentsSeparatedByString:@","];
    
    float timeNow = [[self getDateFormat:@"HH.mm" date:[NSDate date]] floatValue];
    fromTime = [self getAMPM:[[[arr firstObject] componentsSeparatedByString:@"-"] firstObject]];
    toTime = [self getAMPM:[[[arr firstObject] componentsSeparatedByString:@"-"] lastObject]];
    
    if(fromTime<timeNow && toTime>timeNow){
        
        flag = YES;
    }
    
    if([arr count]>1)
    {
        closedFrom = [self getAMPM:[[[arr lastObject] componentsSeparatedByString:@"-"] firstObject]];
        cloasedTo = [self getAMPM:[[[arr lastObject] componentsSeparatedByString:@"-"] lastObject]];
        if(closedFrom<timeNow && timeNow<cloasedTo){
            
            flag = NO;
        }
        
    }
    
    return flag;
}
-(NSString *)getProperNormalTime:(NSString *)time{
    
    //NSLog(@"getProperNormalTime-%@",time);
    NSString *str;
    NSArray *arr = [time componentsSeparatedByString:@","];
    if([arr count]>1 && [arr class]!=[NSNull class]){
        
        if([[arr lastObject] rangeOfString:@"Closed" options:NSCaseInsensitiveSearch].location == NSNotFound){
            
            NSString *optionDay = [self getStringBetweenBraces:[arr lastObject]];
            if([self checkDatewithNow:optionDay]){
                
                str =  [self removeBraces:[arr lastObject]];
            }else{
                str = [[time componentsSeparatedByString:@","]firstObject];
            }
        }else{
            
            str = [NSString stringWithFormat:@"%@,%@",[arr firstObject],[self removeBraces:[arr lastObject]]];
        }
        
        
    }else{
        if([self isContainBraces:[[time componentsSeparatedByString:@","]firstObject]]){
            str = [self removeBracesAndString:[[time componentsSeparatedByString:@","]firstObject]];
                   
        }else{
            str = [[time componentsSeparatedByString:@","]firstObject];
        }
        
    }
    return str;
}
//finding Opening timimgs and removed AM & PM

-(NSString *)openingTime:(LocationData *)LocationData{
    NSString *res;
    if(![LocationData.days isEqualToString:@"All Days"])
        
    {
        
    NSArray *arr = [LocationData.normalTime componentsSeparatedByString:@","];
    
    if([arr count]>1 && [arr class]!=[NSNull class]){
        
        if([[arr lastObject] rangeOfString:@"Closed" options:NSCaseInsensitiveSearch].location == NSNotFound){
            
            NSString *optionDay = [self getStringBetweenBraces:[arr lastObject]];
            if([self checkDatewithNow:optionDay]){
                
                res =  [arr lastObject];
            }else{
                res =  [arr firstObject];
            }
            
        }else{
            res =  [arr firstObject];
        }
    }else{
        res =  [self removeBraces:[arr firstObject]];
    }
    
    res = [res stringByReplacingOccurrencesOfString:@"a.m." withString:@""];
    res = [res stringByReplacingOccurrencesOfString:@"a.m" withString:@""];
    res = [res stringByReplacingOccurrencesOfString:@"am" withString:@""];
    res = [res stringByReplacingOccurrencesOfString:@"p.m." withString:@""];
    res = [res stringByReplacingOccurrencesOfString:@"p.m" withString:@""];
    res = [res stringByReplacingOccurrencesOfString:@"pm" withString:@""];
    res = [res stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    
   
    NSString *searchStr = @"-";
    NSString *subright = [res substringFromIndex:NSMaxRange([res rangeOfString:searchStr])];
     NSString *subleft = [res substringToIndex:NSMaxRange([res rangeOfString:searchStr])];
        //NSLog(@"sub string subright= %@ subleft=%@", subright,subleft);
    subleft = [subleft  stringByReplacingOccurrencesOfString:@"-" withString:@""];
    if ([subright rangeOfString:@":"].location == NSNotFound) {
       // NSLog(@"string does not contain : length =%lu",(unsigned long)[subright length]);
        subright = [subright stringByAppendingString:@":00"];
    } else {
        //NSLog(@"string contains :!");
    }
    if ([subleft rangeOfString:@":"].location == NSNotFound) {
        //NSLog(@"string does not contain : length =%lu",(unsigned long)[subleft length]);
        subleft = [subleft stringByAppendingString:@":00"];
    } else {
       // NSLog(@"string contains :!");
    }
    res =[NSString stringWithFormat:@"%@\n%@",subleft,subright];
    // NSLog(@"res time 1=%@ length =%lu",res,(unsigned long)[res length]);
    }else{
        res=@"00\n24";
    }
    return res;
    
}
//Calculate the hours about to Open or close

-(NSString *)hoursAboutToOpenTest:(LocationData *)LocationData{
    
    
    NSString *timeDiff = [self getTimeDifference:LocationData];
    
    NSArray *tempArr2 = [timeDiff componentsSeparatedByString:@"."];
    NSString *result = [NSString stringWithFormat:@"%@h:%@m",[tempArr2 firstObject],[tempArr2 lastObject]];
    return result;
    
    
}
-(NSString *)getTimeDifference:(LocationData *)LocationData{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"hh.mm a"];
    
    BOOL result = NO;
    NSDate *today = [NSDate date];
    NSDate *reqDate;
    int count = 1;
    
    NSTimeInterval interval = 0.0;
    
    do{
        
        NSString *openCloseTime = [self getOpeningTime:LocationData];
         //NSLog(@"openCloseTime--%@",openCloseTime);
        NSString *endTimeStr = [NSString stringWithFormat:@"%@ %@",[[openCloseTime componentsSeparatedByString:@"-"]firstObject],[[openCloseTime componentsSeparatedByString:@"-"]lastObject]];
        NSDate *todayFormattedDate = [formatter dateFromString:[formatter stringFromDate:today]];
        reqDate = [formatter dateFromString:endTimeStr];
        
        if([todayFormattedDate compare:reqDate]== NSOrderedAscending && ![self isHoiday:[self todayName] model:LocationData]){
            interval = [reqDate timeIntervalSinceDate:todayFormattedDate];
            result = YES;
        }else{
            
            NSString *tomorrow = [self getTomorrowDayString:count];
            if(![self isHoiday:tomorrow model:LocationData]){
                
                NSDateFormatter *newForm = [[NSDateFormatter alloc] init];
                [newForm setDateFormat:@"EEEE hh.mm a"];
                NSString *str = [NSString stringWithFormat:@"%@ %@ %@",tomorrow,[[openCloseTime componentsSeparatedByString:@"-"]firstObject],[[openCloseTime componentsSeparatedByString:@"-"]lastObject]];
                reqDate = [newForm dateFromString:str];
                
                NSString *now = [newForm stringFromDate:today];
                NSDate *todayFormattedDate = [newForm dateFromString:now];
                interval = [reqDate timeIntervalSinceDate:todayFormattedDate];
                result = YES;
                
            }else{
                count++;
            }
            
        }
        
        
    }while (!result);
    
    NSString *convertedTime = [self stringFromTimeInterval:interval];
    
    return convertedTime;
}
-(BOOL)isHoiday:(NSString *)day model:(LocationData *)LocationData{
    BOOL result = NO;
    NSArray *holidaysArr =[self getholidaysArray:LocationData];
    if([holidaysArr containsObject:day]) result = YES;
    
    return result;
}
-(NSArray *)getholidaysArray :(LocationData *)LocationData{
    NSArray *daysArray = [self weekDaysArray];
    NSMutableArray *holidaysArr = [NSMutableArray new];
    
    if(LocationData.holidays != nil && [LocationData.holidays class] != [NSNull class]){
        for(int i=0; i<[daysArray count]; i++){
            if([LocationData.holidays rangeOfString:[daysArray objectAtIndex:i] options:NSCaseInsensitiveSearch].location != NSNotFound){
                [holidaysArr addObject:[daysArray objectAtIndex:i]];
            }
        }
    }
  
    return holidaysArr;
}

-(NSString *)getOpeningTime:(LocationData *)LocationData{
    
    NSString *str = [self getProperNormalTime:LocationData.normalTime];
    BOOL haveClosedTime = [[str componentsSeparatedByString:@","] count]>1 ? YES:NO;
    float endTime;
    NSString *amPm;
    
    NSString *formatTime;
    if(![self isClinicOpen:LocationData]){
        
        if(haveClosedTime)
            formatTime=  [self getActualTime:str status:NO model:LocationData];
        else
        {
            endTime = [[[[str componentsSeparatedByString:@"-" ] firstObject] stringByReplacingOccurrencesOfString:@":" withString:@"."] floatValue];
            amPm = [self getNoonStatus:[[str componentsSeparatedByString:@"-" ] firstObject]];
            formatTime = [NSString stringWithFormat:@"%.02f-%@",endTime,amPm];
        }
    }
    else{
        
        if(haveClosedTime)
        {
            formatTime = [self getActualTime:str status:YES model:LocationData];
        }else{
            if([self isContainBraces:str]){
                str = [self removeBracesAndString:str];
            }
            endTime =[[[[str componentsSeparatedByString:@"-" ] lastObject]stringByReplacingOccurrencesOfString:@":" withString:@"."] floatValue];
            amPm = [self getNoonStatus:[[str componentsSeparatedByString:@"-" ] lastObject]];
            formatTime = [NSString stringWithFormat:@"%.02f-%@",endTime,amPm];
        }
        
    }
 
    return formatTime;
    
}
-(NSString *)removeBracesAndString:(NSString *)str{
    NSString *betweenBraces = str;
    
    NSRange start = [str rangeOfString:@"("];
    NSRange end = [str rangeOfString:@")"];
    if (start.location != NSNotFound && end.location != NSNotFound && end.location > start.location) {
        
        NSRange range = NSMakeRange(start.location, end.location-start.location+1);
        
        betweenBraces = [str stringByReplacingCharactersInRange:range withString:@""];

    }
    return betweenBraces;

}
-(NSString *)getActualTime:(NSString *)timeStr status:(BOOL)flag model:(LocationData *)locModel{
    
    NSString *actualTime;
    
    NSDateFormatter *nowForm = [[NSDateFormatter alloc] init];
    [nowForm setDateFormat:@"EEEE hh.mm a"];
    
    
    NSString *open = [[timeStr componentsSeparatedByString:@","] firstObject];
    
    NSDate *openDateStart = [nowForm dateFromString:[self formatStr:[[open componentsSeparatedByString:@"-"]firstObject] model:locModel]];
    NSDate *openDateEnd = [nowForm dateFromString:[self formatStr:[[open componentsSeparatedByString:@"-"]lastObject] model:locModel]];
    
    
    NSString *between = [[timeStr componentsSeparatedByString:@","] lastObject];
    
    
    NSDate *betDateStart = [nowForm dateFromString:[self formatStr:[[between componentsSeparatedByString:@"-"]firstObject] model:locModel]];
    NSDate *betDateEnd = [nowForm dateFromString:[self formatStr:[[between componentsSeparatedByString:@"-"]lastObject] model:locModel]];
    
    
    if(!flag){
        
        actualTime = [self findAscendingTime:openDateStart toDate:betDateEnd];
        
        
    }else{
        
        actualTime = [self findAscendingTime:openDateEnd toDate:betDateStart];
        
    }
    
    
    return actualTime;
}
-(NSString *)findAscendingTime:(NSDate *)date1 toDate:(NSDate *)date2{
    
    NSDateFormatter *nowForm = [[NSDateFormatter alloc] init];
    [nowForm setDateFormat:@"hh.mm a"];
    
//    //NSLog(@"date1-%@",[nowForm stringFromDate:date1]);
//    //NSLog(@"date2-%@",[nowForm stringFromDate:date2]);
    NSString *result;
    
    
    
    NSString * now = [nowForm stringFromDate:[NSDate date]];
    NSDate *nowDate = [nowForm dateFromString:now];
    
    
    NSDate *arg1 = [nowForm dateFromString:[nowForm stringFromDate:date1]];
    
    NSDate *arg2 = [nowForm dateFromString:[nowForm stringFromDate:date2]];
    NSTimeInterval intervel1 = [arg1 timeIntervalSinceDate:nowDate];
    NSTimeInterval intervel2 = [arg2 timeIntervalSinceDate:nowDate];
    if((intervel1 < 0) && (intervel2 < 0)){
        result = (intervel1<intervel2) ? [nowForm stringFromDate:arg1] : [nowForm stringFromDate:arg2];
    }else if((intervel1 > 0) && (intervel2 > 0)){
        result = (intervel1<intervel2) ? [nowForm stringFromDate:arg1] : [nowForm stringFromDate:arg2];
    }else{
        result = (intervel1>intervel2) ? [nowForm stringFromDate:arg1] : [nowForm stringFromDate:arg2];
    }
    
    
    NSString *final = [NSString stringWithFormat:@"%@-%@",[[result componentsSeparatedByString:@" "]firstObject],[[result componentsSeparatedByString:@" "]lastObject]];
    
    return final;
}
-(NSString *)formatStr:(NSString *)str model:(LocationData *)locModel{
    
    BOOL flag = NO;
    int  count = 0;
    NSString *formString;
    NSString *day;
    
    do{
        
        day = [self getTomorrowDayString:count];
        if([self isHoiday:day model:locModel]){
            count++;
            
        }else{
            flag = YES;
        }
        
    }while (!flag);
    
    
    if([str rangeOfString:@":" options:NSCaseInsensitiveSearch].location != NSNotFound){
        str = [str stringByReplacingOccurrencesOfString:@":" withString:@"."];
    }
    formString = [NSString stringWithFormat:@"%@ %0.2f %@",day,[str floatValue],[self getNoonStatus:str]];
    
    return formString;
}
-(NSArray *)getOpeningDayAndTimings:(LocationData *)LocationData{
    NSArray *daysArray = [self weekDaysArray];
    NSMutableArray *workingDaysArray = [[self weekDaysArray] mutableCopy];
    if(LocationData.holidays != nil){
        for(int i=0; i<[daysArray count]; i++){
            if([LocationData.holidays rangeOfString:[daysArray objectAtIndex:i] options:NSCaseInsensitiveSearch].location != NSNotFound){
                [workingDaysArray removeObject:[daysArray objectAtIndex:i]];
            }
        }
    }
   
    for(int i=0; i<[workingDaysArray count]; i++){
        NSString *str = [NSString stringWithFormat:@"%@ %@",[workingDaysArray objectAtIndex:i],LocationData.normalTime];
        [workingDaysArray replaceObjectAtIndex:i withObject:str];
    }
    
    return workingDaysArray;
}

-(BOOL)isContainBraces:(NSString *)str{
    BOOL retValue = NO;
    
    NSRange start = [str rangeOfString:@"("];
    NSRange end = [str rangeOfString:@")"];
    if (start.location != NSNotFound && end.location != NSNotFound && end.location > start.location) {
        
        retValue = YES;
        
    }
    return retValue;

}
@end
