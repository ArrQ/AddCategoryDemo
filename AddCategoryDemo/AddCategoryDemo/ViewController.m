//
//  ViewController.m
//  AddCategoryDemo
//
//  Created by ArrQ on 2017/8/26.
//  Copyright © 2017年 ArrQ. All rights reserved.
//

#import "ViewController.h"
#import "ArticleCategoryManagerView.h"// 类别视图

@interface ViewController ()
@property(nonatomic,strong) ArticleCategoryManagerView *cateGoryManagerView;//  分类编辑view

@property(nonatomic,strong) NSMutableArray *dataSourceArr;





@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *dataArray = @[@"来点",
                             @"了点",
                             @"看点",
                             @"就猜",
                             @"好点",
                             @"个点",
                             @"的点",
                             @"放点",
                             @"饿点",
                             @"额点",
                             @"他点",
                             @"你点",
                             @"我点",
                             @"擦点",
                             @"放点"
                             
                        
                           
                            ];
    
    
    
    self.dataSourceArr = [dataArray mutableCopy];
    
    [self.cateGoryManagerView addMeCategory:self.dataSourceArr];



    UIButton *button_ = [UIButton buttonWithType:UIButtonTypeCustom];
    button_.frame = CGRectMake(SCREEN_WIDTH/4, 100, 90, 40);
    [button_ setTitle:@"添加" forState:UIControlStateNormal];
    button_.titleLabel.font = [UIFont systemFontOfSize:14];
    button_.layer.masksToBounds = YES;
    button_.layer.cornerRadius = 5;
    
    button_.layer.borderWidth = 1.f;
    button_.layer.borderColor = [[UIColor colorWithWhite:0.7 alpha:1.0]CGColor];
    [button_ setTitleColor:[UIColor colorWithWhite:0.5 alpha:1.0] forState:UIControlStateNormal];
    [button_ addTarget:self action:@selector(showView:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button_];
    
    UIWindow *window=[[UIApplication sharedApplication].windows lastObject];
    
//    [window addSubview:self.cateGoryManagerView];
    

    [self.view addSubview:self.cateGoryManagerView];
    
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [self getCacheData];
    });
    


}


-(void)getCacheData
{




}


// 弹出视图 编辑view
-(ArticleCategoryManagerView *)cateGoryManagerView{
    if(!_cateGoryManagerView){
        _cateGoryManagerView=[ArticleCategoryManagerView new];
    }
    return _cateGoryManagerView;
}



- (void)showView:(UIButton *)sender{

    [self.cateGoryManagerView show];


}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
