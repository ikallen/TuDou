//
//  MovieItemInfoParser.m
//  TuDou
//
//  Created by Kallen on 13-5-22.
//  Copyright (c) 2013年 Kallen. All rights reserved.
//

#import "MovieItemInfoParser.h"
#import "ItemInfo.h"

@implementation MovieItemInfoParser


-(id)parser:(GDataXMLElement *)aElement
{
    NSArray *itemInfos = [aElement children];
    
    NSMutableArray *itemInfoArr = [[NSMutableArray alloc] init];
    
    ItemInfo *info = nil;
    for (GDataXMLElement *e in itemInfos)
    {
        info = [[ItemInfo alloc] init];
        
        for (GDataXMLElement *p in e.children)
        {
            if ([p.name isEqualToString:@"description"])
            {
                [info setValue:p.stringValue forKey:@"Description"];
            }
            else if ([p.name isEqualToString:@"picChoiceUrl"])
            {
                NSMutableArray *arr = [NSMutableArray array];
                for (GDataXMLElement *urlEle in  p.children)
                {
                    [arr addObject:urlEle.stringValue];
                }
                
                [info setValue:arr forKey:p.name];
            }
            else
            {
                [info setValue:p.stringValue forKey:p.name];
            }
        }
        
        [itemInfoArr addObject:info];
    }
    
    NSLog(@"itemInfoArr = %@",itemInfoArr);
    if (itemInfoArr.count > 0)
    {
        [self.parseredDic setValue:itemInfoArr forKey:@"Movie"];
    }
    
    
    return self.parseredDic;
}





@end
