//
//  SimpleCellView.m
//  LTableViewAdapterExample
//
//  Created by ylin on 17/3/6.
//  Copyright © 2017年 ylin.yang. All rights reserved.
//

#import "SimpleCellView.h"
#import <UITableViewCell+Model.h>
#import "TableCell.h"

@implementation SimpleCellView

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)updateUI {
    [super updateUI];
    self.titleLab.text = self.model.title;
}
@end
