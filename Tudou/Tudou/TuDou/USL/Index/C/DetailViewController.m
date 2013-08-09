//
//  DetailViewController.m
//  TuDou
//
//  Created by Kallen on 13-5-31.
//  Copyright (c) 2013年 Kallen. All rights reserved.
//

#import "DetailViewController.h"
#import "UIImageView+WebCache.h"
#import "ItemInfo.h"
#import "SVSegmentedControl.h"
#import "SVSegmentedThumb.h"
#import "IntroInfoViewController.h"
#import "ItemStoreInfo.h"

@implementation DetailViewController
@synthesize itemInfo = _itemInfo;

-(id)initWithInfo:(ItemInfo *)aItemInfo
{
    if (self = [super init])
    {
        self.itemInfo = aItemInfo;
    }
    return self;
}

-(void)loadView
{
    self.view = [[UIView alloc] initWithFrame:KBounds];
    self.view.backgroundColor = [UIColor whiteColor];
    
    _imgView = [[UIImageView alloc] initWithFrame:KFrame(10, 10, 120, 80)];
    [_imgView setImageWithURL:[NSURL URLWithString:self.itemInfo.bigPicUrl] placeholderImage:nil];
    [self.view addSubview:_imgView];
    [_imgView release];
    
    _titleLabel = [[UILabel alloc] initWithFrame:KFrame(140, 10, 150, 40)];
    _titleLabel.text = @"笑功震武林高清";
    [self.view addSubview:_titleLabel];
    [_titleLabel release];
    
    
    _playTimeLabel = [[UILabel alloc] initWithFrame:KFrame(140, 60, 150, 30)];
    _playTimeLabel.text = @"475225";
    [self.view addSubview:_playTimeLabel];
    [_playTimeLabel release];
    
    
    UIButton *playBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    playBtn.frame = KFrame(10, 100, 180, 30);
    [playBtn setTitle:@"播放" forState:0];
    [self.view addSubview:playBtn];
    
    UIButton *storeBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    storeBtn.frame = KFrame(200, 100, 110, 30);
    [storeBtn setTitle:@"收藏" forState:0];
    [storeBtn addTarget:self
                 action:@selector(store:)
       forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:storeBtn];
    
    
	SVSegmentedControl *redSC = [[SVSegmentedControl alloc] initWithSectionTitles:[NSArray arrayWithObjects:@"简介", @"      评论      ", @"剧集", nil]];
    [redSC addTarget:self action:@selector(segmentedControlChangedValue:) forControlEvents:UIControlEventValueChanged];
	redSC.tintColor = [UIColor whiteColor];
	redSC.crossFadeLabelsOnDrag = YES;
	redSC.selectedIndex = 0;
	[self.view addSubview:redSC];
	redSC.center = CGPointMake(160, 170);
    redSC.thumb.tintColor = [UIColor lightTextColor];
	
}

-(void)segmentedControlChangedValue:(id)sender
{
    IntroInfoViewController *intro = [[IntroInfoViewController alloc] initWithNibName:@"IntroInfoViewController" bundle:nil];
    
    intro.itemInfo = self.itemInfo;
    intro.view.frame = KFrame(0, 200, 320, 300);
    [self.view addSubview:intro.view];
}

-(void)store:(id)sender
{
    ItemStoreInfo *store = [[ItemStoreInfo alloc] init];
    [store saveContact:self.itemInfo];
    [store autorelease];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
