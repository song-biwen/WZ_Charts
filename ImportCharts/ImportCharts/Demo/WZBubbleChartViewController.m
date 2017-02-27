//
//  WZBubbleChartViewController.m
//  ImportCharts
//
//  Created by songbiwen on 2017/2/27.
//  Copyright © 2017年 songbiwen. All rights reserved.
//

#import "WZBubbleChartViewController.h"
#import "ImportCharts-Bridging-Header.h"


@interface WZBubbleChartViewController ()
<ChartViewDelegate>

@property (weak, nonatomic) IBOutlet BubbleChartView *chartView;
@end

@implementation WZBubbleChartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.chartView.delegate = self;
    self.chartView.chartDescription.enabled = NO;
    self.chartView.dragEnabled = YES;
    [self.chartView setPinchZoomEnabled:YES];
    self.chartView.drawGridBackgroundEnabled = NO;
    [self.chartView setScaleEnabled:YES];
    
    ChartLegend *legend = self.chartView.legend;
    legend.horizontalAlignment = ChartLegendHorizontalAlignmentRight;
    legend.verticalAlignment = ChartLegendVerticalAlignmentTop;
    legend.orientation = ChartLegendOrientationVertical;
    legend.drawInside = NO;
    legend.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:10];
    
    ChartXAxis *xAxis = self.chartView.xAxis;
    xAxis.labelFont = [UIFont fontWithName:@"HelveticaNeue-Light" size:10];
//    xAxis.drawGridLinesEnabled = NO;
    xAxis.labelPosition = XAxisLabelPositionBottom;
    
    
    ChartYAxis *yAxis = self.chartView.leftAxis;
    yAxis.labelFont = [UIFont fontWithName:@"HelveticaNeue-Light" size:10];
    yAxis.axisMinimum = 0.0;
    yAxis.spaceTop = 0.3;
    yAxis.spaceBottom = 0.4;
    
    
    self.chartView.rightAxis.enabled = NO;
    self.chartView.maxVisibleCount = 200;
    
    
    [self loadData];
}


- (void)loadData {
    int count = 45;
    double range = 100;
    NSMutableArray *value1 = [[NSMutableArray alloc] init];
    NSMutableArray *value2 = [[NSMutableArray alloc] init];
    NSMutableArray *value3 = [[NSMutableArray alloc] init];
    
    
    for (int i = 0; i < count; i ++) {
        double val = arc4random_uniform(range);
        double size = arc4random_uniform(range);
        
        [value1 addObject:[[BubbleChartDataEntry alloc] initWithX:i y:val size:size]];
        
        val = arc4random_uniform(range);
        size = arc4random_uniform(range);
        [value2 addObject:[[BubbleChartDataEntry alloc] initWithX:i y:val size:size]];
     
        val = arc4random_uniform(range);
        size = arc4random_uniform(range);
        [value3 addObject:[[BubbleChartDataEntry alloc] initWithX:i y:val size:size]];
    }
    
    BubbleChartDataSet *set1 = [[BubbleChartDataSet alloc] initWithValues:value1 label:@"DS 1"];
    [set1 setColor:ChartColorTemplates.colorful[0] alpha:0.50f];
    set1.drawValuesEnabled = YES;
    
    
    BubbleChartDataSet *set2 = [[BubbleChartDataSet alloc] initWithValues:value2 label:@"DS 2"];
    [set2 setColor:ChartColorTemplates.colorful[1] alpha:0.50f];
    set2.drawValuesEnabled = YES;

    BubbleChartDataSet *set3 = [[BubbleChartDataSet alloc] initWithValues:value3 label:@"DS 3"];
    [set3 setColor:ChartColorTemplates.colorful[2] alpha:0.50f];
    set3.drawValuesEnabled = YES;

    NSMutableArray *dataSets = [[NSMutableArray alloc] init];
    [dataSets addObject:set1];
    [dataSets addObject:set2];
    [dataSets addObject:set3];
    
    
    BubbleChartData *data = [[BubbleChartData alloc] initWithDataSets:dataSets];
    [data setDrawValues:NO];
    [data setValueFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:7.f]];
    [data setHighlightCircleWidth: 1.5];
    [data setValueTextColor:UIColor.whiteColor];
    
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
