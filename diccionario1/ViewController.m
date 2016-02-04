//
//  ViewController.m
//  diccionario1
//
//  Created by Leonardo Talero on 11/16/15.
//  Copyright © 2015 unir. All rights reserved.
//

#import "ViewController.h"
#import "TableCell.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UITextView *textview;

@property (strong, nonatomic) NSArray *searchResults;
@property (strong, nonatomic) NSArray *keys;
@property (strong, nonatomic) NSArray *objetos;
@property (strong, nonatomic) NSArray *keys2;
@property (strong, nonatomic) NSArray *objetos2;
@property (strong, nonatomic) NSArray *keysAndValues;
@property (strong, nonatomic) UISearchController *searchController;
@property(nonatomic) NSInteger *selectedScopeButtonIndex;
@property(nonatomic) NSInteger *scopeselected;
@property (strong, nonatomic) NSArray * sortedKeys;
@end

@implementation ViewController
- (IBAction)boton:(UIButton *)sender {
}

NSArray* lines;



NSMutableDictionary* diccionario;

NSMutableDictionary* diccionario2;

- (void)viewDidLoad {
    
    [super viewDidLoad];
   diccionario=[NSMutableDictionary new];
    diccionario2=[NSMutableDictionary new];
    NSString* path = [[NSBundle mainBundle] pathForResource:@"diccionario"
                                                     ofType:@"txt"];
    NSString* file_contents=[NSString stringWithContentsOfFile:path  encoding:NSUTF8StringEncoding error:nil];
    lines=[file_contents componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
    _textview.text=file_contents;
    for(NSString* line in lines){
        NSArray* par=[line componentsSeparatedByString:@":"];
        if([par count]!=2){
            continue;
        }else{
            [diccionario setObject:par[1] forKey:par[0]];
            [diccionario2 setObject:par[0] forKey:par[1]];

        }
        
    }
self.keys = [diccionario allKeys];
self.objetos = [diccionario allValues];
self.keys2 = [diccionario2 allKeys];
 self.objetos2 = [diccionario2 allValues];
self.searchResults=[[NSArray alloc]init];
self.keysAndValues=[self.keys arrayByAddingObjectsFromArray:self.objetos];
self.sortedKeys = [[diccionario allKeys] sortedArrayUsingSelector: @selector(caseInsensitiveCompare:)];

    
    
    
    
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)tableView:(UITableView *)tabla numberOfRowsInSection:(NSInteger)section {
    // Number of rows is the number of time zones in the region for the specified section.
    
    if(tabla==self.searchDisplayController.searchResultsTableView){
        //return [self.searchResults count];
        NSInteger numero=[self.searchResults count];
       
        return numero;
    }else{
         //  return [self.keysAndValues count];
       
        return [self.sortedKeys count];
    }
   
}


- (NSString *)tableView:(UITableView *)tabla titleForHeaderInSection:(NSInteger)section {
   
    return @"Resultados";
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //UITableViewCell *cell;
    static NSString *MyIdentifier = @"celda";
  //  UITableViewCell *cell = [tableView  dequeueReusableCellWithIdentifier:MyIdentifier forIndexPath:indexPath];
       TableCell *cellcustom = [self.myTableView  dequeueReusableCellWithIdentifier:MyIdentifier ];
  
    
    if (cellcustom == nil) {
        cellcustom = [[TableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyIdentifier];
        
    }
   
    
    if(tableView==self.searchDisplayController.searchResultsTableView){
       // cell.textLabel.text=[self.keysAndValues  objectAtIndex:indexPath.row] ;
       //  cell.detailTextLabel.text=[self.keysAndValues  objectAtIndex:indexPath.row] ;
       
       // cell.detailTextLabel.text=[[self.keysAndValues  objectAtIndex:indexPath.row]  objectForKey:@"value"];
        if(self.scopeselected==0){
            NSString * key = self.searchResults[indexPath.row];
            NSString * value = diccionario[key];
            cellcustom.labelizquierda.text=key;
            cellcustom.labelderecha.text=value;
            
        }else {
            NSString * key = self.searchResults[indexPath.row];
            NSString * value = diccionario2[key];
            cellcustom.labelizquierda.text=key;
            cellcustom.labelderecha.text=value;

            
        }
    }else{
        NSString * key = self.sortedKeys[indexPath.row];
        NSString * value = diccionario[key];
        
        cellcustom.labelizquierda.text=key;
        cellcustom.labelderecha.text=value;
       // cell.textLabel.text=[self.keysAndValues objectAtIndex:indexPath.row];
        // cell.detailTextLabel.text=@"subdasd";
        //cell.detailTextLabel.text=[[self.keysAndValues  objectAtIndex:indexPath.row]  objectForKey:@"value"];
    }
    return cellcustom;
   
}

-(void) filterContentForSearchText:(NSString *)searchtext scope:(NSString *)scope{
    
    NSPredicate *predicate=[NSPredicate predicateWithFormat:@"SELF beginswith[c] %@",searchtext];
    
    if(self.scopeselected==0){
        self.searchResults=[self.keys filteredArrayUsingPredicate:predicate];

    }else {
       self.searchResults=[self.keys2 filteredArrayUsingPredicate:predicate];

}
    
}



-(BOOL) searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString scope:[[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
  
    return YES;
     
}

- (void)searchBar:(UISearchBar *)searchBar
selectedScopeButtonIndexDidChange:(NSInteger)selectedScope{
 // NSInteger boton= searchBar.selectedScopeButtonIndex;
    
     self.scopeselected= searchBar.selectedScopeButtonIndex;
    

}





@end
