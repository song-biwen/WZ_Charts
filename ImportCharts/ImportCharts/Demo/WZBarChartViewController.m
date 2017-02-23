//
//  WZBarChartViewController.m
//  ImportCharts
//
//  Created by songbiwen on 2017/2/23.
//  Copyright © 2017年 songbiwen. All rights reserved.
//

#import "WZBarChartViewController.h"
#import "ImportCharts-Bridging-Header.h"
#import "WZDayAxisValueFormatter.h"

@interface WZBarChartViewController ()
<ChartViewDelegate>
@property (weak, nonatomic) IBOutlet BarChartView *barChartView;

@end

@implementation WZBarChartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Bar Chart";
    
    
    self.barChartView.delegate = self;
    self.barChartView.drawBarShadowEnabled = NO;
    self.barChartView.drawValueAboveBarEnabled = YES;
    self.barChartView.maxVisibleCount = 60;
    self.barChartView.chartDescription.enabled = NO;
    
    ChartXAxis *xAxis = self.barChartView.xAxis;
    xAxis.labelPosition = XAxisLabelPositionBottom;
    xAxis.labelFont = [UIFont systemFontOfSize:10];
    xAxis.drawGridLinesEnabled = NO;
    xAxis.granularity = 1.0;//间隔
    xAxis.labelCount = 7;
    xAxis.valueFormatter = [[WZDayAxisValueFormatter alloc] initForChart:self.barChartView];
    
    
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    numberFormatter.maximumFractionDigits = 1;
    numberFormatter.minimumFractionDigits = 0;
    numberFormatter.negativeSuffix = @" $";
    numberFormatter.positiveSuffix = @" $";
    
    
    ChartYAxis *leftAxis = self.barChartView.leftAxis;
    leftAxis.labelPosition = YAxisLabelPositionOutsideChart;
    leftAxis.labelFont = [UIFont systemFontOfSize:10];
    leftAxis.valueFormatter = [[ChartDefaultAxisValueFormatter alloc] initWithFormatter:numberFormatter];
    leftAxis.labelCount = 8;
    leftAxis.spaceTop = 0.15;
    leftAxis.axisMinimum = 0.0;
    
    
    
    ChartYAxis *rightAxis = self.barChartView.rightAxis;
    rightAxis.labelPosition = YAxisLabelPositionOutsideChart;
    rightAxis.labelFont = [UIFont systemFontOfSize:10];
    rightAxis.labelCount = 8;
    rightAxis.axisMinimum = 0.0;
    rightAxis.valueFormatter = [[ChartDefaultAxisValueFormatter alloc] initWithFormatter:numberFormatter];
    rightAxis.spaceTop = 0.15;
    rightAxis.enabled = YES;
//    rightAxis.drawGridLinesEnabled = NO;
    
    
    
    ChartLegend *legend = self.barChartView.legend;
    legend.horizontalAlignment = ChartLegendHorizontalAlignmentLeft;
    legend.verticalAlignment = ChartLegendVerticalAlignmentBottom;
    legend.orientation = ChartLegendOrientationHorizontal;
    legend.drawInside = NO;
    legend.form = ChartLegendFormSquare;
    legend.formSize = 9.0;
    legend.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:11];
    legend.xEntrySpace = 4.0;
    
    
    
    [self loadData];
    
}

/*
 double start = 1.0;
 
 NSMutableArray *yVals = [[NSMutableArray alloc] init];
 
 for (int i = start; i < start + count + 1; i++)
 {
 double mult = (range + 1);
 double val = (double) (arc4random_uniform(mult));
 if (arc4random_uniform(100) < 25) {
 [yVals addObject:[[BarChartDataEntry alloc] initWithX:val y:i icon: [UIImage imageNamed:@"icon"]]];
 } else {
 [yVals addObject:[[BarChartDataEntry alloc] initWithX:val y:i]];
 }
 }
 */
- (void)loadData {
    int count = 12;
    int range = 25;
    int start = 1.0;
    NSMutableArray *yVals = [[NSMutableArray alloc] init];
    for (int i = start; i < start + count + 1; i ++) {
        int mult = range + 1;
        int val = arc4random_uniform(mult);
        [yVals addObject:[[BarChartDataEntry alloc] initWithX:val y:i]];
    }
    
    
    BarChartDataSet *set1 = [[BarChartDataSet alloc] initWithValues:yVals];
    [set1 setColors:ChartColorTemplates.material];
    set1.drawIconsEnabled = NO;
    set1.barBorderWidth = 1.0;
    set1.barBorderColor = [UIColor brownColor];
    
    BarChartData *data = [[BarChartData alloc] initWithDataSet:set1];
    data.barWidth = 10.0;
    self.barChartView.data = data;
}
#pragma mark - ChartViewDelegate
- (void)chartValueSelected:(ChartViewBase * _Nonnull)chartView entry:(ChartDataEntry * _Nonnull)entry highlight:(ChartHighlight * _Nonnull)highlight {
    NSLog(@"%s",__func__);
    
    [self.barChartView centerViewToAnimatedWithXValue:entry.x yValue:entry.y axis:[[self.barChartView.data getDataSetByIndex:highlight.dataSetIndex] axisDependency] duration:1.0];
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
