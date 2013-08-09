//
//  SBTickerView+WebCache.m
//  TuDou
//
//  Created by Kallen on 13-5-31.
//  Copyright (c) 2013年 Kallen. All rights reserved.
//

#import "SBTickerView+WebCache.h"

#import "SDWebImageManager.h"

@implementation SBTickerView (WebCache)

- (void)setImageWithURL:(NSURL *)url
{
    [self setImageWithURL:url placeholderImage:nil];
}

- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder
{
    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    
    // Remove in progress downloader from queue
    [manager cancelForDelegate:self];
    
    //self.image = placeholder;
    UIImageView *img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg.png"]];
    img.frame = KFrame(0, 0, 80, 60);
    [self setFrontView:img];
    [self setBackView:img];
    
    if (url)
    {
        [manager downloadWithURL:url delegate:self];
    }
}

- (void)cancelCurrentImageLoad
{
    [[SDWebImageManager sharedManager] cancelForDelegate:self];
}

// 图片下载完成后触发的代理方法
- (void)webImageManager:(SDWebImageManager *)imageManager didFinishWithImage:(UIImage *)image
{
    
    
    [self tick:0 animated:YES completion:^{
        NSLog(@"Done Down");
    }];
}
@end
