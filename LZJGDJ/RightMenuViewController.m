//
//  RightMenuViewController.m
//  SlideMenu
//
//  Created by Aryan Gh on 4/26/14.
//  Copyright (c) 2014 Aryan Ghassemi. All rights reserved.
//

#import "RightMenuViewController.h"

@implementation RightMenuViewController

#pragma mark - UIViewController Methods -

- (void)viewDidLoad
{
	[super viewDidLoad];
    //设置tableView背景图片

    [self.view setBackgroundColor:[UIColor colorWithRed:205/255.0 green:51/255.0 blue:51/255.0 alpha:1.0]];
    
    //定义表格的大小与类型
    self.m_tableView = [[UITableView alloc]initWithFrame:CGRectMake(60, 64, self.view.bounds.size.width-60, self.view.bounds.size.height-50) style:UITableViewStylePlain];
	//定义表格分割线
	self.m_tableView.separatorColor = [UIColor lightGrayColor];
    //去除背景
    _m_tableView.backgroundColor = [UIColor clearColor];
    _m_tableView.tableFooterView = [UIView new];
    //设置代理
    _m_tableView.delegate=self;
    _m_tableView.dataSource=self;
    
    
    //添加tableView
    [self.view addSubview:_m_tableView];
    
}

#pragma mark - UITableView Delegate & Datasrouce -

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //cell的重复利用
    NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    //显示最右边的箭头
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    //cell.textLabel.highlightedTextColor = [UIColor redColor];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.font = [UIFont systemFontOfSize:17.0f];
    NSString *cache = [NSString stringWithFormat:@"%0.2fM",[self calculateCache]];
        switch (indexPath.row)
	{
		case 0:
            cell.textLabel.text =@"关于";
			break;
    }
    cell.backgroundColor = [UIColor clearColor];
	//cell.backgroundColor = [UIColor colorWithRed:205/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
	return cell;
}

-(float)calculateCache {
    NSArray *cacPath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachePath = [cacPath objectAtIndex:0];
    
    NSFileManager *fileManager=[NSFileManager defaultManager];
    float folderSize;
    if ([fileManager fileExistsAtPath:cachePath]) {
        NSArray *childerFiles=[fileManager subpathsAtPath:cachePath];
        for (NSString *fileName in childerFiles) {
            NSString *absolutePath=[cachePath stringByAppendingPathComponent:fileName];
            folderSize += [fileManager fileExistsAtPath:absolutePath];
        }
        //SDWebImage框架自身计算缓存的实现
        folderSize+=[[SDImageCache sharedImageCache] getSize]/1024.0/1024.0;
        return folderSize;
    }
    return 0;
}

-(void)clearCache:(NSString *)path{
    NSFileManager *fileManager=[NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:path]) {
        NSArray *childerFiles=[fileManager subpathsAtPath:path];
        for (NSString *fileName in childerFiles) {
            //如有需要，加入条件，过滤掉不想删除的文件
            NSString *absolutePath=[path stringByAppendingPathComponent:fileName];
            [fileManager removeItemAtPath:absolutePath error:nil];
        }
    }
    [[SDImageCache sharedImageCache] cleanDisk];
    NSLog(@"清理成功");
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AboutViewController *avc;
    NSArray *cacPath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachePath = [cacPath objectAtIndex:0];
    
    switch (indexPath.row) {
        case 0:
            //取消选中状态
            avc = [[AboutViewController alloc] init];
            avc.title = @"关于";
            [[SlideNavigationController sharedInstance] popToRootAndSwitchToViewController:avc withSlideOutAnimation:YES andCompletion:nil];
            //取消选中状态
            [_m_tableView deselectRowAtIndexPath:indexPath animated:NO];
            break;
        case 1:
            //[self clearCache:cachePath];
            break;
        default:
            break;
    }
}

@end
