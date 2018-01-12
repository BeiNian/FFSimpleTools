//
//  ViewControllerCell.m
//  FFSimpleTools
//
//  Created by cts on 2018/1/12.
//  Copyright © 2018年 cts. All rights reserved.
//

#import "ViewControllerCell.h"

@implementation ViewControllerCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
