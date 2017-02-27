//
//  WZPiePolylineChartViewController.m
//  ImportCharts
//
//  Created by songbiwen on 2017/2/23.
//  Copyright © 2017年 songbiwen. All rights reserved.
//

#import "WZPiePolylineChartViewController.h"
#import "ImportCharts-Bridging-Header.h"

@interface WZPiePolylineChartViewController ()
<ChartViewDelegate>

@property (weak, nonatomic) IBOutlet PieChartView *pieChartView;
@end

@implementation WZPiePolylineChartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"Pie Bar Chart";
    
    self.pieChartView.delegate = self;
    self.pieChartView.chartDescription.enabled = NO;
    self.pieChartView.legend.enabled = NO;
    
    [self loadData];
}


- (void)loadData {
    double mult = 100;
    NSMutableArray *values = [[NSMutableArray alloc] init];
    for (int i = 0; i < 4; i ++) {
        [values addObject:[[PieChartDataEntry alloc] initWithValue:arc4random_uniform(mult) + mult / 5 label:[NSString stringWithFormat:@"%d",i]]];
    }
    
    PieChartDataSet *set1 = [[PieChartDataSet alloc] initWithValues:values];
    set1.sliceSpace = 2.0;
    
    
    NSMutableArray *colors = [[NSMutableArray alloc] init];
    [colors addObjectsFromArray:ChartColorTemplates.liberty];
    [colors addObjectsFromArray:ChartColorTemplates.joyful];
    [colors addObjectsFromArray:ChartColorTemplates.pastel];
    [colors addObjectsFromArray:ChartColorTemplates.colorful];
    [colors addObjectsFromArray:ChartColorTemplates.vordiplom];
    [colors addObject:[UIColor colorWithRed:51/255.f green:181/255.f blue:229/255.f alpha:1.f]];
    
    [set1 setColors:colors];
    
    
    set1.valueLinePart1OffsetPercentage = 0.8;
    set1.valueLinePart1Length = 0.2;
    set1.valueLinePart2Length = 0.4;
    set1.yValuePosition = PieChartValuePositionOutsideSlice;
    
    
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.numberStyle = NSNumberFormatterPercentStyle;
    formatter.maximumFractionDigits = 1;
    formatter.multiplier = @1.0;
    formatter.percentSymbol = @" %";
    
    
    PieChartData *data = [[PieChartData alloc] initWithDataSet:set1];
    [data setValueFormatter:[[ChartDefaultValueFormatter alloc] initWithFormatter:formatter]];
    [data setValueTextColor:[UIColor blackColor]];
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
