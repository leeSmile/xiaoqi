//
//  OrderViewController.m
//  高仿花田小溪
//
//  Created by 祥云创想 on 16/7/18.
//  Copyright © 2016年 Lee. All rights reserved.
//

#import "OrderViewController.h"
#import "OlderViewCell.h"
#import "TakeAddressViewCell.h"
#import "TotalInfoViewCell.h"
#import "OlderMessageViewCell.h"
#import "DistributionViewCell.h"
#import "NetworkTool.h"
#import "OlderBottomView.h"
#import "PayView.h"
#import "AddressListViewController.h"
// 最顶部的订单详情重用标识符
static NSString *OrderCellReuseIdentifier = @"OrderCellReuseIdentifier";
// 收货地址重用标识符
static NSString *AddressCellReuseIdentifier = @"AddressCellReuseIdentifier";
// 留言信息重用标识符
static NSString *MessageCellReuseIdentifier = @"MessageCellReuseIdentifier";
// 配送信息重用标识符
static NSString *DistributionCellReuseIdentifier = @"DistributionCellReuseIdentifier";
// 总价信息重用标识符
static NSString *InfoCellReuseIdentifier = @"InfoCellReuseIdentifier";

@interface OrderViewController ()<OlderBottomViewDelegate,DistributionViewCellDelegate>
DIYObj_(NetworkTool, tools)

DIYObj_(OlderBottomView, bottomView)

BOOL_(isNeedInvoice)//是否需要发票

DIYObj_(PayView, PayView)
@end

@implementation OrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
    [self getOlderInfo];
}

-(void)setup
{
    [self customTitle:@"确认订单"];
    self.isNeedInvoice = NO;
    self.view.backgroundColor = Color(241);
    self.tableView.tableFooterView = [UIView new];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    //左按钮
    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStyleDone target:self action:@selector(back)];
    self.navigationItem.leftBarButtonItem = leftBtn;
    
    //注册
    [self.tableView registerClass:[OlderViewCell class] forCellReuseIdentifier:OrderCellReuseIdentifier];
    [self.tableView registerClass:[TakeAddressViewCell class] forCellReuseIdentifier:AddressCellReuseIdentifier];
    [self.tableView registerClass:[OlderMessageViewCell class] forCellReuseIdentifier:MessageCellReuseIdentifier];
    [self.tableView registerClass:[DistributionViewCell class] forCellReuseIdentifier:DistributionCellReuseIdentifier];
    [self.tableView registerClass:[TotalInfoViewCell class] forCellReuseIdentifier:InfoCellReuseIdentifier];
    
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 44, 0);
    
    //通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(buyNumChange:) name:BuyNumNotifyName object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addressChange:) name:AddressChangeNotify object:nil];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [KeyWindow addSubview:self.bottomView];
    
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(KeyWindow);
        make.height.equalTo(@44);
    }];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.bottomView removeFromSuperview];
}
- (void)getOlderInfo
{
    [self.tools getOlderDataWithGoodsId:self.olderID block:^(id json, NSError *error) {
        if (error == nil) {
            self.goods = json;
        }
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
            return 90;
            break;
        case 1:
            return self.goods.uAddress?75:45;
            break;
        case 2:
            return 150;
            break;
        case 3:
            return self.isNeedInvoice?220:90;
            break;
        case 4:
            return 100;
            break;
    }
    return 40;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        OlderViewCell *cell = [tableView dequeueReusableCellWithIdentifier:OrderCellReuseIdentifier];
        cell.goods = self.goods;
        return cell;
    }else if (indexPath.section == 1)
    {
        TakeAddressViewCell *cell = [tableView dequeueReusableCellWithIdentifier:AddressCellReuseIdentifier];
        
        cell.isNoAddress = self.goods.uAddress?YES:NO;
        
        if (self.goods.uAddress) {
            cell.iAddress = self.goods.uAddress;
        }
        return cell;
        
    }else if (indexPath.section == 2)
    {
        OlderMessageViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MessageCellReuseIdentifier];

        cell.buyNum = self.buyNum;
        return cell;
        
    }else if (indexPath.section == 3)
    {
        DistributionViewCell *cell = [tableView dequeueReusableCellWithIdentifier:DistributionCellReuseIdentifier];
        cell.isNeedInvoice = self.isNeedInvoice;
#warning 更新高度后出现两种不同的cell   两种cell中按钮选中状态错乱
        cell.delegate = self;
        return cell;
    }
    TotalInfoViewCell *cell = [tableView dequeueReusableCellWithIdentifier:InfoCellReuseIdentifier];
    cell.goods = self.goods;
    
    if (self.buyNum) {
        cell.num = self.buyNum;
    }else//如果用户没有加入购物车 点击购买  默认购买数量为1
    {
        cell.num = 1;
    }
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 8;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [UIView new];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        LXLog(@"点击地址");
        AddressListViewController *vc = [[AddressListViewController alloc] init];
        vc.selectedID = self.goods.uAddress.fnId;
        [self.navigationController pushViewController:vc animated:YES];
    }
}
#pragma mark - OlderBottomViewDelegate
- (void)OlderBottomViewEntryToBuyTotalPrice:(NSString *)totalPrice
{
    if (self.goods.uAddress == nil) {
        [[Tostal sharTostal] tostalMesg:@"请选择收货地址" tostalTime:1];
    }else
    {
        LXLog(@"购买");
        [KeyWindow addSubview:self.PayView];
        self.PayView.totalPrice = totalPrice;
        self.PayView.frame = KeyWindow.bounds;
        [self.PayView startAnim];
    }
}
#pragma mark - DistributionViewCellDelegate
- (void)DistributionViewCell:(DistributionViewCell *)MallsHeaderCell didClickBtn:(OtherType)type need:(BOOL)need
{
    if (type == invoice) {
        self.isNeedInvoice = need;
        [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:3]] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}
//添加发票地址
- (void)DistributionViewCellAddAddress
{
    AddressListViewController *vc = [[AddressListViewController alloc] init];
    vc.selectedID = self.goods.uAddress.fnId;
    vc.isAddInvoiceAddress = YES;
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark - self

- (void)buyNumChange:(NSNotification *)notify
{
    self.buyNum = [notify.userInfo[BuyNumKey] intValue];
}

- (void)addressChange:(NSNotification *)notify
{
    Address *address = notify.userInfo[AddressChangeNotifyKey];
    self.goods.uAddress = address;
    [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:1]] withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - set
- (NetworkTool *)tools
{
    if (!_tools) {
        _tools = [[NetworkTool alloc] init];
    }
    return _tools;
}

- (PayView *)PayView
{
    if (!_PayView) {
        _PayView = [[PayView alloc] init];
    }
    return _PayView;
}

- (OlderBottomView *)bottomView
{
    if (!_bottomView) {
        _bottomView = [[OlderBottomView alloc] init];
        _bottomView.delegate = self;
    }
    return _bottomView;
}

- (void)setGoods:(Goods *)goods
{
    _goods = goods;
    [self.tableView reloadData];
}

- (void)setBuyNum:(int)buyNum
{
    _buyNum = buyNum;
    
    if (buyNum == 0) {
        self.bottomView.totalPrice = [NSString stringWithFormat:@"%zd",self.goods.fnMarketPrice];
    }else
    {
        self.bottomView.totalPrice = [NSString stringWithFormat:@"%zd",self.goods.fnMarketPrice * buyNum];
    }
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:4] withRowAnimation:UITableViewRowAnimationNone];
    
}
@end
