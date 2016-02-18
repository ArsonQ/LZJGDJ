//
//  Enclosure.h
//  LZJGDJ
//
//  Created by Arson on 16/1/26.
//  Copyright © 2016年 Arson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Enclosure : NSObject

@property (assign, nonatomic) BOOL IsUsed;
@property (assign, nonatomic) unsigned int DownloadTimes;
@property (assign, nonatomic) unsigned int ID;
@property (copy, nonatomic) NSString *AddTime;
@property (copy, nonatomic) NSString *ExtName;
@property (copy, nonatomic) NSString *RealPath;
@property (copy, nonatomic) NSString *RelativePath;
@property (copy, nonatomic) NSString *RelativeThuPath;
@property (copy, nonatomic) NSString *SerialNumber;
@property (copy, nonatomic) NSString *ShowName;
@property (copy, nonatomic) NSString *Size;
@property (copy, nonatomic) NSString *UploadIP;
@property (copy, nonatomic) NSString *UploadUserID;

@end
