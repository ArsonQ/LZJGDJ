//
//  UIButton+ImageWithLable.m
//  LZJGDJ
//
//  Created by Arson on 16/1/20.
//  Copyright © 2016年 Arson. All rights reserved.
//

#import "UIButton+ImageWithLable.h"

@implementation UIButton (ImageWithLable)
/**
 *  文字与图片上下排列
 *
 *  @param image     图片
 *  @param title     文字
 *  @param stateType 按钮状态
 */
- (void) setImage:(NSString *)imageName withTitle:(NSString *)title forState:(UIControlState)stateType {
    //UIEdgeInsetsMake(CGFloat top, CGFloat left, CGFloat bottom, CGFloat right)
    UIImage *image = [UIImage imageNamed:imageName];
    [self.imageView setContentMode:UIViewContentModeCenter];
    [self setImageEdgeInsets:UIEdgeInsetsMake(0.0, (self.bounds.size.width - image.size.width)/2,5,0.0)];
    [self setImage:image forState:UIControlStateNormal];
    //[self.titleLabel setBackgroundColor:[UIColor clearColor]];
    [self setTitleEdgeInsets:UIEdgeInsetsMake(image.size.height+15,-image.size.width,0.0,0.0)];
    [self setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [self setTitle:title forState:stateType];
}

@end
