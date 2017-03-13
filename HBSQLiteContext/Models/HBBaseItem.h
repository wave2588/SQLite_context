//
//  MMBaseItem.h
//  TestFMDB
//
//  Created by wave on 2017/1/6.
//  Copyright © 2017年 wave. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HBSQLiteContext.h"

@interface HBBaseItem : NSObject

- (id)initWithDictionary:(NSDictionary *)dictionary;


/// 以下接口是通过findDataKeys字段去对这条数据做操作,findDataKeys是个数组,会依次根据数组里的值去查找.
-(BOOL)save;
-(BOOL)update;
-(BOOL)delete;
-(id)findByModel;


/// 数据总个数
-(NSInteger)rowNumbers;
+(NSInteger)rowNumbers;


/// 查找表中所有数据
-(NSArray *)findAll;
+(NSArray *)findAll;


/// 查找表中所有数据,按时间排序
-(NSArray *)findAllInTimeQuery;
+(NSArray *)findAllInTimeQuery;


/// 根据字段去查找
-(NSArray *)findByItemsForKey:(NSString *)key value:(NSString *)value;
+(NSArray *)findByItemsForKey:(NSString *)key value:(NSString *)value;


/// 模糊查询
-(NSArray *)fuzzyQueryByKey:(NSString *)key value:(NSString *)value;
+(NSArray *)fuzzyQueryByKey:(NSString *)key value:(NSString *)value;


/// 删除所有数据,谨慎使用
-(BOOL)deleteAllData;
+(BOOL)deleteAllData;


@end
