//
//  NewCharacteristicViewController.m
//  SportAssistant
//
//  Created by ash on 15/11/21.
//  Copyright © 2015年 ash. All rights reserved.
//

#import "NewCharacteristicViewController.h"

#define kIMGCount 3

@interface NewCharacteristicViewController ()

@end

@implementation NewCharacteristicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    /**
     创建scrollview
     */
    _scrollView = [[UIScrollView alloc]init];
    _scrollView.frame = self.view.bounds;
    [self.view addSubview:_scrollView];
    
    CGFloat width = _scrollView.frame.size.width;
    CGFloat height = _scrollView.frame.size.height;

    /**
     设置图片
     */
    for (int i=1; i<kIMGCount+1; i++) {
        UIImageView *imgView = [[UIImageView alloc] init];
        CGFloat img_x = (i-1)*width;
        CGFloat img_y = 0;
        imgView.frame = CGRectMake(img_x, img_y, width, height);
        imgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"characteristic_0%i",i]];
        [_scrollView addSubview:imgView];
        /**
         *  如果是最后一张，插入跳转按钮
         */
        if (i==kIMGCount) {
            [self addJumpBtn:imgView];
        }
    }
    /**
     添加页面控制显示
     */
    _pgControl = [[UIPageControl alloc] initWithFrame:CGRectMake(120, 500, 100, 75)];
    _pgControl.numberOfPages = kIMGCount;
    _pgControl.pageIndicatorTintColor = [UIColor whiteColor];
    _pgControl.currentPageIndicatorTintColor = [UIColor blueColor];
    [self.view addSubview:_pgControl];
    /**
     *  设置scrollview属性
     */
    _scrollView.contentSize = CGSizeMake(width*kIMGCount, 0);
    _scrollView.pagingEnabled = YES;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.bounces = NO;
    _scrollView.delegate = self;
    
    // Do any additional setup after loading the view.
}
/**
 *  添加跳转按钮
 *
 *  @param imgeView 添加到指定的imgeView上
 */
#pragma mark 添加跳转按钮
- (void)addJumpBtn:(UIImageView *)imgeView {
    imgeView.userInteractionEnabled = true;
    UIButton *jumpBtn = [[UIButton alloc] init];
    jumpBtn.frame = CGRectMake(95, 420, 150, 50);
    [jumpBtn setTitle:@"马上体验" forState:UIControlStateNormal];
    [jumpBtn setTitleColor:[UIColor colorWithRed:0 green:255 blue:255 alpha:1] forState:UIControlStateNormal];
    [jumpBtn.layer setBorderWidth:3.0];
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 0, 255, 255, 1 });
    [jumpBtn.layer setBorderColor:colorref];
    [jumpBtn addTarget:self action:@selector(jumpBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [imgeView addSubview:jumpBtn];
 
}
/**
 *  响应点击，跳转至主页面
 */
#pragma mark 跳转按钮响应
- (void)jumpBtnClick {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    HomeViewController *home = [[HomeViewController alloc]init];
    
    self.snc = [[SlideNavigationController alloc]initWithRootViewController:home];
    LeftMenuViewController *leftMenu = [[LeftMenuViewController alloc] init];
    RightMenuViewController *rightMenu = [[RightMenuViewController alloc] init];
    [window setRootViewController:_snc];
    
    [SlideNavigationController sharedInstance].rightMenu = rightMenu;
    [SlideNavigationController sharedInstance].leftMenu = leftMenu;
}
#pragma mark 图片转换控制点显示
- (void) scrollViewDidScroll:(UIScrollView *)scrollView{
    CGPoint point = scrollView.contentOffset;
    CGFloat offsetX = point.x;
    int pgNum =(offsetX + 0.5*_scrollView.frame.size.width)/_scrollView.frame.size.width;
    _pgControl.currentPage = pgNum;
    NSLog(@"当前是%i页",pgNum);	
}

-(void) dealloc{
    NSLog(@"销毁新特性判断线");
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
