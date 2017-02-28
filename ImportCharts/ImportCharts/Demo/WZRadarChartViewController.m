//
//  WZRadarChartViewController.m
//  ImportCharts
//
//  Created by songbiwen on 2017/2/28.
//  Copyright © 2017年 songbiwen. All rights reserved.
//

#import "WZRadarChartViewController.h"
#import "ImportCharts-Bridging-Header.h"


@interface WZRadarChartViewController ()
<ChartViewDelegate,IChartAxisValueFormatter>

@property (weak, nonatomic) IBOutlet RadarChartView *chartView;
@end

@implementation WZRadarChartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.chartView.backgroundColor = [UIColor brownColor];
    self.chartView.delegate = self;
    self.chartView.chartDescription.enabled = NO;
    
    self.chartView.webLineWidth = 1.0;
    self.chartView.webColor = [UIColor lightGrayColor];
    
    self.chartView.innerWebLineWidth = 1.0;
    self.chartView.innerWebColor = [UIColor lightGrayColor];
    self.chartView.webAlpha = 1.0;
    
    ChartXAxis *xAxis = self.chartView.xAxis;
    xAxis.labelFont = [UIFont fontWithName:@"HelveticaNeue-Light" size:9];
    xAxis.xOffset = 0;
    xAxis.yOffset = 0;
    xAxis.labelTextColor = [UIColor whiteColor];
    xAxis.valueFormatter = self;
    
    ChartYAxis *yAxis = self.chartView.yAxis;
    yAxis.labelFont = [UIFont fontWithName:@"HelveticaNeue-Light" size:9];
    yAxis.labelCount = 5;
    yAxis.axisMinimum = 0.0;
    yAxis.axisMaximum = 80.0;
    yAxis.drawLabelsEnabled = NO;
    
    ChartLegend *legend = self.chartView.legend;
    legend.horizontalAlignment = ChartLegendHorizontalAlignmentCenter;
    legend.verticalAlignment = ChartLegendVerticalAlignmentTop;
    legend.orientation = ChartLegendOrientationHorizontal;
    legend.drawInside = NO;
    legend.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:10];
    legend.xEntrySpace = 7.0;
    legend.yEntrySpace = 5.0;
    legend.textColor = [UIColor whiteColor];
    
    
    [self loadData];
}

- (void)loadData {
    double mult = 80;
    double min = 20;
    int cnt = 5;
    
    NSMutableArray *entries1 = [[NSMutableArray alloc] init];
    NSMutableArray *entries2 = [[NSMutableArray alloc] init];
    
    // NOTE: The order of the entries when being added to the entries array determines their position around the center of the chart.
    for (int i = 0; i < cnt; i++)
    {
        [entries1 addObject:[[RadarChartDataEntry alloc] initWithValue:(arc4random_uniform(mult) + min)]];
        [entries2 addObject:[[RadarChartDataEntry alloc] initWithValue:(arc4random_uniform(mult) + min)]];
    }
    
    RadarChartDataSet *set1 = [[RadarChartDataSet alloc] initWithValues:entries1 label:@"Last Week"];
    [set1 setColor:[UIColor colorWithRed:103/255.0 green:110/255.0 blue:129/255.0 alpha:1.0]];
    set1.fillColor = [UIColor colorWithRed:103/255.0 green:110/255.0 blue:129/255.0 alpha:1.0];
    set1.drawFilledEnabled = YES;
    set1.fillAlpha = 0.7;
    set1.lineWidth = 2.0;
    set1.drawHighlightCircleEnabled = YES;
    [set1 setDrawHighlightIndicators:NO];
    
    RadarChartDataSet *set2 = [[RadarChartDataSet alloc] initWithValues:entries2 label:@"This Week"];
    [set2 setColor:[UIColor colorWithRed:121/255.0 green:162/255.0 blue:175/255.0 alpha:1.0]];
    set2.fillColor = [UIColor colorWithRed:121/255.0 green:162/255.0 blue:175/255.0 alpha:1.0];
    set2.drawFilledEnabled = YES;
    set2.fillAlpha = 0.7;
    set2.lineWidth = 2.0;
    set2.drawHighlightCircleEnabled = YES;
    [set2 setDrawHighlightIndicators:NO];
    
    RadarChartData *data = [[RadarChartData alloc] initWithDataSets:@[set1, set2]];
    [data setValueFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:8.f]];
    [data setDrawValues:NO];
    data.valueTextColor = UIColor.whiteColor;
    
    _chartView.data = data;
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

#pragma mark - IChartAxisValueFormatter
- (NSString * _Nonnull)stringForValue:(double)value axis:(ChartAxisBase * _Nullable)axis {
    return [NSString stringWithFormat:@"%d %%",(int)value];
}
@end
