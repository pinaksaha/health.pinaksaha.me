//
//  HeartRateHomeViewController.m
//  healthio
//
//  Created by Pinak Saha on 4/17/14.
//  Copyright (c) 2014 Pinak Saha. All rights reserved.
//

#import "HeartRateHomeViewController.h"
#import "PSUSER.h"
#import "PSDBManager.h"
#import "PSUserHeartrate.h"
#import "PSHeartRateViewController.h"
#import "SHLineGraphView.h"
#import "SHPlot.h"


@interface HeartRateHomeViewController () <UITableViewDataSource, UITableViewDelegate>

@end

@implementation HeartRateHomeViewController

@synthesize  db, user;

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"addHeartRateSegue"]) {
        // pass user object to home vc
        PSHeartRateViewController *homeVC = (PSHeartRateViewController *)segue.destinationViewController;
        homeVC.user = user;
        homeVC.db = db;
    }
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.HeartRateData.text = user.username;
    [user.heartRates removeAllObjects];
    [db getHeartRateByUserid:user];
   
    
    
    SHLineGraphView *_lineGraph = [[SHLineGraphView alloc] initWithFrame:CGRectMake(0, 0, 300, 300)];
    NSDictionary *_themeAttributes = @{
                                       kXAxisLabelColorKey : [UIColor colorWithRed:0.48 green:0.48 blue:0.49 alpha:0.4],
                                       kXAxisLabelFontKey : [UIFont fontWithName:@"TrebuchetMS" size:10],
                                       kYAxisLabelColorKey : [UIColor colorWithRed:0.48 green:0.48 blue:0.49 alpha:0.4],
                                       kYAxisLabelFontKey : [UIFont fontWithName:@"TrebuchetMS" size:10],
                                       kYAxisLabelSideMarginsKey : @20,
                                       kPlotBackgroundLineColorKye : [UIColor colorWithRed:0.48 green:0.48 blue:0.49 alpha:0.4]
                                       };
    _lineGraph.themeAttributes = _themeAttributes;
    _lineGraph.yAxisRange = @(500);
    _lineGraph.yAxisSuffix = @"bpm";
    _lineGraph.xAxisValues = @[
                               @{ @1 : @"1" },
                               @{ @2 : @"2" },
                               @{ @3 : @"3" },
                               @{ @4 : @"4" },
                               @{ @5 : @"5" },
                               @{ @6 : @"6" },
                               @{ @7 : @"7" }
                            
                               ];
    SHPlot *_plot1 = [[SHPlot alloc] init];
    
    int size = [user.heartRates count];
    
    PSUserHeartrate* valu0 = [user.heartRates objectAtIndex:size-1];
    NSNumber *heartRate0 = [NSNumber numberWithInteger:valu0.bmp];
    
    PSUserHeartrate* valu1 = [user.heartRates objectAtIndex:size-2];
    NSNumber *heartRate1 = [NSNumber numberWithInteger:valu1.bmp];
    
    PSUserHeartrate* valu2 = [user.heartRates objectAtIndex:size-3];
    NSNumber *heartRate2 = [NSNumber numberWithInteger:valu2.bmp];
    
    PSUserHeartrate* valu3 = [user.heartRates objectAtIndex:size-4];
    NSNumber *heartRate3 = [NSNumber numberWithInteger:valu3.bmp];
    
    PSUserHeartrate*  valu4 = [user.heartRates objectAtIndex:size-5];
    NSNumber *heartRate4 = [NSNumber numberWithInteger:valu4.bmp];
    
    PSUserHeartrate*  valu5 = [user.heartRates objectAtIndex:size-6];
    NSNumber *heartRate5 = [NSNumber numberWithInteger:valu5.bmp];
    
    PSUserHeartrate*  valu6 = [user.heartRates objectAtIndex:size-7];
    NSNumber *heartRate6 = [NSNumber numberWithInteger:valu6.bmp];
    
    _plot1.plottingValues = @[
                              @{ @1 : heartRate0 },
                              @{ @2 : heartRate1  },
                              @{ @3 : heartRate2 },
                              @{ @4 : heartRate3  },
                              @{ @5 : heartRate4  },
                              @{ @6 : heartRate5 },
                              @{ @7 : heartRate6  }
                             
                              ];
    NSArray *arr = @[@"1", @"2", @"3", @"4", @"5", @"6" , @"7" ];
    _plot1.plottingPointsLabels = arr;
    NSDictionary *_plotThemeAttributes = @{
                                          kPlotFillColorKey : [UIColor colorWithRed:0.47 green:0.75 blue:0.78 alpha:0.5],
                                          kPlotStrokeWidthKey : @2,
                                          kPlotStrokeColorKey : [UIColor colorWithRed:0.18 green:0.36 blue:0.41 alpha:1],
                                          kPlotPointFillColorKey : [UIColor colorWithRed:0.18 green:0.36 blue:0.41 alpha:1],
                                          kPlotPointValueFontKey : [UIFont fontWithName:@"TrebuchetMS" size:18]
                                          };
    
    _plot1.plotThemeAttributes = _plotThemeAttributes;
    [_lineGraph addPlot:_plot1];
    
    //You can as much `SHPlots` as you can in a `SHLineGraphView`
    
    [_lineGraph setupTheView];
    
    [self.view addSubview:_lineGraph];
    
   
    //For showing values we have in array
    
    for (PSUserHeartrate *tempObject in user.heartRates) {
        NSLog(@"Single element: %i", tempObject.bmp);
    }





}

- (void)viewWillAppear:(BOOL)animated
{
    [user.heartRates removeAllObjects];
    [db getHeartRateByUserid:user];
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableView Data Source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [user.heartRates count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"HeartRateCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    PSUserHeartrate *heartrate = user.heartRates[indexPath.row];
    [cell.detailTextLabel setText:heartrate.createdAt];
    [cell.textLabel setText:[NSString stringWithFormat:@"%ld", (long)heartrate.bmp]];
    
    return cell;
}

- (IBAction)makeNewEntry:(id)sender
{
    [self performSegueWithIdentifier:@"addHeartRateSegue" sender:user];
}
@end
