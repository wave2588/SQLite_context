//
//  MMSQLiteContext.h
//  TestFMDB
//
//  Created by wave on 2017/1/6.
//  Copyright © 2017年 wave. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HBSQLiteContext : NSObject

@property (nonatomic,readonly) NSInteger  count;                  // 表里的记录总数
@property (nonatomic,copy)     NSString  *tableName;              // 表名
@property (nonatomic,strong)   NSArray   *findDataKeys;           // 通过数组里的key去查找数据
@property (nonatomic,strong)   NSArray   *fldList;                // 所有字段数组
@property (nonatomic,copy)     NSString  *key;                    // 主键
@property (nonatomic,copy)     NSString  *timeKey;                // 按照时间查询的key


- (NSInteger)rowNumbers;

-(BOOL)insert:(id)model;

-(BOOL)update:(id)model;

-(BOOL)delete:(id)model;

-(NSArray *)findAll;

-(id)findByModel:(id)model;

/// 查询
-(NSArray *)findItemByKey:(NSString *)key value:(NSString *)value;

/// 模糊查询
-(NSArray *)fuzzyQueryByKey:(NSString *)key value:(NSString *)value;

/// 删除所有表中数据,谨慎使用
-(BOOL)deleteAllData;

-(NSArray *)findAllInTimeQuery;



@end
