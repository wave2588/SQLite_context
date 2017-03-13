//
//  AppDelegate.m
//  HBSQLiteContext
//
//  Created by wave on 2017/3/13.
//  Copyright © 2017年 wave. All rights reserved.
//

#import "AppDelegate.h"
#import "HBSQLiteObject.h"

static NSString *const kDBName = @"test.sqlite";

@interface AppDelegate ()

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
        [self _createDBFile];
}

-(void)_createDBFile
{
        HBSQLiteObject *sqliteObject = [HBSQLiteObject sharedInstance];
        BOOL success = [sqliteObject openDBWithDBName:kDBName];
        if(success)
        {
                DLog(@"open db file success");
        }
        else
        {
                DLog(@"open db file fail");
        }
}


@end
