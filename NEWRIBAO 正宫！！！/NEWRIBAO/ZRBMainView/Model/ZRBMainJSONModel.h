//
//  ZRBMainJSONModel.h
//  NEWRIBAO
//
//  Created by 萨缪 on 2018/10/28.
//  Copyright © 2018年 萨缪. All rights reserved.
//

#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN
@interface StoriesJSONModel : JSONModel

@property (nonatomic, strong) NSArray * images;
@property (nonatomic, strong) NSString * type;
@property (nonatomic, strong) NSString * ga_prefix;
@property (nonatomic, strong) NSString * id;
@property (nonatomic, strong) NSString * title;

@end



@interface ZRBMainJSONModel : JSONModel

@property (nonatomic, strong) NSString * type;
@property (nonatomic, strong) NSString * id;
@property (nonatomic, strong) NSArray * images;
@property (nonatomic, strong) NSString * ga_prefix;
@property (nonatomic, strong) NSString * title;


@end


@interface TotalJSONModel : JSONModel

@property (nonatomic, copy) NSString * date;

//解析数据
@property (nonatomic, strong) NSArray <ZRBMainJSONModel *> * top_stories;
@property (nonatomic, strong) NSArray <StoriesJSONModel *> * stories;

@end
NS_ASSUME_NONNULL_END







