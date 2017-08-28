//
//  CategoryMeCollectionViewCell.h
//  HighCopyTodayNews
//
//  Created by hack on 2017/8/1.
//  Copyright © 2017年 hack. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CategoryTitleModel;

@protocol CategoryMeCollectionViewCellDelegate <NSObject>

-(void)clickdelAction:(id)sender;


@end
@interface CategoryMeCollectionViewCell : UICollectionViewCell


@property(nonatomic,weak)id<CategoryMeCollectionViewCellDelegate>delegate;


-(void)setMyModel:(CategoryTitleModel*)model;


@property(nonatomic,assign)BOOL isEdit;
@property(nonatomic,strong) UILabel *showLable;
@property(nonatomic,strong) UIButton *delTipBtn;


@end
