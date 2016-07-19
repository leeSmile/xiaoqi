//
//  CommentViewController.m
//  高仿花田小憩OC版
//
//  Created by 祥云创想 on 16/6/29.
//  Copyright © 2016年 Lee. All rights reserved.
//

#import "CommentViewController.h"
#import "CommentViewCell.h"
#import "NetworkTool.h"
#import "CommentBottomView.h"
#import "MJRefresh.h"
@interface CommentViewController()<CommentViewCellDelegate,CommentBottomViewDelegate>
// 没有任何评论的提醒label
Label_(tipLabel)
DIYObj_(NetworkTool, tools)
// 当前页码
int_(currentPage)
//底部评论View
DIYObj_(CommentBottomView, inputBottomView)
// 评论列表
@property(nonatomic, strong) NSMutableArray<Comment *> *comments;

//蒙版
Button_(HUDView)
@end

static NSString *CommentCellReuseIdentifier = @"CommentCellReuseIdentifier";
@implementation CommentViewController
//懒加载
- (UIButton *)HUDView
{
    if (!_HUDView) {
        _HUDView = [[UIButton alloc] init];
        _HUDView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
        [_HUDView addTarget:self action:@selector(clickHideBottomView) forControlEvents:UIControlEventTouchUpInside];
    }
    return _HUDView;
}
- (CommentBottomView *)inputBottomView
{
    if (!_inputBottomView) {
        _inputBottomView = [[CommentBottomView alloc] init];
        _inputBottomView.delegate = self;
    }
    return _inputBottomView;
}

- (NetworkTool *)tools
{
    if (!_tools) {
        _tools = [[NetworkTool alloc] init];
    }
    return _tools;
}

- (UILabel *)tipLabel
{
    if (!_tipLabel) {
        _tipLabel = [UILabel new];
        _tipLabel.textColor = [UIColor lightGrayColor];
        _tipLabel.font = [UIFont systemFontOfSize:14];
        _tipLabel.text = @"尚未发表任何评论";
    }
    return  _tipLabel;
}

- (NSMutableArray<Comment *> *)comments
{
    if (!_comments) {
        _comments = [NSMutableArray array];
    }
    return _comments;
}

//- (void)setComments:(NSMutableArray<Comment *> *)comments
//{
//    _comments = comments;
//    [self.tipLabel removeFromSuperview];
//    
//    
//}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setup];
    [self setRefresh];
    
}

//基本配置
- (void)setup
{
    
    
    self.currentPage = 0;
    
    //左按钮
    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStyleDone target:self action:@selector(back)];
    self.navigationItem.leftBarButtonItem = leftBtn;
    
//    self.navigationItem.title = @"评论";
    [self customTitle:@"评论"];
    [self.tableView registerClass:[CommentViewCell class] forCellReuseIdentifier:CommentCellReuseIdentifier];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.rowHeight = 200;
    
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 44, 0);
    //添加评论视图
    [KeyWindow addSubview:self.inputBottomView];
    
    [self.inputBottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(KeyWindow);
        make.height.equalTo(@44);
    }];
}
- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

//设置刷新控件
- (void)setRefresh
{
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(getNewData)];
    [self.tableView.mj_header beginRefreshing];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(getMoreData)];
    self.tableView.mj_footer.hidden = YES;
}


- (void)getNewData
{
    self.currentPage = 0;
    [self.comments removeAllObjects];
    
    [self.tools getCommentListDataWithBbsID:self.bbsID CurrentPage:0 block:^(id json, NSError *error, BOOL isNotComment) {

        [self.tableView.mj_header endRefreshing];
        if ([error isKindOfClass:[NSNull class]]) {
            [[Tostal sharTostal] tostalMesg:@"网络异常" tostalTime:1];
        }else
        {
            if (isNotComment) {//如果没有数据
                [self.view addSubview:self.tipLabel];
                [self.tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(@60);
                    make.centerX.equalTo(self.view);
                }];

            }else
            {
                [self.tipLabel removeFromSuperview];
                [self.comments addObjectsFromArray:json];

                self.currentPage +=1;
                [self.tableView reloadData];
                self.tableView.mj_footer.hidden = NO;
                [self.tableView.mj_footer endRefreshing];
            }
        }
    }];
}


- (void)getMoreData
{
    [self.tools getCommentListDataWithBbsID:self.bbsID CurrentPage:self.currentPage block:^(id json, NSError *error, BOOL isNotComment) {

        [self.tableView.mj_footer endRefreshing];
        
        if ([error isKindOfClass:[NSNull class]]) {
            [[Tostal sharTostal] tostalMesg:@"网络异常" tostalTime:1];
            self.currentPage -=1;
        }else
        {
            if (isNotComment) {//如果没有数据
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
            }else
            {
                [self.tipLabel removeFromSuperview];
                [self.comments addObjectsFromArray:json];
                self.currentPage +=1;
                [self.tableView reloadData];
            }
        }
    }];
}




#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.comments.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CommentViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CommentCellReuseIdentifier forIndexPath:indexPath];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (self.comments.count) {
        cell.comment = self.comments[indexPath.row];
    }
  
    cell.delegate = self;
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.comments[indexPath.row].rowHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [self replyWithComment:self.comments[indexPath.row]];
}

#pragma mark - CommentViewCellDelegate

- (void)commentViewCell:(CommentViewCell *)commentViewCell didClickBtn:(CommentBtnType)type ReplyComment:(Comment *)comment
{
    if (type == More) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction *cancelAction1 = [UIAlertAction actionWithTitle:@"举报" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            [[Tostal sharTostal] tostalMesg:@"举报成功" tostalTime:1];
        }];
        UIAlertAction *cancelAction2 = [UIAlertAction actionWithTitle:@"拉黑" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            [[Tostal sharTostal] tostalMesg:@"拉黑成功" tostalTime:1];
        }];
        UIAlertAction *cancelAction3 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [[Tostal sharTostal] tostalMesg:@"保存失败" tostalTime:1];
        }];
        [alertController addAction:cancelAction1];
        [alertController addAction:cancelAction2];
        [alertController addAction:cancelAction3];
        [self presentViewController:alertController animated:YES completion:nil];
    }else if (type == Reply)
    {
        [self replyWithComment:comment];
    }
}


//#warning 这是点击cell是调用的  还有直接点击输入框调用的   不传入comment

- (void)replyWithComment:(Comment *)comment
{
    //点击回复
    self.inputBottomView.placeHolderStr = comment.anonymous ? @"匿名用户" : comment.writer.userName;
    self.inputBottomView.comment = comment;
}

- (void)clickHideBottomView
{
    LXLog(@"adasd");
    [self.inputBottomView endEditing:YES];
//    self.HUDView = nil;
    [self.HUDView removeFromSuperview];
}

#pragma mark - CommentBottomViewDelegate

- (void)commentBottomView:(CommentBottomView *)commentBottomView sendMessage:(NSString *)message replyComment:(Comment *)comment
{
    //发送消息，删除蒙版
    [self clickHideBottomView];
    
    // 模拟数据    正常情况下需要先审核，才显示
    Comment *newComment = [[Comment alloc] init];
    newComment.content = message;
    
    newComment.writer.ID = @"a1e67080-dd5a-4aea-abae-95712211e69a";
    newComment.writer.userName = @"xiao公子";
    newComment.writer.headImg = @"http://static.htxq.net/UploadFiles/headimg/20160422164405309.jpg";
    
    if (comment) {//如果comment有值，说明是回复
        newComment.toUser.userName = comment.writer.userName;
        newComment.toUser.ID = @"a1e67080-dd5a-4aea-abae-95712211e69a";
        [self.comments addObject:newComment];
        [[Tostal sharTostal] tostalMesg:@"回复成功" tostalTime:1];
    }else
    {
        newComment.toUser.userName = @"";
        newComment.toUser.ID = @"";
        [self.comments addObject:newComment];
        [[Tostal sharTostal] tostalMesg:@"评论成功" tostalTime:1];
    }
    
    
    
    //滑动到评论页
    Weak(self)
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //刷新
        [self.tableView reloadData];
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.comments.count - 1 inSection:0];
        [wArg.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionNone animated:YES];
        
    });
}

- (void)commentBottomView:(CommentBottomView *)commentBottomView keyboradFrameChange:(NSDictionary *)userInfo
{

    //拿到当前键盘尺寸
    CGRect rect = [userInfo[@"UIKeyboardFrameEndUserInfoKey"] CGRectValue];
    CGFloat y = rect.origin.y-MY_HEIGHT;
    
    [self.inputBottomView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(@(y));
    }];
    
//    [UIView animateWithDuration:0.25 animations:^{
//        [KeyWindow layoutIfNeeded];
//    }];
    
    //当弹出键盘时，添加蒙版
    if (y < MY_HEIGHT) {
        [KeyWindow insertSubview:self.HUDView belowSubview:self.inputBottomView];
        
        [self.HUDView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@64);
            make.left.right.bottom.equalTo(KeyWindow);
        }];
    }
    
    

}

//在这里判断  当键盘落下时  删除蒙版

-(void)commentBottomView:(CommentBottomView *)commentBottomView keyboardWillHide:(NSDictionary *)userInfo
{
    self.inputBottomView.textFiled.placeholder = @" 评论";
    self.inputBottomView.comment = nil;
    [UIView animateWithDuration:0.25 animations:^{
        self.HUDView.backgroundColor = [UIColor clearColor];
        
    } completion:^(BOOL finished) {
        //需要把置为nil
        self.HUDView = nil;
        [self.HUDView removeFromSuperview];
    }];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self clickHideBottomView];
    [self.inputBottomView removeFromSuperview];
}


@end
