//
//  NSString+Category.h
//  MagicBoard_Mac
//
//  Created by wave on 16/11/1.
//  Copyright © 2016年 wave. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Category)

- (BOOL)isEmail;

- (BOOL)isExistAtPath;

- (BOOL)isFolder;

- (NSString *)getUserName;

- (NSUInteger)getPathCount;

/**
 *  转换为Base64编码
 */
- (NSString *)base64EncodedString;
/**
 *  将Base64编码还原
 */
- (NSString *)base64DecodedString;



+(NSString *)getQiNiuKey:(NSString *)path;

@end
