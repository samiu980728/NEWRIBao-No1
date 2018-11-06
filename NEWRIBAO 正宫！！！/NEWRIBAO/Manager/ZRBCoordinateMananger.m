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
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
    });
    return manager;
}

- (void)fetchDataWithMainJSONModelsucceed:(ZRBGetJSONModelHandle)succeedBlock error:(ErrorHandle)errorBlock
{
    _testUrlStr = @"https://news-at.zhihu.com/api/4/news/latest";
    
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
