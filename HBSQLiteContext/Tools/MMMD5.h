//
//  MMMD5.h
//  MagicBoard_Mac
//
//  Created by wave on 16/12/1.
//  Copyright © 2016年 wave. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>
#define FileHashDefaultChunkSizeForReadingData 1024*8 /// 8K

@interface MMMD5 : NSObject


///计算NSData 的MD5值
+(NSString*)getMD5WithData:(NSData*)data;

///计算字符串的MD5值，
+(NSString*)getmd5WithString:(NSString*)string;

///计算大文件的MD5值
+(NSString*)getFileMD5WithPath:(NSString*)path;


@end
