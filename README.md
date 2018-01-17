## HBSQLiteContext 

eg:  
```
HBFileItem *fileItem = [[MMFileItem alloc]init];
fileItem.file_md5 = @"123";

/// 新增
[fileItem save];

/// 删除
[fileItem delete];

/// 更新
[fileItem update];

/// 查找
MMFileItem fileItem = [[MMFileItem alloc]init];
fileItem.file_id = @"222";
fileItem = [fileItem findByModel];
```
