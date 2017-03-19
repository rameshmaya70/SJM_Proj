//
//  Utility.m
//  Sjmo
//
//  Created by Ramesh Khanna on 5/21/15.
//  Copyright (c) 2015 Altimetrik. All rights reserved.
//

#import "ImageDownloader.h"
#import "NSData+Base64.h"

@implementation ImageDownloader

-(NSData *)downloadImage:(NSString *) urlString{
    

    NSURL* url = [NSURL URLWithString:urlString];
   
    NSString *userName = @"sjmoPhysianImages";
    NSString *password = @"0d769db5a50f0b1f";
    
    NSError *myError = nil;
    
    // create a plaintext string in the format username:password
    NSMutableString *loginString = (NSMutableString*)[@"" stringByAppendingFormat:@"%@:%@", userName, password];
    NSData *encodeData = [loginString dataUsingEncoding:NSUTF8StringEncoding];
    // employ the Base64 encoding above to encode the authentication tokens
   
    NSString *authValue = [NSString stringWithFormat:@"Basic %@", [encodeData base64EncodedString]];
    

    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL: url
                                                           cachePolicy: NSURLRequestReloadIgnoringCacheData
                                                       timeoutInterval: 3];
    
    // add the header to the request.  Here's the $$$!!!
    [request addValue:authValue forHTTPHeaderField:@"Authorization"];
    
    // perform the reqeust
    NSURLResponse *response;
    
    NSData *data = [NSURLConnection
                    sendSynchronousRequest: request
                    returningResponse: &response
                    error: &myError];
    
   
    return data;
    
}

-(void)saveImageInDocDirectory:(NSString *)url data:(NSData *)imgData{
    
    
        NSArray *arr = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *str = [[url componentsSeparatedByString:@"/"] lastObject];
        NSString *path = [arr.lastObject stringByAppendingPathComponent:str];
        [imgData writeToFile:path atomically:NO];
   
   
}

-(BOOL)checkImageExistance:(NSString *)urlString{
    
    NSArray *arr = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *str = [[urlString componentsSeparatedByString:@"/"] lastObject];
    NSString *path = [arr.lastObject stringByAppendingPathComponent:str];
 
    return [[NSFileManager defaultManager] fileExistsAtPath:path];
    
}

-(NSData *)getDownloadedImage:(NSString *)urlString{
    
    NSArray *arr = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *str = [[urlString componentsSeparatedByString:@"/"] lastObject];
    NSString *path = [arr.lastObject stringByAppendingPathComponent:str];
        
    return [NSData dataWithContentsOfFile:path];
}

@end
