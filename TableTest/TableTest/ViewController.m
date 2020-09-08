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
        _tableView.estimatedRowHeight = 200;
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
@end
