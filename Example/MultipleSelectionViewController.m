//
//  MultipleSelectionViewController.m
//  FSCalendar
//
//  Created by dingwenchao on 9/9/15.
//  Copyright (c) 2015 wenchaoios. All rights reserved.
//

#import "MultipleSelectionViewController.h"
#import "FSCalendarTestMacros.h"

@interface MultipleSelectionViewController () <FSCalendarDelegateAppearance>

@end

@implementation MultipleSelectionViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.title = @"FSCalendar";
    }
    return self;
}

- (void)loadView
{
    UIView *view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    view.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1.0];
    self.view = view;
    
    CGFloat height = [[UIDevice currentDevice].model hasPrefix:@"iPad"] ? 450 : 300;
    FSCalendar *calendar = [[FSCalendar alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.navigationController.navigationBar.frame), view.bounds.size.width, height)];
    calendar.dataSource = self;
    calendar.delegate = self;
    calendar.backgroundColor = [UIColor whiteColor];
    calendar.allowsMultipleSelection = YES;
    [self.view addSubview:calendar];
    self.calendar = calendar;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [_calendar selectDate:[[NSDate date] fs_dateByAddingDays:1]];
    
#if 0
    FSCalendarTestSelectDate
#endif
}

- (BOOL)calendar:(FSCalendar *)calendar shouldSelectDate:(NSDate *)date
{
    BOOL shouldDedeselect = date.fs_day != 5;
    if (!shouldDedeselect) {
        [[[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"Forbidden date %@ to be selected",date.fs_string] message:@"" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
        return NO;
    }
    return YES;
}

- (BOOL)calendar:(FSCalendar *)calendar shouldDeselectDate:(NSDate *)date
{
    BOOL shouldDedeselect = date.fs_day != 7;
    if (!shouldDedeselect) {
        [[[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"Forbidden date %@ to be deselected",date.fs_string] message:@"" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
        return NO;
    }
    return YES;
}

- (void)calendar:(FSCalendar *)calendar didSelectDate:(NSDate *)date
{
    NSMutableArray *selectedDates = [NSMutableArray arrayWithCapacity:calendar.selectedDates.count];
    [calendar.selectedDates enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [selectedDates addObject:[obj fs_stringWithFormat:@"yyyy/MM/dd"]];
    }];
    NSLog(@"selected dates is %@",selectedDates);
}

- (void)calendar:(FSCalendar *)calendar didDeselectDate:(NSDate *)date
{
    NSMutableArray *selectedDates = [NSMutableArray arrayWithCapacity:calendar.selectedDates.count];
    [calendar.selectedDates enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [selectedDates addObject:[obj fs_stringWithFormat:@"yyyy/MM/dd"]];
    }];
    NSLog(@"selected dates is %@",selectedDates);
}

- (UIColor *)calendar:(FSCalendar *)calendar appearance:(FSCalendarAppearance *)appearance selectionColorForDate:(NSDate *)date
{
    if (date.fs_day % 2 == 0) {
        return appearance.selectionColor;
    }
    return [UIColor purpleColor];
}

- (UIColor *)calendar:(FSCalendar *)calendar appearance:(FSCalendarAppearance *)appearance borderDefaultColorForDate:(NSDate *)date
{
    if (date.fs_day == 17 || date.fs_day == 18 || date.fs_day == 19) {
        return [UIColor magentaColor];
    }
    return appearance.borderDefaultColor;
}

@end
