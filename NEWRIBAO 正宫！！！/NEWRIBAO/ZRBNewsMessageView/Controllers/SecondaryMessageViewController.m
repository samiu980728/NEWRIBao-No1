//
//  SecondaryMessageViewController.m
//  NEWRIBAO
//
//  Created by 萨缪 on 2018/10/28.
//  Copyright © 2018年 萨缪. All rights reserved.
//

#import "SecondaryMessageViewController.h"

@interface SecondaryMessageViewController ()

@end

@implementation SecondaryMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //屏蔽右滑返回功能代码：
    if ( [self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)] ){
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
    
    _mainWebView = [[ZRBMainWKWebView alloc] init];
    
    [_mainWebView createAndGetJSONModelWKWebView];
    
    //由于自定义返回按钮，所以iOS7自带返回手势无效。在需要的页面加上navigationController.interactivePopGestureRecognizer.delegate = self 返回手势好用了。
    //self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    
    
    [_mainWebView.panGestureRecognizer addTarget:self action:@selector(handlePan:)];
    
    [self.view addSubview:_mainWebView];
    
    [_mainWebView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
//    id target = self.
    
}

- (void)handlePan:(UIPanGestureRecognizer *) recognizer
{
    CGPoint translation = [recognizer translationInView:self.view];
    recognizer.view.center = CGPointMake(recognizer.view.center.x + translation.x,
                                         recognizer.view.center.y + translation.y);
    [recognizer setTranslation:CGPointZero inView:self.view];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    __weak typeof(self) weakSelf = self;
    self.navigationController.interactivePopGestureRecognizer.delegate = weakSelf;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
