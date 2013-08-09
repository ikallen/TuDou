//
//  KView.h
//  TuDou
//
//  Created by Kallen on 13-5-31.
//  Copyright (c) 2013年 Kallen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
@interface KView : UIView
{
    CAScrollLayer *_bookRootLayer;
}

@property(nonatomic,retain)CAScrollLayer *bookRootLayer;
@property(nonatomic,retain)NSMutableArray *booksArray;

@end
