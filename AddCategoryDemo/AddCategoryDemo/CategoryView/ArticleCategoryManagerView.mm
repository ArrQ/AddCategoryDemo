//
//  ArticleCategoryManagerView.m
//  HighCopyTodayNews
//
//  Created by hack on 2017/8/1.
//  Copyright © 2017年 hack. All rights reserved.
//

#import "ArticleCategoryManagerView.h"

#import "CategoryCollectionViewFlowLayout.h"
#import "CategoryCollectionReusableView.h"

#import "CategoryMeCollectionViewCell.h"
#import "CategoryAddCollectionViewCell.h"
#import "CategoryTitleModel.h"
@interface ArticleCategoryManagerView ()<UICollectionViewDelegate,UICollectionViewDataSource,CategoryCollectionReusableViewDelegate,CategoryMeCollectionViewCellDelegate,UIGestureRecognizerDelegate>

@property(nonatomic,strong) UIView *frameView;
@property(nonatomic,strong) UIView *topView;
@property(nonatomic,strong) UIView *mianCenterView;
@property(nonatomic,strong) UIView *topViewBottomLine;// 导航栏下的分界线
@property(nonatomic,strong) UIButton *closeBtn;
@property(nonatomic,strong) UICollectionView *collectionView;

@property(nonatomic,strong) NSMutableArray *dataSourceArr;

@property(nonatomic,strong) NSMutableArray *meTitleArrs;
@property(nonatomic,strong) NSMutableArray *otherTitleArrs;

@property(nonatomic,assign) BOOL isEdit;

//@property (nonatomic, strong) UILongPressGestureRecognizer *longPress;// 拖动排序
@property (nonatomic, strong) UIPanGestureRecognizer *panGestureRecognizer;



@end

static NSString *const cellIdentf=@"showCellTop";
static NSString *const cellIdentfAdd=@"showCellAdd";
static NSString *const headeridentify=@"headeridentify";


@implementation ArticleCategoryManagerView


-(instancetype)init{
    if(self=[super init]){
        
         [self initSubView];

    }
    return self;
}


- (NSMutableArray *)dataSourceArr{

    if (!_dataSourceArr) {
        
        _dataSourceArr = [NSMutableArray array];
        
    }

    return _dataSourceArr;

}


- (NSMutableArray *)meTitleArrs{
    if (!_meTitleArrs) {
        
        
        _meTitleArrs = [NSMutableArray array];
        
        
    }

    return _meTitleArrs;

}



- (NSMutableArray *)otherTitleArrs{

    if (!_otherTitleArrs) {
        
        _otherTitleArrs = [NSMutableArray array];
        
    }

    return _otherTitleArrs;

}


# pragma mark ---  数据分步加载 --------
// -----  加载 第一组数据
-(void)addMeCategory:(NSMutableArray*)meArr{
    
    self.meTitleArrs = meArr;
    
    [self.dataSourceArr addObject:self.meTitleArrs];
    
     NSLog(@"返回数据：%ld",self.dataSourceArr.count);
    [self.collectionView reloadData];
    
}


// 加载第二组数据
- (void)loadData{

    
    NSArray *dataArray = @[
                           @"0点",
                               @"1点",
                               @"2点",
                               @"3点",
                               @"4点",
                               @"5点",
                               @"6点",
                               @"7点",
                               @"8点",
                               @"9点",
                               @"10点",
                               @"11点",
                               @"12点",
                               @"13点",
                               @"14点"
                           ];
    

    
    
    if(self.dataSourceArr.count == 2){
        [self.dataSourceArr removeLastObject];
    }
    
    self.otherTitleArrs = [dataArray mutableCopy];
    
    [self.dataSourceArr addObject:self.otherTitleArrs];
    
    
    [self.collectionView reloadData];
    

}




-(void)initSubView{
    
    self.hidden=YES;
    self.frame=CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT);
    UIColor *color = [UIColor blackColor];
    self.backgroundColor=[color colorWithAlphaComponent:0.5];
    [self addSubview:self.frameView];
    [self.frameView addSubview:self.topView];
    [self.frameView addSubview:self.mianCenterView];
    [self.topView addSubview:self.closeBtn];
    [self.mianCenterView addSubview:self.collectionView];
    [self.topView addSubview:self.topViewBottomLine];
//   //长按拖动排序手势
//    _longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(lonePressMoving:)];
//    [self.collectionView addGestureRecognizer:_longPress];
// 
    //添加下拉view手势
    _panGestureRecognizer= [[UIPanGestureRecognizer alloc]
                                                    initWithTarget:self
                                                    action:@selector(handlePan:)];
    _panGestureRecognizer.delegate = self;
    [self.collectionView addGestureRecognizer:_panGestureRecognizer];
    
 
    
 
}
-(void)show
{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        


           });
    
    [self loadData];

    [UIView animateWithDuration:0.4// 动画时长
                          delay:0.0 // 动画延迟
         usingSpringWithDamping:0.9 // 类似弹簧振动效果 0~1
          initialSpringVelocity:0.3 // 初始速度
                        options:UIViewAnimationOptionCurveEaseInOut // 动画过渡效果
                     animations:^{
                         self.hidden=NO;
                         self.frame=CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
                         self.frameView.frame=CGRectMake(0,20, SCREEN_WIDTH, SCREEN_HEIGHT);
                         
                     } completion:^(BOOL finished) {
                         
                     }];
    
}

-(void)close{
    [UIView animateWithDuration:0.4 animations:^{
        self.frameView.frame=CGRectMake(0,SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT);
        self.hidden=YES;
        
    }];
}


-(void)closeAction{
    [self close];
}

#pragma  mark 编辑模式 按钮代理
-(void)clickEditBtn{
    _isEdit = !_isEdit;
    [self.collectionView reloadData];
   
}
#pragma  mark 删除标签 按钮代理

-(void)clickdelAction:(id)sender{
    
    UICollectionViewCell *cell=(UICollectionViewCell *)[sender superview];
    NSIndexPath *indexPath=[self.collectionView indexPathForCell:cell];
    NSMutableArray *extraArr = _dataSourceArr[0];
    
    [extraArr removeObject:extraArr[indexPath.row]];
    [self.collectionView deleteItemsAtIndexPaths:@[[NSIndexPath  indexPathForRow:indexPath.row inSection:0]]];
    
}

- (void) handlePan:(UIPanGestureRecognizer*) pan
{
    CGPoint point = [pan translationInView:self];
    if (pan.state == UIGestureRecognizerStateBegan)
    {
    } else if (pan.state == UIGestureRecognizerStateChanged){
        [UIView animateWithDuration:0.3 animations:^{
            self.frameView.frame=CGRectMake(0, point.y, SCREEN_WIDTH, SCREEN_HEIGHT);
        }];
        
    }  else if (pan.state == UIGestureRecognizerStateEnded ||
                pan.state == UIGestureRecognizerStateCancelled ||
                pan.state == UIGestureRecognizerStateFailed)
    {
        if(point.y>200)
        {
            [UIView animateWithDuration:0.2 animations:^{
                self.frameView.frame=CGRectMake(0,SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT);
                 self.hidden=YES;
            }];
        }else{
            [UIView animateWithDuration:0.2 animations:^{
                 self.hidden=NO;
                  self.frameView.frame=CGRectMake(0,20, SCREEN_WIDTH, SCREEN_HEIGHT);
            }];
        }
    }
    
}
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    if ([gestureRecognizer.view isKindOfClass:[UIScrollView class]]) {
         return NO;
    }
    else {
         return YES;
    }
}

// 给加的手势设置代理, 并实现此协议方法
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if ([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]) {
        CGPoint point = [_panGestureRecognizer translationInView:self];
        //NSLog(@"%f---------：：：%f",point.y,self.collectionView.contentOffset.y);
        //向上拉动的时候  滚动视图没滑动的偏移
        if(point.y > 0.0f && self.collectionView.contentOffset.y <= 0.0f)
        {
            return YES;
        }
    }
    return NO;
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat offsetY = scrollView.contentOffset.y;
    CGPoint point = [scrollView.panGestureRecognizer translationInView:self];
     if (offsetY <= 0) {
        _topViewBottomLine.hidden=YES;
         self.collectionView.contentOffset=CGPointMake(0, 0);
      
           if(point.y>120)
           {
               [UIView animateWithDuration:0.2 animations:^{
                   self.frameView.frame=CGRectMake(0, point.y, SCREEN_WIDTH, SCREEN_HEIGHT);
               }];
           }
           //NSLog(@"------%f",point.y);
 
    }else{
        _topViewBottomLine.hidden=NO;
    }
 
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self restoreView:scrollView];
}


- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self restoreView:scrollView];

}

-(void)restoreView:(UIScrollView *)scrollView{
   
    CGPoint point = [scrollView.panGestureRecognizer translationInView:self];
    if(point.y>200){
        self.frameView.frame=CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT);
        self.hidden=YES;
        
    }else{
        [UIView animateWithDuration:0.2 animations:^{
            self.hidden=NO;
            self.frameView.frame=CGRectMake(0,20, SCREEN_WIDTH, SCREEN_HEIGHT);
        }];

        
    }
 }



//// 拖动排序
//- (void)lonePressMoving:(UILongPressGestureRecognizer *)longPress
//{
// 
//    NSIndexPath *selectIndexPath = [self.collectionView indexPathForItemAtPoint:[_longPress locationInView:self.collectionView]];
//     switch (_longPress.state) {
//        case UIGestureRecognizerStateBegan: {
//            {
//                 if(_isEdit&&selectIndexPath.section==0)
//                     [_collectionView beginInteractiveMovementForItemAtIndexPath:selectIndexPath];
//                else{
//                     _isEdit=YES;
//                      [self.collectionView reloadData];
//                     if(selectIndexPath&&selectIndexPath.section==0)
//                        [_collectionView beginInteractiveMovementForItemAtIndexPath:selectIndexPath];
//                 }
//              }
//            break;
//        }
//        case UIGestureRecognizerStateChanged: {
// 
//            [self.collectionView updateInteractiveMovementTargetPosition:[longPress locationInView:_longPress.view]];
//            break;
//        }
//        case UIGestureRecognizerStateEnded: {
//                [self.collectionView endInteractiveMovement];
//            break;
//        }
//        default: [self.collectionView cancelInteractiveMovement];
//            break;
//    }
//}

- (void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(nonnull NSIndexPath *)sourceIndexPath toIndexPath:(nonnull NSIndexPath *)destinationIndexPath
{
    if(!_isEdit||sourceIndexPath.section == 1)
        return;
     // 找到当前的cell
     NSMutableArray *arr = self.dataSourceArr[sourceIndexPath.section];
     [arr exchangeObjectAtIndex:sourceIndexPath.item withObjectAtIndex:destinationIndexPath.item];
     [self.collectionView reloadData];
}

-(UICollectionView *)collectionView{
    if(!_collectionView){
        CategoryCollectionViewFlowLayout *flowLayout=[[CategoryCollectionViewFlowLayout alloc] init];
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
        flowLayout.headerReferenceSize = CGSizeMake(SCREEN_WIDTH, 50);//UICollectionView header 的大小
        _collectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-44-20) collectionViewLayout:flowLayout];
        _collectionView.delegate=self;
        _collectionView.dataSource=self;
        _collectionView.backgroundColor=[UIColor whiteColor];
        [_collectionView registerClass:[CategoryMeCollectionViewCell class] forCellWithReuseIdentifier:cellIdentf];
        [_collectionView registerClass:[CategoryAddCollectionViewCell class] forCellWithReuseIdentifier:cellIdentfAdd];
        [_collectionView registerClass:[CategoryCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headeridentify];//注册头视图

    }
    return _collectionView;
}
#pragma mark - <UICollectionViewDelegate,UICollectionViewDataSource>

//设置头部自定义视图

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableView = nil;
    
    if (kind ==UICollectionElementKindSectionHeader) {
        CategoryCollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headeridentify forIndexPath:indexPath];
        if(indexPath.section==0){
            headerView.mainLable.text=@"我的频道";
            headerView.editBtn.hidden=NO;
            if(_isEdit){
                [headerView.editBtn setTitle:@"完成" forState:UIControlStateNormal];
                headerView.subLable.text=@"拖拽可以排序";
             }else{
                [headerView.editBtn setTitle:@"编辑" forState:UIControlStateNormal];
                headerView.subLable.text=@"点击进入频道";
             }
        }else{
            headerView.mainLable.text=@"频道推荐";
            headerView.subLable.text=@"点击添加频道";
            headerView.editBtn.hidden=YES;
         }
        headerView.delegate=self;
        reusableView = headerView;
    }
    if (kind == UICollectionElementKindSectionFooter){
        
    }
    return reusableView;
}


//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    
    
    return self.dataSourceArr.count;
    
    
    
}



//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSMutableArray *arr = self.dataSourceArr[section];
     NSLog(@"返回数据：%ld",arr.count);
    
    return arr.count;
    
}




-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0)
    {
        CategoryMeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentf forIndexPath:indexPath];
        
        NSMutableArray *arr= self.dataSourceArr[indexPath.section];
        
         NSLog(@"返回数据：%ld",self.dataSourceArr.count);
        cell.showLable.text = arr[indexPath.row];
        cell.delegate = self;
        
        cell.isEdit = _isEdit;// 这里 赋值
 
         return cell;
    }else{
        CategoryAddCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentfAdd forIndexPath:indexPath];
        
        NSMutableArray *arr = self.dataSourceArr[indexPath.section];
        cell.showLable.text = arr[indexPath.row];

         return cell;
    }
}




- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{

    if(indexPath.section == 0){
        
    }else{
        
        
        
//        -------
        
        
        NSMutableArray *meArr = [self.dataSourceArr[0] mutableCopy];
        
        NSMutableArray *extraArr = [self.dataSourceArr[1] mutableCopy];
        
        
        [self.dataSourceArr[1] removeObjectAtIndex:indexPath.row];
        [self.collectionView deleteItemsAtIndexPaths:@[[NSIndexPath  indexPathForRow:indexPath.row inSection:1]]];
        

        [self.dataSourceArr[0] insertObject:extraArr[indexPath.row] atIndex:meArr.count];
        
        [meArr insertObject:extraArr[indexPath.row] atIndex:meArr.count];
        
        [self.collectionView insertItemsAtIndexPaths:@[[NSIndexPath indexPathForItem:meArr.count-1 inSection:0]]];
        
        [self.collectionView reloadData];
        
        

     
    }
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
    return UIEdgeInsetsMake(5, 10, 5, 5);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CGFloat itemWidth = (SCREEN_WIDTH - 15 - 20-20) / 4;
    CGFloat itemHeight = AutoHeight(44);
    return CGSizeMake(itemWidth, itemHeight);
}




# pragma mark ---
-(UIView *)topView
{
    if(!_topView){
        _topView=[UIView new];
        _topView.backgroundColor=[UIColor whiteColor];
        
        _topView.backgroundColor=[UIColor redColor];

    }
    return _topView;
}
-(UIView *)mianCenterView
{
    if(!_mianCenterView)
    {
        _mianCenterView=[UIView new];
        _mianCenterView.backgroundColor=[UIColor whiteColor];
        
    }
    return _mianCenterView;
}

-(UIButton*)closeBtn{
    if(!_closeBtn){
        _closeBtn=[UIButton new];
//        [_closeBtn setImage:[UIImage imageNamed:@"screenshotShare_close"] forState:UIControlStateNormal];
        
        [_closeBtn setTitle:@"X" forState:UIControlStateNormal];

        [_closeBtn addTarget:self action:@selector(closeAction) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _closeBtn;
}
-(UIView *)frameView
{
    if(!_frameView){
        _frameView=[UIView new];
        _frameView.backgroundColor=[UIColor clearColor];
        
    }
    return _frameView;
}

-(UIView *)topViewBottomLine{
    if(!_topViewBottomLine){
        _topViewBottomLine=[UIView new];
        _topViewBottomLine.hidden=YES;
        _topViewBottomLine.backgroundColor=[UIColor colorWithRed:0.85 green:0.85 blue:0.85 alpha:1];
    }
    return _topViewBottomLine;
}





# pragma mark ---

-(void)layoutSubviews{
    [super layoutSubviews];
    
    //   切边 ------
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.topView.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(5, 5)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.topView.bounds;
    maskLayer.path = maskPath.CGPath;
    self.topView.layer.mask = maskLayer;
    
    
    [self.frameView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(20);
        make.left.equalTo(self);
        make.right.equalTo(self);
        make.bottom.equalTo(self);
    }];
    
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 44));
        make.top.equalTo(self.frameView);
        make.left.equalTo(self.frameView);
        
    }];
    [self.topViewBottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 0.5));
        make.bottom.equalTo(self.topView).offset(-2);
        make.left.equalTo(self.topView);
    }];
    [self.mianCenterView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topView.mas_bottom).offset(-1);
        make.left.equalTo(self.frameView);
        make.right.equalTo(self.frameView);
        make.bottom.equalTo(self.frameView);
    }];
    [self.closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(44, 44));
        make.left.equalTo(self.topView);
        make.top.equalTo(self.topView);
        
    }];
    
    
    
    
}

@end

