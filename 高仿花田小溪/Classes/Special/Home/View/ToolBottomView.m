//
//  ToolBottomView.m
//  高仿花田小憩OC版  github :https://github.com/leeSmile/xiaoqi
//
//  Created by 祥云创想 on 16/6/25.
//  Copyright © 2016年 Lee. All rights reserved.
//

#import "ToolBottomView.h"
#import "UIButton+Extension.h"
@interface ToolBottomView ()
/// 查看数
Button_(seeBtn)
/// 评论数
Button_(commentBtn)
/// 点赞数
Button_(zanBtn)
/// 时间
Button_(timeBtn)
@end

@implementation ToolBottomView

- (instancetype)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI
{
    [self addSubview:self.seeBtn];
    [self addSubview:self.commentBtn];
    [self addSubview:self.zanBtn];
    [self addSubview:self.timeBtn];
    
    
    [self.commentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-20);
        make.centerY.equalTo(self);
    }];
    
    [self.zanBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.commentBtn.mas_left).offset(-10);
        make.centerY.equalTo(self);
    }];
    
    [self.seeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.zanBtn.mas_left).offset(-10);
        make.centerY.equalTo(self);
    }];
    
    [self.timeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(20);
        make.centerY.equalTo(self);
    }];
}


- (UIButton *)seeBtn
{
    if (!_seeBtn) {
        _seeBtn = [self createBtnWithImageName:@"hp_count"];
    }
    return _seeBtn;
}

- (UIButton *)commentBtn
{
    if (!_commentBtn) {
        _commentBtn = [self createBtnWithImageName:@"p_comment"];
    }
    return _commentBtn;
}


- (UIButton *)zanBtn
{
    if (!_zanBtn) {
        _zanBtn = [self createBtnWithImageName:@"p_zan"];
//        _zanBtn.backgroundColor = [UIColor redColor];
    }
    return _zanBtn;
}

- (UIButton *)timeBtn
{
    if (!_timeBtn) {
        _timeBtn = [self createBtnWithImageName:@"ad_time"];
//        _timeBtn.backgroundColor = [UIColor redColor];
    }
    return _timeBtn;
}

- (UIButton *)createBtnWithImageName:(NSString *)imageName
{
    UIButton *btn = [UIButton title:@"10" imageName:imageName target:nil selector:nil font:[UIFont systemFontOfSize:12] titleColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5]];
//    btn.userInteractionEnabled = NO;
    [btn sizeToFit];
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -10);
    [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    return btn;
}


- (void)click:(UIButton *)btn
{
    if (btn ==  self.seeBtn) {
        if ([self.delegate respondsToSelector:@selector(toolBottomView: ToolBarBtnType:)]) {
            [self.delegate toolBottomView:self ToolBarBtnType:See];
        }
        
    }else if (btn ==  self.zanBtn)
    {
        if ([self.delegate respondsToSelector:@selector(toolBottomView: ToolBarBtnType:)]) {
            [self.delegate toolBottomView:self ToolBarBtnType:Zan];
        }
        
    }else if (btn ==  self.commentBtn)
    {
        if ([self.delegate respondsToSelector:@selector(toolBottomView: ToolBarBtnType:)]) {
            [self.delegate toolBottomView:self ToolBarBtnType:Comments];
        }
        
    }
}


- (void)setArticle:(Article *)article
{
    _article = article;
    
    [self.seeBtn setTitle:[NSString stringWithFormat:@"%zd",article.read] forState:UIControlStateNormal];
    [self.commentBtn setTitle:[NSString stringWithFormat:@"%zd",article.fnCommentNum] forState:UIControlStateNormal];
    [self.zanBtn setTitle:[NSString stringWithFormat:@"%zd",article.favo] forState:UIControlStateNormal];
    //判断是否显示
    if (article.isNotHomeList) {
        if (article.createDate) {
            self.timeBtn.hidden = NO;
            NSArray *componentsArr = [article.createDate componentsSeparatedByString:@"."];
            NSString *timeStr = componentsArr.firstObject;
            LXLog(@"%@",timeStr.dateDesc);
            [self.timeBtn setTitle:timeStr.dateDesc forState:UIControlStateNormal];
            self.commentBtn.userInteractionEnabled= YES;
        }else
        {
            self.timeBtn.hidden = YES;
        }
    }else
    {
        self.timeBtn.hidden = YES;
    }
}
@end
