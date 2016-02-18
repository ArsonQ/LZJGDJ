//
//  NewCharacteristicViewController.h
//  SportAssistant
//
//  Created by ash on 15/11/21.
//  Copyright © 2015年 ash. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LeftMenuViewController.h"
#import "RightMenuViewController.h"
#import "HomeViewController.h"


@interface NewCharacteristicViewController : UIViewController<UIScrollViewDelegate>

@property(strong,nonatomic)UIScrollView *scrollView;
@property(strong,nonatomic)UIPageControl *pgControl;
@property (strong,nonatomic)SlideNavigationController *snc;

@end
