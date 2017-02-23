//
//  WZPieChartViewController.m
//  ImportCharts
//
//  Created by songbiwen on 2017/2/23.
//  Copyright © 2017年 songbiwen. All rights reserved.
//

#import "WZPieChartViewController.h"
#import "ImportCharts-Bridging-Header.h"

@interface WZPieChartViewController ()
<ChartViewDelegate>

@property (weak, nonatomic) IBOutlet PieChartView *pieChartView;
@end

@implementation WZPieChartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Pie Chart";
    
    self.pieChartView.delegate = self;
    self.pieChartView.chartDescription.enabled = NO;
    
    
    ChartLegend *legend = self.pieChartView.legend;
    legend.horizontalAlignment = ChartLegendHorizontalAlignmentRight;
    legend.verticalAlignment = ChartLegendVerticalAlignmentTop;
    legend.orientation = ChartLegendOrientationVertical;
    legend.drawInside = NO;
    legend.xEntrySpace = 7.0;
    legend.yEntrySpace = 0.0;
    legend.yOffset = 0.0;
    
    
    self.pieChartView.entryLabelColor = [UIColor whiteColor];
    self.pieChartView.entryLabelFont = [UIFont fontWithName:@"HelveticaNeue-Light" size:12];
    
//    NSMutableArray *values = [[NSMutableArray alloc] init];
//    
//    for (int i = 1; i <= 10; i ++) {
//        [values addObject:[[PieChartDataEntry alloc] initWithValue:i]];
//    }
//    PieChartDataSet *set1 = [[PieChartDataSet alloc] initWithValues:values];
//    [set1 setColors:ChartColorTemplates.material];
//    PieChartData *data = [[PieChartData alloc] initWithDataSet:set1];
//    self.pieChartView.data = data;
    
    [self loadData];
}

- (void)loadData {
    NSMutableArray *values = [[NSMutableArray alloc] init];
    double mult = 100;
    for (int i = 0; i < 4; i ++) {
        [values addObject:[[PieChartDataEntry alloc] initWithValue:arc4random_uniform(mult) + mult / 5]];
    }
    
    PieChartDataSet *set1 = [[PieChartDataSet alloc] initWithValues:values];
    set1.drawIconsEnabled = NO;
    set1.sliceSpace = 2.0;
    set1.iconsOffset = CGPointMake(0, 40);
    
    
    NSMutableArray *colors = [[NSMutableArray alloc] init];
    [colors addObjectsFromArray:ChartColorTemplates.liberty];
    [colors addObjectsFromArray:ChartColorTemplates.joyful];
    [colors addObjectsFromArray:ChartColorTemplates.pastel];
    [colors addObjectsFromArray:ChartColorTemplates.colorful];
    [colors addObjectsFromArray:ChartColorTemplates.vordiplom];
    [colors addObjectsFromArray:ChartColorTemplates.material];
    [set1 setColors:colors];
    
    
    PieChartData *data = [[PieChartData alloc] initWithDataSet:set1];
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.numberStyle = NSNumberFormatterPercentStyle;
    formatter.maximumFractionDigits = 1;
    formatter.multiplier = @1.0;
    formatter.percentSymbol = @" %";
    [data setValueFormatter:[[ChartDefaultValueFormatter alloc] initWithFormatter:formatter]];
    [data setValueTextColor:[UIColor whiteColor]];
    [data setValueFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:11.f]];
    
    self.pieChartView.data = data;
    
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
