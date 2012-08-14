//
//  AWFetchedResultsTableController.m
//  iPhoneMarkItDone
//
//  Created by Artur Wdowiarski on 8/4/12.
//
//

#import "AWToDoListFetchedResultsTableController.h"
#import "AWCoolHeader.h"
#import "AWCoolFooter.h"

@implementation AWToDoListFetchedResultsTableController

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return @"";
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    AWCoolHeader *header = [[AWCoolHeader alloc] init];
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
    return 50;
}

@end
