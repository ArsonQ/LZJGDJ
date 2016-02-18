//
//  HomeViewController.m
//  SlideMenuTest
//
//  Created by ash on 15/12/23.
//  Copyright © 2015年 bodakeji. All rights reserved.
//

#import "HomeViewController.h"

#define kIMGCount 5
#define kimgScrollView_height 200
#define KShotCutPanel_Y 200
#define KShotCutPanel_height 150
#define KDataTableView_Y 350

@interface HomeViewController ()
/** 用来显示的假数据 */
@property (strong, nonatomic) NSMutableArray *data;
@end

@implementation HomeViewController

@synthesize titleLabel;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:205/255.0 green:51/255.0 blue:51/255.0 alpha:1.0]];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName]];
    self.title = @"柳州党建机关";
    //数据初始化
    _currentPage = 1;
    _BannerCount = 0;
    _bannerCurrentPage = 0;
    _articleArray = [NSMutableArray array];
    _BannerArticleArray = [NSMutableArray array];
    _isBanner = NO;
    //请求地址
    _URLString = @"http://103.238.227.64:81/AppAjax/ReadListHandler.ashx";

    [self addMenuIcon];
    [self addShotCutModule];
    [self addDataTableView];
    // Do any additional setup after loading the view.
}

#pragma mark 添加菜单选项
- (void)addMenuIcon {
    //添加左边按钮
    UIButton *leftbButton  = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [leftbButton setImage:[UIImage imageNamed:@"menu-button"] forState:UIControlStateNormal];
    [leftbButton addTarget:[SlideNavigationController sharedInstance] action:@selector(toggleLeftMenu) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftbButton];
    [SlideNavigationController sharedInstance].leftBarButtonItem = leftBarButtonItem;
    //添加右边按钮
    UIButton *rightButton  = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [rightButton setImage:[UIImage imageNamed:@"menu-button"] forState:UIControlStateNormal];
    [rightButton addTarget:[SlideNavigationController sharedInstance] action:@selector(toggleRightMenu) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    [SlideNavigationController sharedInstance].rightBarButtonItem = rightBarButtonItem;
}

#pragma mark 添加滚动图片栏
- (void)addBanner {
    /**
     创建scrollview
     */
    _imgScrollView = [[UIScrollView alloc]init];
    _imgScrollView.frame = CGRectMake(0, 0, self.view.bounds.size.width, kimgScrollView_height);
    [self.view addSubview:_imgScrollView];
    
    CGFloat width = _imgScrollView.frame.size.width;
    CGFloat height = _imgScrollView.frame.size.height;
    //图片信息栏
    UIView *TextView = [[UIView alloc] initWithFrame:CGRectMake(0, _imgScrollView.bounds.size.height-20, _imgScrollView.bounds.size.width, 20)];
    UIColor *bgColor = [UIColor colorWithPatternImage: [UIImage imageNamed:@"textViewBg.png"]];
    TextView.backgroundColor = bgColor;
    //图片标题
    _imgTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, _imgScrollView.bounds.size.width-50, 20)];
    //当前图片
    _currentImg = [[UILabel alloc] initWithFrame:CGRectMake(_imgScrollView.bounds.size.width-30, 0,30, 20)];
    //设置文字属性高
    _imgTitle.textColor = [UIColor whiteColor];
    _imgTitle.font = [UIFont systemFontOfSize:12.0f];
    _currentImg.textColor = [UIColor whiteColor];
    _currentImg.font = [UIFont systemFontOfSize:12.0f];
    //添加到页面
    [TextView addSubview:_imgTitle];
    [TextView addSubview:_currentImg];
    [self.view addSubview:TextView];
    
    /**
     *  设置scrollview属性
     */
    _imgScrollView.contentSize = CGSizeMake(width*_BannerArticleArray.count, 0);
    _imgScrollView.pagingEnabled = YES;
    _imgScrollView.showsHorizontalScrollIndicator = NO;
    _imgScrollView.showsVerticalScrollIndicator = NO;
    _imgScrollView.bounces = FALSE;
    _imgScrollView.delegate = self;
    
    /**
     设置图片与标题
     */
    for (int i=0; i<_BannerArticleArray.count; i++) {
        UIImageView *imgView = [[UIImageView alloc] init];
        CGFloat img_x = i*width;
        CGFloat img_y = 0;
        imgView.frame = CGRectMake(img_x, img_y, width, height);
        Article *article = _BannerArticleArray[i];
        _imgTitle.text = article.Title;
        
        [imgView sd_setImageWithURL:article.url placeholderImage:[UIImage imageNamed:@"characteristic_01.png"]];
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickImage:)];
        //[tapGestureRecognizer setValue:article forKey:@"Article"];
        [imgView addGestureRecognizer:tapGestureRecognizer];
        imgView.userInteractionEnabled=YES;
        [_imgScrollView addSubview:imgView];
        if (i==0) {
            _imgTitle.text = article.Title;
            _currentImg.text = [NSString stringWithFormat:@"1/%lu",_BannerArticleArray.count];
        }
    }
}

- (void)clickImage:(id) sender {
    if (_BannerArticleArray.count>0) {
        Article *article = _BannerArticleArray[_bannerCurrentPage];
        ArtcleDetailViewController *advc = [[ArtcleDetailViewController alloc]init];
        advc.article = article;
        advc.title = @"文章详情";
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
        self.navigationItem.backBarButtonItem = item;
        
        [[SlideNavigationController sharedInstance]popToRootAndSwitchToViewController:advc withSlideOutAnimation:YES andCompletion:nil];
    }
}

#pragma mark 添加快捷操作面板
- (void)addShotCutModule {
    //创建快捷面板
    UIView *ShotCutPanel = [[UIView alloc] initWithFrame:CGRectMake(0, KShotCutPanel_Y, self.view.bounds.size.width, KShotCutPanel_height)];
    ShotCutPanel.backgroundColor = [UIColor whiteColor];
    
    //图片名字
    NSArray *img = @[@"CEvent.png",@"Dynamic.png",@"Organization.png",@"RSS.png",@"Research.png",@"Inspection.png",@"Union.png",@"Teenage.png",@"Woman.png",@"OnlineSch.png"];
    //标题文字
    NSArray *name = @[@"时事",@"工委动态",@"组织工作",@"宣传工作",@"党建研究",@"纪检工作",@"机关工会",@"机关青年",@"机关妇女",@"网上党校"];
    int space = (self.view.bounds.size.width-250)/6;
    
    //创建按钮
    for (int i=0; i<10; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.titleLabel.font = [UIFont systemFontOfSize:12.0f];
        if (i<5) {
            btn.frame = CGRectMake((i*50)+(i+1)*space, 10, 50, 50);
            [btn setImage:[img objectAtIndex:i] withTitle:[name objectAtIndex:i] forState:(UIControlStateNormal)];
        }else {
            //调整第二排参数
            int j = i-5;
            btn.frame = CGRectMake((j*50)+(j+1)*space, 80, 50, 50);
            [btn setImage:[img objectAtIndex:i] withTitle:[name objectAtIndex:i] forState:(UIControlStateNormal)];
        }
        //添加按钮监听
        switch (i) {
            case 0:
                [btn addActionHandler:^(NSInteger tag) {
                    NSLog(@"点击了时事按钮！");
                }];
                break;
            case 1:
                [btn addActionHandler:^(NSInteger tag) {
                    NSLog(@"点击了工委动态按钮！");
                }];
                break;
            case 2:
                [btn addActionHandler:^(NSInteger tag) {
                    NSLog(@"点击了组织工作按钮！");
                }];
                break;
            case 3:
                [btn addActionHandler:^(NSInteger tag) {
                    NSLog(@"点击了宣传工作按钮！");
                }];
                break;
            case 4:
                [btn addActionHandler:^(NSInteger tag) {
                    NSLog(@"点击了党建研究按钮！");
                }];
                break;
            case 5:
                [btn addActionHandler:^(NSInteger tag) {
                    NSLog(@"点击了纪检工作按钮！");
                }];
                break;
            case 6:
                [btn addActionHandler:^(NSInteger tag) {
                    NSLog(@"点击了机关工会按钮！");
                }];
                break;
            case 7:
                [btn addActionHandler:^(NSInteger tag) {
                    NSLog(@"点击了机关青年按钮！");
                }];
                break;
            case 8:
                [btn addActionHandler:^(NSInteger tag) {
                    NSLog(@"点击了机关妇女按钮！");
                }];
                break;
            case 9:
                [btn addActionHandler:^(NSInteger tag) {
                    NSLog(@"点击了网上党校按钮！");
                }];
                break;
            default:
                break;
        }
        [ShotCutPanel addSubview:btn];
    }
    [self.view addSubview:ShotCutPanel];
}

#pragma mark 图片文字显示
- (void) scrollViewDidScroll:(UIScrollView *)scrollView{
    CGPoint point = scrollView.contentOffset;
    CGFloat offsetX = point.x;
    int pgNum =(offsetX + 0.5*_imgScrollView.frame.size.width)/_imgScrollView.frame.size.width;
    if (_BannerArticleArray.count>0) {
        Article *article = _BannerArticleArray[pgNum];
        _imgTitle.text = [NSString stringWithFormat:@"%@",article.Title];
        _currentImg.text = [NSString stringWithFormat:@"%d/%lu",pgNum+1,_BannerArticleArray.count];
        _bannerCurrentPage = pgNum;
    }
}

#pragma mark 网络检测
- (void)reach {
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
                //AFNetworkReachabilityStatusUnknown          = -1
            case -1:
                NSLog(@"当前网络为未知网路");
                break;
                //AFNetworkReachabilityStatusNotReachable     = 0
            case 0:
                NSLog(@"当前网络无法连接");
                break;
                //AFNetworkReachabilityStatusReachableViaWWAN = 1
            case 1:
                NSLog(@"当前网络为3G网络");
                break;
                //AFNetworkReachabilityStatusReachableViaWiFi = 2
            case 2:
                NSLog(@"当前网络为局域网络");
                break;
                
            default:
                break;
        }
    }];
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
}
#pragma mark 添加数据table
- (void)addDataTableView {
    _dataTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, KDataTableView_Y, self.view.bounds.size.width, self.view.bounds.size.height-KDataTableView_Y)];
    //去掉分割线
    _dataTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //设置cell的高度
    _dataTableView.rowHeight = 90;
    //设置代理
    _dataTableView.delegate = self;
    _dataTableView.dataSource = self;
    
    //加载数据
    [self loadNewData];
    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    _dataTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        _currentPage++;
        [self loadNewData];
    }];
    // 马上进入刷新状态
    [_dataTableView.mj_header beginRefreshing];
    
    [self.view addSubview:_dataTableView];
    
}

- (void)loadNewData
{
    //检测网络，待用
    [self reach];
    NSString *pageString = [NSString stringWithFormat:@"%ld",(long)_currentPage];
    //请求参数
    _parameters = [self parametersWithPageSize:@"5" PageIndex:pageString TableName:@"oBo_Article" TableID:@"ID" SelectedFields:@"*" strWhere:@"1=1" PagestrOrderBySize:@"ID"];
    
    [NetworkInterface connectWithMode:@"POST" baseURL:_URLString parameters:_parameters progress:^(NSProgress *progress) {
    } success:^(id responseObject) {
        NSDictionary *dict = [responseObject valueForKey:@"Rows"];
        //临时保存文章
        NSMutableArray *temp = [Article mj_objectArrayWithKeyValuesArray:dict];
        //添加到数组
        for (Article *article in temp) {
            [_articleArray addObject:article];
        }
        // 刷新表格
        [_dataTableView reloadData];
        [_dataTableView.mj_footer endRefreshing];
        //下载缩略图
        [self downLoadthumbnail:temp];
    } failure:^(NSError *error) {
        NSLog(@"失败：%@",error);
    }];
    
}

//        /*
//        //上传范例
//        NSURL *fileURL = [[NSBundle mainBundle] URLForResource:@"头像1.png" withExtension:nil];
//        
//        // 要上传保存在服务器中的名称
//        // 使用时间来作为文件名 2014-04-30 14:20:57.png
//        // 让不同的用户信息,保存在不同目录中
//        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//        // 设置日期格式
//        formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
//        NSString *fileName = [formatter stringFromDate:[NSDate date]];
//        
//        [formData appendPartWithFileURL:fileURL name:@"uploadFile" fileName:fileName mimeType:@"image/png" error:NULL];
//         */

#pragma mark请求参数
- (NSDictionary *)parametersWithPageSize:(NSString *)pageSize PageIndex:(NSString *)pageIndex TableName:(NSString *)tableName TableID:(NSString *)tableID SelectedFields:(NSString *)selectedFields strWhere:(NSString *)strWhere PagestrOrderBySize:(NSString *)strOrderBy {
    //创建参数字典
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    //添加参数到字典
    [parameters setObject:pageSize forKey:@"PageSize"];
    [parameters setObject:pageIndex forKey:@"PageIndex"];
    [parameters setObject:tableName forKey:@"TableName"];
    [parameters setObject:tableID forKey:@"TableID"];
    [parameters setObject:selectedFields forKey:@"SelectedFields"];
    [parameters setObject:strWhere forKey:@"strWhere"];
    [parameters setObject:strOrderBy forKey:@"strOrderBy"];

    return parameters;
}

#pragma mark 下载缩略图
- (void)downLoadthumbnail:(NSMutableArray *)array {

    for (int i=0; i<array.count; i++) {
        Article *article = (Article *)array[i];
        //获取附件ID
        NSString *ID = [NSString stringWithFormat:@"ID=%u",article.PicPath];
//        //当缩略图不存在时，设置为空
//        if (article.PicPath == 0) {
//            article.image = nil;
//            continue;
//        }
        //请求参数
        _parameters = [self parametersWithPageSize:@"1" PageIndex:@"1" TableName:@"sys_uploadfile" TableID:@"ID" SelectedFields:@"*" strWhere:ID PagestrOrderBySize:@"ID"];
        //建立请求
        [NetworkInterface connectWithMode:@"POST" baseURL:_URLString parameters:_parameters progress:^(NSProgress *progress) {
        } success:^(id responseObject) {
            NSDictionary *dict = [responseObject valueForKey:@"Rows"];
            //临时保存
            NSMutableArray *tempArray = [Enclosure mj_objectArrayWithKeyValuesArray:dict];
            if (tempArray.count>0) {
                Enclosure *enl = tempArray[0];
                //地址制表符替换
                NSString *tempString= [enl.RelativeThuPath stringByReplacingOccurrencesOfString:@"\\" withString:@"/"];
                //地址拼接
                NSString *urlString = [NSString stringWithFormat:@"http://103.238.227.64:81/%@",tempString];
                NSURL * url=[[NSURL alloc] initWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
                
                //设置文章缩略图的链接地址
                article.url = url;
                if (_isBanner == NO) {
                    [_BannerArticleArray addObject:article];
                }
            }
            _BannerCount ++;
            if (_BannerCount == 5) {
                _isBanner = YES;
                [self addBanner];
                
            }
            [_dataTableView reloadData];
        } failure:^(NSError *error) {
            NSLog(@"缩略图下载失败：%@",error);
        }];
    }
    
}

#pragma mark --数据表处理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _articleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * ID = @"cellID";
    BOOL nibsRegistered = NO;
    //自定义cell
    if (!nibsRegistered) {
        UINib *nib = [UINib nibWithNibName:NSStringFromClass([TableViewCell class]) bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:ID];
        nibsRegistered = YES;
    }
    //循环利用cell
    TableViewCell *cell = (TableViewCell *)[_dataTableView dequeueReusableCellWithIdentifier:ID];
    //设置cell的边框
    cell.View.layer.borderColor=[UIColor darkGrayColor].CGColor;
    cell.View.layer.borderWidth=0.3;
    //设置cell的信息
    Article *article =(Article *)_articleArray[indexPath.row];
    cell.title.text = article.Title;
    cell.addtime.text = article.AddTime;
    //异步获取图片
    [cell.imgeView sd_setImageWithURL:article.url placeholderImage:[UIImage imageNamed:@"default_img.png"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
    }];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"选取了index:%ld",indexPath.row);
    ArtcleDetailViewController *advc = [[ArtcleDetailViewController alloc]init];
    advc.article = _articleArray[indexPath.row];
    advc.title = @"文章详情";
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = item;
    
    [[SlideNavigationController sharedInstance]popToRootAndSwitchToViewController:advc withSlideOutAnimation:YES andCompletion:nil];
    
}

- (BOOL)slideNavigationControllerShouldDisplayLeftMenu {
    return YES;
}

- (BOOL)slideNavigationControllerShouldDisplayRightMenu {
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
