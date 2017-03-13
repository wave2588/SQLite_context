//
//  NSFileManager+Category.h
//  SketchExport
//
//  Created by wave on 16/10/25.
//  Copyright © 2016年 com.ichengzivrqianiu.orgz. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^CompletionJSONCallBackBlock)(id dict, NSError *error);

@interface NSFileManager (Category)

///*********************文件夹操作*********************

/**
 *  给一个路径和文件名称,创建一个文件夹来保存资源
 *
 *  @path：路径
 *  @directoryName: 文件名称
 */
- (NSString *)createDirectoryAtPath:(NSString *)path directoryName:(NSString *)name;

/**
 *  给一个路径和文件名称,读取这个路径下所有资源
 *
 *  @path：路径
 *  @directoryName: 文件名称
 */
- (NSArray*)fetchDirectoryAtPath:(NSString*)path directoryName:(NSString *)name;


///*********************文件操作*********************

/**
 *  给一个路径和文件名称,创建一个文件
 *
 *  @path：路径
 *  @content: 文件名称
 */
- (NSString *)createFileAtPath:(NSString *)path fileName:(NSString *)name;

/**
 *  给一个路径和文件名称,删除文件
 *
 *  @path：路径
 *  @fileName: 文件名称
 */
- (BOOL)removeFileAtPath:(NSString *)path fileName:(NSString *)name;

/**
 *  给一个路径和文件名称,获取文件内容
 *
 *  @path：路径
 */
- (void)getFileContentAtPath:(NSString *)path fileName:(NSString *)name completion:(CompletionJSONCallBackBlock)callback;

/**
 *  给一个路径和内容,累加写入文件
 *
 *  @path：路径
 *  @content: 写入内容
 */
- (void)writeContentAtPath:(NSString *)path content:(NSString *)content;


/**
 *  修改文件名称

 @param oldPath 要修改文件名称的路径
 @param newFileName 新的文件名称
 @return 返回修改结果
 */
-(BOOL)changeFileNameInPath:(NSString *)oldPath newFileName:(NSString *)newFileName;



- (unsigned long long)fileSizeAtPath:(NSString *)filePath;
- (unsigned long long)folderSizeAtPath:(NSString*)folderPath;

@end
