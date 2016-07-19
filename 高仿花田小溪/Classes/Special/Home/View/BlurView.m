//
//  BlurView.m
//  高仿花田小憩OC版  github :https://github.com/leeSmile/xiaoqi
//
//  Created by 祥云创想 on 16/6/24.
//  Copyright © 2016年 Lee. All rights reserved.
//

#import "BlurView.h"
#import "MallsCategoryHeader.h"
#import "MallsCategory.h"

static NSString *CategoryCellReuseIdentifier = @"CategoryCellReuseIdentifier";
@interface BlurView()<MallsCategoryHeaderDelegate>

 // 里面放置的都是MallsCategoryHeader, 保存了是否显示, 是否关闭
@property(nonatomic, strong) NSMutableArray<MallsCategoryHeader *> *selectedArray;
/// 底部的Logo
ImageView_(bottomView)
/// 底部的分割线
ImageView_(underLine)
@end


@implementation BlurView

- (instancetype)initWithEffect:(UIVisualEffect *)effect
{
    if (self == [super initWithEffect:effect]) {
        [self setupUI];
    }
    return self;
}

//设置UI
- (void)setupUI
{
    [self addSubview:self.tableView];
    [self addSubview:self.bottomView];
    [self addSubview:self.underLine];
    
    self.isMalls = NO;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(@20);
        make.bottom.equalTo(self.underLine.mas_top);
    }];
    
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.bottom.equalTo(self).offset(-10);
        make.height.equalTo(@27);
    }];
    
    [self.underLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self).offset(0);
        make.bottom.equalTo(self.bottomView.mas_top).offset(-10);
    }];
    
}

- (NSMutableArray<MallsCategoryHeader *> *)selectedArray
{
    if (!_selectedArray) {
        _selectedArray = [NSMutableArray array];
    }
    return _selectedArray;
}


- (void)setCategories:(NSMutableArray *)categories
{
    _categories = categories;
    [self.tableView reloadData];
}

- (void)setIsMalls:(BOOL)isMalls
{
    _isMalls = isMalls;
    if (!isMalls) {
        self.tableView.rowHeight = 70;
    }
}





#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    //商城
    if (self.isMalls) {
        return self.categories.count;
    }
    //非商城
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if (self.isMalls) {
        // 如果是商城, 返回子序列的个数
        
        if (self.selectedArray.count > 0) {
            for (int i = 0; i<self.selectedArray.count; i++) {
                if (i == section) {
                    MallsCategoryHeader *header = self.selectedArray[section];
                    if (header.isShow) {
                        //返回模型中的数据
                       MallsCategory *category = self.categories[section];
                        return category.childrenList.count;
                    }else
                    {
                        
                    }
                }
            }
        }
        return 0;
    }
    //非商城
    return self.categories.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
     UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CategoryCellReuseIdentifier forIndexPath:indexPath];
     cell.backgroundColor = [UIColor clearColor];
     cell.selectionStyle = UITableViewCellSelectionStyleNone;
     cell.textLabel.textAlignment = NSTextAlignmentCenter;
     cell.textLabel.font = [UIFont fontWithName:@"CODE LIGHT" size:14];
     
     if (self.categories.count) {
         if (self.isMalls) {// 如果是商城, 则需要显示子序列
             MallsCategory *category = self.categories[indexPath.section];
             cell.textLabel.text = category.childrenList[indexPath.row].fnName;
         }else
         {
             Categorys *category = self.categories[indexPath.row];
             cell.textLabel.text = category.name;
         }
     }

     
     return cell;
 }


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (self.isMalls) {
        return 80;
    }
    return 0;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (self.isMalls) {
        MallsCategoryHeader *header = nil;
        if (self.selectedArray.count) {
            for (int i = 0; i<self.selectedArray.count-1; i++) {
                if (i == section) {
                    header = self.selectedArray[i];
                }
            }
        }
        if (header == nil) {
            header = [[MallsCategoryHeader alloc] initWithFrame:CGRectMake(0, 0, MY_WIHTE, 44)];
            header.delegate = self;
            MallsCategory * category = self.categories[section];
            header.title = category.fnName;
            header.tag = section;
            header.isShow = NO;
            [self.selectedArray addObject:header];
        }
        return header;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.isMalls) {
        if ([self.delegate respondsToSelector:@selector(blurView: didSelectCategory:)]) {
            MallsCategory *category = self.categories[indexPath.section];
            [self.delegate blurView:self didSelectCategory:category.childrenList[indexPath.row]];
        }
    }else
    {
        if ([self.delegate respondsToSelector:@selector(blurView: didSelectCategory:)]) {
            [self.delegate blurView:self didSelectCategory:self.categories[indexPath.row]];
        }
    }

}
#pragma mark - MallsCategoryHeaderdelegate
- (void)mallsCategoryHeaderchick:(MallsCategoryHeader *)header
{
    MallsCategoryHeader *tempHeader = self.selectedArray[header.tag];
    tempHeader.isShow = !tempHeader.isShow;
    [self.tableView reloadData];
}
#pragma mark - set get
- (UIImageView *)bottomView
{
    if (!_bottomView) {
        _bottomView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"l_regist"]];
    }
    return _bottomView;
}

- (UIImageView *)underLine
{
    if (!_underLine) {
        _underLine = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"underLine"]];
    }
    return _underLine;
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.backgroundColor = [UIColor clearColor];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CategoryCellReuseIdentifier];
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}
@end
