
#import <Foundation/Foundation.h>
#import "GDataXMLNode.h"

@interface BaseParser : NSObject
{
    NSString *_parserString;
    NSMutableDictionary *_parseredDic;
}

@property(nonatomic,retain) NSString *parserString;
@property(nonatomic,retain) NSMutableDictionary *parseredDic;

-(id)initWithStr:(NSString *)aStr;
-(id)superParser;
-(id)parser:(GDataXMLElement *)aElement;

@end

