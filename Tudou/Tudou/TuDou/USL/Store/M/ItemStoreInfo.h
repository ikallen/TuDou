

#import <Foundation/Foundation.h>
#import "FMDatabase.h"



@class ItemInfo;
@interface ItemStoreInfo : NSObject
{
    FMDatabase *db;
}


- (NSString *)sql:(NSString *)aSql
          inTable:(NSString *)table;

-(NSMutableArray *)allItemInfo;
- (void)saveContact:(ItemInfo *)aItemInfo;
-(BOOL)deleteAtIndex;


@end
