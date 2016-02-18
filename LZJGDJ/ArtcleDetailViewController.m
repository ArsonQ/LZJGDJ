//
//  ArtcleDetailViewController.m
//  LZJGDJ
//
//  Created by Arson on 16/1/27.
//  Copyright © 2016年 Arson. All rights reserved.
//

#import "ArtcleDetailViewController.h"


@interface ArtcleDetailViewController ()

@end

@implementation ArtcleDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self laodarticleHead];
    [self loadWebView];
}
//添加头部
- (void)laodarticleHead {
    //添加标题
    _articleTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, 64, self.view.bounds.size.width-10, 45)];
    _articleTitle.font = [UIFont systemFontOfSize:18.0];;
    _articleTitle.textColor = [UIColor colorWithRed:156/255.0 green:6/255.0 blue:6/255.0 alpha:1.0];
    _articleTitle.numberOfLines = 2;
    _articleTitle.text = _article.Title;
    //添加作者
    _articleAuthor = [[UILabel alloc] initWithFrame:CGRectMake(10, 110, self.view.bounds.size.width-10, 20)];
    _articleAuthor.font = [UIFont systemFontOfSize:15.0];;
    _articleAuthor.textColor = [UIColor grayColor];
    NSString *authorS= [NSString stringWithFormat:@"作者：%u",_article.AuthorID];
    _articleAuthor.text = authorS;
    //添加时间
    _articleAddtime = [[UILabel alloc] initWithFrame:CGRectMake(10, 130, self.view.bounds.size.width-10, 20)];
    _articleAddtime.font = [UIFont systemFontOfSize:15.0];;
    _articleAddtime.textColor = [UIColor grayColor];
    _articleAddtime.text = _article.AddTime;
    
    [self.view addSubview:_articleTitle];
    [self.view addSubview:_articleAuthor];
    [self.view addSubview:_articleAddtime];
}
//添加网页展示
- (void)loadWebView {
    //创建WebView
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 150, self.view.bounds.size.width, self.view.bounds.size.height-150)];
    //主机地址
    NSURL *URLString = [NSURL URLWithString:@"http://103.238.227.64:81"];
    //限制图片大小
    NSString *htmlString = [NSString stringWithFormat:@"%@%@",@"<head><style>img{max-width:300px;max-height:225px;}</style></head>",_article.Content];
    //从字符串加载
    [webView loadHTMLString:htmlString baseURL:URLString];
    
    
    [self.view addSubview:webView];

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
