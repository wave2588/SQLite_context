//
//  ProjectSettings.h
//  HBSQLiteContext
//
//  Created by wave on 2017/3/13.
//  Copyright © 2017年 wave. All rights reserved.
//

#ifndef ProjectSettings_h
#define ProjectSettings_h


#define DLog(FORMAT, ...) fprintf(stderr,"\nfunction:%s line:%d content:%s\n", __FUNCTION__, __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String])

#endif /* ProjectSettings_h */
