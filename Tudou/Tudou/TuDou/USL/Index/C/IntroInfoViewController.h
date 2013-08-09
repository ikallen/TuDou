//
//  IntroInfoViewController.h
//  TuDou
//
//  Created by Kallen on 13-6-2.
//  Copyright (c) 2013年 Kallen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ItemInfo;
@interface IntroInfoViewController : UIViewController
{
    
    IBOutlet UIScrollView *_scrollView;
    
    IBOutlet UILabel *_tipLabel;
    IBOutlet UILabel *_ownerLabel;
    IBOutlet UILabel *_commentCountLabel;
    IBOutlet UILabel *_introLabel;
    
}


@property(nonatomic,retain)ItemInfo *itemInfo;
-(id)initWithItemInfo:(ItemInfo *)aItemInfo;

@end
