//
//  WZStackedBarChartViewController.m
//  ImportCharts
//
//  Created by songbiwen on 2017/2/27.
//  Copyright © 2017年 songbiwen. All rights reserved.
//

#import "WZStackedBarChartViewController.h"
#import "ImportCharts-Bridging-Header.h"

@interface WZStackedBarChartViewController ()
<ChartViewDelegate>

@property (weak, nonatomic) IBOutlet BarChartView *chartView;
@end

@implementation WZStackedBarChartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.chartView.delegate = self;
    self.chartView.chartDescription.enabled = NO;
    self.chartView.drawGridBackgroundEnabled = NO;
    self.chartView.pinchZoomEnabled = NO;
    self.chartView.maxVisibleCount = 40;
    [self.chartView setDrawBarShadowEnabled:NO];
    self.chartView.drawValueAboveBarEnabled = NO;
    self.chartView.highlightFullBarEnabled = NO;
    
    
    ChartLegend *legend = self.chartView.legend;
    legend.horizontalAlignment = ChartLegendHorizontalAlignmentRight;
    legend.verticalAlignment = ChartLegendVerticalAlignmentBottom;
    legend.orientation = ChartLegendOrientationHorizontal;
    legend.drawInside = NO;
    legend.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:10];
    legend.form = ChartLegendFormSquare;
    legend.formSize = 8.0;
    legend.formToTextSpace = 4.0;
    legend.xEntrySpace = 6.0;
    
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.negativeSuffix = @" $";
    formatter.positiveSuffix = @" $";
    formatter.maximumFractionDigits =1;
    
    ChartYAxis *leftAxis = self.chartView.leftAxis;
    leftAxis.axisMinValue = 0.0;
    leftAxis.valueFormatter = [[ChartDefaultAxisValueFormatter alloc] initWithFormatter:formatter];
    
    self.chartView.rightAxis.enabled = NO;
    
    ChartXAxis *xAxis = self.chartView.xAxis;
    xAxis.labelPosition = XAxisLabelPositionTop;
    
    [self loadData];
}

- (void)loadData {
    int count = 12;
    double range = 100;
    
    NSMutableArray *values = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < count; i ++) {
        double val1 = arc4random_uniform(range + 1) + range/3;
        double val2 = arc4random_uniform(range + 1) + range/3;
        double val3 = arc4random_uniform(range + 1) + range/3;
        [values addObject:[[BarChartDataEntry alloc] initWithX:i yValues:@[@(val1),@(val2),@(val3)]]];
    }
    
    BarChartDataSet *set1 = [[BarChartDataSet alloc] initWithValues:values];
    set1.colors = @[ChartColorTemplates.material[0], ChartColorTemplates.material[1], ChartColorTemplates.material[2]];
    set1.stackLabels = @[@"Births", @"Divorces", @"Marriages"];
    
    
    BarChartData *data = [[BarChartData alloc] initWithDataSet:set1];
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.maximumFractionDigits = 1;
    formatter.negativeSuffix = @" $";
    formatter.positiveSuffix = @" $";
    [data setValueFormatter:[[ChartDefaultValueFormatter alloc] initWithFormatter:formatter]];
    [data setValueFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:7.0]];
    [data setValueTextColor:[UIColor whiteColor]];
    
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
