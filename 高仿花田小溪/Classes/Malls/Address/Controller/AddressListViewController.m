//
//  AddressListViewController.m
//  高仿花田小溪
//
//  Created by 祥云创想 on 16/7/19.
//  Copyright © 2016年 Lee. All rights reserved.
//

#import "AddressListViewController.h"
#import "AddressViewCell.h"
#import "NetworkTool.h"
static NSString *AddressCellReuseIdentifier = @"AddressCellReuseIdentifier";

@interface AddressListViewController ()


@property(nonatomic, strong)NSMutableArray *addresses;
Button_(addAddressBtn)// 新增地址按钮
DIYObj_(Address, selectedAddress)// 正在操作的地址
DIYObj_(NetworkTool, tools)
@end

@implementation AddressListViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setup];
    [self getAddressList];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [KeyWindow addSubview:self.addAddressBtn];
    [self.addAddressBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(KeyWindow);
        make.bottom.equalTo(@(-15));
    }];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.addAddressBtn removeFromSuperview];
}

- (void)setup
{
    [self customTitle:@"收货地址"];
    //左按钮
    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStyleDone target:self action:@selector(back)];
    self.navigationItem.leftBarButtonItem = leftBtn;
    
    //注册
    [self.tableView registerClass:[AddressViewCell class] forCellReuseIdentifier:AddressCellReuseIdentifier];
    self.tableView.tableFooterView = [UIView new];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 50, 0);
}

- (void)getAddressList
{
    [self.tools getAddressListData:^(id json, NSError *error) {
        if (error == nil) {
            if ([json isKindOfClass:[NSArray class]]) {
                self.addresses = json;
                [self.tableView reloadData];
            }
            
        }else
        {
            [[Tostal sharTostal] tostalMesg:@"网络异常" tostalTime:1];
        }
    }];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.addresses.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    Address *address = self.addresses.count > 0 ?self.addresses[indexPath.row]:nil;
    return self.addresses.count > 0 ? address.cellHeight : 83;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AddressViewCell *cell = [tableView dequeueReusableCellWithIdentifier:AddressCellReuseIdentifier];
    if (self.addresses.count) {
        Address *address = self.addresses[indexPath.row];
        cell.iAddress = address;
        cell.selectedAddress = [self.selectedID isEqualToString:address.fnId];
    }
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    //第一行不能编辑
    if (indexPath.row == self.addresses.count-1) {
        return NO;
    }
    return YES;
}

- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Address *address = self.addresses[indexPath.row];
    self.selectedAddress = address;
    
    UITableViewRowAction *delete = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        
    }];
    delete.backgroundColor = [UIColor redColor];
    
    UITableViewRowAction *update = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"修改" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        
    }];
    update.backgroundColor = [UIColor blueColor];
    
    UITableViewRowAction *setDefault = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"设置成默认" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        
    }];
    setDefault.backgroundColor = [UIColor greenColor];
    
    return @[delete,update,setDefault];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.isAddInvoiceAddress) {
        [[NSNotificationCenter defaultCenter] postNotificationName:InvoiceAddressChangeNotifyKey object:nil userInfo:@{AddressChangeNotifyKey : self.addresses[indexPath.row]}];
        [self.navigationController popViewControllerAnimated:YES];
    }else
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:AddressChangeNotify object:nil userInfo:@{AddressChangeNotifyKey : self.addresses[indexPath.row]}];
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}
#pragma mark - self
- (void)clickAdd
{
    
}
- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark -  set  get
- (NSMutableArray *)addresses
{
    if (!_addresses) {
        _addresses = [NSMutableArray array];
    }
    return _addresses;
}
- (UIButton *)addAddressBtn
{
    if (!_addAddressBtn) {
        _addAddressBtn = [UIButton title:nil imageName:@"f_addAdress_278x35" target:self selector:@selector(clickAdd) font:nil titleColor:nil];
    }
    return _addAddressBtn;
}
- (NetworkTool *)tools
{
    if (!_tools) {
        _tools = [[NetworkTool alloc] init];
    }
    return _tools;
}
@end
