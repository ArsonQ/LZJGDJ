//
//  MenuViewController.h
//  SlideMenu
//
//  Created by Aryan Gh on 4/24/13.
//  Copyright (c) 2013 Aryan Ghassemi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SlideNavigationController.h"
#import "DropDownListView.h"
#import "ArticleListViewController.h"


@interface LeftMenuViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,DropDownChooseDelegate,DropDownChooseDataSource>
@property (nonatomic, assign) BOOL slideOutAnimationEnabled;
//创建菜单列表
@property (nonatomic,strong) UITableView *m_tableView;
//下拉列表数组
@property (nonatomic,strong) NSMutableArray *itemArray;
//菜单选项图标
@property (nonatomic,strong) NSMutableArray *iconArray;
//菜单选项名称
@property (nonatomic,strong) NSArray *menuItemName;

@end
