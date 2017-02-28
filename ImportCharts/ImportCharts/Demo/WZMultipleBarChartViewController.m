//
//  WZMultipleBarChartViewController.m
//  ImportCharts
//
//  Created by songbiwen on 2017/2/28.
//  Copyright © 2017年 songbiwen. All rights reserved.
//

#import "WZMultipleBarChartViewController.h"
#import "ImportCharts-Bridging-Header.h"

@interface WZMultipleBarChartViewController ()
<ChartViewDelegate>

@property (weak, nonatomic) IBOutlet BarChartView *barChartView;
@end

@implementation WZMultipleBarChartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.barChartView.delegate = self;
    self.barChartView.chartDescription.enabled = NO;
    self.barChartView.drawGridBackgroundEnabled = NO;
    self.barChartView.pinchZoomEnabled= NO;
    self.barChartView.drawBarShadowEnabled = NO;
    
    ChartLegend *legend = self.barChartView.legend;
    legend.horizontalAlignment = ChartLegendHorizontalAlignmentRight;
    legend.verticalAlignment = ChartLegendVerticalAlignmentTop;
    legend.orientation = ChartLegendOrientationVertical;
    legend.drawInside = YES;
    legend.xOffset = 10;
    legend.yOffset = 10;
    legend.yEntrySpace = 0.0;
    legend.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:8.0];
    
    ChartXAxis *xAxis = self.barChartView.xAxis;
    xAxis.labelPosition = XAxisLabelPositionTop;
    xAxis.granularity = 1.0;
    xAxis.labelFont = [UIFont fontWithName:@"HelveticaNeue-Light" size:10.0];
    xAxis.centerAxisLabelsEnabled = YES;
    
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.negativeSuffix = @" m";
    formatter.positiveSuffix = @" m";
    formatter.maximumFractionDigits = 1;
    
    ChartYAxis *leftAxis = self.barChartView.leftAxis;
    leftAxis.drawGridLinesEnabled = NO;
    leftAxis.axisMinimum = 0.0;
    leftAxis.valueFormatter = [[ChartDefaultAxisValueFormatter alloc] initWithFormatter:formatter];
    leftAxis.spaceTop = 0.35;
    
    
    self.barChartView.rightAxis.enabled = NO;
    
    [self loadData];
    
}


- (void)loadData {
    int count = 20;
    double range = 100;
    double groupSpace = 0.08;
    double barSpace = 0.03;
    double barWidth = 0.2;
    
    NSMutableArray *value1 = [[NSMutableArray alloc] init];
    NSMutableArray *value2 = [[NSMutableArray alloc] init];
    NSMutableArray *value3 = [[NSMutableArray alloc] init];
    NSMutableArray *value4 = [[NSMutableArray alloc] init];
    
    double randomMultiply = range * 100000;
    double groupCount = count + 1;
    double startYear = 1980;
    double endYear = startYear + groupCount;
    
    for (int i = startYear; i < endYear; i ++) {
        [value1 addObject:[[BarChartDataEntry alloc] initWithX:i y:arc4random_uniform(randomMultiply)]];
        [value2 addObject:[[BarChartDataEntry alloc] initWithX:i y:arc4random_uniform(randomMultiply)]];
        [value3 addObject:[[BarChartDataEntry alloc] initWithX:i y:arc4random_uniform(randomMultiply)]];
        [value4 addObject:[[BarChartDataEntry alloc] initWithX:i y:arc4random_uniform(randomMultiply)]];
        
    }
    
    BarChartDataSet *set1 = [[BarChartDataSet alloc] initWithValues:value1 label:@"Company A"];
    [set1 setColor:[UIColor redColor]];
    
    BarChartDataSet *set2 = [[BarChartDataSet alloc] initWithValues:value2 label:@"Company B"];
    [set2 setColor:[UIColor greenColor]];
    
    BarChartDataSet *set3 = [[BarChartDataSet alloc] initWithValues:value3 label:@"Company C"];
    [set3 setColor:[UIColor blueColor]];
    
    BarChartDataSet *set4 = [[BarChartDataSet alloc] initWithValues:value4 label:@"Company D"];
    [set4 setColor:[UIColor purpleColor]];
    
    
    
    
    NSMutableArray *dataSets = [[NSMutableArray alloc] init];
    [dataSets addObject:set1];
    [dataSets addObject:set2];
    [dataSets addObject:set3];
    [dataSets addObject:set4];
    
    BarChartData *data = [[BarChartData alloc] initWithDataSets:dataSets];
    [data setValueFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:10]];
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.maximumFractionDigits = 1;
    formatter.positiveSuffix = @" m";
    formatter.negativeSuffix = @" m";
    
    [data setValueFormatter:[[ChartDefaultValueFormatter alloc] initWithFormatter:formatter]];
    data.barWidth = barWidth;
    
    [data groupBarsFromX: startYear groupSpace: groupSpace barSpace: barSpace];
    
    self.barChartView.data = data;
    
    self.barChartView.xAxis.axisMinimum = startYear;
    
    
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
