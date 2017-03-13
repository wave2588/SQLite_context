//
//  NSString+JSONCategories.h
//  LingVR
//
//  Created by Apple on 15/9/12.
//  Copyright (c) 2015年 LingVR. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (JSONCategories)
// 返回NSArray或者NSDictionary
- (id)JSONValue;
@end
