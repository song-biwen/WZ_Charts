//
//  WZCombinedChartViewController.m
//  ImportCharts
//
//  Created by songbiwen on 2017/2/23.
//  Copyright © 2017年 songbiwen. All rights reserved.
//

#import "WZCombinedChartViewController.h"
#import "ImportCharts-Bridging-Header.h"

#define ITEM_COUNT 12

@interface WZCombinedChartViewController ()
<ChartViewDelegate>

@property (weak, nonatomic) IBOutlet CombinedChartView *combinedChartView;
@end

@implementation WZCombinedChartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Combined Chart";
    
    self.combinedChartView.delegate = self;
    self.combinedChartView.chartDescription.enabled = NO;
    self.combinedChartView.drawBarShadowEnabled = NO;
    self.combinedChartView.drawGridBackgroundEnabled = NO;
    self.combinedChartView.highlightFullBarEnabled = NO;
    
    self.combinedChartView.drawOrder = @[@(CombinedChartDrawOrderBar),@(CombinedChartDrawOrderLine),@(CombinedChartDrawOrderBubble),@(CombinedChartDrawOrderCandle),@(CombinedChartDrawOrderScatter)];
    
    ChartLegend *legend = self.combinedChartView.legend;
    legend.wordWrapEnabled = YES;
    legend.horizontalAlignment = ChartLegendHorizontalAlignmentCenter;
    legend.verticalAlignment = ChartLegendVerticalAlignmentBottom;
    legend.orientation = ChartLegendOrientationHorizontal;
    legend.drawInside = NO;
    
    
    ChartYAxis *rightAxis = self.combinedChartView.rightAxis;
    rightAxis.drawGridLinesEnabled = NO;
    rightAxis.axisMinimum = 0.0;
    
    ChartYAxis *leftAxis = self.combinedChartView.leftAxis;
    leftAxis.drawGridLinesEnabled = NO;
    leftAxis.axisMinimum = 0.0;
    
    ChartXAxis *xAxis = self.combinedChartView.xAxis;
    xAxis.labelPosition = XAxisLabelPositionBothSided;
    xAxis.axisMinimum = 0.0;
    xAxis.granularity = 1.0;
    
    [self loadData];
}

- (void)loadData {
    
    CombinedChartData *data = [[CombinedChartData alloc] init];
    data.barData = [self generateBarData];
    data.lineData = [self generateLineData];
    data.bubbleData = [self generateBubbleData];
    data.candleData = [self generateCandleData];
    data.scatterData = [self generateScatterData];
    
    self.combinedChartView.data = data;
}


- (LineChartData *)generateLineData
{
    LineChartData *d = [[LineChartData alloc] init];
    
    NSMutableArray *entries = [[NSMutableArray alloc] init];
    
    for (int index = 0; index < ITEM_COUNT; index++)
    {
        [entries addObject:[[ChartDataEntry alloc] initWithX:index + 0.5 y:(arc4random_uniform(15) + 5)]];
    }
    
    LineChartDataSet *set = [[LineChartDataSet alloc] initWithValues:entries label:@"Line DataSet"];
    [set setColor:[UIColor colorWithRed:240/255.f green:238/255.f blue:70/255.f alpha:1.f]];
    set.lineWidth = 2.5;
    [set setCircleColor:[UIColor colorWithRed:240/255.f green:238/255.f blue:70/255.f alpha:1.f]];
    set.circleRadius = 5.0;
    set.circleHoleRadius = 2.5;
    set.fillColor = [UIColor colorWithRed:240/255.f green:238/255.f blue:70/255.f alpha:1.f];
    set.mode = LineChartModeCubicBezier;
    set.drawValuesEnabled = YES;
    set.valueFont = [UIFont systemFontOfSize:10.f];
    set.valueTextColor = [UIColor colorWithRed:240/255.f green:238/255.f blue:70/255.f alpha:1.f];
    
    set.axisDependency = AxisDependencyLeft;
    
    [d addDataSet:set];
    
    return d;
}

- (BarChartData *)generateBarData
{
    NSMutableArray<BarChartDataEntry *> *entries1 = [[NSMutableArray alloc] init];
    NSMutableArray<BarChartDataEntry *> *entries2 = [[NSMutableArray alloc] init];
    
    for (int index = 0; index < ITEM_COUNT; index++)
    {
        [entries1 addObject:[[BarChartDataEntry alloc] initWithX:0.0 y:(arc4random_uniform(25) + 25)]];
        
        // stacked
        [entries2 addObject:[[BarChartDataEntry alloc] initWithX:0.0 yValues:@[@(arc4random_uniform(13) + 12), @(arc4random_uniform(13) + 12)]]];
    }
    
    BarChartDataSet *set1 = [[BarChartDataSet alloc] initWithValues:entries1 label:@"Bar 1"];
    [set1 setColor:[UIColor colorWithRed:60/255.f green:220/255.f blue:78/255.f alpha:1.f]];
    set1.valueTextColor = [UIColor colorWithRed:60/255.f green:220/255.f blue:78/255.f alpha:1.f];
    set1.valueFont = [UIFont systemFontOfSize:10.f];
    set1.axisDependency = AxisDependencyLeft;
    
    BarChartDataSet *set2 = [[BarChartDataSet alloc] initWithValues:entries2 label:@""];
    set2.stackLabels = @[@"Stack 1", @"Stack 2"];
    set2.colors = @[
                    [UIColor colorWithRed:61/255.f green:165/255.f blue:255/255.f alpha:1.f],
                    [UIColor colorWithRed:23/255.f green:197/255.f blue:255/255.f alpha:1.f]
                    ];
    set2.valueTextColor = [UIColor colorWithRed:61/255.f green:165/255.f blue:255/255.f alpha:1.f];
    set2.valueFont = [UIFont systemFontOfSize:10.f];
    set2.axisDependency = AxisDependencyLeft;
    
    float groupSpace = 0.06f;
    float barSpace = 0.02f; // x2 dataset
    float barWidth = 0.45f; // x2 dataset
    // (0.45 + 0.02) * 2 + 0.06 = 1.00 -> interval per "group"
    
    BarChartData *d = [[BarChartData alloc] initWithDataSets:@[set1, set2]];
    d.barWidth = barWidth;
    
    // make this BarData object grouped
    [d groupBarsFromX:0.0 groupSpace:groupSpace barSpace:barSpace]; // start at x = 0
    
    return d;
}

- (ScatterChartData *)generateScatterData
{
    ScatterChartData *d = [[ScatterChartData alloc] init];
    
    NSMutableArray *entries = [[NSMutableArray alloc] init];
    
    for (double index = 0; index < ITEM_COUNT; index += 0.5)
    {
        [entries addObject:[[ChartDataEntry alloc] initWithX:index + 0.25 y:(arc4random_uniform(10) + 55)]];
    }
    
    ScatterChartDataSet *set = [[ScatterChartDataSet alloc] initWithValues:entries label:@"Scatter DataSet"];
    set.colors = ChartColorTemplates.material;
    set.scatterShapeSize = 4.5;
    [set setDrawValuesEnabled:NO];
    set.valueFont = [UIFont systemFontOfSize:10.f];
    
    [d addDataSet:set];
    
    return d;
}

- (CandleChartData *)generateCandleData
{
    CandleChartData *d = [[CandleChartData alloc] init];
    
    NSMutableArray *entries = [[NSMutableArray alloc] init];
    
    for (int index = 0; index < ITEM_COUNT; index += 2)
    {
        [entries addObject:[[CandleChartDataEntry alloc] initWithX:index + 1 shadowH:90.0 shadowL:70.0 open:85.0 close:75.0]];
    }
    
    CandleChartDataSet *set = [[CandleChartDataSet alloc] initWithValues:entries label:@"Candle DataSet"];
    [set setColor:[UIColor colorWithRed:80/255.f green:80/255.f blue:80/255.f alpha:1.f]];
    set.decreasingColor = [UIColor colorWithRed:142/255.0 green:150/255.0 blue:175/255.0 alpha:1.0];
    set.shadowColor = UIColor.darkGrayColor;
    set.valueFont = [UIFont systemFontOfSize:10.f];
    [set setDrawValuesEnabled:NO];
    
    [d addDataSet:set];
    
    return d;
}

- (BubbleChartData *)generateBubbleData
{
    BubbleChartData *bd = [[BubbleChartData alloc] init];
    
    NSMutableArray *entries = [[NSMutableArray alloc] init];
    
    for (int index = 0; index < ITEM_COUNT; index++)
    {
        double y = arc4random_uniform(10) + 105.0;
        double size = arc4random_uniform(50) + 105.0;
        [entries addObject:[[BubbleChartDataEntry alloc] initWithX:index + 0.5 y:y size:size]];
    }
    
    BubbleChartDataSet *set = [[BubbleChartDataSet alloc] initWithValues:entries label:@"Bubble DataSet"];
    [set setColors:ChartColorTemplates.vordiplom];
    set.valueTextColor = UIColor.whiteColor;
    set.valueFont = [UIFont systemFontOfSize:10.f];
    [set setDrawValuesEnabled:YES];
    
    [bd addDataSet:set];
    
    return bd;
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
