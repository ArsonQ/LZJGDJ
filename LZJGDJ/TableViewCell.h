//
//  TableViewCell.h
//  LZJGDJ
//
//  Created by Arson on 16/1/26.
//  Copyright © 2016年 Arson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *View;

@property (weak, nonatomic) IBOutlet UIImageView *imgeView;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *addtime;
@end
