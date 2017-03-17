//
//  MMFileItem.m
//  MagicBoard_Mac
//
//  Created by wave on 2017/2/14.
//  Copyright © 2017年 wave. All rights reserved.
//

#import "HBFileItem.h"

@implementation HBFileItemDAO

-(instancetype)init
{
        if (self = [super init])
        {
                self.tableName      = @"File";
                
                self.fldList        = [[NSArray alloc]initWithObjects:@"file_md5",@"file_name",@"file_createTime",@"file_localPath",nil];
                
                self.findDataKeys   = [[NSArray alloc]initWithObjects:@"file_localPath",nil];
                
                self.key            = @"id";
        }
        return self;
}


@end



@implementation HBFileItem



@end
