//
//  LYFMainViewController.m
//  3DTouchPreview
//
//  Created by 李玉枫 on 2018/8/8.
//  Copyright © 2018年 李玉枫. All rights reserved.
//

#import "LYFMainViewController.h"
#import "LYFSubViewController.h"

@interface LYFMainViewController () <UITableViewDataSource, UITableViewDelegate, UIViewControllerPreviewingDelegate>

/// 列表
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation LYFMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"这是第%li行", indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (self.traitCollection.forceTouchCapability == UIForceTouchCapabilityAvailable) {// 3DTouch可用
        // 注册协议
        [self registerForPreviewingWithDelegate:self sourceView:cell];
    } else{
        NSLog(@"3DTouch不可用");
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    LYFSubViewController *viewController = [[LYFSubViewController alloc] init];
    viewController.text = [NSString stringWithFormat:@"这是第%li行", indexPath.row];
    
    [self showViewController:viewController sender:self];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80.f;
}

#pragma mark - UIViewControllerPreviewingDelegate
-(UIViewController *)previewingContext:(id<UIViewControllerPreviewing>)previewingContext viewControllerForLocation:(CGPoint)location {
    NSIndexPath *indexPath = [self.tableView indexPathForCell:(UITableViewCell *)[previewingContext sourceView]];
    
    /// 需要创建的控制器
    LYFSubViewController *viewController = [[LYFSubViewController alloc] init];
    viewController.text = [NSString stringWithFormat:@"这是第%li行", indexPath.row];
    
    /// 没有毛玻璃的大小(80.f就是每一个cell的高度，大家可以改变高度来看看效果)
    CGRect rect = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 80.f);
    previewingContext.sourceRect = rect;
    
    return viewController;
}

-(void)previewingContext:(id<UIViewControllerPreviewing>)previewingContext commitViewController:(UIViewController *)viewControllerToCommit {
    [self showViewController:viewControllerToCommit sender:self];
}

#pragma mark - Get方法
-(UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        
        _tableView.dataSource = self;
        _tableView.delegate = self;
        
        [self.view addSubview:_tableView];
        [_tableView reloadData];
    }
    
    return _tableView;
}

@end
