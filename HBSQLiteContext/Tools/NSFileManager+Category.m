//
//  NSFileManager+Category.m
//  SketchExport
//
//  Created by wave on 16/10/25.
//  Copyright © 2016年 com.ichengzivrqianiu.orgz. All rights reserved.
//

#import "NSFileManager+Category.h"
#import "NSString+Category.h"
#import "NSString+JSONCategories.h"

@implementation NSFileManager (Category)

///指定一个路径 创建一个新的文件夹
-(NSString *)createDirectoryAtPath:(NSString *)path directoryName:(NSString *)name{
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    path = [path stringByAppendingPathComponent:name];
    
    if ([path isExistAtPath]){
        
//        DLog(@"%@ not create   path-->: %@",name,path);
        return path;
    }else{
        BOOL isSuccess = [fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
        if (isSuccess) {
//            DLog(@"%@ create success   path-->: %@",name,path);
            return path;
        } else {
//            DLog(@"%@ create fail   path-->: %@",name,path);
            return nil;
        }
    }
    return nil;
}

///获取路径下所有文件
-(NSArray*)fetchDirectoryAtPath:(NSString*)path directoryName:(NSString *)name{
    path = [path stringByAppendingPathComponent:name];
    
    NSMutableArray* array = [NSMutableArray array];
    
    if ([path isExistAtPath]){
        NSFileManager* fileMgr = [NSFileManager defaultManager];
        NSArray* tempArray = [fileMgr contentsOfDirectoryAtPath:path error:nil];
        for (NSString* fileName in tempArray) {
            if (![fileName isEqualToString:@".DS_Store"]) {             //// 这里太变态了,文件夹为空的时候就竟然有.DS_Store文件,重点还是删不掉!!!!!!
                BOOL flag = YES;
                NSString* fullPath = [path stringByAppendingPathComponent:fileName];
//                if ([fileMgr fileExistsAtPath:fullPath isDirectory:&flag]) {
//                    if (!flag) {
//                        [array addObject:fullPath];
//                    }
//                }
                
                if (fullPath.isExistAtPath) {
                    [array addObject:fullPath];
                }
                
            }
        }
        return array;
    }
    
//    DLog(@"%@  没有找到路径,无法读取",name);
    
    return array;
}

///创建文件
-(NSString *)createFileAtPath:(NSString *)path fileName:(NSString *)name{
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    path = [path stringByAppendingPathComponent:name];
    
    if ([path isExistAtPath]){
        
//        DLog(@"%@ not create   path-->: %@",name,path);
        return path;
        
    }else{
        BOOL isSuccess = [fileManager createFileAtPath:path contents:nil attributes:nil];
        if (isSuccess) {
//            DLog(@"%@ create success   path-->: %@",name,path);
            return path;
        } else {
//            DLog(@"%@ create fail   path-->: %@",name,path);
            return nil;
        }
    }

    return nil;
}

///删除文件
-(BOOL)removeFileAtPath:(NSString *)path fileName:(NSString *)name{
    path = [path stringByAppendingPathComponent:name];
    
    if ([path isExistAtPath]){
        BOOL success = [[NSFileManager defaultManager]removeItemAtPath:path error:nil];
        if (success)
        {
            return YES;
        }
        else
        {
            return NO;
        }
    }else{
        return YES;
    }
}

-(void)getFileContentAtPath:(NSString *)path fileName:(NSString *)name completion:(CompletionJSONCallBackBlock)callback{
    
    path = [path stringByAppendingPathComponent:name];
    
    NSData *data = [[NSFileManager defaultManager]contentsAtPath:path];
    
//    DLog(@"%@",data);
    
    if (data != nil) {
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            NSError *error = nil;
            
            id result = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
            
            //        DLog(@"%@",result);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                callback(result,error);
            });
        });
    }
}

-(void)writeContentAtPath:(NSString *)path content:(NSString *)content{
    
    NSFileHandle *fileHandle = [NSFileHandle fileHandleForWritingAtPath:path];
    
    [fileHandle seekToEndOfFile];
    
    NSString *resultStr = [NSString stringWithFormat:@"%@",content];
    
    NSData* stringData  = [resultStr dataUsingEncoding:NSUTF8StringEncoding];
    
    [fileHandle writeData:stringData];      ///追加写入数据
    
    [fileHandle closeFile];
}

-(BOOL)changeFileNameInPath:(NSString *)oldPath newFileName:(NSString *)newFileName
{
    NSString *newPath = [[oldPath stringByDeletingLastPathComponent] stringByAppendingPathComponent:newFileName];
    return [[NSFileManager defaultManager] moveItemAtURL:[NSURL fileURLWithPath:oldPath] toURL:[NSURL fileURLWithPath:newPath] error:nil];
}



/// 计算文件大小
- (unsigned long long)fileSizeAtPath:(NSString *)filePath
{
        NSFileManager *fileManager = [NSFileManager defaultManager];
        BOOL isExist = [fileManager fileExistsAtPath:filePath];
        if (isExist)
        {
                unsigned long long fileSize = [[fileManager attributesOfItemAtPath:filePath error:nil] fileSize];
                return fileSize;
        }
        else
        {
                NSLog(@"file is not exist");
                return 0;
        }
}

/// 计算文件夹大小
- (unsigned long long)folderSizeAtPath:(NSString*)folderPath
{
        NSFileManager *fileManager = [NSFileManager defaultManager];
        BOOL isExist = [fileManager fileExistsAtPath:folderPath];
        if (isExist)
        {
                NSEnumerator *childFileEnumerator = [[fileManager subpathsAtPath:folderPath] objectEnumerator];
                unsigned long long folderSize = 0;
                NSString *fileName = @"";
                while ((fileName = [childFileEnumerator nextObject]) != nil)
                {
                    NSString* fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
                    folderSize += [self fileSizeAtPath:fileAbsolutePath];
                }
                return folderSize / (1024.0 * 1024.0);
        }
        else
        {
                NSLog(@"file is not exist");
                return 0;
        }
}




@end
