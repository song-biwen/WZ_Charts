//
//  WZCubicLineChartViewController.m
//  ImportCharts
//
//  Created by songbiwen on 2017/2/28.
//  Copyright © 2017年 songbiwen. All rights reserved.
//

#import "WZCubicLineChartViewController.h"
#import "ImportCharts-Bridging-Header.h"

@interface WZCubicLineChartViewController ()
<ChartViewDelegate>

@property (weak, nonatomic) IBOutlet LineChartView *chartView;
@end

@implementation WZCubicLineChartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.chartView.delegate = self;
    self.chartView.chartDescription.enabled = NO;
    self.chartView.drawGridBackgroundEnabled = NO;
    self.chartView.pinchZoomEnabled = NO;
    
    
    self.chartView.legend.enabled = NO;
    self.chartView.rightAxis.enabled = NO;
    self.chartView.xAxis.enabled = NO;
    
    
    ChartYAxis *leftAxis = self.chartView.leftAxis;
    leftAxis.drawGridLinesEnabled = NO;
    leftAxis.labelFont = [UIFont fontWithName:@"HelveticaNeue-Light" size:12];
    [leftAxis setLabelCount:6 force:NO];
    [leftAxis setAxisLineColor:[UIColor whiteColor]];
    [leftAxis setLabelTextColor:[UIColor whiteColor]];
    [leftAxis setLabelPosition:YAxisLabelPositionInsideChart];
    
    self.chartView.backgroundColor = [UIColor brownColor];
    
    [self loadData];
}

- (void)loadData {
    int count = 45;
    double range = 100;
    
    NSMutableArray *values = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < count; i++) {
        [values addObject:[[ChartDataEntry alloc] initWithX:i y:arc4random_uniform(range)]];
    }
    
    LineChartDataSet *set1 = [[LineChartDataSet alloc] initWithValues:values];
    set1.mode = LineChartModeCubicBezier;
//    set1.cubicIntensity = 0.2;
    set1.drawCirclesEnabled = NO;
//    set1.lineWidth = 1.8;
//    set1.circleRadius = 4.0;
//    [set1 setCircleColor:[UIColor whiteColor]];
//     set1.highlightColor = [UIColor colorWithRed:244/255.f green:117/255.f blue:117/255.f alpha:1.f];
//    [set1 setColor:[UIColor whiteColor]];
//    set1.fillColor = UIColor.whiteColor;
//    set1.fillAlpha = 1.f;
//    set1.drawHorizontalHighlightIndicatorEnabled = NO;

    
    LineChartData *data = [[LineChartData alloc] initWithDataSet:set1];
//    [data setValueFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:9.f]];
    [data setDrawValues:NO];
    
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
