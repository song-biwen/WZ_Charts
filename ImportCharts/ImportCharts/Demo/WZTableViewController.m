//
//  WZTableViewController.m
//  ImportCharts
//
//  Created by songbiwen on 2017/2/22.
//  Copyright © 2017年 songbiwen. All rights reserved.
//

#import "WZTableViewController.h"

@interface WZTableViewController ()
@property (nonatomic, strong) NSMutableArray *dataSource;
@end

@implementation WZTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.dataSource addObjectsFromArray:@[
                           @"WZLineChart1ViewController",@"WZLineChart2ViewController",
                           @"WZBarChartViewController",@"WZHorizontalBarChartViewController",
                           @"WZCombinedChartViewController",@"WZPieChartViewController",
                        @"WZPiePolylineChartViewController",@"WZScatterChartViewController",
                           @"WZBubbleChartViewController",@"WZStackedBarChartViewController",
            @"WZNegativeStackedBarChartViewController",@"WZAnotherBarChartViewController",
                @"WZMultipleLinesChartViewController",@"WZMultipleBarChartViewController",
                    @"WZCandleStickChartViewController",@"WZCubicLineChartViewController",
                           @"WZRadarChartViewController",
                           ]
     
     ];
}


#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    cell.textLabel.text = self.dataSource[indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *clsName = self.dataSource[indexPath.row];
    Class cls = NSClassFromString(clsName);
    [self.navigationController pushViewController:[[cls alloc] init] animated:YES];
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
    
}


- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [[NSMutableArray alloc] init];
    }
    return _dataSource;
}
@end
