//
//  WZSinusBarChartViewController.m
//  ImportCharts
//
//  Created by songbiwen on 2017/3/1.
//  Copyright © 2017年 songbiwen. All rights reserved.
//

#import "WZSinusBarChartViewController.h"
#import "ImportCharts-Bridging-Header.h"

@interface WZSinusBarChartViewController ()
<ChartViewDelegate>

@property (weak, nonatomic) IBOutlet BarChartView *chartView;
@end

@implementation WZSinusBarChartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.chartView.delegate = self;
    self.chartView.chartDescription.enabled = NO;
    self.chartView.drawGridBackgroundEnabled = NO;
    self.chartView.dragEnabled = YES;
    self.chartView.pinchZoomEnabled = NO;
    [self.chartView setScaleEnabled:YES];
    self.chartView.drawBarShadowEnabled = NO;
    self.chartView.maxVisibleCount = 60;
    
    
    ChartXAxis *xAxis = self.chartView.xAxis;
    xAxis.labelPosition = XAxisLabelPositionBottom;
    xAxis.labelFont = [UIFont fontWithName:@"HelveticaNeue-Light" size:10.f];
    xAxis.drawGridLinesEnabled = NO;
    xAxis.enabled = NO;
    
    ChartYAxis *leftAxis = self.chartView.leftAxis;
    leftAxis.axisMinimum = -2.5;
    leftAxis.axisMaximum = 2.5;
    leftAxis.labelCount = 6;
    leftAxis.granularity = 0.1;
    leftAxis.granularityEnabled = YES;
    
    
    
    ChartYAxis *rightAxis = self.chartView.rightAxis;
    rightAxis.axisMaximum = 2.5;
    rightAxis.axisMinimum = -2.5;
    rightAxis.labelCount = 6;
    rightAxis.granularity = 0.1;
    rightAxis.granularityEnabled = YES;
    
    
    ChartLegend *legend = self.chartView.legend;
    legend.horizontalAlignment = ChartLegendHorizontalAlignmentLeft;
    legend.verticalAlignment = ChartLegendVerticalAlignmentBottom;
    legend.orientation = ChartLegendOrientationHorizontal;
    legend.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:11.0];
    legend.drawInside = NO;
    legend.form = ChartLegendFormSquare;
    legend.formSize = 9.0;
    legend.xEntrySpace = 4.0;
    
    //加载数据
    [self loadData];
    
    [self.chartView animateWithXAxisDuration:2.0 yAxisDuration:2.0];
}


- (void)loadData {
    int count = 150;
    
    
    NSMutableArray *values = [[NSMutableArray alloc] init];
    for (int i = 0; i < count; i ++) {
        [values addObject:[[BarChartDataEntry alloc] initWithX:i y:sin(M_PI * (i % 128) / 64.0)]];
    }
    
    BarChartDataSet *set1 = [[BarChartDataSet alloc] initWithValues:values label:@"Sinus Function"];
    [set1 setColor:[UIColor redColor]];
    set1.drawValuesEnabled = NO;
    
    BarChartData *data = [[BarChartData alloc] initWithDataSet:set1];
    data.barWidth = 0.8;
    [data setDrawValues:NO];
    [data setValueFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:10]];
    
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
