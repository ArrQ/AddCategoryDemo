//
//  CategoryTitleModel.h
//  AddCategoryDemo
//
//  Created by ArrQ on 2017/8/26.
//  Copyright © 2017年 ArrQ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CategoryTitleModel : NSObject
@property (nonatomic, copy) NSString *category;

@property (nonatomic, assign) NSInteger default_add;

@property (nonatomic, assign) NSInteger tip_new;

@property (nonatomic, copy) NSString *web_url;

@property (nonatomic, copy) NSString *concern_id;

@property (nonatomic, copy) NSString *icon_url;

@property (nonatomic, assign) NSInteger flags;

@property (nonatomic, assign) NSInteger type;

@property (nonatomic, copy) NSString *name;

@end
