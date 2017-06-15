//
//  BHJMultistageTableViewController.m
//  FreeNetApp
//
//  Created by 白华君 on 2016/11/29.
//  Copyright © 2016年 BHJ. All rights reserved.
//

#import "BHJMultistageTableViewController.h"
#import "EvaluationCell.h"

static NSString *kheader = @"menuSectionHeader";
static NSString *ksubSection = @"menuSubSection";

@interface BHJMultistageTableViewController ()

@property NSArray *sections;
@property (strong, nonatomic) NSMutableArray *sectionsArray;
@property (strong, nonatomic) NSMutableArray *showingArray;

@end

@implementation BHJMultistageTableViewController
@synthesize delegate;

- (id)initWithMenuSections:(NSArray *) menuSections
{
    self = [super init];
    if (self) {
        self.sections = menuSections;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.backgroundColor = [UIColor  whiteColor];
    
    self.tableView.frame = self.view.frame;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"EvaluationCell" bundle:nil] forCellReuseIdentifier:@"EvaluationCell"];
    
    self.sectionsArray = [NSMutableArray new];
    self.showingArray = [NSMutableArray new];
    [self setMenuSections:self.sections];
    
}

- (void)setMenuSections:(NSArray *)menuSections{
    
    for (NSDictionary *sec in menuSections) {
        
        NSString *header = [sec objectForKey:kheader];
        NSArray *subSection = [sec objectForKey:ksubSection];
        
        NSMutableArray *section = [NSMutableArray new];
        [section addObject:header];
        
        for (NSString *sub in subSection) {
            [section addObject:sub];
        }
        [self.sectionsArray addObject:section];
        [self.showingArray addObject:[NSNumber numberWithBool:NO]];
    }
    [self.tableView reloadData];
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return [self.sectionsArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if (![[self.showingArray objectAtIndex:section]boolValue]) {
        return 1;
    }
    else{
        return [[self.sectionsArray objectAtIndex:section]count];;
    }
}


- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(indexPath.row ==0){
        if([[self.showingArray objectAtIndex:indexPath.section]boolValue]){
            [cell setBackgroundColor:[UIColor whiteColor]];
        }else{
            [cell setBackgroundColor:[UIColor clearColor]];
        }
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    EvaluationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"EvaluationCell" forIndexPath:indexPath];
    cell.titleLabel.text = [[self.sectionsArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    if (indexPath.section == 0) {
        cell.rightBtn.hidden = YES;
    }else{
        cell.rightBtn.hidden = NO;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if([[self.showingArray objectAtIndex:indexPath.section]boolValue]){
        [self.showingArray setObject:[NSNumber numberWithBool:NO] atIndexedSubscript:indexPath.section];
    }else{
        [self.showingArray setObject:[NSNumber numberWithBool:YES] atIndexedSubscript:indexPath.section];
    }
    [tableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationFade];
    
    [self.delegate didSelectRowAtIndexPath:indexPath];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{

    return kScreenHeight / 10;
}



/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
