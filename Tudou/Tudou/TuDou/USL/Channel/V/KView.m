//
//  KView.m
//  TuDou
//
//  Created by Kallen on 13-5-31.
//  Copyright (c) 2013年 Kallen. All rights reserved.
//

#import "KView.h"


@implementation KView
@synthesize bookRootLayer = _bookRootLayer;
@synthesize booksArray = _booksArray;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        // Initialization code
        self.booksArray = [NSMutableArray array];
        [self.booksArray addObject:@"1"];
        [self.booksArray addObject:@"2"];
        [self.booksArray addObject:@"3"];
        [self.booksArray addObject:@"4"];
        
        [self setupLayers];
        
        [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(movie) userInfo:nil repeats:YES];
    }
    return self;
}

-(void)movie
{
    static int i = 0;
    [self.bookRootLayer scrollToPoint:CGPointMake(++i,0)];
}

-(void) setupLayers{
    CALayer* mainLayer = self.layer;
    CGFloat midX = CGRectGetMidX( mainLayer.frame );
    CGFloat midY = CGRectGetMidY( mainLayer.frame );
    CAScrollLayer* contentContainer = [CAScrollLayer layer];
    contentContainer.bounds  = mainLayer.bounds;
    //currentX=contentContainer.bounds.origin.x;
    contentContainer.anchorPoint      = CGPointMake(0.5,0.5);
    contentContainer.position         = CGPointMake( midX, midY );
    
    [self.layer addSublayer:contentContainer];
    self.bookRootLayer = contentContainer;
    contentContainer.name = @"scrollLayer";
    contentContainer.scrollMode = kCAScrollHorizontally;
    for (int i=0;i<[self.booksArray count];i++){
        CALayer *singleLayer=[CALayer layer];
        //homebrew shadow
        CALayer *shadowLayer=[CALayer layer];
        shadowLayer.contents=(id)[UIImage imageNamed:@"bookshadow.png"].CGImage;
        shadowLayer.frame=CGRectMake(i*100, (self.frame.size.height-118), 91, 118);
        shadowLayer.name=[NSString stringWithFormat:@"shadow-%d",i];
        [self.bookRootLayer addSublayer:shadowLayer];
        //NSDictionary *singleBook=[self.booksArray objectAtIndex:i];
//        [singleLayer setContents:(id)[(UIImage*)[singleBook objectForKey:@"imgdata"] CGImage]];
        [singleLayer setContents:(id)[UIImage imageNamed:@"bookshadow.png"].CGImage];
        singleLayer.frame=CGRectMake(i*100+4, (self.frame.size.height-115), 82, 110);
        singleLayer.name=[NSString stringWithFormat:@"layer-%d",i];
        [self.bookRootLayer addSublayer:singleLayer];
        ((CAScrollLayer*)self.bookRootLayer).frame =CGRectMake(0, (self.frame.size.height-110), (i+1)*100, 118);
    }
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
