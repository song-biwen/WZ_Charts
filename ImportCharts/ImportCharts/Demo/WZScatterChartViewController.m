//
//  WZScatterChartViewController.m
//  ImportCharts
//
//  Created by songbiwen on 2017/2/23.
//  Copyright © 2017年 songbiwen. All rights reserved.
//

#import "WZScatterChartViewController.h"
#import "ImportCharts-Bridging-Header.h"


@interface WZScatterChartViewController ()
<ChartViewDelegate>

@property (weak, nonatomic) IBOutlet ScatterChartView *scatterChartView;
@end

@implementation WZScatterChartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.scatterChartView.delegate = self;
    self.scatterChartView.chartDescription.enabled = NO;
    
    self.scatterChartView.drawGridBackgroundEnabled = NO;
    self.scatterChartView.dragEnabled = YES;
    [self.scatterChartView setScaleEnabled:YES];
    self.scatterChartView.maxVisibleCount = 200;
    self.scatterChartView.pinchZoomEnabled = YES;
    
    
    ChartLegend *legend = self.scatterChartView.legend;
    legend.horizontalAlignment = ChartLegendHorizontalAlignmentRight;
    legend.verticalAlignment = ChartLegendVerticalAlignmentTop;
    legend.orientation = ChartLegendOrientationVertical;
    legend.drawInside = NO;
    legend.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:10];
    legend.xOffset = 5;
    
    
    ChartYAxis *leftAxis = self.scatterChartView.leftAxis;
    leftAxis.labelFont = [UIFont fontWithName:@"HelveticaNeue-Light" size:10];
    leftAxis.axisMinimum = 0.0;
    
    
    self.scatterChartView.rightAxis.enabled = NO;
    
    
    ChartXAxis *xAxis = self.scatterChartView.xAxis;
    xAxis.labelFont = [UIFont fontWithName:@"HelveticaNeue-Light" size:10];
    xAxis.drawGridLinesEnabled = NO;
    
    
    [self loadData];
}

//加载数据
- (void)loadData {
    int count = 45;
    double range = 100;
    
    NSMutableArray *value1 = [[NSMutableArray alloc] init];
    NSMutableArray *value2 = [[NSMutableArray alloc] init];
    NSMutableArray *value3 = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < count; i ++) {
        double val = arc4random_uniform(range) + 3;
        [value1 addObject:[[ChartDataEntry alloc] initWithX:i y:val]];
        
        val = arc4random_uniform(range) + 3;
        [value2 addObject:[[ChartDataEntry alloc] initWithX:(double)i + 0.33 y:val]];
        
        val = arc4random_uniform(range) + 3;
        [value3 addObject:[[ChartDataEntry alloc] initWithX:(double)i + 0.66 y:val]];
    }
    
    ScatterChartDataSet *set1 = [[ScatterChartDataSet alloc] initWithValues:value1 label:@"DS 1"];
    [set1 setScatterShape:ScatterShapeSquare];
    [set1 setColor:ChartColorTemplates.colorful[0]];
    
    
    ScatterChartDataSet *set2 = [[ScatterChartDataSet alloc] initWithValues:value2 label:@"DS 2"];
    [set2 setScatterShape:ScatterShapeCircle];
//    set2.scatterShapeHoleColor = ChartColorTemplates.colorful[3];
    set2.scatterShapeHoleRadius = 3.0;
    [set2 setColor:ChartColorTemplates.colorful[1]];
    
    
    ScatterChartDataSet *set3 = [[ScatterChartDataSet alloc] initWithValues:value3 label:@"DS 3"];
    [set3 setScatterShape:ScatterShapeCross];
    [set3 setColor:ChartColorTemplates.colorful[2]];
    
    
    set1.scatterShapeSize = 8.0;
    set2.scatterShapeSize = 8.0;
    set3.scatterShapeSize = 8.0;
    
    
    NSMutableArray *dataSets = [[NSMutableArray alloc] initWithObjects:set1,set2,set3, nil];
    ScatterChartData *data = [[ScatterChartData alloc] initWithDataSets:dataSets];
    [data setValueFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:7]];
    self.scatterChartView.data = data;
}
#pragma mark - ChartViewDelegate
- (void)chartValueSelected:(ChartViewBase * _Nonnull)chartView entry:(ChartDataEntry * _Nonnull)entry highlight:(ChartHighlight * _Nonnull)highlight {
    
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
