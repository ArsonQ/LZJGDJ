//
//  AppDelegate.h
//  LZJGDJ
//
//  Created by Arson on 16/1/17.
//  Copyright © 2016年 Arson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewCharacteristicViewController.h"
#import "LeftMenuViewController.h"
#import "RightMenuViewController.h"
#import "HomeViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong,nonatomic)SlideNavigationController *snc;


@end

