//
//  LoadViewExampleViewController.m
//  FSCalendar
//
//  Created by DingWenchao on 6/25/15.
//  Copyright (c) 2015 =. All rights reserved.
//

#import "LoadViewExampleViewController.h"
#import "NSDate+FSExtension.h"
#import "FSCalendarTestMacros.h"

@implementation LoadViewExampleViewController

- (void)dealloc
{
    NSLog(@"%@:%s", self.class.description, __FUNCTION__);
}

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
    UIView *view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    view.backgroundColor = [UIColor colorWithRed:.95 green:.95 blue:.95 alpha:1.0];
    self.view = view;
    
    // 450 for iPad and 300 for iPhone
    CGFloat height = [[UIDevice currentDevice].model hasPrefix:@"iPad"] ? 450 : 300;
    FSCalendar *calendar = [[FSCalendar alloc] initWithFrame:CGRectMake(0, 64, view.frame.size.width, height)];
    calendar.dataSource = self;
    calendar.delegate = self;
    calendar.scrollDirection = FSCalendarScrollDirectionVertical;
//    calendar.scrollEnabled = NO;
//    calendar.scope = FSCalendarScopeWeek;
    [calendar selectDate:[NSDate fs_dateWithYear:2015 month:2 day:1]];
    calendar.backgroundColor = [UIColor whiteColor];
    [view addSubview:calendar];
    self.calendar = calendar;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
#if 0
    FSCalendarTestSelectDate
#endif
    
}

- (BOOL)calendar:(FSCalendar *)calendar shouldSelectDate:(NSDate *)date
{
    NSLog(@"should select date %@",[date fs_stringWithFormat:@"yyyy/MM/dd"]);
    return YES;
}

- (void)calendar:(FSCalendar *)calendar didSelectDate:(NSDate *)date
{
    NSLog(@"did select date %@",[date fs_stringWithFormat:@"yyyy/MM/dd"]);
}

- (void)calendarCurrentPageDidChange:(FSCalendar *)calendar
{
    NSLog(@"did change to page %@",[calendar.currentPage fs_stringWithFormat:@"MMMM yyyy"]);
}

//- (void)calendarCurrentScopeWillChange:(FSCalendar *)calendar animated:(BOOL)animated
//{
//    calendar.frame = CGRectMake(0, 64, self.view.bounds.size.width, [calendar sizeThatFits:CGSizeZero].height);
//}

//- (NSDate *)minimumDateForCalendar:(FSCalendar *)calendar
//{
//    return [NSDate fs_dateWithYear:2015 month:1 day:1];
//}
//
//- (NSDate *)maximumDateForCalendar:(FSCalendar *)calendar
//{
//    return [NSDate fs_dateWithYear:2015 month:10 day:31];
//}

- (UIImage *)calendar:(FSCalendar *)calendar imageForDate:(NSDate *)date
{
    if (date.fs_day == 5) {
        return [UIImage imageNamed:@"icon_footprint"];
    }
    if (date.fs_day == 10 || date.fs_day == 15) {
        return [UIImage imageNamed:@"icon_cat"];
    }
    return nil;
}

@end
