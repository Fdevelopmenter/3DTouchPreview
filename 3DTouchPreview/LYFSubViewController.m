//
//  LYFSubViewController.m
//  3DTouchPreview
//
//  Created by 李玉枫 on 2018/8/8.
//  Copyright © 2018年 李玉枫. All rights reserved.
//

#import "LYFSubViewController.h"

@interface LYFSubViewController ()

/// 标签
@property (nonatomic, strong) UILabel *textLabel;

@end

@implementation LYFSubViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor lightGrayColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - 预览Action代理
-(NSArray<id<UIPreviewActionItem>> *)previewActionItems {
    UIPreviewAction *cancelAction = [UIPreviewAction actionWithTitle:@"取消" style:UIPreviewActionStyleDestructive handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        NSLog(@"取消了");
    }];
    
    UIPreviewAction *confirmAction = [UIPreviewAction actionWithTitle:@"确定" style:UIPreviewActionStyleSelected handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        NSLog(@"确定");
    }];
    
    UIPreviewAction *defaultAction = [UIPreviewAction actionWithTitle:@"你好呀兄弟" style:UIPreviewActionStyleDefault handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        NSLog(@"你好呀，兄die");
    }];
    return @[cancelAction, confirmAction, defaultAction];
}

#pragma mark - Set方法
-(void)setText:(NSString *)text {
    _text = text;
    
    self.textLabel.text = text;
}

#pragma mark - Get方法
-(UILabel *)textLabel {
    if (!_textLabel) {
        _textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 100, 100, 50)];
        _textLabel.center = self.view.center;
        
        [self.view addSubview:_textLabel];
    }
    
    return _textLabel;
}

@end
