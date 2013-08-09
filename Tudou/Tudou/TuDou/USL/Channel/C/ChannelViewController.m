//
//  ChannelViewController.m
//  TuDou
//
//  Created by Kallen on 13-5-29.
//  Copyright (c) 2013年 Kallen. All rights reserved.
//

#import "ChannelViewController.h"
#import "KView.h"
#import "ASIHTTPRequest.h"


@implementation ChannelViewController

-(void)loadView
{
    self.view = [[[UIView alloc] initWithFrame:KFrame(0, 0, 320, 568)] autorelease];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"频道";
    
    NSURL *url = [NSURL URLWithString:@"http://api.tudou.com/v3/gw?method=item.ranking&appKey=myKey&format=xml&pageNo=1&pageSize=10&channelId=22&inDays=3&sort=v"];
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    request.delegate = self;
    request.didFinishSelector = @selector(reqDidFinish:);
    request.didFailSelector = @selector(reqDidFail:);
    [request startAsynchronous];
    
}


-(void)reqDidFinish:(ASIHTTPRequest *)aReq
{
    NSLog(@"string = %@",aReq.responseString);
}

-(void)reqDidFail:(ASIHTTPRequest *)aReq
{
    
}







- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}


@end
