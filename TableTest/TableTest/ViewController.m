//
//  ViewController.m
//  TableTest
//
//  Created by 小小李子 on 2020/9/7.
//  Copyright © 2020 小小李子. All rights reserved.
//

#import "ViewController.h"
#import "TestTableViewCell.h"
#import "WLPageTableView.h"

@interface ViewController ()<WLPageDelegate,UITableViewDataSource> {
    CGFloat contentOffsetY;
    BOOL dragDirection;
    BOOL beginDecelerating;
}
@property (nonatomic,strong) WLPageTableView *tableView;
@property (nonatomic,strong) UIScrollView *scrollView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.tableView];
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[WLPageTableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
        _tableView.pageDelegate = self;
        _tableView.dataSource = self;
        _tableView.scrollEnabled = YES;
        [_tableView registerNib:[UINib nibWithNibName:@"TestTableViewCell" bundle:nil] forCellReuseIdentifier:@"TestTableViewCell"];
    }
    return _tableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TestTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TestTableViewCell"];
    cell.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255 alpha:1];
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

/*
// scrollView 结束拖动
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
    NSArray *cells = self.tableView.visibleCells;
    CGPoint oldPoint = scrollView.contentOffset;
    CGFloat maxHeight = 50;
    if (cells.count > 1) {
         
        UITableView *cell;
        if (dragDirection == YES) {//下

             cell = cells.lastObject;
            
            CGPoint point = [cell.superview convertPoint:cell.frame.origin toView:self.view];

            
            if (point.y > maxHeight) {
                
                oldPoint.y -= self.view.frame.size.height - point.y;
                [scrollView setContentOffset:oldPoint animated:YES];
            } else {
                
                oldPoint.y += point.y;
                [scrollView setContentOffset:oldPoint animated:YES];
            }
            
            
        } else { //上
            cell = cells.lastObject;
            
            CGPoint point = [cell.superview convertPoint:cell.frame.origin toView:self.view];

            if (self.view.frame.size.height - point.y > maxHeight) {
                
                oldPoint.y += self.view.frame.size.height - (self.view.frame.size.height - point.y);
                [scrollView setContentOffset:oldPoint animated:YES];
                
            } else {
                
                oldPoint.y -= self.view.frame.size.height - point.y;
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
    
    if (beginDecelerating && dragDirection == NO) {//开始减速
        
        if ([self.tableView visibleCells].count > 1) {
            NSLog(@"停止滚动");
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
 */
@end
