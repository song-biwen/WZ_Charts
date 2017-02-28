//
//  WZCandleStickChartViewController.m
//  ImportCharts
//
//  Created by songbiwen on 2017/2/28.
//  Copyright © 2017年 songbiwen. All rights reserved.
//

#import "WZCandleStickChartViewController.h"
#import "ImportCharts-Bridging-Header.h"

@interface WZCandleStickChartViewController ()
<ChartViewDelegate>

@property (weak, nonatomic) IBOutlet CandleStickChartView *chartView;

@end

@implementation WZCandleStickChartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.chartView.delegate = self;
    self.chartView.chartDescription.enabled = NO;
    self.chartView.legend.enabled = NO;
    self.chartView.pinchZoomEnabled = NO;
    self.chartView.drawGridBackgroundEnabled = NO;
    
    self.chartView.rightAxis.enabled = NO;
    self.chartView.maxVisibleCount = 60;
    
    ChartXAxis *xAxis = self.chartView.xAxis;
    xAxis.labelPosition = XAxisLabelPositionBottom;
    xAxis.drawGridLinesEnabled = NO;
    xAxis.axisMinimum = 0;
    
    
    ChartYAxis *leftAxis = self.chartView.leftAxis;
    leftAxis.drawGridLinesEnabled = NO;
    leftAxis.drawAxisLineEnabled = NO;
    leftAxis.axisMinimum = 0;
    leftAxis.labelCount = 7;
    
    [self loadData];
}

- (void)loadData {
    int count = 40;
    double range = 100;
    
    NSMutableArray *values = [[NSMutableArray alloc] init];
    for (int i = 0; i < count; i ++) {
        
        double mult = (range + 1);
        double val = (double) (arc4random_uniform(40)) + mult;
        double high = (double) (arc4random_uniform(9)) + 8.0;
        double low = (double) (arc4random_uniform(9)) + 8.0;
        double open = (double) (arc4random_uniform(6)) + 1.0;
        double close = (double) (arc4random_uniform(6)) + 1.0;
        BOOL even = i % 2 == 0;
        [values addObject:[[CandleChartDataEntry alloc] initWithX:i shadowH:val + high shadowL:val - low open:even ? val + open : val - open close:even ? val - close : val + close]];
    }
    
    CandleChartDataSet *set1 = [[CandleChartDataSet alloc] initWithValues:values];
    set1.axisDependency = AxisDependencyLeft;
    [set1 setColor:[UIColor colorWithWhite:80/255.f alpha:1.f]];
    
    set1.shadowColor = UIColor.darkGrayColor;
    set1.shadowWidth = 0.7;
    set1.decreasingColor = UIColor.redColor;
    set1.decreasingFilled = YES;
    set1.increasingColor = [UIColor colorWithRed:122/255.f green:242/255.f blue:84/255.f alpha:1.f];
    set1.increasingFilled = NO;
    set1.neutralColor = UIColor.blueColor;
    
    CandleChartData *data = [[CandleChartData alloc] initWithDataSet:set1];
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
