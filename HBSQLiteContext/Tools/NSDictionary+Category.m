//
//  NSDictionary+Category.m
//  MagicBoard_Mac
//
//  Created by wave on 2017/2/15.
//  Copyright © 2017年 wave. All rights reserved.
//

#import "NSDictionary+Category.h"

@implementation NSDictionary (Category)

+ (NSString*)dictionaryToJson:(NSDictionary *)dic
{
        NSError *parseError = nil;
        
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
        
        return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString
{
        if (jsonString == nil)
        {
                return nil;
        }
        NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
        
        NSError *err;
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                            options:NSJSONReadingMutableContainers
                                                              error:&err];
        if(err)
        {
                NSLog(@"json解析失败：%@",err);
                return nil;
        }
        return dic;
}



@end
