//
//  LXTestBaseController.h
//  ImitationJianshu
//
//  Created by zhongzhi on 2017/8/30.
//  Copyright © 2017年 漫漫. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LXTestBaseController : UITableViewController
@property(nonatomic,strong)NSMutableArray *dataA;
@property(nonatomic,assign)CGFloat headerH; //外面除却下方的虚拟高度
@end
