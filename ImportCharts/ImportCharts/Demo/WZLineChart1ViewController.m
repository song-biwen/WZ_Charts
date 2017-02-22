//
//  WZLineChart1ViewController.m
//  ImportCharts
//
//  Created by songbiwen on 2017/2/22.
//  Copyright © 2017年 songbiwen. All rights reserved.
//

#import "WZLineChart1ViewController.h"
#import "ImportCharts-Bridging-Header.h"

@interface WZLineChart1ViewController ()
<ChartViewDelegate>

@property (weak, nonatomic) IBOutlet LineChartView *lineChartView;

@property (nonatomic, strong) UILabel *markerLabel;
@end

@implementation WZLineChart1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGFloat width = 1.0/[UIScreen mainScreen].scale;
    
    
    self.lineChartView.delegate = self;//设置代理
    self.lineChartView.chartDescription.enabled = NO;//不显示description label
    self.lineChartView.dragEnabled = YES;//是否可以拖拽
    [self.lineChartView setPinchZoomEnabled:YES];
    self.lineChartView.drawGridBackgroundEnabled = NO;//
    
    //设置x轴
    ChartXAxis *xAxis = self.lineChartView.xAxis;
    xAxis.axisLineWidth = width;//设置X轴的宽度
    xAxis.axisLineColor = [UIColor darkGrayColor];//设置X轴的颜色
    xAxis.labelPosition = XAxisLabelPositionBottom;//设置X轴文字的文字
    xAxis.labelFont = [UIFont systemFontOfSize:10];//设置文字的大小
    xAxis.labelTextColor = [UIColor brownColor];//设置文字的颜色
    xAxis.gridLineDashLengths = @[@(10),@(10)];//设置虚线样式的网格线
    xAxis.gridLineDashPhase = 0.f;
    
    
    self.lineChartView.rightAxis.enabled = NO;//不绘制右边轴
    
    
    
    //设置限制线
    ChartLimitLine *ll1 = [[ChartLimitLine alloc] initWithLimit:150 label:@"Upper Limit"];
    ll1.lineWidth = 4.0;
    ll1.labelPosition = ChartLimitLabelPositionRightBottom;
    ll1.valueFont = [UIFont systemFontOfSize:10];
    ll1.lineDashLengths = @[@(5.0),@(5.0)];
    
    ChartLimitLine *ll2 = [[ChartLimitLine alloc] initWithLimit:-30 label:@"Lower Limit"];
    ll2.lineWidth = 4.0;
    ll2.labelPosition = ChartLimitLabelPositionRightBottom;
    ll2.valueFont = [UIFont systemFontOfSize:10];
    ll2.lineDashLengths = @[@(5.0),@(5.0)];
    
    //设置left轴
    ChartYAxis *leftAxis = self.lineChartView.leftAxis;
    leftAxis.axisLineWidth = width;
    leftAxis.axisLineColor = [UIColor darkGrayColor];
    leftAxis.labelPosition = YAxisLabelPositionOutsideChart;
    leftAxis.labelFont = [UIFont systemFontOfSize:10];
    leftAxis.labelTextColor = [UIColor brownColor];
    
    [leftAxis removeAllLimitLines];
    [leftAxis addLimitLine:ll1];
    [leftAxis addLimitLine:ll2];
    leftAxis.axisMaximum = 200;
    leftAxis.axisMinimum = -50;
    leftAxis.gridLineDashLengths = @[@(5.0),@(5.0)];
    leftAxis.drawLimitLinesBehindDataEnabled = YES;
    leftAxis.drawZeroLineEnabled = NO;
    
    
    
    ChartMarkerView *makerView = [[ChartMarkerView alloc] init];
    makerView.chartView = self.lineChartView;
    self.lineChartView.marker = makerView;
    [makerView addSubview:self.markerLabel];
    
    self.lineChartView.legend.form = ChartLegendFormLine;//图例样式
    
    
    //加载数据
    [self loadData];
}

//加载数据
- (void)loadData {
    NSMutableArray *valus = [[NSMutableArray alloc] init];
    
    int count = 45;
    int range = 100;
    
    for (int i = 0; i < count; i ++) {
        int val = arc4random_uniform(range) + 3;
        [valus addObject:[[ChartDataEntry alloc] initWithX:i y:val]];
    }
    
    LineChartDataSet *set1 = [[LineChartDataSet alloc] initWithValues:valus];
    set1.lineDashLengths = @[@(5.0),@(2.5)];
    set1.highlightLineDashLengths = @[@(5.0),@(2.5)];
    [set1 setColor:[UIColor blackColor]];
    [set1 setCircleColor:[UIColor greenColor]];
    set1.lineWidth = 1.0;
    set1.circleRadius = 3.0;
    set1.drawCircleHoleEnabled = NO;
    set1.valueFont = [UIFont systemFontOfSize:9.0];
    set1.formLineDashLengths = @[@(5.0),@(2.5)];
    set1.formLineWidth = 1.0;
    set1.formSize = 15;
    
    NSArray *gradientColor = @[(id)[ChartColorTemplates colorFromString:@"#00ff0000"].CGColor,(id)[ChartColorTemplates colorFromString:@"#ffff0000"].CGColor];//梯度的颜色
    CGGradientRef gradient = CGGradientCreateWithColors(nil, (CFArrayRef)gradientColor, nil);
    set1.fillAlpha = 1.0;
    set1.fill = [ChartFill fillWithRadialGradient:gradient];
    set1.drawFilledEnabled = YES;
    CGGradientRelease(gradient);
    
    
    
    self.lineChartView.data =  [[LineChartData alloc] initWithDataSet:set1];
    
}
#pragma mark - ChartViewDelegate
- (void)chartValueSelected:(ChartViewBase * _Nonnull)chartView entry:(ChartDataEntry * _Nonnull)entry highlight:(ChartHighlight * _Nonnull)highlight {
    NSLog(@"%s",__func__);
    
    self.markerLabel.text = [NSString stringWithFormat:@"%ld%%",(NSInteger)entry.y];//改变选中的数据时候，label的值跟着变化
    //将点击的数据滑动到中间
    [self.lineChartView centerViewToAnimatedWithXValue:entry.x yValue:entry.y axis:[self.lineChartView.data getDataSetByIndex:highlight.dataSetIndex].axisDependency duration:1.0];
    
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

- (UILabel *)markerLabel {
    if (!_markerLabel) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 35, 25)];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:15];
        label.textColor = [UIColor whiteColor];
        label.backgroundColor = [UIColor grayColor];
        label.text = @"";
        _markerLabel = label;
    }
    return _markerLabel;
}

@end
