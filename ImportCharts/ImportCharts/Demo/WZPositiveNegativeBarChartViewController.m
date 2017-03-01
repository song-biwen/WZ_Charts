//
//  WZPositiveNegativeBarChartViewController.m
//  ImportCharts
//
//  Created by songbiwen on 2017/3/1.
//  Copyright © 2017年 songbiwen. All rights reserved.
//

#import "WZPositiveNegativeBarChartViewController.h"
#import "ImportCharts-Bridging-Header.h"

@interface WZPositiveNegativeBarChartViewController ()
<ChartViewDelegate,IChartAxisValueFormatter>
{
     NSArray<NSDictionary *> *dataList;
}

@property (weak, nonatomic) IBOutlet BarChartView *chartView;
@end

@implementation WZPositiveNegativeBarChartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.chartView.delegate = self;
    self.chartView.chartDescription.enabled = NO;
    self.chartView.drawGridBackgroundEnabled = NO;
    self.chartView.dragEnabled = YES;
    self.chartView.pinchZoomEnabled = NO;
    [self.chartView setScaleEnabled:YES];
    self.chartView.drawBarShadowEnabled = NO;
    self.chartView.drawValueAboveBarEnabled = YES;
    
    ChartXAxis *xAixs = self.chartView.xAxis;
    xAixs.drawGridLinesEnabled = NO;
    xAixs.drawAxisLineEnabled = NO;
    xAixs.labelPosition = XAxisLabelPositionBottom;
    xAixs.labelCount = 6;
    xAixs.labelFont = [UIFont systemFontOfSize:13];
    xAixs.granularity = 1.0;
    xAixs.centerAxisLabelsEnabled = YES;
    xAixs.valueFormatter = self;
    
    ChartYAxis *leftAxis = self.chartView.leftAxis;
    leftAxis.drawLabelsEnabled = NO;
    leftAxis.spaceTop = 0.25;
    leftAxis.spaceBottom = 0.25;
    leftAxis.drawAxisLineEnabled = NO;
    leftAxis.drawGridLinesEnabled = NO;
    leftAxis.drawZeroLineEnabled = YES;
    leftAxis.zeroLineColor = UIColor.grayColor;
    leftAxis.zeroLineWidth = 0.7f;

    
    self.chartView.rightAxis.enabled = NO;
    self.chartView.legend.enabled = NO;
    
    [self loadData];
}


- (void)loadData {
    dataList = @[
                 @{@"xValue": @(0),
                   @"yValue": @(-224.1f),
                   @"xLabel": @"12-19"},
                 @{@"xValue": @(1),
                   @"yValue": @(238.5f),
                   @"xLabel": @"12-30"},
                 @{@"xValue": @(2),
                   @"yValue": @(1280.1f),
                   @"xLabel": @"12-31"},
                 @{@"xValue": @(3),
                   @"yValue": @(-442.3f),
                   @"xLabel": @"01-01"},
                 @{@"xValue": @(4),
                   @"yValue": @(-2280.1f),
                   @"xLabel": @"01-02"},
                 ];
    
    NSMutableArray<BarChartDataEntry *> *values = [[NSMutableArray alloc] init];
    NSMutableArray<UIColor *> *colors = [[NSMutableArray alloc] init];
    
    UIColor *green = [UIColor colorWithRed:110/255.f green:190/255.f blue:102/255.f alpha:1.f];
    UIColor *red = [UIColor colorWithRed:211/255.f green:74/255.f blue:88/255.f alpha:1.f];
    
    for (int i = 0; i < dataList.count; i++)
    {
        NSDictionary *d = dataList[i];
        BarChartDataEntry *entry = [[BarChartDataEntry alloc] initWithX:[d[@"xValue"] doubleValue] y:[d[@"yValue"] doubleValue]];
        [values addObject:entry];
        
        // specific colors
        if ([d[@"yValue"] doubleValue] >= 0.f)
        {
            [colors addObject:red];
        }
        else
        {
            [colors addObject:green];
        }
    }
    
    BarChartDataSet *set = set = [[BarChartDataSet alloc] initWithValues:values label:@"Values"];
    set.colors = colors;
    set.valueColors = colors;
    
    BarChartData *data = [[BarChartData alloc] initWithDataSet:set];
    [data setValueFont:[UIFont systemFontOfSize:13.f]];
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.maximumFractionDigits = 1;
    [data setValueFormatter:[[ChartDefaultValueFormatter alloc] initWithFormatter:formatter]];
    
    data.barWidth = 0.8;
    
    _chartView.data = data;

}

#pragma mark - IChartAxisValueFormatter
- (NSString * _Nonnull)stringForValue:(double)value axis:(ChartAxisBase * _Nullable)axis {
    return dataList[MIN(MAX((int) value, 0), dataList.count - 1)][@"xLabel"];
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
