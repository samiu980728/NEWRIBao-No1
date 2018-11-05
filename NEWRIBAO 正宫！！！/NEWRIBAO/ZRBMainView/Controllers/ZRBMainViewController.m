//
//  ZRBMainViewController.m
//  NEWRIBAO
//
//  Created by 萨缪 on 2018/10/28.
//  Copyright © 2018年 萨缪. All rights reserved.
//

#import "ZRBMainViewController.h"

@interface ZRBMainViewController ()

@end

@implementation ZRBMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"今日新闻";
    
    //开启滑动返回功能代码
    if ( [self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)] ){
        self.navigationController.interactivePopGestureRecognizer.delegate = nil;
    }
    
    
    _messageView = [[ZRBMessageVView alloc] init];
    
    [_messageView initTableView];
    
    [self.view addSubview:_messageView];
    
    //_viewController = [[ViewController alloc] init];
    
    // _viewController.view.backgroundColor = [UIColor yellowColor];
    //[self.view addSubview:_viewController.view];
    
    
    
    _MainView = [[ZRBMainVIew alloc] init];
    
    [_MainView initMainTableView];
    
    [_MainView.leftNavigationButton addTarget:self action:@selector(pressLeftBarButton:) forControlEvents:UIControlEventTouchUpInside];
    
    _MainView.delegate = self;
    
    [self.view addSubview:_MainView];
    
    [_MainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    //    _mainWebView = [[mainWKWebView alloc] init];
    //
    //    [_mainWebView createWKWebView];
    
    
    
    
    //这一下就万法皆通了么！！！！！！！！！！！
    //一直在疑惑怎么证明代理是加到ZRNMainView上的
    //这下就好了!!!
    _MainView.mainMessageTableView.delegate = self;
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if ( _MainView.analyJSONMutArray.count == 0 || _MainView.mainMessageTableView.isHidden == NO ){
        return;
    }
    
    CGFloat offsetY = scrollView.contentOffset.y;
    
    // 当最后一个cell完全显示在眼前时，contentOffset的y值
    
    
    //不知道这样还能用不
    //与那个博客上的赋值方法不相符合！！！！
    
    
    
    
    
    
    
    
    
    
    
    //当最后一个CELL完全显示在眼前时
    CGFloat judgeOffsetY = scrollView.contentSize.height + scrollView.contentInset.bottom - scrollView.contentSize.height - _MainView.mainMessageTableView.tableFooterView.frame.size.height;
    
    if ( offsetY >= judgeOffsetY ){
        //最后一个CELL完全进入视野
        //显示footer
        _MainView.mainMessageTableView.tableFooterView.hidden = NO;
        
        //加载更多数据
        //就把那个 正在加载中 弄出来
        
        //这是那个异步请求数据的方法 不是那个UIVIew视图
        
        //这里需要修改一下！！！！！！
        
        
        
        
        
        
        
        
        
        //判断一下 最后一个CELL 网址找好了！！！
//        还有这里修改一下
        [_MainView loadMoreView];
    }
    
    
}

- (void)pushToWKWebView
{
    //UIViewController * currentViewControlller = [self getCurrentVC];
    
    //现在的问题是 在这里设置断点  但是 不走 SecondaryMessageViewController.m文件中的viewDidLoad方法
    SecondaryMessageViewController * secondMessageViewController = [[SecondaryMessageViewController alloc] init];
    
    
    
    //UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:secondMessageViewController];
    
    [self.navigationController pushViewController:secondMessageViewController animated:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationItem.title = @"每日新闻";

    UIBarButtonItem * leftBarButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"1.png"] style:UIBarButtonItemStyleDone target:self action:@selector(pressLeftBarButton:)];
    self.navigationItem.leftBarButtonItem = leftBarButton;
}

- (void)pressLeftBarButton:(UIBarButtonItem *)leftBtn
{
    NSLog(@"666666");
    if ( _iNum == 0 ){
        [_MainView mas_remakeConstraints:^(MASConstraintMaker *make) {
            //        make.height.mas_equalTo(self.view.bounds.size.height);
            //        make.width.mas_equalTo(
            make.left.equalTo(self.view).offset(250);
            make.top.equalTo(self.view).offset(0);
            make.width.mas_equalTo([UIScreen mainScreen].bounds.size.width-250);
            make.height.mas_equalTo([UIScreen mainScreen].bounds.size.height);
            
            //创建另一个controller
            
            
            
            [_messageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.view);
                make.top.equalTo(self.view).offset(50);
                make.bottom.equalTo(self.view).offset(-50);
                make.width.mas_equalTo(250);
                make.height.mas_equalTo([UIScreen mainScreen].bounds.size.height-100);
            }];
            
            //make.edges.equalTo(self.view);
        }];
        //在这里new 一个新的视图！
        
        //[_aView initScrollView];
        _iNum++;
    }
    
    
    else{
        [_MainView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
        //在这里new出来的新视图 坐标改变！
        _iNum--;
    }
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
