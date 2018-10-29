//
//  ZRBMainVIew.m
//  NEWRIBAO
//
//  Created by 萨缪 on 2018/10/28.
//  Copyright © 2018年 萨缪. All rights reserved.
//

#import "ZRBMainVIew.h"

@implementation ZRBMainVIew

- (void)initMainTableView
{
    //在这里解析数据
    // _mainMessageTableView = [[UITableView alloc] init];
    //_analyJSONMutArray = [[NSMutableArray alloc] init];
    
    //    NSNotification * notification = [NSNotification notificationWithName:@"notification" object:nil];
    //
    //    //[[NSNotificationCenter defaultCenter] postNotificationName:@"notification" object:_analyJSONMutArray];
    //    [[NSNotificationCenter defaultCenter] postNotification:notification];
    //
    //    NSLog(@"mainView 中的 _analyJSONMutArray = %@",_analyJSONMutArray);
    
    _titleMutArray = [[NSMutableArray alloc] init];
    
    _imageMutArray = [[NSMutableArray alloc] init];
    
    _newsLabel = [[UILabel alloc] init];
    _newsImageView = [[UIImageView alloc] init];
    
    
    _analyJSONModel = [[ZRBAnalysisJSONModel alloc] init];
    
    //解析今日数据
    [_analyJSONModel AnalysisJSON];
    
    //解析昨天数据
    
    
    _analyJSONMutArray = [[NSMutableArray alloc] init];
    
    _navigationTextLabel = [[UILabel alloc] init];
    
    _leftNavigationButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    _navigationTextLabel.text = @"今日新闻";
    
    _navigationTextLabel.font = [UIFont systemFontOfSize:15];
    _navigationTextLabel.textColor = [UIColor blackColor];
    
    [_leftNavigationButton setBackgroundImage:[UIImage imageNamed:@"1.png"] forState:UIControlStateNormal];
    
    [self addSubview:_navigationTextLabel];
    [self addSubview:_leftNavigationButton];
    
    [_navigationTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(150);
        make.top.equalTo(self).offset(20);
        make.width.equalTo(@200);
        make.height.equalTo(@20);
    }];
    
    [_leftNavigationButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.top.equalTo(self).offset(10);
        make.width.equalTo(@50);
        make.height.equalTo(@35);
    }];
    
    
    NSLog(@"----------------------");
    
    //在发送通知后
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tongzhi:) name:@"tongzhi" object:nil];
    
    
    //    _analyJSONModel = [[AnalysisJSONModel alloc] init];
    //
    //    [_analyJSONModel AnalysisJSON];
    //NSLog(@"_analyJSONMutArray ----- --- - -- - --- - --- - = %@",_analyJSONMutArray);
}

//移除通知
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"tongzhi" object:nil];
}


- (void)tongzhi:(NSNotification *)noti
{
    //NSLog(@"==========noti.userInfo = %@",noti.userInfo[@"one"]);
    
    //应该字典赋值
    
    //_analyJSONDict = [NSDictionary dictionaryWithDictionary:noti.userInfo[@"one"]];
    //NSLog(@"_analyJSONDict ==== === %@",_analyJSONDict);
    
    _analyJSONMutArray = [NSMutableArray arrayWithArray:noti.userInfo[@"one"]];
    
    for ( int i = 0; i < _analyJSONMutArray.count; i++ ) {
        ZRBMainJSONModel * titleModel = [[ZRBMainJSONModel alloc] init];
        //StoriesJSONModel * storiesModel = [[StoriesJSONModel alloc] init];
        
        titleModel = _analyJSONMutArray[i];
        NSLog(@"-------titleModel---- == = %@--",_analyJSONMutArray[i]);
        
        //为什么加不上去？？？？？
        NSLog(@"titleModel.title === %@",titleModel.title);
        [_titleMutArray addObject:titleModel.title];
        
        NSLog(@"1232132132132132132132131");
        
        //打印下来是【Images】 但是API分析里是image
        //现在问题是 他把StoriesJSONModel 和 MainJSONModel  里的image弄混了
        //一个是Images 一个是image
        
        
        //NSString * JSONImageStr = [NSString stringWithFormat:@"%@",titleModel.images];
        
        NSURL *JSONUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@",titleModel.images[0]]];
        
        NSLog(@"titleModel.image === %@",titleModel.images);
        
        NSLog(@"JSONImageStr == %@",JSONUrl);
        
        NSData * imageData = [NSData dataWithContentsOfURL:JSONUrl];
        UIImage * image = [UIImage imageWithData:imageData];
        
        if ( image ){
            [_imageMutArray addObject:image];
        }
        
        
        
    }
    //NSLog(@"_titleMutArray =====  %@----",_titleMutArray);
    
    //    MainJSONModel * titleModel = [[MainJSONModel alloc] init];
    
    
    //NSLog(@"_analyJSONMutArray[0] ----- --- - -- - --- - --- - = %@",_analyJSONMutArray[0]);
    //NSLog(@"_analyJSONMutArray.count === =   %li",_analyJSONMutArray.count);
    
    dispatch_async(dispatch_get_main_queue(), ^{
        _mainMessageTableView = [[UITableView alloc] init];
        [_mainMessageTableView registerClass:[ZRBNewsTableViewCell class] forCellReuseIdentifier:@"messageCell"];
        
        _mainMessageTableView.delegate = self;
        _mainMessageTableView.dataSource = self;
        
        [self addSubview:_mainMessageTableView];
        
        [_mainMessageTableView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self);
            make.top.equalTo(self).offset(50);
            make.width.mas_equalTo([UIScreen mainScreen].bounds.size.width);
            make.height.mas_equalTo([UIScreen mainScreen].bounds.size.height-30);
            //            make.edges.mas_equalTo(self);
        }];
    });
    //    _mainMessageTableView = [[UITableView alloc] init];
    //
    //    _mainMessageTableView.delegate = self;
    //    _mainMessageTableView.dataSource = self;
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //在mainView的nagviationBar上加按钮！！！
    ZRBNewsTableViewCell * cell = nil;
    
    cell = [_mainMessageTableView dequeueReusableCellWithIdentifier:@"messageCell" forIndexPath:indexPath];
    
    //NSLog(@"_titleMutArray.count = %li, _imageMutArray.count = %li ",_titleMutArray.count,_imageMutArray.count);
    
    //NSLog(@"CELlllllllll 里的 _titleMutArray == %@",_titleMutArray);
    if ( [_titleMutArray isKindOfClass:[NSArray class]] && _titleMutArray.count > 0 ){
        cell.newsLabel.text = [NSString stringWithFormat:@"%@",[_titleMutArray objectAtIndex:indexPath.row]];
        // NSLog(@"[_titleMutArray objectAtIndex:indexPath.row] == %@",[_titleMutArray objectAtIndex:indexPath.row]);
        
    }
    
    if ( [_imageMutArray isKindOfClass:[NSArray class]] && _imageMutArray.count > 0 ){
        cell.newsImageView.image = _imageMutArray[indexPath.row];
    }
    
    //[self addSubview:cell];
    //开始给每个单元格赋值
    
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //这应该push 到一个controller里
    //在那个controller里显示webView
    //    [_mainWebView mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.edges.equalTo(self);
    //    }];
    
    UIViewController * currentViewControlller = [self getCurrentVC];
    
    SecondaryMessageViewController * secondMessageViewController = [[SecondaryMessageViewController alloc] init];
    
    //UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:secondMessageViewController];
    
    [currentViewControlller presentViewController:secondMessageViewController animated:YES completion:nil];
    //    _mainWebView = [[mainWKWebView alloc] initWithFrame:self.frame];
    //
    //    [self addSubview:_mainWebView];
    //
    //        [_mainWebView createAndGetJSONModelWKWebView];
    
    
    
    //[_mainWebView recieveNotification];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    //NSLog(@"_analyJSONMutArray.count === =   %li",_analyJSONMutArray.count);
    //注意 这个根据 数组的count数量决定
    return _analyJSONMutArray.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}




- (UIViewController *)getCurrentVC
{
    UIViewController * result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if ( window.windowLevel != UIWindowLevelNormal ){
        NSArray * windows = [[UIApplication sharedApplication] windows];
        for (UIWindow * tmpWin in windows) {
            if ( tmpWin.windowLevel == UIWindowLevelNormal ){
                window = tmpWin;
                break;
            }
        }
    }
    UIView * frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ( [nextResponder isKindOfClass:[UIViewController class]] ){
        result = nextResponder;
    }else{
        result = window.rootViewController;
    }
    return result;
}


/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end

