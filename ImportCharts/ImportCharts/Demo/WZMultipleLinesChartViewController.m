//
//  WZMultipleLinesChartViewController.m
//  ImportCharts
//
//  Created by songbiwen on 2017/2/27.
//  Copyright © 2017年 songbiwen. All rights reserved.
//

#import "WZMultipleLinesChartViewController.h"
#import "ImportCharts-Bridging-Header.h"

@interface WZMultipleLinesChartViewController ()
<ChartViewDelegate>

@property (weak, nonatomic) IBOutlet LineChartView *lineChartView;
@end

@implementation WZMultipleLinesChartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.lineChartView.delegate = self;
    self.lineChartView.chartDescription.enabled = NO;
    self.lineChartView.drawGridBackgroundEnabled = NO;
    self.lineChartView.pinchZoomEnabled = NO;
    self.lineChartView.dragEnabled = YES;
    self.lineChartView.drawBordersEnabled = NO;
    
    ChartLegend *legend = self.lineChartView.legend;
    legend.horizontalAlignment = ChartLegendHorizontalAlignmentRight;
    legend.verticalAlignment = ChartLegendVerticalAlignmentTop;
    legend.orientation = ChartLegendOrientationVertical;
    legend.drawInside = NO;
    
    ChartXAxis *xAxis = self.lineChartView.xAxis;
    xAxis.labelPosition = XAxisLabelPositionTop;
    xAxis.drawGridLinesEnabled = NO;
    xAxis.drawAxisLineEnabled = NO;
    xAxis.axisMinimum = 0;
    xAxis.axisMaximum = 30;
    
    
    self.lineChartView.leftAxis.enabled = NO;
    
    
    ChartYAxis *rightAxis = self.lineChartView.rightAxis;
    rightAxis.axisMinimum = 0;
    rightAxis.axisMaximum = 110;
    rightAxis.drawAxisLineEnabled = NO;
    rightAxis.drawGridLinesEnabled = NO;
    
    
    [self loadData];
}

- (void)loadData {
    
    int count = 20;
    double range = 100;
    NSArray *colors = @[ChartColorTemplates.vordiplom[0], ChartColorTemplates.vordiplom[1], ChartColorTemplates.vordiplom[2]];
    
    NSMutableArray *dataSets = [[NSMutableArray alloc] init];
    
    for (int z = 0; z < 3; z++)
    {
        NSMutableArray *values = [[NSMutableArray alloc] init];
        
        for (int i = 0; i < count; i++)
        {
            double val = (double) (arc4random_uniform(range) + 3);
            [values addObject:[[ChartDataEntry alloc] initWithX:i y:val]];
        }
        
        LineChartDataSet *d = [[LineChartDataSet alloc] initWithValues:values label:[NSString stringWithFormat:@"DataSet %d", z + 1]];
        d.lineWidth = 2.5;
        d.circleRadius = 4.0;
        d.circleHoleRadius = 2.0;
        
        UIColor *color = colors[z % colors.count];
        [d setColor:color];
        [d setCircleColor:color];
        [dataSets addObject:d];
    }
    
    ((LineChartDataSet *)dataSets[0]).lineDashLengths = @[@5.f, @5.f];
    ((LineChartDataSet *)dataSets[0]).colors = ChartColorTemplates.vordiplom;
    ((LineChartDataSet *)dataSets[0]).circleColors = ChartColorTemplates.vordiplom;
    
    LineChartData *data = [[LineChartData alloc] initWithDataSets:dataSets];
    [data setValueFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:7.f]];
    self.lineChartView.data = data;
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
