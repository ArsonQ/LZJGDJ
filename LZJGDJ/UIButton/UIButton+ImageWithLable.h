//
//  UIButton+ImageWithLable.h
//  LZJGDJ
//
//  Created by Arson on 16/1/20.
//  Copyright © 2016年 Arson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (ImageWithLable)
//设置图片与文字
- (void) setImage:(NSString *)imageName withTitle:(NSString *)title forState:(UIControlState)stateType;
@end
