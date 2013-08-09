//
//  LeftNavViewController.m
//  SideBarNavDemo
//
//  Created by JianYe on 12-12-11.
//  Copyright (c) 2012年 JianYe. All rights reserved.
//

#import "LeftSideBarViewController.h"
#import "SideBarSelectedDelegate.h"
#import "IndexViewController.h"
#import "ChannelViewController.h"


@interface LeftSideBarViewController ()
{
    NSArray *_dataList;
    int _selectIdnex;
}
@end

@implementation LeftSideBarViewController

@synthesize mainTableView,delegate;

-(void)loadView
{
    self.view = [[UIView alloc] initWithFrame:KBounds];
    self.view.backgroundColor = [UIColor whiteColor];
    
    mainTableView = [[UITableView alloc] initWithFrame:KFrame(0, 0, 230, KBounds.size.height)];
    mainTableView.delegate = self;
    mainTableView.dataSource = self;
    [self.view addSubview:mainTableView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _dataList = @[@"首页",@"频道",@"收藏",@"历史",@"设置"];
    [_dataList retain];
    
    
    viewControllers = [[NSMutableArray alloc] init];
    
    IndexViewController *indexViewController = [[IndexViewController alloc] init];
    indexViewController.title = @"首页";
    [viewControllers addObject:indexViewController];
    [indexViewController release];
    
    ChannelViewController *channelViewController = [[ChannelViewController alloc] init];
    channelViewController.title = @"频道";
    [viewControllers addObject:channelViewController];
    [channelViewController release];
    
    
    //
    
    if ([delegate respondsToSelector:@selector(leftSideBarSelectWithController:)]) {
        [delegate leftSideBarSelectWithController:[self subConWithIndex:0]];
        _selectIdnex = 0;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_dataList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
    }
    cell.textLabel.text = [_dataList objectAtIndex:indexPath.row];
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ([delegate respondsToSelector:@selector(leftSideBarSelectWithController:)]) {
        if (indexPath.row == _selectIdnex)
        {
            [delegate leftSideBarSelectWithController:nil];
        }else
        {
            [delegate leftSideBarSelectWithController:[self subConWithIndex:indexPath.row]];
        }
        
    }
    _selectIdnex = indexPath.row;
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (UINavigationController *)subConWithIndex:(int)index
{
    
    UIViewController *con = [viewControllers objectAtIndex:index];

   // con.index = index+1;
    UINavigationController *nav= [[UINavigationController alloc] initWithRootViewController:con];
    
    //nav.navigationBar.hidden = YES;
    return nav ;
}









@end
