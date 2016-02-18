//
//  ArticleListViewController.m
//  LZJGDJ
//
//  Created by Arson on 16/2/15.
//  Copyright © 2016年 Arson. All rights reserved.
//

#import "ArticleListViewController.h"

@interface ArticleListViewController ()

@end

@implementation ArticleListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(0, 150, self.view.bounds.size.width, 150)];
    lable.font = [UIFont systemFontOfSize:20.0];
    lable.textAlignment = 	NSTextAlignmentCenter;
    lable.text = @"暂无数据";
    
    [self.view addSubview:lable];
    
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
