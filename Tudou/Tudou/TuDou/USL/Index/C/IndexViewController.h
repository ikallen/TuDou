
#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"

@interface IndexViewController : UIViewController
<UITableViewDelegate, UITableViewDataSource>
{
    UIScrollView *_scrollView;
    
	UITableView *_tableView;
	
    // 数据源
    NSMutableArray *dataList;
    
    
    
}
@end
