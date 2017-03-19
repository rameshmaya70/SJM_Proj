//
//  LocationData.m
//  SJMO
//
//  Created by Ramesh Khanna on 9/18/14.
//  Copyright (c) 2014 Satya Bhanu Nayak. All rights reserved.
//

#import "LocationData.h"
@implementation LocationData

-(id)initWithDictionary:(NSDictionary *)dic{
    if(self = [super init]){
        self.IDVAL = [dic objectForKey:@"ID"];

        self.name = [dic objectForKey:@"Name"];
        self.category= [dic objectForKey:@"Category"];
        self.address= [dic objectForKey:@"Address"];
        self.latitude= [dic objectForKey:@"Lattitude"];
        self.longitude= [dic objectForKey:@"Longitude"];
        self.phone = [dic objectForKey:@"Phone"];
        self.street = [dic objectForKey:@"Street"];
        self.city = [dic objectForKey:@"City"];
        self.state = [dic objectForKey:@"State"];
        self.zip = [dic objectForKey:@"Zip"];
        self.days = [dic objectForKey:@"Normal_Days"];
        self.normalTime = [dic objectForKey:@"Normal_Time"];
        self.holidays = [dic objectForKey:@"Holidays"];
        self.holidaysTime = [dic objectForKey:@"Holiday_Time"];
        
    }
    
    return self;
}

-(NSString *)getCombinedString{
    
    
    @try {
        
        if([self.holidays length] == 0){
            
            self.holidays =@"";
            
            
            
        }
        
        if([self.holidaysTime length] == 0){
            
            self.holidaysTime=@"";
            
        }
        
    }
    
    @catch (NSException *exception) {
        
        self.holidays =@"";
        
        self.holidaysTime=@"";
        
    }
    
    @finally {
        
    }
    
    
    
    return [NSString stringWithFormat:@"%@ %@ %@ %@",self.days,self.normalTime,self.holidays,self.holidaysTime];
}

@end
