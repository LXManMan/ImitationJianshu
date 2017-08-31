//
//  LXCustomController.m
//  ImitationJianshu
//
//  Created by zhongzhi on 2017/8/30.
//  Copyright © 2017年 漫漫. All rights reserved.
//

#import "LXCustomController.h"
#import "LXMoreController.h"
#import "LXDynamicController.h"
#import "LXArticleController.h"
#import "LXCustomHeader.h"
#import "AvatarView.h"
@interface LXCustomController ()<UIScrollViewDelegate,QBQuSegmentViewDelegate>

@property(nonatomic,strong)QBQuSegmentView *segmentView;
@property (nonatomic, strong)UIScrollView *mainScrollView;
@property(nonatomic,strong)LXCustomHeader *customHeader;
// 头部头像
@property (nonatomic, strong) AvatarView *avatarView;
@end

@implementation LXCustomController
-(void)dealloc{
    [self.childViewControllers enumerateObjectsUsingBlock:^(__kindof LXTestBaseController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [obj.tableView removeObserver:self forKeyPath:@"contentOffset"];
        
    }];
    
    NSLog(@"%@",self.class);
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    

    // 加载头部头像
    AvatarView *avatarView = [[AvatarView alloc] initWithFrame:(CGRect){0, 0, 35, 35}];
    self.navigationItem.titleView = avatarView;
    self.avatarView = avatarView;
    
    self.view.backgroundColor =[UIColor groupTableViewBackgroundColor];
    
    [self.view addSubview:self.mainScrollView];
    
    [self.view addSubview:self.customHeader];
    [self.view addSubview:self.segmentView];
    
    [self setupChildVc:[LXDynamicController class] x:0];
    [self setupChildVc:[LXArticleController class] x:1  * Device_Width];

    [self setupChildVc:[LXMoreController class] x:2 * Device_Width];
  
}
- (void)setupChildVc:(Class)c x:(CGFloat)x
{
    LXTestBaseController *vc = [c new];
    
    [self.mainScrollView addSubview:vc.view];
    
    vc.view.frame = CGRectMake(x, 0, self.view.frame.size.width, self.view.frame.size.height);
    [self addChildViewController:vc];
    vc.headerH = self.segmentView.bottom - self.customHeader.y +1; //把外面自定义的header高度和 分段控制器的高度传入 ，做一个虚拟的header
    //监听tableView的contentOffset变化
    
    [vc.tableView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionInitial context:nil];
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"contentOffset"]) {
        
        UITableView *tableview = object;
        
        CGFloat contentOffsetY = tableview.contentOffset.y;
        
        //临界点是 自定义header的高度，这样我们就可以在滑动tableview的时候单独把分段控制器固定在上面。小于这个高度的时候我们需要把三个tableview的高度同步一下
        if (contentOffsetY < self.customHeader.height) {
            
            [self.childViewControllers enumerateObjectsUsingBlock:^(__kindof LXTestBaseController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                    if (obj.tableView.contentOffset.y != contentOffsetY) {
                        obj.tableView.contentOffset  = tableview.contentOffset;
                    }
                }];
            
            self.customHeader.y = NAVH - contentOffsetY; //原始的y坐标 - 现在的偏移量
            self.segmentView.y = self.customHeader.bottom;
            
        }else{
            self.customHeader.y = NAVH - self.customHeader.height; //固定y 坐标，
            self.segmentView.y = self.customHeader.bottom;
        }
        
        // 处理顶部头像
        CGFloat scale = tableview.contentOffset.y / 80;
        
        // 如果大于80，==1，小于0，==0
        if (tableview.contentOffset.y > 80) {
            scale = 1;
        } else if (tableview.contentOffset.y <= 0) {
            scale = 0;
        }
        [self.avatarView setupScale:scale];
        
    }

}
 //刷新最大OffsetY，让三个tableView同步
- (void)reloadMaxOffsetY {
    
    __block CGFloat maxOffsetY =0;
    [self.childViewControllers enumerateObjectsUsingBlock:^(__kindof LXTestBaseController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if (obj.tableView.contentOffset.y > maxOffsetY) {
            maxOffsetY = obj.tableView.contentOffset.y;
        }
        
    }];
    
    
    if (maxOffsetY > self.customHeader.height) {
        [self.childViewControllers enumerateObjectsUsingBlock:^(__kindof LXTestBaseController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if (obj.tableView.contentOffset.y <self.customHeader.height) {
                obj.tableView.contentOffset = CGPointMake(0, self.customHeader.height);
            }
            
        }];
    }

   }

-(QBQuSegmentView *)segmentView{
    if (!_segmentView) {
        _segmentView =[[QBQuSegmentView alloc]initWithFrame:CGRectMake(0, self.customHeader.bottom, Device_Width, 45) titlesA:@[@"动态",@"文章",@"更多"]];
        _segmentView.backgroundColor =[UIColor whiteColor];
        _segmentView.delegate = self;
    }
    [_segmentView setLineColor:LXMainColor];
    
    return _segmentView;
}
-(void)QBQuSegmentView:(QBQuSegmentView *)segmentView didSelectBtnAtIndex:(NSInteger)index{
    // 1 计算滚动的位置
    
    CGFloat offsetX = index * self.view.frame.size.width;
    // 2.给对应位置添加对应子控制器
    [self.mainScrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
    [self showVc:index];
    // 刷新最大OffsetY
    [self reloadMaxOffsetY];
}
// 开始拖拽
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    // 刷新最大OffsetY
    [self reloadMaxOffsetY];
}
#pragma mark - UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView == self.mainScrollView) {
        // 计算滚动到哪一页
        NSInteger index = scrollView.contentOffset.x / scrollView.frame.size.width;
        
        // 1.添加子控制器view
        [self showVc:index];
        
        // 2.把对应的标题选中
        [self.segmentView titleBtnSelectedWithScrollView:scrollView];
    }
    
}
// 显示控制器的view
- (void)showVc:(NSInteger)index {
    
    
    CGFloat offsetX = index * self.view.frame.size.width;
    
    LXTestBaseController *vc = self.childViewControllers[index];

    vc.view.frame = CGRectMake(offsetX, 0, Device_Width, self.mainScrollView.height);
}

-(UIScrollView *)mainScrollView{
    if (!_mainScrollView) {
        _mainScrollView =[[UIScrollView alloc]initWithFrame:CGRectMake(0, NAVH, Device_Width, Device_Height - NAVH)];
        _mainScrollView.contentSize = CGSizeMake(3 *Device_Width,0 );
        _mainScrollView.pagingEnabled = YES;
        _mainScrollView.bounces = NO;
        _mainScrollView.delegate = self;
        _mainScrollView.showsHorizontalScrollIndicator = NO;
        _mainScrollView.showsVerticalScrollIndicator = NO;
    }
    return _mainScrollView;
}

-(LXCustomHeader *)customHeader{
    if (!_customHeader) {
        _customHeader =[[NSBundle mainBundle]loadNibNamed:@"LXCustomHeader" owner:self options:nil].firstObject;
        _customHeader.frame = CGRectMake(0, NAVH, Device_Width, 150);
    }
    return _customHeader;
}
@end
