//
//  MMFileItem.h
//  MagicBoard_Mac
//
//  Created by wave on 2017/2/14.
//  Copyright © 2017年 wave. All rights reserved.
//

#import "HBBaseItem.h"

@class HBRecordItem,HBFileItem;


@interface HBFileItemDAO : HBSQLiteContext

@end




@interface HBFileItem : HBBaseItem

@property (nonatomic,copy) NSString *id;

@property (nonatomic,copy) NSString *file_md5;

@property (nonatomic,copy) NSString *file_name;

@property (nonatomic,copy) NSString *file_createTime;

@property (nonatomic,copy) NSString *file_localPath;

@end
