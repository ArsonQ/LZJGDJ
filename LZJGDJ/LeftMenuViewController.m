//
//  MenuViewController.m
//  SlideMenu
//
//  Created by Aryan Gh on 4/24/13.
//  Copyright (c) 2013 Aryan Ghassemi. All rights reserved.
//

#import "LeftMenuViewController.h"
#import "SlideNavigationContorllerAnimatorFade.h"
#import "SlideNavigationContorllerAnimatorSlide.h"
#import "SlideNavigationContorllerAnimatorScale.h"
#import "SlideNavigationContorllerAnimatorScaleAndFade.h"
#import "SlideNavigationContorllerAnimatorSlideAndFade.h"

@implementation LeftMenuViewController

- (void)viewDidLoad
{
	[super viewDidLoad];
    //创建菜单头部
    UIView *headView = [[UIView alloc] init];
    headView.frame = CGRectMake(0, 0, 414, 150);
    //添加背景图片
    UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 414, 150)];
    UIImage *img = [UIImage imageNamed:@"menuHead.png"];
    bgImageView.image = img;
    [headView addSubview: bgImageView];
    //添加登陆按钮
    UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [loginBtn setFrame:CGRectMake(80, 80, 100, 25)];
    loginBtn.titleLabel.font = [UIFont systemFontOfSize:20.0];
    [loginBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [loginBtn setTitle:@"登陆" forState:UIControlStateNormal];
    [headView addSubview:loginBtn];
    //添加下拉列表
    _itemArray = [NSMutableArray arrayWithArray:@[
                                                  @[@"1",@"2",@"3",@"4",@"5",@"6"]]];
    DropDownListView * dropDownView = [[DropDownListView alloc] initWithFrame:CGRectMake(0,115, 200, 30) dataSource:self delegate:self];
    dropDownView.mSuperView = self.view;
    [headView addSubview:dropDownView];
    
    //添加菜单列表
    _menuItemName = @[@"柳州机关党建",@"党建工作考核平台",@"文明机关创建",@"在线党组织",@"电子图书馆",@"互动咨询平台",@"建言献策",@"点将台",@"在线报名",@"发文管理",];
    _m_tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 150, self.view.bounds.size.width, self.view.bounds.size.height-150) style:UITableViewStylePlain];
    //设置tableView背景图片
    UIImageView *t_imageView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"menu_bg.png"]];
    [_m_tableView setBackgroundView:t_imageView];
    //去除分割线
    _m_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self loadMenuIcon];
    //设置代理
    _m_tableView.delegate=self;
    _m_tableView.dataSource=self;
    
    [self.view addSubview:_m_tableView];
    [self.view addSubview:headView];
   
}
/**
 *  从Plist文件中加载图标
 */
- (void) loadMenuIcon {
    //读取plist
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"MenuIocn" ofType:@"plist"];
    NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    _iconArray = [NSMutableArray array];
    for (int i = 1; i<11; i++) {
        NSString *imgName = [data objectForKey:[NSString stringWithFormat:@"%d",i]];
        [_iconArray addObject:imgName];
    }
}

#pragma mark --菜单项数据
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_menuItemName count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * ID = @"cellID";
    UITableViewCell * cell = [_m_tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil)
    {

        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                       reuseIdentifier:ID];
    }
    // Configure the cell.
    cell.backgroundColor = [UIColor clearColor];
    cell.imageView.image = [UIImage imageNamed:[_iconArray objectAtIndex:indexPath.row]];
    cell.textLabel.text=[_menuItemName objectAtIndex:indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    cell.textLabel.highlightedTextColor = [UIColor redColor];
    cell.textLabel.textColor = [UIColor whiteColor];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //NSLog(@"选取了index:%ld",indexPath.row);
    id <SlideNavigationContorllerAnimator> revealAnimator;
   	CGFloat animationDuration = 0;
    //转到主页面
    if(indexPath.row==0){
        revealAnimator = [[SlideNavigationContorllerAnimatorSlideAndFade alloc] initWithMaximumFadeAlpha:.8 fadeColor:[UIColor blackColor] andSlideMovement:100];
        animationDuration = .19;
        [[SlideNavigationController sharedInstance] closeMenuWithCompletion:^{
            [SlideNavigationController sharedInstance].menuRevealAnimationDuration = animationDuration;
            [SlideNavigationController sharedInstance].menuRevealAnimator = revealAnimator;
        }];
    }else {
        ArticleListViewController *alv = [[ArticleListViewController alloc] init];
        alv.title = @"文章列表";
        [[SlideNavigationController sharedInstance] popToRootAndSwitchToViewController:alv withSlideOutAnimation:YES andCompletion:nil];
        //取消选中状态
        [_m_tableView deselectRowAtIndexPath:indexPath animated:NO];
    }
}

#pragma mark -- 下拉列表事件处理
-(void) chooseAtSection:(NSInteger)section index:(NSInteger)index
{
    //NSLog(@"选取了section:%ld ,index:%ld",(long)section,(long)index);
   
}
                                   
#pragma mark -- 下拉列表数据处理
-(NSInteger)numberOfSections
{
    return [_itemArray count];
}
-(NSInteger)numberOfRowsInSection:(NSInteger)section
{
    NSArray *arry =_itemArray[section];
    return [arry count];
}
-(NSString *)titleInSection:(NSInteger)section index:(NSInteger) index
{
    return _itemArray[section][index];
}
-(NSInteger)defaultShowSection:(NSInteger)section
{
    return 0;
}

@end
