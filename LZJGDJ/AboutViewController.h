//
//  AboutViewController.h
//  LZJGDJ
//
//  Created by Arson on 16/2/15.
//  Copyright © 2016年 Arson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AboutViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView* m_tableView;

@end
