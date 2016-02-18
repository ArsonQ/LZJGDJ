//
//  Article.h
//  LZJGDJ
//
//  Created by Arson on 16/1/19.
//  Copyright © 2016年 Arson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Article : NSObject

@property (assign, nonatomic) BOOL IsVisible;
@property (assign, nonatomic) BOOL IsTop;
@property (assign, nonatomic) BOOL IsAlwaysTop;
@property (assign, nonatomic) BOOL IsPassCheck;
@property (assign, nonatomic) unsigned int ID;
@property (assign, nonatomic) unsigned int GroupID;
@property (assign, nonatomic) unsigned int AuthorID;
@property (assign, nonatomic) unsigned int ParentID;
@property (assign, nonatomic) unsigned int VedioPath;
@property (assign, nonatomic) unsigned int PicPath;
@property (copy, nonatomic) NSString *AddTime;
@property (copy, nonatomic) NSString *Title;
@property (copy, nonatomic) NSString *KeyWord;
@property (copy, nonatomic) NSString *Content;
@property (copy, nonatomic) NSString *CreateHostAddress;
@property (copy, nonatomic) NSString *Remark;
@property (copy, nonatomic) NSString *CurrentCheckTypeName;
@property (copy, nonatomic) NSString *Source;
@property (copy, nonatomic) NSString *AttrIDs;
@property (copy, nonatomic) NSString *LinkUrl;
@property (copy, nonatomic) NSString *Sort;
@property (copy, nonatomic) NSString *AskForCheckText;
@property (copy, nonatomic) NSString *ModifyHostAddress;
@property (copy, nonatomic) NSString *NotPassCheckText;
@property (copy, nonatomic) NSString *Hits;
@property (copy, nonatomic) NSString *DQSHLCID;
@property (strong,nonatomic) NSURL *url;
@property (strong,nonatomic) UIImage *image;

@end
