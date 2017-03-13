//
//  MMSQLiteContext.m
//  TestFMDB
//
//  Created by wave on 2017/1/6.
//  Copyright © 2017年 wave. All rights reserved.
//

#import "HBSQLiteContext.h"
#import "HBSQLiteObject.h"
#import <FMDB/FMDB.h>

@interface HBSQLiteContext ()

@property (nonatomic,assign) FMDatabase *db;

@end

@implementation HBSQLiteContext

-(instancetype)init
{
        if (self = [super init])
        {
                _db = [HBSQLiteObject sharedInstance].db;
                if (!_db)
                {
                        return nil;
                }
        }
        return self;
}

-(BOOL)insert:(id)model
{
        if (!model)
        {
                return NO;
        }
        
        if ([self findByKey:model])
        {
//                DLog(@"info: add %@ exsist model ~~~!\n",self.tableName);
                return [self update:model];
        }
        
        NSInteger fieldCount = self.fldList.count;
        
        NSMutableString *vals = [NSMutableString string];
        
        for (int i = 0; i < fieldCount; i++)
        {
                if(i != fieldCount-1)
                {
                        [vals appendString:@"?,"];
                }
                else
                {
                        [vals appendString:@"?"];
                }
        }
        
        NSString *fieldString = [self.fldList componentsJoinedByString:@","];
        NSString *sql = [NSString stringWithFormat:@"INSERT INTO %@ (%@) VALUES ( %@ )",self.tableName,fieldString,vals];
//        DLog(@"insert sql ------>: %@",sql);
    
        NSMutableArray *args=[NSMutableArray array];
        for (int i = 0; i < fieldCount; i++)
        {
                NSString *mapKey = [self.fldList objectAtIndex:i];
                id value = [model valueForKey:mapKey];
                if (!value)
                {
                        value = [NSNull null];
                }
                [args addObject:value];
        }
        
        BOOL isOK = [self.db executeUpdate:sql withArgumentsInArray:args];
//        DLog(@"insert lastErrorMessage ---> %@",[self.db lastErrorMessage]);
    
        return isOK;
}

-(BOOL)update:(id)model
{
        if (!model)
        {
                return NO;
        }
        
        if (![self findByKey:model])
        {
//                DLog(@"info: no exsist update model~~~!\n");
                return NO;
        }
        
        NSInteger keyCount = self.fldList.count;
        NSMutableString *fldListStr = [NSMutableString string];
        
        NSMutableArray *args=[NSMutableArray array];
        
        for (int i = 0; i < keyCount; i++)
        {
                NSString *fName = [self.fldList objectAtIndex:i];
                id value = [model valueForKey:fName];
                if (!value)
                {
                        value = [NSNull null];
                }
                [args addObject:value];
                
                if(i != keyCount-1)
                {
                        [fldListStr appendFormat:@"%@ = ?,",fName];
                }
                else
                {
                        [fldListStr appendFormat:@"%@ = ?",fName];
                }
        }
        
        NSString *wheres = [self wheres:model];
        
        NSString *sql = [NSString stringWithFormat:@"UPDATE %@ SET %@ WHERE %@ ",self.tableName,fldListStr,wheres];
//        DLog(@"update sql=%@",sql);
    
        BOOL isOK = [self.db executeUpdate:sql withArgumentsInArray:args];
//        DLog(@"update lastErrorMessage ---> %@",[self.db lastErrorMessage]);
    
        return isOK;
}

-(BOOL)delete:(id)model
{
        if (!model)
        {
                return NO;
        }
        
        if (![self findByKey:model])
        {
//                DLog(@"info: no exsist delete model~~~!\n");
                return NO;
        }
        
        NSString *wheres = [self wheres:model];
        
        NSString *sql = [NSString stringWithFormat:@"DELETE FROM  %@ WHERE %@ ",self.tableName,wheres];
//        DLog(@"delete sql=%@",sql);
    
        BOOL isOK  = [self.db executeUpdate:sql];
//        DLog(@"delete lastErrorMessage ---> %@",[self.db lastErrorMessage]);
    
        return isOK;
}

-(id)findByKey:(id)key
{
        NSString *objStr = [self findTableObject:self.tableName];
        id model = [[NSClassFromString(objStr) alloc] init];
        if ([key isKindOfClass:[model class]])
        {
                return [self findByModel:key];
        }
        else
        {
                id retModel = model;
                NSInteger findKeyCount = self.findDataKeys.count;
                for (int i = 0; i < findKeyCount; i++)
                {
                        NSString *mapKey = [self.findDataKeys objectAtIndex:i];
                        [retModel setValue:key forKey:mapKey];
                }
                return [self findByModel:retModel];
        }
        
        return NO;
}

/// 通过一个key value去查找数据,返回的是一个数组
-(NSArray *)findItemByKey:(NSString *)key value:(NSString *)value
{
        NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE %@ = '%@'",self.tableName,key,value];
        
        FMResultSet *rs = [self.db executeQuery:sql];
        
        NSMutableArray *models = [NSMutableArray array];
        while ([rs next])
        {
                NSString *objStr = [self findTableObject:self.tableName];
                id model = [[NSClassFromString(objStr) alloc] init];
                for(NSString  *mapkey in self.fldList)
                {
                        id obj=[rs objectForColumnName: mapkey];
                        if([obj isEqual:[NSNull null]])
                        {
                            continue;
                        }
                        [model setValue:obj forKey:mapkey];
                }
                
                [models addObject:model];
        }

        [rs close];
    
        if (models > 0)
        {
            return models;
        }
    
        return nil;
}

/// 模糊查询
-(NSArray *)fuzzyQueryByKey:(NSString *)key value:(NSString *)value
{
        NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE %@ LIKE '%%%@%%'",self.tableName,key,value];
        FMResultSet *rs = [self.db executeQuery:sql];
        NSMutableArray *models = [NSMutableArray array];
        while ([rs next])
        {
                NSString *objStr = [self findTableObject:self.tableName];
                id model = [[NSClassFromString(objStr) alloc] init];
                for(NSString  *mapkey in self.fldList)
                {
                        id obj=[rs objectForColumnName: mapkey];
                        if([obj isEqual:[NSNull null]])
                        {
                                continue;
                        }
                        [model setValue:obj forKey:mapkey];
                }
                
                [models addObject:model];
        }
        
        [rs close];
        
        if (models > 0)
        {
                return models;
        }
        
        return nil;
}


/// 通过findDataKeys获取记录
-(id)findByModel:(id)model
{
        if (!model)
        {
                return nil;
        }
    
        NSInteger findKeyCount = [self.findDataKeys count];
        if (findKeyCount <= 0)
        {
//                DLog(@"findDataKeys不能为空");
                return nil;
        }
        
        NSString *wheres = [self wheres:model];
        
        NSString *sql = [NSString stringWithFormat:@"SELECT * FROM  %@  WHERE %@",self.tableName,wheres];
//        DLog(@"%@",sql);
        
        FMResultSet *rs = [self.db executeQuery:sql];
        
        if ([rs next])
        {
                NSString *objStr = [self findTableObject:self.tableName];
                id model = [[NSClassFromString(objStr) alloc] init];
                
                for (NSString *mapKey in self.fldList)
                {
                        id obj = [rs objectForKeyedSubscript:mapKey];
                        if ([obj isEqual:[NSNull null]])
                        {
                                continue;
                        }
                        
                        [model setValue:obj forKey:mapKey];
                }
                
                [rs close];
                return model;
        }
        
        return nil;
}


/// 获取总共数据的条数
- (NSInteger)rowNumbers
{
        if(!self.tableName)
        {
                return 0;
        }
        
        NSString *sql =[NSString stringWithFormat:@"SELECT count(*) as count FROM %@", self.tableName];
        FMResultSet *rs = [self.db executeQuery:sql];
        _count = 0;
        
        if([rs next])
        {
                _count  = [rs intForColumnIndex:0];
        }
        [rs close];
        return _count;
}

/// 获取所有记录,并且按照时间排序
-(NSArray *)findAllInTimeQuery
{
        NSString *sql = [NSString stringWithFormat:@"SELECT * FROM  %@ ORDER BY %@ DESC",self.tableName,self.timeKey];
        FMResultSet *rs = [self.db executeQuery:sql];
        return [self sqlQueryFetch:rs];
}

/// 获取所有记录
- (NSArray*)findAll
{
        NSString *sql = [NSString stringWithFormat:@"SELECT * FROM  %@  ",self.tableName];
//        DLog(@"findAll sql=%@",sql);
        FMResultSet *rs = [self.db executeQuery:sql];
        return [self sqlQueryFetch:rs];
}

- (NSArray*)sqlQueryFetch:(FMResultSet*)rs
{
        NSMutableArray *models = [NSMutableArray array];
        while ([rs next])
        {
                NSString *objStr = [self findTableObject:self.tableName];
                id model = [[NSClassFromString(objStr) alloc] init];
                for(NSString  *mapkey in self.fldList)
                {
                        id obj=[rs objectForColumnName: mapkey];
                        if([obj isEqual:[NSNull null]])
                        {
                                continue;
                        }
                        [model setValue:obj forKey:mapkey];
                }
                
                [models addObject:model];
        }
        
        [rs close];
        
        if(models.count>0)
        {
                return models;
        }
        
        return nil;
}


/// 获取查找的条件语句
-(NSString *)wheres:(id)model
{
        NSInteger findKeyCount = [self.findDataKeys count];
        NSMutableString *wheres = [NSMutableString string];
        
        for (int i = 0; i < findKeyCount; i++)
        {
                NSString *findKey = self.findDataKeys[i];
                id value = [model valueForKey:findKey];
                
                if (!value)
                {
                        value = [NSNull null];
                }
                
                if(i != findKeyCount-1)
                {
                        [wheres appendFormat:@"%@ = '%@' or ",findKey,value];
                }
                else
                {
                        [wheres appendFormat:@"%@ = '%@'",findKey,value];
                }
        }
        
        return wheres;
}

-(BOOL)deleteAllData
{
        NSString *sql = [NSString stringWithFormat:@"DELETE FROM %@",self.tableName];
        BOOL isDeleteOK = [self.db executeUpdate:sql];
        if (isDeleteOK)
        {
                return [self.db executeUpdate:[NSString stringWithFormat:@"UPDATE sqlite_sequence set seq=0 where name='%@'",self.tableName]];
        }
        else
        {
                return NO;
        }
}

-(NSString *)findTableObject:(NSString *)tableName
{
        NSDictionary *dict = @{
                               @"File"   : @"MMFileItem",
                               @"Record" : @"MMRecordItem"
                             };
        
        NSString *modelName = dict[tableName];
        if (modelName)
        {
                return modelName;
        }
        
        return nil;
}

@end
