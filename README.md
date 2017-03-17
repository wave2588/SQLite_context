# HBSQLiteContext 
## 基于Mac OS操作系统写的一套本地数据库,可以直接通过模型操作数据库. iOS也可以使用

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
