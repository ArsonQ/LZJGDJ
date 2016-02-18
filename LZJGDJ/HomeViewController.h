//
//  HomeViewController.h
//  SlideMenuTest
//
//  Created by ash on 15/12/23.
//  Copyright © 2015年 bodakeji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SlideNavigationController.h"
#import "Button_Header.h"
#import "NetworkInterface.h"
#import "MJExtension.h"
#import "MJRefresh.h"
#import "Article.h"
#import "Enclosure.h"
#import "TableViewCell.h"
#import "ArtcleDetailViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface HomeViewController : UIViewController<SlideNavigationControllerDelegate,UIScrollViewDelegate,UIWebViewDelegate,UITableViewDelegate,UITableViewDataSource>

@property (strong,nonatomic) NSString *URLString;
@property (strong,nonatomic) NSDictionary *parameters;
@property (strong,nonatomic) UIScrollView *imgScrollView;
@property (strong,nonatomic) UILabel *imgTitle;
@property (strong,nonatomic) UILabel *currentImg;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UITableView *dataTableView;
@property (strong,nonatomic) NSMutableArray *articleArray;
@property (strong,nonatomic) NSMutableArray *BannerArticleArray;
@property (assign,nonatomic) NSInteger currentPage;
@property (assign,nonatomic) NSInteger bannerCurrentPage;
@property (strong,nonatomic) SDWebImageManager *sdmanager;
@property (assign,nonatomic) NSInteger BannerCount;
@property (assign,nonatomic) Boolean isBanner;


- (NSDictionary *) parametersWithPageSize:(NSString *)pageSize PageIndex:(NSString *)pageIndex TableName:(NSString *)tableName TableID:(NSString *)tableID SelectedFields:(NSString *)selectedFields strWhere:(NSString *)strWhere PagestrOrderBySize:(NSString *)strOrderBy;

@end
