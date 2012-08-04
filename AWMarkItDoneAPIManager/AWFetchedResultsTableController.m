//
//  AWFetchedResultsTableController.m
//  iPhoneMarkItDone
//
//  Created by Artur Wdowiarski on 8/4/12.
//
//

#import "AWFetchedResultsTableController.h"
#import "AWCoolHeader.h"
#import "AWCoolFooter.h"

@implementation AWFetchedResultsTableController

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return @"";
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    AWCoolHeader *header = [[AWCoolHeader alloc] init];
    header.lightColor = [UIColor colorWithRed:0.0/255.0 green:123.0/255.0 blue:204.0/255.0 alpha:1.0];
    header.darkColor = [UIColor colorWithRed:0.0/255.0 green:123.0/255.0 blue:204.0/255.0 alpha:1.0];
    return header;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    AWCoolFooter *footer = [[AWCoolFooter alloc] init];
    return footer;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 15;
}

@end
