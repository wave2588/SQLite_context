//
//  MMSQLiteObject.m
//  TestFMDB
//
//  Created by wave on 2017/1/6.
//  Copyright © 2017年 wave. All rights reserved.
//

#import "HBSQLiteObject.h"
#import <FMDB/FMDB.h>
#import "NSString+Category.h"
#import "NSFileManager+Category.h"

@interface HBSQLiteObject ()

@property(nonatomic,readwrite)FMDatabase *db;

@property(nonatomic,strong)NSString *dbName;

@end

@implementation HBSQLiteObject

-(void)dealloc
{
        [self close];
}

+ (instancetype)sharedInstance
{
        static HBSQLiteObject *instace = nil;
        static dispatch_once_t oncePredicate;
        dispatch_once(&oncePredicate, ^{
                instace = [[self alloc] init];
        });
        return instace;
}

-(BOOL)openDBWithDBName:(NSString *)DBName
{
        self.dbName = DBName;
        
        NSString *path = [self supportPath];
    
        if (path.isExistAtPath)
        {
                DLog(@"database exist, not create");
        }
        else
        {
                NSString *filePath = [[NSFileManager defaultManager] createFileAtPath:path fileName:nil];
                if (filePath)
                {
                        DLog(@"database found success");
                }
                else
                {
                        return NO;
                }
        }
        
        self.db = [FMDatabase databaseWithPath:path];
    
        if(![self.db open])
        {
                [self.db setShouldCacheStatements:YES];
                DLog(@"error opening the database!");
                return NO;
        }
    
        DLog(@"database path :  %@",path);

        [self.db executeUpdate:@"create table if not exists File(id integer primary key autoincrement,file_md5 text,file_name text,file_createTime text,file_localPath text)"];
    
        return YES;
}

-(void)close
{
        [self.db close];
}

- (NSString *)supportPath
{
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, YES);
        NSString *path = [paths objectAtIndex:0];
        path = [path stringByAppendingPathComponent:self.dbName];
        return path;
}



@end
