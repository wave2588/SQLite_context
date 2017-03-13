//
//  MMSQLiteObject.h
//  TestFMDB
//
//  Created by wave on 2017/1/6.
//  Copyright © 2017年 wave. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FMDatabase;

@interface HBSQLiteObject : NSObject

@property(nonatomic,readonly) FMDatabase *db;

+ (instancetype)sharedInstance;

-(BOOL)openDBWithDBName:(NSString *)DBName;

-(void)close;

@end
