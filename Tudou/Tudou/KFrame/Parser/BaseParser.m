//
//  BaseParser.m
//  TuDou
//
//  Created by Kallen on 13-5-21.
//  Copyright (c) 2013年 Kallen. All rights reserved.
//

#import "BaseParser.h"

@implementation BaseParser
@synthesize parserString = _parserString;
@synthesize parseredDic = _parseredDic;

-(id)initWithStr:(NSString *)aStr
{
    if (self = [super init])
    {
        self.parserString = aStr;
        self.parseredDic = [NSMutableDictionary dictionary];
    }
    return self;
}

-(id)superParser
{
    GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithXMLString:self.parserString options:0 error:nil];
    
    GDataXMLElement *root = doc.rootElement;

    NSArray *pageNoArr = [root nodesForXPath:@"//page/pageNo" error:nil];
    
    if (pageNoArr)
    {
        GDataXMLElement *pageNo = [pageNoArr objectAtIndex:0];
        [self.parseredDic setObject:pageNo.stringValue forKey:@"pageNo"];
    }
    
    
    NSArray *pageSizeArr = [root nodesForXPath:@"//page/pageSize" error:nil];
    
    if (pageSizeArr)
    {
        GDataXMLElement *pageSize = [pageSizeArr objectAtIndex:0];
        [self.parseredDic setObject:pageSize.stringValue forKey:@"pageSize"];
    }
    
    
    NSArray *totalCountArr = [root nodesForXPath:@"//page/totalCount" error:nil];
    if (totalCountArr)
    {
        GDataXMLElement *totalCount = [totalCountArr objectAtIndex:0];
        // 断言
        assert(totalCount.stringValue);
        [self.parseredDic setObject:totalCount.stringValue forKey:@"totalCount"];
    }

    NSArray *resluts = [root elementsForName:@"results"];
    GDataXMLElement *resultEle = [resluts objectAtIndex:0];

    return [self parser:resultEle];

}

// 虚函数
-(id)parser:(GDataXMLElement *)aElement
{
    return nil;
}












@end
