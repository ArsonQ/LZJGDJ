//
//  ArtcleDetailViewController.h
//  LZJGDJ
//
//  Created by Arson on 16/1/27.
//  Copyright © 2016年 Arson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Article.h"
#import "SlideNavigationController.h"


@interface ArtcleDetailViewController : UIViewController<SlideNavigationControllerDelegate>
@property (nonatomic,strong) Article *article;
@property (strong, nonatomic) UILabel *articleTitle;
@property (strong,nonatomic) UILabel *articleAuthor;
@property (strong,nonatomic) UILabel *articleAddtime;

@end
