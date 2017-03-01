//
//  WZLineChartFilledViewController.m
//  ImportCharts
//
//  Created by songbiwen on 2017/3/1.
//  Copyright © 2017年 songbiwen. All rights reserved.
//

#import "WZLineChartFilledViewController.h"
#import "ImportCharts-Bridging-Header.h"

@interface WZLineChartFilledViewController ()
<ChartViewDelegate>

@property (weak, nonatomic) IBOutlet LineChartView *chartView;
@end

@implementation WZLineChartFilledViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.chartView.delegate = self;
    self.chartView.chartDescription.enabled = NO;
    self.chartView.dragEnabled = YES;
    self.chartView.pinchZoomEnabled = NO;
    [self.chartView setScaleEnabled:YES];
    
    self.chartView.backgroundColor = [UIColor whiteColor];
    _chartView.gridBackgroundColor = [UIColor colorWithRed:51/255.0 green:181/255.0 blue:229/255.0 alpha:150/255.0];
    _chartView.drawGridBackgroundEnabled = YES;

    self.chartView.legend.enabled = NO;
    
    
    ChartXAxis *xAxis = self.chartView.xAxis;
    xAxis.drawGridLinesEnabled = NO;
    xAxis.drawAxisLineEnabled = YES;
    xAxis.labelPosition = XAxisLabelPositionBothSided;
    xAxis.drawLabelsEnabled = NO;
    
    
    ChartYAxis *leftAxis = self.chartView.leftAxis;
    leftAxis.drawGridLinesEnabled = NO;
    leftAxis.granularity = 1.0;
    leftAxis.axisMaximum = 900.0;
    leftAxis.axisMinimum = -250.0;
    
    ChartYAxis *rightAxis = self.chartView.rightAxis;
    rightAxis.drawGridLinesEnabled = NO;
    rightAxis.drawLabelsEnabled = NO;
    
    
    [self loadData];
}


- (void)loadData {
    int count = 100;
    double range = 60;
    NSMutableArray *values1 = [[NSMutableArray alloc] init];
    NSMutableArray *values2 = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < count; i ++) {
        [values1 addObject:[[ChartDataEntry alloc] initWithX:i y:arc4random_uniform(range) + 50]];
        [values2 addObject:[[ChartDataEntry alloc] initWithX:i y:arc4random_uniform(range) + 450]];
    }
    
    LineChartDataSet *set1 = [[LineChartDataSet alloc] initWithValues:values1];
    set1.lineWidth = 1.0;
    set1.drawCirclesEnabled = NO;
    set1.drawValuesEnabled = NO;
    set1.drawFilledEnabled = YES;
    set1.fillColor = UIColor.whiteColor;
    [set1 setColor:[UIColor redColor]];
    set1.axisDependency = AxisDependencyLeft;
    set1.fillFormatter = [ChartDefaultFillFormatter withBlock:^CGFloat(id<ILineChartDataSet>  _Nonnull dataSet, id<LineChartDataProvider>  _Nonnull dataProvider) {
        return _chartView.leftAxis.axisMaximum;
    }];
    
    LineChartDataSet *set2 = [[LineChartDataSet alloc] initWithValues:values2];
    set2.lineWidth = 1.0;
    set2.drawValuesEnabled = NO;
    set2.drawCirclesEnabled = NO;
    set2.drawFilledEnabled = YES;
    set2.fillColor = UIColor.whiteColor;
    set2.axisDependency = AxisDependencyLeft;
    set2.fillFormatter = [ChartDefaultFillFormatter withBlock:^CGFloat(id<ILineChartDataSet>  _Nonnull dataSet, id<LineChartDataProvider>  _Nonnull dataProvider) {
        return _chartView.leftAxis.axisMinimum;
    }];
    
    LineChartData *data = [[LineChartData alloc] initWithDataSets:@[set1,set2]];
    
    self.chartView.data = data;
}
#pragma mark - ChartViewDelegate
- (void)chartValueSelected:(ChartViewBase * _Nonnull)chartView entry:(ChartDataEntry * _Nonnull)entry highlight:(ChartHighlight * _Nonnull)highlight {
    NSLog(@"%s",__func__);
}
- (void)chartValueNothingSelected:(ChartViewBase * _Nonnull)chartView {
    NSLog(@"%s",__func__);
}
- (void)chartScaled:(ChartViewBase * _Nonnull)chartView scaleX:(CGFloat)scaleX scaleY:(CGFloat)scaleY {
    NSLog(@"%s",__func__);
}
- (void)chartTranslated:(ChartViewBase * _Nonnull)chartView dX:(CGFloat)dX dY:(CGFloat)dY {
    NSLog(@"%s",__func__);
}
@end
