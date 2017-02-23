//
//  WZLineChart2ViewController.m
//  ImportCharts
//
//  Created by songbiwen on 2017/2/22.
//  Copyright © 2017年 songbiwen. All rights reserved.
//

#import "WZLineChart2ViewController.h"
#import "ImportCharts-Bridging-Header.h"


@interface WZLineChart2ViewController ()
<ChartViewDelegate>

@property (weak, nonatomic) IBOutlet LineChartView *lineChartView;

@end

@implementation WZLineChart2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"Line Chart (Dual YAxis)";
    
    
    
    self.lineChartView.backgroundColor = [UIColor colorWithWhite:204/255.f alpha:1.f];
    self.lineChartView.delegate = self;//设置代理
    self.lineChartView.chartDescription.enabled = NO;//不显示description label
    self.lineChartView.dragEnabled = YES;//可以拖拽
    [self.lineChartView setScaleEnabled:YES];//可以缩放
    self.lineChartView.drawGridBackgroundEnabled = NO;//不绘制网格
    self.lineChartView.pinchZoomEnabled = YES;
    
    
    
    //设置图例
    ChartLegend *legend = self.lineChartView.legend;
    legend.form = ChartLegendFormLine;
    legend.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:11.0];
    legend.textColor = [UIColor whiteColor];
    legend.horizontalAlignment = ChartLegendHorizontalAlignmentLeft;
    legend.verticalAlignment = ChartLegendVerticalAlignmentBottom;
    legend.orientation = ChartLegendOrientationHorizontal;
    legend.drawInside = NO;
    
    
    
    //设置X轴
    ChartXAxis *xAixs = self.lineChartView.xAxis;
    xAixs.labelFont = [UIFont systemFontOfSize:11];
    xAixs.labelTextColor = [UIColor whiteColor];
    xAixs.drawAxisLineEnabled = NO;
    xAixs.drawGridLinesEnabled = NO;
    
    
    
    //设置left轴
    ChartYAxis *leftAxis = self.lineChartView.leftAxis;
    leftAxis.labelTextColor = [UIColor colorWithRed:51/255.f green:181/255.f blue:229/255.f alpha:1.f];
    leftAxis.axisMaximum = 200;
    leftAxis.axisMinimum = 0;
    leftAxis.drawGridLinesEnabled = YES;
    leftAxis.drawZeroLineEnabled = NO;
    leftAxis.granularityEnabled = YES;
    
    
    
    //设置right轴
    ChartYAxis *rightAxis = self.lineChartView.rightAxis;
    rightAxis.labelTextColor = [UIColor redColor];
    rightAxis.axisMaximum = 900;
    rightAxis.axisMinimum = -200;
    rightAxis.drawGridLinesEnabled = NO;
    rightAxis.granularityEnabled = NO;
    
    
    
    
    //加载数据
    [self loadData];
//    [self.lineChartView animateWithXAxisDuration:2.5];
}

#pragma makr - ChartViewDelegate
- (void)chartValueSelected:(ChartViewBase * _Nonnull)chartView entry:(ChartDataEntry * _Nonnull)entry highlight:(ChartHighlight * _Nonnull)highlight {
    NSLog(@"%s",__func__);
    
    [self.lineChartView centerViewToAnimatedWithXValue:entry.x yValue:entry.y axis:[[self.lineChartView.data getDataSetByIndex:highlight.dataSetIndex] axisDependency] duration:1.0];
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


- (void)loadData {
    int count = 20.0;
    double range = 30.0;
    
    NSMutableArray *yValues1 = [[NSMutableArray alloc] init];
    NSMutableArray *yValues2 = [[NSMutableArray alloc] init];
    NSMutableArray *yValues3 = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < count; i ++) {
        double mult = range/2.0;
        double value = arc4random_uniform(mult) + 50;
        [yValues1 addObject:[[ChartDataEntry alloc] initWithX:i y:value]];
    }
    
    for (int i = 0; i < count - 1; i ++) {
        double mult = range;
        double value = arc4random_uniform(mult) + 450;
        [yValues2 addObject:[[ChartDataEntry alloc] initWithX:i y:value]];
    }

    for (int i = 0; i < count; i ++) {
        double mult = range;
        double value = arc4random_uniform(mult) + 500;
        [yValues3 addObject:[[ChartDataEntry alloc] initWithX:i y:value]];
    }
    
    LineChartDataSet *set1 = [[LineChartDataSet alloc] initWithValues:yValues1 label:@"DataSet 1"];
    set1.axisDependency = AxisDependencyLeft;
    [set1 setColor:[UIColor colorWithRed:51/255.f green:181/255.f blue:229/255.f alpha:1.f]];
    [set1 setCircleColor:[UIColor whiteColor]];
    set1.lineWidth = 2.0;
    set1.circleRadius = 3.0;
    set1.fillAlpha = 65.0/255.0;
    set1.fillColor = [UIColor colorWithRed:51/255.f green:181/255.f blue:229/255.f alpha:1.f];
    set1.highlightColor = [UIColor colorWithRed:244/255.f green:117/255.f blue:117/255.f alpha:1.f];
    set1.drawCircleHoleEnabled = NO;
    
    
    LineChartDataSet *set2 = [[LineChartDataSet alloc] initWithValues:yValues2 label:@"DataSet 2"];
    set2.axisDependency = AxisDependencyRight;
    [set2 setCircleColor:[UIColor whiteColor]];
    [set2 setColor:[UIColor redColor]];
    set2.lineWidth = 2.0;
    set2.circleRadius = 3.0;
    set2.fillAlpha = 65.0/255.0;
    set2.fillColor = [UIColor redColor];
    set2.highlightColor = [UIColor colorWithRed:244/255.f green:117/255.f blue:117/255.f alpha:1.f];
    set2.drawCircleHoleEnabled = NO;
    
    
    
    LineChartDataSet *set3 = [[LineChartDataSet alloc] initWithValues:yValues3 label:@"DataSet 3"];
    set3.axisDependency = AxisDependencyRight;
    [set3 setColor:[UIColor yellowColor]];
    [set3 setCircleColor:[UIColor whiteColor]];
    set3.lineWidth = 2.0;
    set3.circleRadius = 3.0;
    set3.fillAlpha = 65.0/255.0;
    set3.fillColor = [UIColor.yellowColor colorWithAlphaComponent:200/255.f];
    set3.highlightColor = [UIColor colorWithRed:244/255.f green:117/255.f blue:117/255.f alpha:1.f];
    set3.drawCircleHoleEnabled = NO;
    
    self.lineChartView.data = [[LineChartData alloc] initWithDataSets:@[set1,set2,set3]];
    
}
@end
