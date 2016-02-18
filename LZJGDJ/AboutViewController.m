//
//  AboutViewController.m
//  LZJGDJ
//
//  Created by Arson on 16/2/15.
//  Copyright © 2016年 Arson. All rights reserved.
//

#import "AboutViewController.h"

@interface AboutViewController ()

@end

@implementation AboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置背景
    [self.view setBackgroundColor:[UIColor colorWithRed:245.0/255 green:245.0/255 blue:245.0/255 alpha:1]];
    //imege展示
    UIImageView *logoView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 100, self.view.bounds.size.width, 100)];
    //获取图片
    UIImage *image = [UIImage imageNamed:@"aboutLogo.png"];
    logoView.contentMode = UIViewContentModeCenter;
    logoView.image = image;
    
    //创建tableView
    _m_tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 250, self.view.bounds.size.width, self.view.bounds.size.height)];
    _m_tableView.backgroundColor = [UIColor clearColor];
    _m_tableView.tableFooterView = [UIView new];
    _m_tableView.delegate = self;
    _m_tableView.dataSource = self;
    
    //版权信息
    UILabel *right_cn = [[UILabel alloc]initWithFrame:CGRectMake(0, self.view.bounds.size.height-50, self.view.bounds.size.width, 20)];
    UILabel *right_en = [[UILabel alloc]initWithFrame:CGRectMake(0, self.view.bounds.size.height-25, self.view.bounds.size.width, 20)];
    //设置文字居中,文字大小，文字颜色
    right_cn.textAlignment = NSTextAlignmentCenter;
    right_cn.font = [UIFont systemFontOfSize:12.0f];
    right_cn.textColor = [UIColor darkGrayColor];
    right_en.textAlignment = NSTextAlignmentCenter;
    right_en.font = [UIFont systemFontOfSize:12.0f];
    right_en.textColor = [UIColor darkGrayColor];
    //设置版权文字信息
    right_cn.text = @"xxx公司 版权所有";
    right_en.text = @"Copyright © 2015-1016 xxx.All Right Rserved.";
    
    [self.view addSubview:logoView];
    [self.view addSubview:_m_tableView];
    [self.view addSubview:right_cn];
    [self.view addSubview:right_en];
    

    // Do any additional setup after loading the view.
}


#pragma mark -- tableView代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}	

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellID = @"ID";
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (nil==cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    //cell字体颜色
    cell.textLabel.textColor = [UIColor darkGrayColor];
    //cell去除背景色
    cell.backgroundColor = [UIColor clearColor];
    //cell右边小箭头
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    switch (indexPath.row) {
        case 0:
            cell.textLabel.text = @"去评分";
            break;
        case 1:
            cell.textLabel.text = @"常见问题";
            break;
        default:
            break;
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
