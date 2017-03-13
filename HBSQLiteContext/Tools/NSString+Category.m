//
//  NSString+Category.m
//  MagicBoard_Mac
//
//  Created by wave on 16/11/1.
//  Copyright © 2016年 wave. All rights reserved.
//

#import "NSString+Category.h"
#import "NSDictionary+Category.h"

@implementation NSString (Category)

-(BOOL)isEmail{
    NSString *regex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [emailTest evaluateWithObject:self];
}


///判断路径文件是否存在
- (BOOL)isExistAtPath{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isExist = [fileManager fileExistsAtPath:self];
    return isExist;
}

/// 判断是文件夹还是文件
-(BOOL)isFolder
{
    BOOL isDir = NO;
    [[NSFileManager defaultManager] fileExistsAtPath:self isDirectory:&isDir];
    
    return isDir;
}

-(NSString *)getUserName
{
    NSArray *array = [self componentsSeparatedByString:@"/"];
    
    NSString *userName = array[2];
    
    return userName;
}

-(NSUInteger)getPathCount
{
    NSArray *array = [self componentsSeparatedByString:@"/"];
    return array.count;
}

- (NSString *)base64EncodedString;
{
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    return [data base64EncodedStringWithOptions:0];
}

- (NSString *)base64DecodedString
{
    NSData *data = [[NSData alloc]initWithBase64EncodedString:self options:0];
    return [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
}

@end
