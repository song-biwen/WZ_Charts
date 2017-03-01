//
//  WZLineChartTimeViewController.m
//  ImportCharts
//
//  Created by songbiwen on 2017/3/1.
//  Copyright © 2017年 songbiwen. All rights reserved.
//

#import "WZLineChartTimeViewController.h"
#import "ImportCharts-Bridging-Header.h"

@interface WZLineChartTimeViewController ()
<ChartViewDelegate,IChartAxisValueFormatter>

@property (weak, nonatomic) IBOutlet LineChartView *chartView;

@property (nonatomic, strong) NSDateFormatter *dateFormatter;
@end

@implementation WZLineChartTimeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.chartView.delegate = self;
    self.chartView.chartDescription.enabled = NO;
    self.chartView.drawGridBackgroundEnabled = NO;
    self.chartView.dragEnabled = YES;
    [self.chartView setScaleEnabled:YES];
    self.chartView.pinchZoomEnabled = NO;
    
    self.chartView.legend.enabled = NO;
    
    ChartXAxis *xAxis = self.chartView.xAxis;
    xAxis.labelPosition = XAxisLabelPositionTopInside;
    xAxis.drawGridLinesEnabled = YES;
    xAxis.drawAxisLineEnabled = NO;
    xAxis.centerAxisLabelsEnabled = YES;
    xAxis.labelTextColor = [UIColor brownColor];
    xAxis.labelFont = [UIFont systemFontOfSize:10];
    xAxis.valueFormatter = self;
    xAxis.granularity = 3600;
    
    
    ChartYAxis *leftAxis = self.chartView.leftAxis;
    leftAxis.labelPosition = YAxisLabelPositionInsideChart;
    leftAxis.drawGridLinesEnabled = YES;
    leftAxis.labelFont = [UIFont systemFontOfSize:10];
    leftAxis.labelTextColor = [UIColor brownColor];
    leftAxis.axisMinimum = 0;
    leftAxis.granularity = 1.0;
    leftAxis.axisMaximum = 170;
    leftAxis.labelCount = 6;
    
    
    self.chartView.rightAxis.enabled = NO;
    
    
    [self loadData];
}

- (void)loadData {
    int count = 100;
    double range = 30;
    
    NSTimeInterval now = [[NSDate date] timeIntervalSince1970];
    NSTimeInterval hourSeconds = 3600.0;
    
    NSMutableArray *values = [[NSMutableArray alloc] init];
    
    NSTimeInterval from = now - (count / 2.0) * hourSeconds;
    NSTimeInterval to = now + (count / 2.0) * hourSeconds;
    
    for (NSTimeInterval x = from; x < to; x += hourSeconds)
    {
        double y = arc4random_uniform(range) + 50;
        [values addObject:[[ChartDataEntry alloc] initWithX:x y:y]];
    }
    
    LineChartDataSet *set = [[LineChartDataSet alloc] initWithValues:values];
    set.lineWidth = 1.0;
    [set setColor:[UIColor blueColor]];
    set.drawValuesEnabled = NO;
    set.drawCirclesEnabled = NO;
    
    LineChartData *data = [[LineChartData alloc] initWithDataSet:set];
    self.chartView.data = data;
}
#pragma mark - ChartViewDelegate
- (void)chartValueSelected:(ChartViewBase * _Nonnull)chartView entry:(ChartDataEntry * _Nonnull)entry highlight:(ChartHighlight * _Nonnull)highlight; {
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
- (NSString *)stringForValue:(double)value axis:(ChartAxisBase *)axis {
    return [self.dateFormatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:value]];
}

- (NSDateFormatter *)dateFormatter {
    if (!_dateFormatter) {
        _dateFormatter = [[NSDateFormatter alloc] init];
        [_dateFormatter setDateFormat:@"dd MMM HH:mm"];
    }
    return _dateFormatter;
}
@end
