//
//  NSString+JSONCategories.m
//  LingVR
//
//  Created by Apple on 15/9/12.
//  Copyright (c) 2015年 LingVR. All rights reserved.
//

#import "NSString+JSONCategories.h"

@implementation NSString (JSONCategories)

// 返回NSArray或者NSDictionary
- (id)JSONValue {
    NSData* data = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSError* error = nil;
    id result = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    if (error != nil) return nil;
    return result;
}
@end
