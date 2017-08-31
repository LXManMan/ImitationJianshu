//
//  QBQuSegmentView.h
//  QianBao
//
//  Created by zhongzhi on 2017/5/17.
//  Copyright © 2017年 zhongzhi. All rights reserved.
//

#import <UIKit/UIKit.h>

//改变类型
typedef enum : NSUInteger {
    
    QBQuSegmentBottomLineDefault,
    QBQuSegmentBottomLineButton,
    
} QBQuSegmentBottomLineType;
@class QBQuSegmentView;
@protocol QBQuSegmentViewDelegate<NSObject>
-(void)QBQuSegmentView:(QBQuSegmentView *)segmentView didSelectBtnAtIndex:(NSInteger)index;
@end;
@interface QBQuSegmentView : UIView
-(instancetype)initWithFrame:(CGRect)frame titlesA:(NSArray *)titlesArray;
@property(nonatomic,strong)NSArray *titleA;
@property(nonatomic,strong)UIColor *lineColor;
@property(nonatomic,assign)CGFloat lineAdjust;//线的位置调整
@property(nonatomic,weak)id<QBQuSegmentViewDelegate>delegate;

@property(nonatomic,assign)QBQuSegmentBottomLineType BottomLineType;
-(void)titleBtnSelectedWithScrollView:(UIScrollView *)scrollview;
-(void)isHavebottomLine:(BOOL) ishaveLine;
@end
