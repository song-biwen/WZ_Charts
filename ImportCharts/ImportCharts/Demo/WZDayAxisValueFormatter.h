//
//  WZDayAxisValueFormatter.h
//  ImportCharts
//
//  Created by songbiwen on 2017/2/23.
//  Copyright © 2017年 songbiwen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ImportCharts-Bridging-Header.h"

@interface WZDayAxisValueFormatter : NSObject
<IChartAxisValueFormatter>

- (id)initForChart:(BarLineChartViewBase *)chart;
@end
