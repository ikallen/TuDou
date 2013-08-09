//
//  IntroInfoViewController.m
//  TuDou
//
//  Created by Kallen on 13-6-2.
//  Copyright (c) 2013年 Kallen. All rights reserved.
//

#import "IntroInfoViewController.h"
#import "ItemInfo.h"

@implementation IntroInfoViewController
@synthesize itemInfo = _itemInfo;

-(id)initWithItemInfo:(ItemInfo *)aItemInfo
{
    if (self = [super init])
    {
        self.itemInfo = aItemInfo;
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _tipLabel.text = [_tipLabel.text stringByAppendingString:self.itemInfo.tags];
    
    _ownerLabel.text = [_ownerLabel.text stringByAppendingString:self.itemInfo.ownerNickname];
    _commentCountLabel.text = [_commentCountLabel.text stringByAppendingString:self.itemInfo.commentCount];
    
    
    _introLabel.text = self.itemInfo.Description;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
