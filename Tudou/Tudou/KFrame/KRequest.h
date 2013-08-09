//
//  KRequest.h
//  TuDou
//
//  Created by Kallen on 13-5-21.
//  Copyright (c) 2013年 Kallen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"
#import "ASINetworkQueue.h"

@interface KRequest : NSObject
{
    ASINetworkQueue *_queue;
    NSString *_apiURL;
    NSString *_apiName;
    
    SEL _connectEnd;     // 请求成功
    SEL _connectFailded; // 请求失败
    
    NSMutableDictionary *_responseDic;
    
    id _delegate;
}

@property(nonatomic,assign)id delegate;
@property(nonatomic,retain) NSMutableDictionary *responseDic;
@property(nonatomic,retain) NSString *apiName;
@property(nonatomic,retain) ASINetworkQueue *queue;
@property(nonatomic,retain) NSString *apiURL;
@property(nonatomic,assign) SEL connectEnd;
@property(nonatomic,assign) SEL connectFailded;

-(void)callAPI:(NSString *)aAPI
    WithParams:(NSDictionary *)aParams;











@end
