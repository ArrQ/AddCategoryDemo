//
//  CategoryAddCollectionViewCell.h
//  HighCopyTodayNews
//
//  Created by hack on 2017/8/1.
//  Copyright © 2017年 hack. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CategoryTitleModel;

@interface CategoryAddCollectionViewCell : UICollectionViewCell

@property(nonatomic,strong) UIImageView *addImg;
@property(nonatomic,strong) UILabel *showLable;


-(void)setMyModel:(CategoryTitleModel*)model;

@end
