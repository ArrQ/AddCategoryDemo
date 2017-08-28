//
//  CategoryMeCollectionViewCell.m
//  HighCopyTodayNews
//
//  Created by hack on 2017/8/1.
//  Copyright © 2017年 hack. All rights reserved.
//

#import "CategoryMeCollectionViewCell.h"
#import "CategoryTitleModel.h"

@interface CategoryMeCollectionViewCell ()

@end


@implementation CategoryMeCollectionViewCell


- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        
        
        [self customSubViews];
        
    }
    
    
    return self;
    
}



- (void)customSubViews{
    
    self.backgroundColor=[UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1];
    
    _delTipBtn = [[UIButton alloc]init];
    _delTipBtn.hidden=YES;// 可写可不写
    [_delTipBtn setTitle:@"X" forState:UIControlStateNormal];
    [_delTipBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [_delTipBtn addTarget:self action:@selector(delclickAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_delTipBtn];
    
    _showLable=[[UILabel alloc]init];
    _showLable.font=[UIFont systemFontOfSize:15];
    _showLable.textColor=[UIColor blackColor];
    _showLable.text=@"内容";
    
    [self addSubview:_showLable];
    
    
    
    
}


- (void)layoutSubviews{
    [super layoutSubviews];
    
    [_showLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
    }];
    [_delTipBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(18, 18));
        make.right.equalTo(self).offset(3);
        make.top.equalTo(self).offset(-3);
        
        
    }];
    
    

    
    
    
    
}




-(void)setMyModel:(CategoryTitleModel*)model
{
//    self.showLable.text=model.name;
    
}

-(void)delclickAction:(id)sender{
    if([self.delegate respondsToSelector:@selector(clickdelAction:)]){
        [self.delegate clickdelAction:sender];
    }
}



-(void)setIsEdit:(BOOL)isEdit{
    _isEdit = isEdit;
    if(_isEdit){
        self.delTipBtn.hidden=NO;
    }else{
        self.delTipBtn.hidden=YES;

    }
}



@end
