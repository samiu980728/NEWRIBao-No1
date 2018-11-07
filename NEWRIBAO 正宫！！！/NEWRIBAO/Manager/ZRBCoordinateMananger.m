//
//  ZRBCoordinateMananger.m
//  NEWRIBAO
//
//  Created by 萨缪 on 2018/11/6.
//  Copyright © 2018年 萨缪. All rights reserved.
//

#import "ZRBCoordinateMananger.h"


@implementation ZRBCoordinateMananger
static ZRBCoordinateMananger * manager = nil;

//单例创建仅仅执行一次 随时取用相关方法
+ (id)sharedManager
{
    //static ZRBCoordinateMananger * manager = nil;
    //_beforeDateStr = [[NSString alloc] init];
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
    });
    return manager;
}

- (void)fetchDataWithMainJSONModelsucceed:(ZRBGetJSONModelHandle)succeedBlock error:(ErrorHandle)errorBlock
{
    //用这一个方法就行了感觉？？？
    //新建一个NSString * 类型的
    //如果他为空 那么请求最新数据 同时把最新数据的date值赋值给这个 str
    //此时str不为空  那么执行另外一种网络请求 返回的都是NSMUtableArray类型数组
    
    //然后在Controller层 调用 didScriolleView 方法中 那个判断 括号里面 再次调用 这个块中的 方法即可
    //这样请求到的网络数据就是往日的数据
    //然后在View层 返回的行数 是 要创建一个总的 NSMUtableArray 每次请求一次数据 把这次数据的所有东西作为一个单元传入这个数组中（当成一个单元）
    //然后每次reloadData 重走代理的那些方法的时候 就可以返回这个数组的count值
    
    
    //下来该怎么做？

    
    NSLog(@"_ifAdoultRefreshStr 这里面的 = == = = == = = = %@",_ifAdoultRefreshStr);
    
    if ( _ifAdoultRefreshStr ){
        NSLog(@"成功调用之前的信息====-=-=-=-=-=-=-=-=-=-=-=-=-=-=-");
        //把下面那个else 可能去掉
        //
        //把date 存入一个数组中 然后 for 循环这个数组
        for (int i = 0; i < _dateMutArray.count; i++) {
            _testUrlStr = [NSString stringWithFormat:@"https://news-at.zhihu.com/api/4/news/before/%@",_dateMutArray[i]];
            
            _testUrlStr = [_testUrlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
            
            _testUrl = [NSURL URLWithString:_testUrlStr];
            
            _testRequest = [NSURLRequest requestWithURL:_testUrl];
            
            _nowDateStr = [[NSString alloc] init];
            
            _testSession = [NSURLSession sharedSession];
            
            //继续复制下去
            
        }
        
        
    }
    
    
    
    
    
    
    
        
        NSLog(@"继续调用原网络请求");
    _testUrlStr = @"https://news-at.zhihu.com/api/4/news/latest";
    
        //创建判断str
        _ifAdoultRefreshStr = [[NSString alloc] init];
        
    _testUrlStr = [_testUrlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    _testUrl = [NSURL URLWithString:_testUrlStr];
    
    _testRequest = [NSURLRequest requestWithURL:_testUrl];
    
    _nowDateStr = [[NSString alloc] init];
    
    _testSession = [NSURLSession sharedSession];
    _testDataTask = [_testSession dataTaskWithRequest:_testRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if ( error == nil ){
            //这里写一个通知 网络请求接收到了之后再到 VView.m文件中回传通知
            //在通知里执行数组 数组属性赋值的方法
            
            
            _obj = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            
            
            //这一步好了  成功传参 下一步就是在MainView 层 写 参照崔总
            
            
            
            
            
            //_nowDateStr = [NSString stringWithFormat:@"%@",_obj[@"date"]];
            
            //NSLog(@"_nowDateStr === = == = == %@",_nowDateStr);
            
            _totalJSONModel = [[TotalJSONModel alloc] initWithDictionary:_obj error:nil];

            _JSONModelMut = [[NSMutableArray alloc] init];
            
            _dateMutArray = [[NSMutableArray alloc] init];
            
            _beforeDateStr = [NSString stringWithFormat:@"%@",_totalJSONModel.date];
            
            [_dateMutArray addObject:_beforeDateStr];
            
            //好了 解析成功
            NSLog(@"_beforeDateStr == = = = = %@",_beforeDateStr);
            

            for (int i = 0; i < _totalJSONModel.stories.count; i++) {
                _storiesJSONModel = [[StoriesJSONModel alloc] initWithDictionary:_obj[@"stories"][i] error:nil];
                if ( _storiesJSONModel ){
                    [_JSONModelMut addObject:_storiesJSONModel];
                }
            }

            for (int i = 0; i < _totalJSONModel.top_stories.count; i++) {
                _mainJSONModel = [[ZRBMainJSONModel alloc] initWithDictionary:_obj[@"top_stories"][i] error:nil];
                if ( _mainJSONModel ){
                    [_JSONModelMut addObject:_mainJSONModel];
                }
            }
//            //NSLog(@"_JSONModelMut ====  ---- %@ ----",_JSONModelMut);
//
//            //取值
//            ZRBMainJSONModel * MModel = _JSONModelMut[0];
//
//            NSLog(@"MModel = %@",MModel.title);
//
            //            NSNotificationCenter * center = [NSNotificationCenter defaultCenter];
            //            [center addObserver:self selector:@selector(changJSONModel:) name:@"notification" object:nil];
            
//            NSDictionary * dict = [[NSDictionary alloc] initWithObjectsAndKeys:_JSONModelMut,@"one", nil];
//            NSNotification * notification = [NSNotification notificationWithName:@"tongzhi" object:nil userInfo:dict];
//
//            [[NSNotificationCenter defaultCenter] postNotification:notification];
            NSLog(@"块中的_JSONModelMut == = == %@",_JSONModelMut);
            
            
            succeedBlock(_JSONModelMut);
            
        }else{
            if ( error ){
            errorBlock(error);
            }
        }
        
    }];
    [_testDataTask resume];
    
}

@end
