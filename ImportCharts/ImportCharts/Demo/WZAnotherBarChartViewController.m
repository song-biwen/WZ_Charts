//
//  WZAnotherBarChartViewController.m
//  ImportCharts
//
//  Created by songbiwen on 2017/2/27.
//  Copyright © 2017年 songbiwen. All rights reserved.
//

#import "WZAnotherBarChartViewController.h"
#import "ImportCharts-Bridging-Header.h"

@interface WZAnotherBarChartViewController ()
<ChartViewDelegate>

@property (weak, nonatomic) IBOutlet BarChartView *chartView;

@end

@implementation WZAnotherBarChartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.chartView.delegate= self;
    self.chartView.chartDescription.enabled = NO;
    self.chartView.legend.enabled = NO;
    self.chartView.dragEnabled= YES;
    self.chartView.drawBarShadowEnabled = NO;
    self.chartView.drawGridBackgroundEnabled = NO;
    self.chartView.pinchZoomEnabled = NO;
    self.chartView.maxVisibleCount = 40;
    
    ChartXAxis *xAxis = self.chartView.xAxis;
    xAxis.labelPosition = XAxisLabelPositionBottom;
    xAxis.drawGridLinesEnabled = NO;
    
    
    ChartYAxis *leftAxis = self.chartView.leftAxis;
    leftAxis.drawGridLinesEnabled = NO;
    
    ChartYAxis *rightAxis = self.chartView.rightAxis;
    rightAxis.drawGridLinesEnabled = NO;
    
    [self loadData];
}

- (void)loadData {
    int count = 10;
    double range = 100;
    NSMutableArray *values = [[NSMutableArray alloc] init];
    for (int i = 0; i < count; i ++) {
        double val = arc4random_uniform(range) + range/3;
        [values addObject:[[BarChartDataEntry alloc] initWithX:i y:val]];
    }
    
    BarChartDataSet *set1 = [[BarChartDataSet alloc] initWithValues:values];
    set1.colors = ChartColorTemplates.vordiplom;
    set1.drawValuesEnabled = NO;
    
    BarChartData *data = [[BarChartData alloc] initWithDataSet:set1];
    
    self.chartView.data = data;
    self.chartView.fitBars = YES;
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
