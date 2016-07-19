//
//  SettingViewController.m
//  高仿花田小憩OC版  github :https://github.com/leeSmile/xiaoqi
//
//  Created by 祥云创想 on 16/7/12.
//  Copyright © 2016年 Lee. All rights reserved.
//

#import "SettingViewController.h"
#import "ProtocolViewController.h"


#define  LXSDWebImageCachePath [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject stringByAppendingPathComponent:@"default"]

#define LXCustomCachePath [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject stringByAppendingPathComponent:@"MyCache"]
static NSString *LoginoutNotify = @"LoginoutNotify";

@interface SettingViewController ()<UITableViewDelegate,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *cacheLabel;

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setup];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self computeSize];
}
- (void)setup
{
    self.tableView.contentInset = UIEdgeInsetsMake(-20, 0, 0, 0);

    //左按钮
    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStyleDone target:self action:@selector(back)];
    self.navigationItem.leftBarButtonItem = leftBtn;
    
}

- (void)computeSize
{
    //计算所有文件的大小，并且显示出来

    //开启一个子线程
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        //获得所有文件的缓存总大小
        unsigned long long fileSize = LXSDWebImageCachePath.lx_fileSize + LXCustomCachePath.lx_fileSize;
        
        //根据缓存大小生成字符串
        NSString *fileSizeText = nil;
        // pow(10, 9) == 10的9次方
        if (fileSize >= pow(10, 9)) { // fileSize >= 1GB
            fileSizeText = [NSString stringWithFormat:@"%.1fGB", fileSize / pow(10, 9)];
        } else if (fileSize >= pow(10, 6)) { // fileSize >= 1MB
            fileSizeText = [NSString stringWithFormat:@"%.1fMB", fileSize / pow(10, 6)];
        } else if (fileSize >= pow(10, 3)) { // fileSize >= 1KB
            fileSizeText = [NSString stringWithFormat:@"%.1fKB", fileSize / pow(10, 3)];
        } else { // fileSize < 1KB
            fileSizeText = [NSString stringWithFormat:@"%zdB", fileSize];
        }
        //回到主线程设置文字(更新UI)
        NSString *text = [NSString stringWithFormat:@"清除缓存(%@)",fileSizeText];
        dispatch_async(dispatch_get_main_queue(), ^{
            
            //显示文字
            self.cacheLabel.text = text;
            
        });
    });

}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LXLog(@"点击");
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];

    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
                [[Tostal sharTostal] tostalMesg:@"0" tostalTime:1];
                break;
            case 1:
                [[Tostal sharTostal] tostalMesg:@"1" tostalTime:1];
                break;
            case 2:
                [[Tostal sharTostal] tostalMesg:@"2" tostalTime:1];
                break;
            case 3:
                [self gotoHtml5WithUrl:@"http://m.htxq.net/servlet/SysContentServlet?action=getDetail&id=309356e8-6bde-40f4-98aa-6d745e804b1f" title:@"积分规则"];
                break;
            case 4:
                [self gotoHtml5WithUrl:@"http://m.htxq.net/servlet/SysContentServlet?action=getDetail&id=48d4eac5-18e6-4d48-8695-1a42993e082e" title:@"认证规则"];
                break;
                
            default:
                break;
        }
    }else if (indexPath.section == 1)
    {
        switch (indexPath.row) {
            case 0:
                [self gotoHtml5WithUrl:@"http://m.htxq.net/servlet/SysContentServlet?action=getDetail&id=0001c687-9393-4ad3-a6ad-5b81391c5253" title:@"关于我们"];
                break;
            case 1:
                [self gotoHtml5WithUrl:@"http://m.htxq.net/servlet/SysContentServlet?action=getDetail&id=e30840e6-ef01-4e97-b612-8b930bdfd8bd" title:@"商业合作"];
                break;
            case 2:
                [[Tostal sharTostal] tostalMesg:@"意见反馈" tostalTime:1];
                break;
            case 3:
                [self toAppStore];
                break;
            default:
            break;
        }
        
    }else if (indexPath.section == 2)
    {
        if (indexPath.row == 0) {
            [self clearCache];
        }
    }
}
// MARK: - private method
- (void)toAppStore
{
    [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewSoftware?id=998252000"]];
}
- (void)gotoHtml5WithUrl:(NSString *)url title:(NSString *)title
{
    ProtocolViewController *vc = [[ProtocolViewController alloc] init];
    [vc customTitle:title];
    vc.HTM5Url = url;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)clearCache
{

    //在子线程中删除
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        //创建文件管理者
        NSFileManager *mgr = [NSFileManager defaultManager];
        //删除文件夹
        [mgr removeItemAtPath:LXCustomCachePath error:nil];
        [mgr removeItemAtPath:LXSDWebImageCachePath error:nil];
        //创建一个文件夹
        [mgr createDirectoryAtPath:LXCustomCachePath withIntermediateDirectories:YES attributes:nil error:nil];
        
        //然后回到主线程
        dispatch_async(dispatch_get_main_queue(), ^{
            //隐藏唐匡

            [[Tostal sharTostal] tostalMesg:@"清除成功!" tostalTime:2];
            //显示文字
            self.cacheLabel.text
            = @"清除缓存(0B)";
        });
    });

}
- (IBAction)logout:(UIButton *)sender {
    [[Tostal sharTostal] tostalMesg:@"退出登录" tostalTime:1];
    
    [LXFileManager saveObject:@"0" byFileName:LoginStatus];
    [[NSNotificationCenter defaultCenter] postNotificationName:LoginoutNotify object:nil];
    [self.navigationController popToRootViewControllerAnimated:YES];
}
- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
