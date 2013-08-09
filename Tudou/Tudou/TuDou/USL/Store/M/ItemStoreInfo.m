//
//  ItemStoreInfo.m
//  TuDou
//
//  Created by Kallen on 13-5-30.
//  Copyright (c) 2013年 Kallen. All rights reserved.
//

#import "ItemStoreInfo.h"
#import "FMDatabase.h"
#import "FMDatabaseAdditions.h"
#import "ItemInfo.h"

#define DB_Name @"TUDOU.sqlite"
#define TABLE_NAME_ITEMINFO @"ItemInfoTable"

@implementation ItemStoreInfo

-(BOOL)openDB
{
    BOOL success;
    
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [path objectAtIndex:0];
    NSString *DBPath = [documentDirectory stringByAppendingPathComponent:DB_Name];
    
    
    db = [FMDatabase databaseWithPath:DBPath];
    if ([db open])
    {
        success = YES;
        [db setShouldCacheStatements:YES];
        NSLog(@"Open success db !");
    }
    else
    {
        NSLog(@"Failed to open db!");
        success = NO;
    }
    
    return success;
}

- (NSString *)sql:(NSString *)aSql
          inTable:(NSString *)table
{
    return [NSString stringWithFormat:aSql,table];
}

-(id)init
{
    self = [super init];
    if (self)
    {
        if ([self openDB])
        {
            if (![db tableExists:TABLE_NAME_ITEMINFO])
            {
                NSString *sql = [self sql:@"CREATE TABLE IF NOT EXISTS '%@' ('kID' INTEGER PRIMARY KEY AUTOINCREMENT, 'itemId' text,'itemCode' text,'vcode' text,'title' text,'tags' text,'Description'text, 'picUrl' text,'totalTime' text,'pubDate' text,'ownerId' text,'ownerName' text,'ownerNickname' text,'ownerPic' text,'ownerURL' text,'channelId'  text,'outerPlayerUrl'  text,'itemUrl' text,'mediaType' text,'secret' text,'definition' text,'hdType' text,'playTimes' text,'commentCount' text,'bigPicUrl' text,'addPlaylistTime' text,'alias' text,'downEnable' text,'favorall' text,'location' text,'html5Url' text);" inTable:TABLE_NAME_ITEMINFO];
                
                NSLog(@"%@",sql);
                
                // 执行sql语句
                BOOL result = [db executeUpdate:sql];
                if (result)
                {    
                    NSLog(@"create success");
                }
            }
        }
        

        NSLog(@"db exists!");
        //[db close];

    }
    
    return self;
}


-(NSMutableArray *)allItemInfo:(NSString *)aCondition
{
    NSMutableArray *result = [[[NSMutableArray alloc]initWithCapacity:0]autorelease];
    NSMutableString *sql = [NSMutableString stringWithString:[self sql:@"SELECT * FROM %@" inTable:TABLE_NAME_ITEMINFO]];
    
    if (aCondition !=nil)
    {
        [sql appendString:aCondition];
    }
    NSLog(@"sql %@",sql);
    [db open];
    FMResultSet *rs = [db executeQuery:sql];
    while ([rs next])
    {
        ItemInfo *item = [[ItemInfo alloc]init];
        item.itemId = [rs objectForColumnIndex:0];
        item.itemCode = [rs objectForColumnIndex:1];
        [result addObject:item];
        [item release];
    }
    [rs close];
    [db close];
    
    return result;
}


- (BOOL)updateAtIndex:(int)index
             withItem:(ItemInfo *)aItemInfo
{
    BOOL success = YES;
    
    NSNumber *kID = [[NSNumber alloc]initWithInt:index];
    //NSNumber *personID = [[NSNumber alloc]initWithInt:contact.person_id];
    
    [db open];
    [db executeUpdate:[self sql:@"UPDATE %@ SET itemId = ? WHERE 'index' = ?"
                        inTable:TABLE_NAME_ITEMINFO],aItemInfo.itemId,kID];
    [db close];

    if ([db hadError])
    {
        NSLog(@"Err %d: %@",[db lastErrorCode],[db lastErrorMessage]);
        success = NO;
    }
    return success;
    
}


-(BOOL)checkExist:(ItemInfo *)aItemInfo
{
    BOOL success = NO;
    
    NSInteger _kID = [aItemInfo.kID integerValue];
    NSNumber *kID = [[NSNumber alloc]initWithInt:_kID];
    
    NSString *sql = [self sql:@"select kID from '%@' where 'kID = ?'"
                      inTable:TABLE_NAME_ITEMINFO];
    NSLog(@"sql  = %@",sql);
    
    [db open];
    FMResultSet *rs = [db executeQuery:sql,kID];
    while ([rs next])
    {
        NSInteger _ID = [rs intForColumnIndex:0];
        if (_ID == _kID)
        {
            success = YES;
        }
        else
        {
            success = NO;
        }
    }
    
    return success;
}

- (void)saveContact:(ItemInfo *)aItemInfo
{
    
    //检测是否已经添加收藏
    //NSInteger index = [aItemInfo.kID intValue];
    if ([self checkExist:aItemInfo])
    {
        //[self updateAtIndex:index withContact:contact];
    }
    else
    {
        
        [db open];
        [db beginTransaction];
        NSString * insertSql = [self sql:@"INSERT OR IGNORE INTO %@ ('itemId') VALUES (?)" inTable:TABLE_NAME_ITEMINFO];
        [db executeUpdate:insertSql,aItemInfo.itemId];
        [db commit];
        [db close];
        
    }
}

-(BOOL)deleteAtIndex
{
    
}

@end
