//
//  ViewController.m
//  HBSQLiteContext
//
//  Created by wave on 2017/3/13.
//  Copyright © 2017年 wave. All rights reserved.
//

#import "ViewController.h"
#import "HBFileItem.h"

@implementation ViewController

- (IBAction)saveAction:(id)sender {
    
    HBFileItem *item = [[HBFileItem alloc]init];
    item.file_name = @"test.png";
    item.file_md5 = @"555";
    item.file_createTime = @"11";
    item.file_localPath = @"1";
    
    if ([item save]) {
        DLog(@"save success");
    }else{
        DLog(@"save fail");
    }
}


- (IBAction)deleteAction:(id)sender {
    
    HBFileItem *item = [[HBFileItem alloc]init];
    item.file_localPath = @"1";
    item = [item findByModel];
    
    if (item) {
        if ([item delete]) {
            DLog(@"delete success");
        }else{
            DLog(@"delete fail");
        }
    }else{
        DLog(@"not exist");
    }
}




@end
