    //
//  ViewController.m
//  2ndHand
//
//  Created by Yuval on 6/16/16.
//  Copyright © 2016 itmatters. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic) NSMutableArray *categoryArray;

@end

@implementation ViewController
{
   }


- (void)viewDidLoad {
    [super viewDidLoad];
    self.listTableView.dataSource = self;
    self.listTableView.delegate = self;
    
    // Do any additional setup after loading the view, typically from a nib.
    /* {
     // Call web service with no parameters
        NSURL *wsURL = [NSURL URLWithString:@"http://192.168.1.108/2ndhand/getcategories.php"];
         NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
         [request setURL:wsURL];
         [[[NSURLSession sharedSession]
                                              dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                              
                                                  if (error) {
                                                      NSLog(@"ERROR:%@", [error localizedDescription]);
                                                  } else {
                                                  // 4: Handle response here
                                                 
                                                  NSError *err = nil;
                                                  
                                                      NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                                                      NSLog(@"Response string is %@",responseString);
                                                   self.categoryArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&err];
                                                  
                                                     [self.listTableView reloadData];
                                                  }
                                              } ]resume];
    }*/
   
    /*
    {
        // call web service with Post data in the body
        NSURL *wsURL = [NSURL URLWithString:@"https://192.168.1.108/secure/getsubcategory.php"];
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        
        
        int categoryID = 8;
        NSString *post = [NSString stringWithFormat:@"CategoryId=%lu",(unsigned long)categoryID];
        
       NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
       NSString *postLength = [NSString stringWithFormat:@"%lu",(unsigned long)[postData length]];

        [request setURL:wsURL];
        [request setHTTPMethod:@"POST"];

        [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
        [request setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];

        [request setHTTPBody:postData];

        [[[NSURLSession sharedSession]
          dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
              
              if ([data length] >0 && error == nil) {
                  NSError *err = nil;
                  
                  NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                  NSLog(@"Response string is %@",responseString);
                  self.categoryArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&err];
                  
                  [self.listTableView reloadData];
              }
              else if ([data length] == 0 && error == nil) {
                  NSLog(@"Empty Response. Check your credentials.");
              }
              else if (error != nil) {
                  NSLog(@"Error = %@", error);
              }
              
              
              
          } ]resume];
    }*/
    {
        // HTTPS call, changed shareSession to sessionWithConfiguration , and also implemented didReceiveChallenge in the
        //  NSURLSessionDelegate protocol which was now added to the ViewController . This is necessary because
        // the SSL certificate used is self-signed and so we have to intervene in method didReceiveChallenge
        // call web service with Post data in the body
        NSURL *wsURL = [NSURL URLWithString:@"https://192.168.1.108/secure/getsubcategory.php"];
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        
        
        int categoryID = 9;
        NSString *post = [NSString stringWithFormat:@"CategoryId=%lu",(unsigned long)categoryID];
        
        NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
        NSString *postLength = [NSString stringWithFormat:@"%lu",(unsigned long)[postData length]];
        
        [request setURL:wsURL];
        [request setHTTPMethod:@"POST"];
        
        [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
        [request setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
        
        [request setHTTPBody:postData];
        
        NSURLSession *myUrlSession = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:nil];
        
        [[myUrlSession
          dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
              
              if ([data length] >0 && error == nil) {
                  NSError *err = nil;
                  
                  NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                  NSLog(@"Response string is %@",responseString);
                  self.categoryArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&err];
                  
                  [self.listTableView reloadData];
              }
              else if ([data length] == 0 && error == nil) {
                  NSLog(@"Empty Response. Check your credentials.");
              }
              else if (error != nil) {
                  NSLog(@"Error = %@", error);
              }
              
              
              
          } ]resume];
    }
}


- (void)URLSession:(NSURLSession *)session didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential *))completionHandler{
    if([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]){
        if([challenge.protectionSpace.host isEqualToString:@"192.168.1.108"]){
            NSURLCredential *credential = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];
            completionHandler(NSURLSessionAuthChallengeUseCredential,credential);
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.categoryArray.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *basicCell = @"BasicCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:basicCell];

    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:basicCell];
    }
    //cell.textLabel.text = [tableData objectAtIndex:indexPath.row];
    cell.textLabel.text = [[self.categoryArray objectAtIndex:indexPath.row] objectForKey:@"value"];
    return cell;
}



@end
