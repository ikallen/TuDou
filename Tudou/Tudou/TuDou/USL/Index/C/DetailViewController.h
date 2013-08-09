//
//  DetailViewController.h
//  TuDou
//
//  Created by Kallen on 13-5-31.
//  Copyright (c) 2013年 Kallen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ItemInfo;

@interface DetailViewController : UIViewController
{
    ItemInfo *_itemInfo;
    UIImageView *_imgView;
    UILabel *_titleLabel;
    UILabel *_playTimeLabel;
    
    
    //简介
    
    //评论
    
    //剧集
    
}

@property(nonatomic,retain)ItemInfo *itemInfo;

-(id)initWithInfo:(ItemInfo *)aItemInfo;
@end
