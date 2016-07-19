//
//  CountryTableViewController.m
//  高仿花田小憩OC版
//
//  Created by Lee on 16/7/15.
//  Copyright © 2016年 Lee. All rights reserved.
//

#import "CountryTableViewController.h"
#import "CountryCell.h"
#import "countryHeadView.h"
static NSString *CountryCellIdentifier = @"CountryCellIdentifier";
static NSString *ChangeCountyNotifyName = @"ChangeCountyNotifyName";
@interface CountryTableViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic, strong)NSMutableArray *keys;
@property(nonatomic, strong)NSMutableArray *countries;
@property(nonatomic, strong)NSMutableArray *countryID;
TableView_(tableView)
DIYObj_(countryHeadView, countryHeadView)
@end

@implementation CountryTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
    [self getList];
}
- (void)setup
{

    [self customTitle:@"选择国家和地区"];
    self.view.backgroundColor = [UIColor whiteColor];
    //设置导航条
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStyleDone target:self action:@selector(back)];
    
    [self.view addSubview:self.countryHeadView];
    [self.view addSubview:self.tableView];
    
    [self.countryHeadView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(@64);
        make.height.equalTo(@44);
    }];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(self.view);
        make.top.equalTo(self.countryHeadView.mas_bottom);
    }];

    
}

- (void)getList
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"country.plist" ofType:nil];
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithContentsOfFile:path];
    
    //索引排序
    self.keys = (NSMutableArray *)[[dic allKeys] sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [obj1 compare:obj2 options:NSNumericSearch];
    }];
    for (NSString *key in self.keys) {
        //装着名字
        NSMutableArray *valuesArr = dic[key];
        
        NSMutableArray *nameArr = [NSMutableArray array];
        NSMutableArray *IDArr = [NSMutableArray array];
        for (NSString *allCountry in valuesArr) {
            NSArray *arr = [allCountry componentsSeparatedByString:@"+"];
            //名字
            [nameArr addObject: arr[0]];
            //id
            [IDArr addObject:[NSString stringWithFormat:@"+%@",arr.lastObject]];
        }
        [self.countries addObject:nameArr];
        [self.countryID addObject:IDArr];
        
    }
    [self.tableView reloadData];
//    LXLog(@"adasd");
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return self.keys.count?self.keys[section]:nil;
}
- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return self.keys;
}
- (void)back
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.keys.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if (self.countries.count) {
        NSArray *arr = self.countries[section];
        return arr.count;
    }
    return 0;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CountryCell *cell = [tableView dequeueReusableCellWithIdentifier:CountryCellIdentifier];
    NSArray *onecountries = self.countries[indexPath.section];
    NSArray *onecountryID = self.countryID[indexPath.section];
    if (onecountries.count) {
        cell.countryNameLabel.text = onecountries[indexPath.row];
    }
    if (onecountryID.count) {
        cell.countryIDLabel.text = onecountryID[indexPath.row];
    }

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *onecountries = self.countries[indexPath.section];
    NSArray *onecountryID = self.countryID[indexPath.section];
    NSString *countryNameLabel = onecountries[indexPath.row];
    NSString *countryIDLable = onecountryID[indexPath.row];
    NSString *allCountryStr = [NSString stringWithFormat:@"%@/%@",countryNameLabel,countryIDLable];
    
    //通知
    [[NSNotificationCenter defaultCenter] postNotificationName:ChangeCountyNotifyName object:nil userInfo:@{@"country":allCountryStr}];
    [self back];
}
#pragma mark - set
- (NSMutableArray *)keys
{
    if (!_keys) {
        _keys = [NSMutableArray array];
    }
    return _keys;
}
- (countryHeadView *)countryHeadView
{
    if (!_countryHeadView) {
        _countryHeadView = [[countryHeadView alloc] init];
        _countryHeadView.lx_height = 44;
    }
    return _countryHeadView;
}

- (NSMutableArray *)countries
{
    if (!_countries) {
        _countries = [NSMutableArray array];
    }
    return _countries;
}
- (NSMutableArray *)countryID
{
    if (!_countryID) {
        _countryID = [NSMutableArray array];
    }
    return _countryID;
}
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.dataSource = self;
        _tableView.sectionIndexColor = [UIColor lightGrayColor];
        _tableView.sectionIndexBackgroundColor = [UIColor clearColor];
        _tableView.delegate = self;
        _tableView.backgroundColor = [UIColor whiteColor];
        [_tableView registerClass:[CountryCell class] forCellReuseIdentifier:CountryCellIdentifier];
    
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

@end
