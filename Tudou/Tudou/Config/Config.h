//
//  Config.h
//  SideBarDemo
//
//  Created by Kallen on 13-5-15.
//  Copyright (c) 2013年 JianYe. All rights reserved.
//


#define KBounds [UIScreen mainScreen].bounds
#define KAppFrame [UIScreen mainScreen].applicationFrame
#define KFrame(x,y,w,h) CGRectMake(x, y, w, h)

// 排行API
#define RankingAPI @"http://api.tudou.com/v3/gw?method=item.ranking"

// 服务器接口API
#define Movie_URL @"http://api.tudou.com/v3/gw?method=item.ranking&appKey=06427c0461c8ed10&format=xml&pageNo=1&pageSize=5&channelId=22&inDays=3&sort=v"