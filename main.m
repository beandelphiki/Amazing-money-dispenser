//
//  main.m
//  TellerMachine
//
//  Created by Orlando Medina on 1/12/16.
//

/*
The MIT License (MIT)

Copyright (c) 2016 Orlando Medina 

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
*/


/*
 Import the needed classes into the main function so we can start organizing the teller machine.
 */

#pragma mark Import the classes and needed functions
#import <Foundation/Foundation.h>
#import "TellerMachine.h"





/*
 Run the main application
 */
#pragma mark Main function for running the application.
int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        TellerMachine* LocalMachine = [[TellerMachine alloc]init];
#pragma mark Accept data from the command line — Complete
        
        while(TRUE){
            NSString* input = [[NSString alloc]init];
            //Extract the Data from the command line and stick it in an NSMutable Array
            NSFileHandle *fileHandle = [NSFileHandle fileHandleWithStandardInput];
            NSData *inputData;
            inputData = [fileHandle availableData];
            input = [[NSString alloc] initWithData: inputData encoding:NSASCIIStringEncoding];
            NSMutableArray *array = (NSMutableArray *)[input componentsSeparatedByString:@" "];
            [array filteredArrayUsingPredicate: [NSPredicate predicateWithFormat:@"SELF != ''"]];
            //Extraction complete.
            
            //Create separate instances so I can quit the program safely and feel free to modify data in the array.
            NSMutableArray* dataDenom = [[NSMutableArray alloc]initWithArray:array];
            NSMutableArray* dataWithdraw = [[NSMutableArray alloc]initWithArray:array];
            
            
            
            
            
            
            
            
            
            //Start processing the input
#pragma mark    Input processing — Complete
            for(int x=0; x<1; x++){
                //Set up my options statements
                    NSString* quit=@"Q";
                
                    NSString* pipe =@"|";
                
                    NSString* withdraw=@"W";
                
                    NSString* restock=@"R";
                
                
#pragma mark Sanitize the input — Complete
                    //Remove the whitespace and new lines.
                    NSString* extracted  = [[NSString alloc] initWithString: array[0]];
                    NSString* extractedString = [extracted stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
                
                //Is it time to quit?
                if ([extractedString isEqualToString:quit]) {
                    exit(0);
                }
                
#pragma mark Check the denominations of funds safely — Complete
               else if ([extractedString isEqualToString:pipe]) {
                    /* for (NSString* info in array) {
                       NSLog(@"Result = '%@'", info);
                   }*/
                   
                //Clean all the strings in the array and remove all the new lines and spaces so strings are equal or not.
                   for (int x = 0; x<dataDenom.count;x++)
                   {
                       NSString* cleanString= [dataDenom[x] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
                       
                       [dataDenom replaceObjectAtIndex:x withObject:cleanString];
                   }
                   
                   [LocalMachine TrayPhysicalCount:dataDenom];
                }
                
                
                
                
                
#pragma mark Withdraw funds
               else if ([extractedString isEqualToString:withdraw]){
                   NSLog(@"Withdrawing Funds");
                   
                   //Clean out the strings in the Mutable Array for sanitization before entry into the withdrawal function
                   for (int x = 0; x<dataWithdraw.count;x++)
                   {
                       NSString* cleanString= [dataWithdraw[x] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
                       
                       [dataWithdraw replaceObjectAtIndex:x withObject:cleanString];
                   }
                   
                   if ([dataWithdraw count]<=1){
                       NSLog(@"Invalid Command");
                       continue;
                   }
                   
                   
                   NSString* amount = [[NSString alloc]initWithString:dataWithdraw[1]];
                   if ([amount isEqualToString:@""]) {
                       NSLog(@"Invalid Command");
                       continue;
                   }
                   
                   
                   
                
                   else {
                       //Remove the dollar sign and produce a new string
                       NSCharacterSet *removeDollar = [NSCharacterSet characterSetWithCharactersInString:@"$"];
                       NSString* newAmt = [amount stringByTrimmingCharactersInSet:removeDollar];
                       
                       //Convert that string into an int.
                      // NSLog(@"Amount in String is: '%@'",newAmt);
                       int finalAmt = [newAmt intValue];
                       //NSLog(@"Amount in int is %d",finalAmt);
                       [LocalMachine withdrawFunds:finalAmt];
                   
                   }
                   
                   
                   
                   
               }
                
                
                
#pragma mark Restock the funds — Complete
                
               else if ([extractedString isEqualToString:restock]){
                   [LocalMachine RestockAll];
               }
                
                //If not, continue with processing.
                else{
                    NSLog(@"Invalid Command");
                    continue;
                }
            }
        }
    
        return 0;

        }
    }




