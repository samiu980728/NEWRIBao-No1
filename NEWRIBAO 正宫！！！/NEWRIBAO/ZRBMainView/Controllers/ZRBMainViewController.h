//
//  ZRBMainViewController.h
//  NEWRIBAO
//
//  Created by 萨缪 on 2018/10/28.
//  Copyright © 2018年 萨缪. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZRBMainVIew.h"
#import "ZRBMyMessageViewController.h"
#import "ZRBMainWKWebView.h"
#import "ZRBMessageVView.h"
#import <Masonry.h>
#import "SecondaryMessageViewController.h"

@interface ZRBMainViewController : UIViewController
<ZRBPushToWebViewDelegate>

@property (nonatomic, strong) ZRBMainVIew * MainView;

@property (nonatomic, assign) NSInteger iNum;

@property (nonatomic, strong) ZRBMyMessageViewController * viewController;

@property (nonatomic, strong) ZRBMessageVView * messageView;

@property (nonatomic, strong) ZRBMainWKWebView * mainWebView;


@end
