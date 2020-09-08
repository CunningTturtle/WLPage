//
//  WLPageTableView.h
//  TableTest
//
//  Created by 小小李子 on 2020/9/8.
//  Copyright © 2020 小小李子. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

//代理在这里 需要用到的代理 大家自己重写一下
@protocol WLPageDelegate <UITableViewDelegate,NSObject>



@end
@interface WLPageTableView : UITableView
@property (nonatomic,weak) id <WLPageDelegate> pageDelegate;
@end

NS_ASSUME_NONNULL_END
