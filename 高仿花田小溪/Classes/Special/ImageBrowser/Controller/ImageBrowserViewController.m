//
//  ImageBrowserViewController.m
//  高仿花田小憩OC版  github :https://github.com/leeSmile/xiaoqi
//
//  Created by Lee on 16/6/28.
//  Copyright © 2016年 Lee. All rights reserved.
//

#import "ImageBrowserViewController.h"
#import "ImageBrowserViewCell.h"

static NSString *ImageBrowserCellReuseIdentifier = @"ImageBrowserCellReuseIdentifier";
@interface ImageBrowserViewController ()<ImageBrowserViewCellDelegate,UIActionSheetDelegate>

Label_(titleLabel)
@property(nonatomic, strong)UICollectionViewFlowLayout *PhotoBrowserLayout;
@end

@implementation ImageBrowserViewController

//懒加载
- (NSArray *)imageUrls
{
    if (!_imageUrls) {
        _imageUrls = [NSArray array];
    }
    return _imageUrls;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.font = [UIFont systemFontOfSize:22];
    }
    return _titleLabel;
}
- (UICollectionViewFlowLayout *)PhotoBrowserLayout
{
    if (!_PhotoBrowserLayout) {
        _PhotoBrowserLayout = [[UICollectionViewFlowLayout alloc] init];
        // 1.设置layout
        _PhotoBrowserLayout.itemSize = [UIScreen mainScreen].bounds.size;
        _PhotoBrowserLayout.minimumInteritemSpacing = 0;
        _PhotoBrowserLayout.minimumLineSpacing = 0;
        _PhotoBrowserLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    }
    return _PhotoBrowserLayout;
}
- (instancetype)init
{
    return [super initWithCollectionViewLayout:self.PhotoBrowserLayout];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 2.设置collectionView

    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.pagingEnabled = YES;
    self.collectionView.bounces = NO;
    

    //注册
    [self.collectionView registerClass:[ImageBrowserViewCell class] forCellWithReuseIdentifier:ImageBrowserCellReuseIdentifier];
    
    [KeyWindow addSubview:self.titleLabel];
    //约束
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@30);
        make.centerX.equalTo(KeyWindow);
    }];
    
    self.titleLabel.text = [NSString stringWithFormat:@"%zd/%zd",self.indexPath.item+1,self.imageUrls.count];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.collectionView scrollToItemAtIndexPath:self.indexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.titleLabel removeFromSuperview];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.imageUrls.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ImageBrowserViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ImageBrowserCellReuseIdentifier forIndexPath:indexPath];

    cell.imageURL = self.imageUrls[indexPath.item];
    cell.delegate = self;
    return cell;
}

#pragma mark <PhotoBrowserViewCellDelegate>
- (void)ImageBrowserViewCellDidClickImage:(ImageBrowserViewCell *)cell
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
//{
//    [self dismissViewControllerAnimated:YES completion:nil];
//}

- (void)ImageBrowserViewCellDidLongClickImage:(ImageBrowserViewCell *)cell
{    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"保存图片" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
     UIAlertAction *cancelAction1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
         [self saveImage];
     }];
    UIAlertAction *cancelAction2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
     [alertController addAction:cancelAction1];
     [alertController addAction:cancelAction2];
     [self presentViewController:alertController animated:YES completion:nil];
}

- (void)saveImage
{
    //获得当前正在展示的位置
    NSIndexPath *indexPath = self.collectionView.indexPathsForVisibleItems.lastObject;
    ImageBrowserViewCell *cell = (ImageBrowserViewCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
    
    UIImageWriteToSavedPhotosAlbum(cell.iconView.image, self,  @selector(image:didFinishSavingWithError:contextInfo:), nil);
}

//保存后
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (error) {
        [[Tostal sharTostal] tostalMesg:@"保存失败" tostalTime:1];

    } else {

        [[Tostal sharTostal] tostalMesg:@"保存成功" tostalTime:1];
    }
}
@end
