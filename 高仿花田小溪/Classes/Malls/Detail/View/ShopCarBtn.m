//
//  ShopCarBtn.m
//  高仿花田小憩OC版
//
//  Created by 祥云创想 on 16/7/11.
//  Copyright © 2016年 Lee. All rights reserved.
//

#import "ShopCarBtn.h"

static CGFloat labelWidth = 12;

@interface ShopCarBtn ()
Label_(numLabel)
@end

@implementation ShopCarBtn




- (UILabel *)numLabel
{
    if (!_numLabel) {
        _numLabel = [UILabel new];
        _numLabel.font = [UIFont systemFontOfSize:9];
        _numLabel.layer.cornerRadius = labelWidth * 0.5;
        _numLabel.layer.masksToBounds = YES;
        _numLabel.textColor = [UIColor whiteColor];
        _numLabel.backgroundColor = [UIColor redColor];
        _numLabel.textAlignment = NSTextAlignmentCenter;
        
        [self addSubview:_numLabel];
        
        [_numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self);
            make.left.equalTo(self.mas_right).offset(-3);
            make.size.mas_equalTo(CGSizeMake(labelWidth, labelWidth));
        }];
    }
    return _numLabel;
}


- (void)setNum:(int)num
{
    _num = num;
    if (num == 0) {
        self.numLabel.hidden = YES;
    }else
    {
        self.numLabel.hidden = NO;
        self.numLabel.text = [NSString stringWithFormat:@"%zd",num];
    }
}

@end
