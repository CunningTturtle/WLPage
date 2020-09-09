//
//  WLPageTableView.m
//  TableTest
//
//  Created by 小小李子 on 2020/9/8.
//  Copyright © 2020 小小李子. All rights reserved.
//

#import "WLPageTableView.h"

@interface WLPageTableView ()<UITableViewDelegate> {
    CGFloat contentOffsetY;//记录Y
    BOOL dragDirection;//滑动方向 下 = YES。上 = NO。
    BOOL beginDecelerating;//是否开始减速
}

@end

@implementation WLPageTableView
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self == [super initWithFrame:frame style:style]) {
     
        self.delegate = self;
    }
    return self;
}
// scrollView 结束拖动
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
    NSArray *cells = self.visibleCells;
    CGPoint oldPoint = scrollView.contentOffset;
    CGFloat maxHeight = 50;
    if (cells.count > 1) {
         
        UITableView *cell;
        cell = cells.lastObject;
        CGPoint point = [cell.superview convertPoint:cell.frame.origin toView:self.superview];
        point.y -= self.frame.origin.y;
        
        if (dragDirection == YES) {//下

            if (point.y > maxHeight) {
                
                oldPoint.y -= cell.frame.size.height - point.y;
                [scrollView setContentOffset:oldPoint animated:YES];
            } else {
                
                oldPoint.y += point.y;
                [scrollView setContentOffset:oldPoint animated:YES];
            }
            
            
        } else { //上


            if (self.frame.size.height - point.y > maxHeight) {
                
                oldPoint.y += self.frame.size.height - (self.frame.size.height - point.y);
                [scrollView setContentOffset:oldPoint animated:YES];
                
            } else {
                
                oldPoint.y -= self.frame.size.height - point.y;
                [scrollView setContentOffset:oldPoint animated:YES];
            }

            
        }
    } else {
        NSLog(@"只有一个cell");
    }
}
//开始减速
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {
    
    beginDecelerating = YES;
}
// scrollview 减速停止
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
       beginDecelerating = NO;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
     dragDirection = [self dragDirection:scrollView];
     contentOffsetY = scrollView.contentOffset.y;
    
    if (beginDecelerating) {//开始减速
        
        if ([self visibleCells].count > 1) {
            [scrollView setContentOffset:scrollView.contentOffset animated:NO];
            [self scrollViewDidEndDragging:scrollView willDecelerate:NO];

        }
    }
}

//滑动方向  下 = YES。上 = NO。
- (BOOL)dragDirection:(UIScrollView *)scrollerView {
    
    if (contentOffsetY > scrollerView.contentOffset.y) {
        return YES;
    } else {
        return NO;
    }
}


- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.pageDelegate && [self.pageDelegate respondsToSelector:@selector(tableView:willDisplayCell:forRowAtIndexPath:)]) {
        [self.pageDelegate tableView:tableView willDisplayCell:cell forRowAtIndexPath:indexPath];
    }
}

@end
