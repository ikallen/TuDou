//
//  IndexImageView.m
//  TuDou
//
//  Created by Kallen on 13-5-21.
//  Copyright (c) 2013年 Kallen. All rights reserved.
//

#import "IndexImageView.h"

@implementation IndexImageView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        
    }
    return self;
}

-(void)startReqImg:(NSString *)aURL
{
    NSURL *_url = [NSURL URLWithString:aURL];
    [self performSelectorInBackground:@selector(req:)
                           withObject:_url];
}


-(void)req:(NSURL *)aURL
{
    NSData *_data = [NSData dataWithContentsOfURL:aURL];
    UIImage *_img = [UIImage imageWithData:_data];
    
    [self performSelectorOnMainThread:@selector(clipImg:)
                           withObject:_img
                        waitUntilDone:NO];
}

-(void)clipImg:(UIImage *)aImg
{
    self.image = aImg;
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
