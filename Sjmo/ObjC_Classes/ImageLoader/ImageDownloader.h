//
//  Utility.h
//  Sjmo
//
//  Created by Ramesh Khanna on 5/21/15.
//  Copyright (c) 2015 Altimetrik. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImageDownloader : NSObject
-(NSData *)downloadImage:(NSString *) urlString;
-(BOOL)checkImageExistance:(NSString *)urlString;
-(NSData *)getDownloadedImage:(NSString *)urlString;
-(void)saveImageInDocDirectory:(NSString *)url data:(NSData *)imgData;
@end
