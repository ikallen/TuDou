//
//  IndexTableCell.h
//  TuDou
//
//  Created by Kallen on 13-5-31.
//  Copyright (c) 2013年 Kallen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IndexTableCell : UITableViewCell
{
    IBOutlet UIView *_imgView;
    IBOutlet UILabel *_titleLabel;
    IBOutlet UILabel *_count;
}

@property(nonatomic,assign)IBOutlet UIView *imgView;
@property(nonatomic,assign)IBOutlet UILabel *titleLabel;
@property(nonatomic,assign)IBOutlet UILabel *count;

@end
