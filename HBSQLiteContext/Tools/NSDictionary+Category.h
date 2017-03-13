//
//  NSDictionary+Category.h
//  MagicBoard_Mac
//
//  Created by wave on 2017/2/15.
//  Copyright © 2017年 wave. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Category)

/// 字典转json
+ (NSString*)dictionaryToJson:(NSDictionary *)dic;

+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;

@end
