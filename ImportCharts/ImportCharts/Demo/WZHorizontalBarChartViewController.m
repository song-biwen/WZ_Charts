//
//  WZHorizontalBarChartViewController.m
//  ImportCharts
//
//  Created by songbiwen on 2017/2/23.
//  Copyright © 2017年 songbiwen. All rights reserved.
//

#import "WZHorizontalBarChartViewController.h"
#import "ImportCharts-Bridging-Header.h"


@interface WZHorizontalBarChartViewController ()
<ChartViewDelegate>
@property (weak, nonatomic) IBOutlet HorizontalBarChartView *barChartView;

@end

@implementation WZHorizontalBarChartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"Horizontal Bar Chart";
    self.barChartView.delegate = self;
    self.barChartView.chartDescription.enabled = NO;
    self.barChartView.drawBarShadowEnabled = NO;
    self.barChartView.drawValueAboveBarEnabled = YES;
    self.barChartView.maxVisibleCount = 60;
    
    
    ChartXAxis *xAxis = self.barChartView.xAxis;
    xAxis.labelPosition = XAxisLabelPositionBottom;
    xAxis.drawAxisLineEnabled = YES;
    xAxis.drawGridLinesEnabled = NO;
    xAxis.granularity = 10.0;
    xAxis.labelFont = [UIFont systemFontOfSize:10];
    
    
    
    ChartYAxis *leftAxis = self.barChartView.leftAxis;
    leftAxis.labelFont = [UIFont systemFontOfSize:10];
    leftAxis.labelPosition = YAxisLabelPositionOutsideChart;
    leftAxis.drawAxisLineEnabled = YES;
    leftAxis.drawGridLinesEnabled = YES;
    leftAxis.axisMinimum = 0.0;
    
    
    ChartYAxis *rightAxis = self.barChartView.rightAxis;
    rightAxis.enabled = YES;
    rightAxis.labelFont = [UIFont systemFontOfSize:10];
    rightAxis.drawAxisLineEnabled = YES;
    rightAxis.drawGridLinesEnabled = NO;
    rightAxis.axisMinimum = 0.0;
    
    
    ChartLegend *legend = self.barChartView.legend;
    legend.horizontalAlignment = ChartLegendHorizontalAlignmentLeft;
    legend.verticalAlignment = ChartLegendVerticalAlignmentBottom;
    legend.orientation = ChartLegendOrientationHorizontal;
    legend.form = ChartLegendFormSquare;
    legend.formSize= 8.0;
    legend.xEntrySpace = 10;
    legend.drawInside = NO;
    legend.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:11.f];
    
    
    
    self.barChartView.fitBars = YES;
    
    
    [self loadData];
    
}


- (void)loadData {
    
    double count = 12.0;
    double range = 50.0;
    double barWidth = 9.0;
    double spaceForBar = 10.0;
    
    NSMutableArray *yVals = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < count; i++)
    {
        double mult = (range + 1);
        double val = (double) (arc4random_uniform(mult));
        [yVals addObject:[[BarChartDataEntry alloc] initWithX:i * spaceForBar y:val icon: [UIImage imageNamed:@"icon"]]];
    }
    
    BarChartDataSet *set1 = nil;
    set1 = [[BarChartDataSet alloc] initWithValues:yVals label:@"DataSet"];
    
    set1.drawIconsEnabled = NO;
    
    NSMutableArray *dataSets = [[NSMutableArray alloc] init];
    [dataSets addObject:set1];
    
    BarChartData *data = [[BarChartData alloc] initWithDataSets:dataSets];
    [data setValueFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:10.f]];
    data.barWidth = barWidth;
    self.barChartView.data = data;

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
