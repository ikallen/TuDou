//
//  KRequest.m
//  TuDou
//
//  Created by Kallen on 13-5-21.
//  Copyright (c) 2013年 Kallen. All rights reserved.
//

#import "KRequest.h"
#import "BaseParser.h"

@implementation KRequest
@synthesize queue = _queue;
@synthesize apiURL = _apiURL;
@synthesize apiName = _apiName;
@synthesize responseDic = _responseDic;
@synthesize connectEnd = _connectEnd;
@synthesize connectFailded =  _connectFailded;
@synthesize delegate = _delegate;

-(id)init
{
    if (self = [super init])
    {
        ASINetworkQueue *aQueue=[[ASINetworkQueue alloc] init];
		aQueue.delegate=self;
		aQueue.requestDidFinishSelector=@selector(requestDidFinish:);
		aQueue.requestDidFailSelector=@selector(requestDidFail:);
        aQueue.queueDidFinishSelector=@selector(allRequestDone:);
		self.queue = aQueue;
		[aQueue release];
        
        self.apiName = nil;
        self.apiURL = nil;
        
        self.responseDic = [NSMutableDictionary dictionary];
    }
    
    return self;
}

//产生网络请求队列
-(ASINetworkQueue *)createRequestQueue
{
	ASINetworkQueue *aQueue=[[[ASINetworkQueue alloc] init] autorelease];
	aQueue.delegate=self;
	aQueue.requestDidFinishSelector=@selector(requestDidFinish:);
	aQueue.queueDidFinishSelector=@selector(allRequestDone:);
	aQueue.requestDidFailSelector=@selector(requestDidFail:);
    
	return aQueue;
}

-(void)callAPI:(NSString *)aAPI
    WithParams:(NSDictionary *)aParams
{
    self.queue = [self createRequestQueue];
    
    ASIHTTPRequest *_request = [self createHttpRequest:aAPI WithParams:aParams];
    
    [self.queue addOperation:_request];
    [self.queue go];
}

-(void)callAPI:(NSDictionary *)aAPIDic
{
    self.queue = [self createRequestQueue];
    
    for (NSString *key in [aAPIDic allKeys])
    {
        ASIHTTPRequest *_request = [self createHttpRequest:key WithParams:[aAPIDic valueForKey:key]];
        
        [self.queue addOperation:_request];
    }
    
    [self.queue go];
}


// 产生Http请求
-(ASIHTTPRequest *)createHttpRequest:(NSString *)aAPI
                          WithParams:(NSDictionary *)aParams
{
    // TODO:  to see;
    NSMutableString *url = [NSMutableString stringWithString:aAPI];
    for (NSString *key in [aParams allKeys])
    {
        NSString *value = [aParams valueForKey:key];
        [url appendFormat:@"&%@=%@",key,value];
    }
    
    NSLog(@"request url = %@",url);
    
    NSString *encodeURL = [url stringByAddingPercentEscapesUsingEncoding:4];
	ASIHTTPRequest *_ASIHTTPRequest=[ASIHTTPRequest requestWithURL:[NSURL URLWithString:encodeURL]];
    [_ASIHTTPRequest setShouldAttemptPersistentConnection:NO];
    _ASIHTTPRequest.timeOutSeconds = 120;
	return _ASIHTTPRequest;
}


// 单个网络请求完成
-(void)requestDidFinish:(ASIHTTPRequest *)aRequest
{
    NSLog(@"%d",[NSThread isMainThread]);
    NSLog(@"response string : %@",aRequest.responseString);
    
    NSString *parserName = [self.apiName stringByAppendingString:@"Parser"];
    
    // 动态创建类
    Class _parserClass = NSClassFromString(parserName);
    BaseParser *parser = [[_parserClass alloc] initWithStr:aRequest.responseString];
    
    id obj = [parser superParser];
    
    if (obj)
    {
        [self.responseDic setValue:obj
                            forKey:aRequest.url.absoluteString];
    }
}

-(void)requestDidFail:(ASIHTTPRequest *)aRequest
{
    
}

// 队列请求完成
-(void)allRequestDone:(ASINetworkQueue *)aQueue
{
    if (!self.connectEnd)
    {
        self.connectEnd = @selector(connectEnd:);
    }
    
    if (!self.connectFailded)
    {
        self.connectFailded = @selector(connectFailded:);
    }
    
    [self.delegate performSelector:self.connectEnd
                        withObject:self.responseDic];
    
    
}











@end
