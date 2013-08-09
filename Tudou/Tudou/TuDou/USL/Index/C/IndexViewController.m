//
//  IndexViewController.m
//  TuDou
//
//  Created by Kallen on 13-5-21.
//  Copyright (c) 2013年 Kallen. All rights reserved.
//

#import "IndexViewController.h"
#import "IndexImageView.h"
#import "KRequest.h"
#import "ItemInfo.h"
#import "IndexTableCell.h"
#import "UIImageView+WebCache.h"
#import "DetailViewController.h"

@implementation IndexViewController

-(void)loadView
{
    self.view = [[UIView alloc] initWithFrame:KBounds];
    self.view.backgroundColor = [UIColor whiteColor];
    
    _scrollView = [[UIScrollView alloc] initWithFrame:KFrame(0, 0, 320, 200)];
    _scrollView.backgroundColor = [UIColor whiteColor];
    _scrollView.scrollEnabled = YES;
    _scrollView.pagingEnabled = YES;
    int i = 0;
    for (;i<5;i++)
    {
        IndexImageView *img = [[IndexImageView alloc] initWithFrame:KFrame(i*320, 0, 320, 200)];
        
        img.tag = 1000+i;
        [_scrollView addSubview:img];
        [img release];
    }
    _scrollView.contentSize = CGSizeMake(i*320, 200);

    
    // tableview
    _tableView = [[UITableView alloc] initWithFrame:KFrame(0, 0, 320, 568-44-20) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    [_tableView release];
    
    _tableView.tableHeaderView=_scrollView;
    [_scrollView release];
    

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    dataList = [[NSMutableArray alloc] initWithCapacity:5];
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]initWithCapacity:2];
    [dict setObject:@"电影" forKey:@"groupname"];
	
	//利用数组来填充数据
	NSMutableArray *arr = [[NSMutableArray alloc] initWithCapacity : 2];
	[dict setObject:arr forKey:@"users"];
	[arr release];
	[dataList addObject: dict];
	[dict release];
	
	
	dict = [[NSMutableDictionary alloc]initWithCapacity : 2];
	[dict setObject:@"电视剧" forKey:@"groupname"];
	
	arr = [[NSMutableArray alloc] initWithCapacity : 2];
	[dict setObject:arr forKey:@"users"];
	[arr release];
	[dataList addObject: dict];
	[dict release];
    
    
    dict = [[NSMutableDictionary alloc]initWithCapacity : 2];
	[dict setObject:@"综艺" forKey:@"groupname"];
	
	arr = [[NSMutableArray alloc] initWithCapacity : 2];
	[dict setObject:arr forKey:@"users"];
	[arr release];
	[dataList addObject: dict];
	[dict release];

    
    
    KRequest *req = [[KRequest alloc] init];
    req.delegate = self;
    req.apiName = @"MovieItemInfo";
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:@"06427c0461c8ed10" forKey:@"appKey"];
    [dic setObject:@"xml" forKey:@"format"];
    [dic setObject:@"1" forKey:@"pageNo"];
    [dic setObject:@"5" forKey:@"pageSize"];
    [dic setObject:@"29" forKey:@"channelId"];
    [dic setObject:@"v" forKey:@"sort"];
    [req callAPI:RankingAPI WithParams:dic];
    
    
    KRequest *movieReq = [[KRequest alloc] init];
    movieReq.delegate = self;
    movieReq.apiName = @"MovieItemInfo";
    movieReq.connectEnd = @selector(movieConEnd:);
    NSMutableDictionary *movieDic = [NSMutableDictionary dictionary];
    [movieDic setObject:@"06427c0461c8ed10" forKey:@"appKey"];
    [movieDic setObject:@"xml" forKey:@"format"];
    [movieDic setObject:@"1" forKey:@"pageNo"];
    [movieDic setObject:@"5" forKey:@"pageSize"];
    [movieDic setObject:@"22" forKey:@"channelId"];
    [movieDic setObject:@"v" forKey:@"sort"];
    [movieReq callAPI:RankingAPI WithParams:movieDic];
    
    
    KRequest *tvReq = [[KRequest alloc] init];
    tvReq.delegate = self;
    tvReq.apiName = @"MovieItemInfo";
    tvReq.connectEnd = @selector(tvConEnd:);
    NSMutableDictionary *tvDic = [NSMutableDictionary dictionary];
    [tvDic setObject:@"06427c0461c8ed10" forKey:@"appKey"];
    [tvDic setObject:@"xml" forKey:@"format"];
    [tvDic setObject:@"1" forKey:@"pageNo"];
    [tvDic setObject:@"5" forKey:@"pageSize"];
    [tvDic setObject:@"30" forKey:@"channelId"];
    [tvDic setObject:@"v" forKey:@"sort"];
    [tvReq callAPI:RankingAPI WithParams:tvDic];
    
    // 综艺31
    KRequest *artReq = [[KRequest alloc] init];
    artReq.delegate = self;
    artReq.apiName = @"MovieItemInfo";
    artReq.connectEnd = @selector(artConEnd:);
    NSMutableDictionary *artDic = [NSMutableDictionary dictionary];
    [artDic setObject:@"06427c0461c8ed10" forKey:@"appKey"];
    [artDic setObject:@"xml" forKey:@"format"];
    [artDic setObject:@"1" forKey:@"pageNo"];
    [artDic setObject:@"5" forKey:@"pageSize"];
    [artDic setObject:@"31" forKey:@"channelId"];
    [artDic setObject:@"v" forKey:@"sort"];
    [artReq callAPI:RankingAPI WithParams:artDic];
}

#pragma mark -网络请求代理-
-(void)artConEnd:(id)aDic
{
    NSString *key = [[aDic allKeys] objectAtIndex:0];
    NSDictionary *dic = [aDic valueForKey:key];
    NSArray *items = [dic valueForKey:@"Movie"];
    
    for (NSDictionary *dic in dataList)
    {
        NSString *value = [dic valueForKey:@"groupname"];
        if ([value isEqualToString:@"综艺"])
        {
            NSMutableArray *arr =  [dic valueForKey:@"users"];
            [arr addObjectsFromArray:items];
            break;
        }
    }
    
    [_tableView reloadData];
}


-(void)movieConEnd:(id)aDic
{
    NSString *key = [[aDic allKeys] objectAtIndex:0];
    NSDictionary *dic = [aDic valueForKey:key];
    NSArray *items = [dic valueForKey:@"Movie"];
    
    for (NSDictionary *dic in dataList)
    {
        NSString *value = [dic valueForKey:@"groupname"];
        if ([value isEqualToString:@"电影"])
        {
            NSMutableArray *arr =  [dic valueForKey:@"users"];
            [arr addObjectsFromArray:items];
            break;
        }
    }
    
    [_tableView reloadData];
}

-(void)tvConEnd:(id)aDic
{
    NSString *key = [[aDic allKeys] objectAtIndex:0];
    NSDictionary *dic = [aDic valueForKey:key];
    NSArray *items = [dic valueForKey:@"Movie"];
    
    for (NSDictionary *dic in dataList)
    {
        NSString *value = [dic valueForKey:@"groupname"];
        if ([value isEqualToString:@"电视剧"])
        {
            NSMutableArray *arr =  [dic valueForKey:@"users"];
            [arr addObjectsFromArray:items];
            break;
        }
    }
    
    [_tableView reloadData];
}

-(void)connectEnd:(id)aDic
{
    NSString *key = [[aDic allKeys] objectAtIndex:0];
    NSDictionary *dic = [aDic valueForKey:key];
    NSArray *items = [dic valueForKey:@"Movie"];
    int i = 0;
    for (ItemInfo *item in items)
    {
        IndexImageView *img = (IndexImageView *)[_scrollView viewWithTag:1000+i];
        [img startReqImg:item.bigPicUrl];
        i++;
    }
}


#pragma mark -tableview- 
//对指定的节进行“展开/折叠”操作
-(void)collapseOrExpand:(int)section{
	Boolean expanded = NO;
	//Boolean searched = NO;
	NSMutableDictionary* d=[dataList objectAtIndex:section];
	
	//若本节model中的“expanded”属性不为空，则取出来
	if([d objectForKey:@"expanded"]!=nil)
		expanded=[[d objectForKey:@"expanded"]intValue];
	
	//若原来是折叠的则展开，若原来是展开的则折叠
	[d setObject:[NSNumber numberWithBool:!expanded] forKey:@"expanded"];
    
}


//返回指定节的“expanded”值
-(Boolean)isExpanded:(int)section{
	Boolean expanded = NO;
	NSMutableDictionary* d=[dataList objectAtIndex:section];
	
	//若本节model中的“expanded”属性不为空，则取出来
	if([d objectForKey:@"expanded"]!=nil)
		expanded=[[d objectForKey:@"expanded"]intValue];
	
	return expanded;
}


//按钮被点击时触发
-(void)expandButtonClicked:(id)sender{
	
	UIButton* btn= (UIButton*)sender;
	int section= btn.tag; //取得tag知道点击对应哪个块
	
	//	NSLog(@"click %d", section);
	[self collapseOrExpand:section];
	
	//刷新tableview
	[_tableView reloadData];
	
}




- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    
    return [dataList count];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
	
	
	//对指定节进行“展开”判断
    /*
	if (![self isExpanded:section]) {
		
		//若本节是“折叠”的，其行数返回为0
		return 0;
	}
     */
	
	NSDictionary* d=[dataList objectAtIndex:section];
	return [[d objectForKey:@"users"] count];
	
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90.0;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"Cell";
    
    IndexTableCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        
        NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"IndexTableCell" owner:self options:nil];
        cell = [array objectAtIndex:0];
        
    }
    
    
	NSDictionary* m= (NSDictionary*)[dataList objectAtIndex: indexPath.section];
	NSArray *d = (NSArray*)[m objectForKey:@"users"];
    
	if (d == nil || d.count == 0)
    {
		return cell;
	}
	
	//显示联系人名称
    ItemInfo *item = (ItemInfo *)[d objectAtIndex: indexPath.row];
	cell.titleLabel.text = item.title;
    cell.count.text = item.playTimes;
    
    [cell.imgView setImageWithURL:[NSURL URLWithString:item.picUrl] placeholderImage:nil];
    
	
	//选中行时灰色
	cell.selectionStyle = UITableViewCellSelectionStyleGray;
	[cell setAccessoryType: UITableViewCellAccessoryDisclosureIndicator];
    
    return cell;
}



// 设置header的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
	return 40;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section;
{
	
    
	UIView *hView;
	if (UIInterfaceOrientationLandscapeRight == [[UIDevice currentDevice] orientation] ||
        UIInterfaceOrientationLandscapeLeft == [[UIDevice currentDevice] orientation])
	{
		hView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 480, 40)];
	}
	else
	{
		hView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 40)];
        //self.tableView.tableHeaderView.frame = CGRectMake(0.f, 0.f, 320.f, 44.f);
	}
    //UIView *hView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 40)];
    
	UIButton* eButton = [[UIButton alloc] init];
    
	//按钮填充整个视图
	eButton.frame = hView.frame;
	[eButton addTarget:self action:@selector(expandButtonClicked:)
      forControlEvents:UIControlEventTouchUpInside];
	eButton.tag = section;//把节号保存到按钮tag，以便传递到expandButtonClicked方法
    
	//根据是否展开，切换按钮显示图片
	if ([self isExpanded:section])
		[eButton setImage: [ UIImage imageNamed: @"btn_down.png" ] forState:UIControlStateNormal];
	else
		[eButton setImage: [ UIImage imageNamed: @"btn_right.png" ] forState:UIControlStateNormal];
    
    
	//由于按钮的标题，
	//4个参数是上边界，左边界，下边界，右边界。
	eButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
	[eButton setTitleEdgeInsets:UIEdgeInsetsMake(5, 10, 0, 0)];
	[eButton setImageEdgeInsets:UIEdgeInsetsMake(5, 5, 0, 0)];
    
    
	//设置按钮显示颜色
	eButton.backgroundColor = [UIColor lightGrayColor];
	[eButton setTitle:[[dataList objectAtIndex:section] objectForKey:@"groupname"] forState:UIControlStateNormal];
	[eButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    //[eButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
	
	[eButton setBackgroundImage: [ UIImage imageNamed: @"btn_listbg.png" ] forState:UIControlStateNormal];//btn_line.png"
	//[eButton setTitleShadowColor:[UIColor colorWithWhite:0.1 alpha:1] forState:UIControlStateNormal];
	//[eButton.titleLabel setShadowOffset:CGSizeMake(1, 1)];
    
	[hView addSubview: eButton];
    
	[eButton release];
	return hView;
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary* m= (NSDictionary*)[dataList objectAtIndex: indexPath.section];
	NSArray *d = (NSArray*)[m objectForKey:@"users"];
    ItemInfo *item = [d objectAtIndex:indexPath.row];
    
    // 属性传值
    DetailViewController *detailViewController = [[DetailViewController alloc] initWithInfo:item];
    [self.navigationController pushViewController:detailViewController animated:YES];
    [detailViewController release];
}

@end
