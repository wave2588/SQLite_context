//
//  MMBaseItem.m
//  TestFMDB
//
//  Created by wave on 2017/1/6.
//  Copyright © 2017年 wave. All rights reserved.
//

#import "HBBaseItem.h"

@interface HBBaseItem ()

@property (nonatomic,strong) HBSQLiteContext *context;

@end

@implementation HBBaseItem

-(id)initWithDictionary:(NSDictionary *)dictionary
{
        self = [super init];
        if(!self)
        {
                return nil;
        }
        return self;
}

-(HBSQLiteContext *)context
{
        if (!_context)
        {
                NSString *selfName = NSStringFromClass([self class]);
                
                NSString *className = [NSString stringWithFormat:@"%@DAO",selfName];
                
                Class class = NSClassFromString(className);
                
                return [[class alloc]init];
        }
        return _context;
}

-(BOOL)save
{
        return [self.context insert:self];
}

-(BOOL)update
{
        return [self.context update:self];
}

-(BOOL)delete
{
        return [self.context delete:self];
}

-(id)findByModel
{
        return [self.context findByModel:self];
}


-(NSInteger)rowNumbers
{
        return [self.context rowNumbers];
}

+(NSInteger)rowNumbers
{
        return [[[self alloc] init] rowNumbers];
}




-(NSArray *)findAll
{
        return [self.context findAll];
}

+(NSArray *)findAll
{
        return [[[self alloc] init] findAll];
}



-(NSArray *)findAllInTimeQuery
{
        return [self.context findAllInTimeQuery];
}

+(NSArray *)findAllInTimeQuery
{
        return [[[self alloc] init] findAllInTimeQuery];
}




-(NSArray *)findByItemsForKey:(NSString *)key value:(NSString *)value
{
        return [self.context findItemByKey:key value:value];
}

+(NSArray *)findByItemsForKey:(NSString *)key value:(NSString *)value
{
        return [[[self alloc] init] findByItemsForKey:key value:value];
}




-(NSArray *)fuzzyQueryByKey:(NSString *)key value:(NSString *)value
{
        return [self.context fuzzyQueryByKey:key value:value];
}

+(NSArray *)fuzzyQueryByKey:(NSString *)key value:(NSString *)value
{
        return [[[self alloc] init] fuzzyQueryByKey:key value:value];
}




-(BOOL)deleteAllData
{
        return [self.context deleteAllData];
}

+(BOOL)deleteAllData
{
        return [[[self alloc] init] deleteAllData];
}

@end
