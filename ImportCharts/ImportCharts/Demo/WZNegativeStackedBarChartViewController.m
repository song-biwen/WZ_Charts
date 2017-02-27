//
//  WZNegativeStackedBarChartViewController.m
//  ImportCharts
//
//  Created by songbiwen on 2017/2/27.
//  Copyright © 2017年 songbiwen. All rights reserved.
//

#import "WZNegativeStackedBarChartViewController.h"
#import "ImportCharts-Bridging-Header.h"

@interface WZNegativeStackedBarChartViewController ()
<ChartViewDelegate,IChartAxisValueFormatter>
@property (weak, nonatomic) IBOutlet HorizontalBarChartView *chartView;
@end

@implementation WZNegativeStackedBarChartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.chartView.delegate = self;
    self.chartView.chartDescription.enabled = NO;
    self.chartView.drawBarShadowEnabled = NO;
    self.chartView.pinchZoomEnabled = NO;
    self.chartView.drawValueAboveBarEnabled = YES;
    self.chartView.highlightFullBarEnabled = NO;
    
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.minimumFractionDigits = 1.0;
    formatter.minimumSignificantDigits = 1.0;
    formatter.negativeSuffix = @" m";
    formatter.positiveSuffix = @" m";
    
    ChartXAxis *xAxis = self.chartView.xAxis;
    xAxis.labelPosition = XAxisLabelPositionBothSided;
    xAxis.valueFormatter = [[ChartDefaultAxisValueFormatter alloc] initWithFormatter:formatter];
    xAxis.drawAxisLineEnabled = NO;
    xAxis.drawGridLinesEnabled = NO;
    xAxis.axisMinimum = 0.0;
    xAxis.axisMaximum = 110.0;
    xAxis.centerAxisLabelsEnabled = YES;
    xAxis.labelCount = 12;
    xAxis.granularity = 10;
    xAxis.valueFormatter = self;
    
    
    self.chartView.leftAxis.enabled = NO;
    ChartYAxis *rightAxis = self.chartView.rightAxis;
    rightAxis.axisMinimum = -25;
    rightAxis.axisMaximum = 25;
    rightAxis.drawGridLinesEnabled = NO;
    rightAxis.drawZeroLineEnabled = YES;
    rightAxis.labelCount = 7;
    rightAxis.valueFormatter = [[ChartDefaultAxisValueFormatter alloc] initWithFormatter:formatter];
    rightAxis.labelFont = [UIFont systemFontOfSize:9];
    
    
    ChartLegend *legend = self.chartView.legend;
    legend.horizontalAlignment = ChartLegendHorizontalAlignmentCenter;
    legend.verticalAlignment = ChartLegendVerticalAlignmentBottom;
    legend.orientation = ChartLegendOrientationHorizontal;
    legend.drawInside = NO;
    legend.formSize = 8.0;
    legend.formToTextSpace = 4.0;
    legend.xEntrySpace = 6.0;
    
    [self loadData];
}

- (void)loadData
{
    NSMutableArray *yValues = [NSMutableArray array];
    [yValues addObject:[[BarChartDataEntry alloc] initWithX:5 yValues:@[ @-11, @11]]];
    [yValues addObject:[[BarChartDataEntry alloc] initWithX:15 yValues:@[ @-13, @13 ]]];
    [yValues addObject:[[BarChartDataEntry alloc] initWithX:25 yValues:@[ @-15, @15 ]]];
    [yValues addObject:[[BarChartDataEntry alloc] initWithX:35 yValues:@[ @-17, @17 ]]];
    [yValues addObject:[[BarChartDataEntry alloc] initWithX:45 yValues:@[ @-19, @19 ] icon: [UIImage imageNamed:@"icon"]]];
    [yValues addObject:[[BarChartDataEntry alloc] initWithX:55 yValues:@[ @-19, @19 ]]];
    [yValues addObject:[[BarChartDataEntry alloc] initWithX:65 yValues:@[ @-16, @16 ]]];
    [yValues addObject:[[BarChartDataEntry alloc] initWithX:75 yValues:@[ @-13, @13 ]]];
    [yValues addObject:[[BarChartDataEntry alloc] initWithX:85 yValues:@[ @-10, @10 ]]];
    [yValues addObject:[[BarChartDataEntry alloc] initWithX:95 yValues:@[ @-7, @7 ]]];
    [yValues addObject:[[BarChartDataEntry alloc] initWithX:105 yValues:@[ @-4, @4 ]]];
    
    BarChartDataSet *set = nil;
    if (_chartView.data.dataSetCount > 0)
    {
        set = (BarChartDataSet *)_chartView.data.dataSets[0];
        set.values = yValues;
        [_chartView.data notifyDataChanged];
        [_chartView notifyDataSetChanged];
    }
    else
    {
        NSNumberFormatter *customFormatter = [[NSNumberFormatter alloc] init];
        customFormatter.negativePrefix = @"";
        customFormatter.positiveSuffix = @"m";
        customFormatter.negativeSuffix = @"m";
        customFormatter.minimumSignificantDigits = 1;
        customFormatter.minimumFractionDigits = 1;
        
        set = [[BarChartDataSet alloc] initWithValues:yValues label:@"Age Distribution"];
        
        set.drawIconsEnabled = NO;
        
        set.valueFormatter = [[ChartDefaultValueFormatter alloc] initWithFormatter:customFormatter];
        set.valueFont = [UIFont systemFontOfSize:7.f];
        set.axisDependency = AxisDependencyRight;
        set.colors = @[
                       [UIColor colorWithRed:67/255.f green:67/255.f blue:72/255.f alpha:1.f],
                       [UIColor colorWithRed:124/255.f green:181/255.f blue:236/255.f alpha:1.f]
                       ];
        set.stackLabels = @[
                            @"Men", @"Women"
                            ];
        
        BarChartData *data = [[BarChartData alloc] initWithDataSet:set];
        
        data.barWidth = 8.5;
        
        _chartView.data = data;
        [_chartView setNeedsDisplay];
    }
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

#pragma mark - IAxisValueFormatter

- (NSString *)stringForValue:(double)value
                        axis:(ChartAxisBase *)axis
{
    return [NSString stringWithFormat:@"%03.0f-%03.0f", value, value + 10.0];
}

@end
