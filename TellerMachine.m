//
//  TellerMachine.m
//  TellerMachine
//
//  Created by Orlando Medina on 1/13/16.
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


#import "TellerMachine.h"

@implementation TellerMachine

#pragma mark Synthesize setters and getters using Foundation functions.
//Create our setters and getters.
@synthesize ones,fives,tens,twenties,fifties,hundreds,machineAmount;


#pragma mark Helper methods implementation
/*
 @Return: Initialize our Teller Machine class instance.
 */
- (id)init{
    self = [super init];
    
    if (self) {
  
        self.ones = 10;
        self.fives= 10;
        self.tens= 10;
        self.twenties = 10;
        self.fifties = 10;
        self.hundreds = 10;
        
        
        //Sum the amount of the tray total and put it into the overall machine amount
        self.machineAmount = self.tellerMachineTotalAmount;
    }
    return self;
}







#pragma mark Tray counting functions
/*
 @Return: Return the total of money denominations left in the machine based on a list of denominations presented.
 */
- (void)TrayPhysicalCount:(NSMutableArray*)denoms{
    int Ones=(int)self.ones;
    int Fives = (int)self.fives;
    int Tens = (int)self.tens;
    int Twenties = (int)self.twenties;
    int Fifties = (int)self.fifties;
    int Hundreds = (int)self.hundreds;
    
    
    for (NSString* entry in denoms ){
        if ([entry isEqualToString:@"|"]) {
            continue;
        }
        
       else if ([entry isEqualToString:@"$100"]) {
            NSLog(@"$100 - %d",Hundreds);
        }
        
        else if ([entry isEqualToString:@"$50"]) {
            NSLog(@"$50 - %d",Fifties);
        }
        
       else if ([entry isEqualToString:@"$20"]) {
            NSLog(@"$20 - %d",Twenties);
        }
        
       else if ([entry isEqualToString:@"$10"]) {
           NSLog(@"$10 - %d",Tens);
       }
        
       else if ([entry isEqualToString:@"$5"]) {
           NSLog(@"$5 - %d",Fives);
       }
        
       else if ([entry isEqualToString:@"$1"]) {
           NSLog(@"$1 - %d",Ones);
       }
       else{
           continue;
       }
    
    }


}














#pragma mark Withdrawal functions

/*
 @Return: Return true if you could withdraw the amount asked for by the user
 */
- (BOOL)withdrawFunds:(int)amount{
    
    //Progress counter to know how much we have left
    int progress = amount;
    
    
    //Smallest 10s number
    NSString* idenfitiedSmallest = [[NSString alloc]init];
    
    
    
    //If someone tries to pull out more than what's avaialble kick them out right away.
    int limit = [self tellerMachineTotalAmount];
    
    if ( amount > limit){
        NSLog(@"Insufficient Funds");
        return false;
      }
    
    

    

    while (progress !=0 ) {
        
        if(progress >99){
        
            //Calculate the amount of dollars we need to grab
            double amountNeeded =progress/100;
            int dollarsNeeded =(int) amountNeeded;//This is the intger value of the amount of dollars needed.
            
            
            
            if (dollarsNeeded <= self.hundreds){
                self.hundreds= self.hundreds-dollarsNeeded;
                
                //Calculate the amount of hundreds of dollars that were deducted
                int deductedHundreds = dollarsNeeded*100;
                
                //Remove that from the progress
                progress = progress-deductedHundreds;
            }
            
            else {
                NSLog(@"Insufficient Funds");
                return false;
            
            }
            
            
    }
        
        if(progress <99){
            
            int CurrentProgress = progress;
            
            //Divide out the options for the digits in the 10s (10,20,50)
            //Figure out which one of this is equal to 1 when you drop the decimal point.
            //After you figure that out deduct from that dollar amount.
            
            
            double divTens = CurrentProgress/10;
            double divTwenties = CurrentProgress/20;
            double divFifties = CurrentProgress/50;
            
            
           
            if ((int)divTens == 1) {
                
                idenfitiedSmallest = @"Tens";
                self.tens = self.tens - 1;
                progress = progress-10;
                
            }
            
            if ((int)divTwenties ==1) {
                
                idenfitiedSmallest = @"Twenties";
                self.twenties = self.twenties - 1;
                progress = progress-20;
                
            }
            
            if ((int)divFifties == 1) {
                
                
                
                self.fifties = self.fifties - 1;
                progress = progress-50;
                
            }
            
        }
        
        if(progress <9){
            
            
            
            
            int CurrentIntProgressOnes;
            CurrentIntProgressOnes = progress;
            
            if (progress >=5 ) {
                
                progress = progress -5;
                self.fives = self.fives - 1;
            }
            
            else {
                progress = progress -CurrentIntProgressOnes;
                self.ones = self.ones-CurrentIntProgressOnes;
            
            }
            
        
        }
        
    }
    NSLog(@"Success: Dispensed");
    [self tellerMachineTotal];
    return true;
}







#pragma mark Restocking functions
/*
 Restocks all the drawers to 10 of each denomination
 @Return: None
 */
- (void)RestockAll{
    
    //Call all the restocking functions and just refill all the money in all the trays.
    [self RestockHundreds];
    [self RestockFifties];
    [self RestockTwenties];
    [self RestockTens];
    [self RestockFives];
    [self RestockOnes];
}


/*
 Restocks the Ones drawer to 10
 @Return: None
 */
- (void)RestockOnes{
    int count = self.ones;
    if ( self.ones != 10) {
        int neededAmount = 10-count;
        int CompletedAmount = self.ones+neededAmount;
        self.ones = CompletedAmount;
    }
    
    NSLog(@"$1 - %d",self.ones);
}



/*
 Restocks the Fives drawer to 10
 @Return: None
 */
- (void)RestockFives{
    int count = self.fives;
    if ( self.fives != 10) {
        int neededAmount = 10-count;
        int CompletedAmount = self.fives+neededAmount;
        self.fives = CompletedAmount;
    }
    NSLog(@"$5 - %d",self.fives);

}




/*
 Restocks the Tens drawer to 10
 @Return: None
 */
- (void)RestockTens{
    
    int count = self.tens;
    if ( self.tens != 10) {
        int neededAmount = 10-count;
        int CompletedAmount = self.tens+neededAmount;
        self.tens = CompletedAmount;
    }
    NSLog(@"$10 - %d",self.tens);

}


/*
 Restocks the Twenties drawer to 10
 @Return: None
 */
- (void)RestockTwenties{
    int count = self.twenties;
    if ( self.twenties != 10) {
        int neededAmount = 10-count;
        int CompletedAmount = self.twenties+neededAmount;
        self.twenties = CompletedAmount;
    }
    NSLog(@"$20 - %d",self.twenties);

}

/*
 Restocks the Fifties drawer to 10
 @Return: None
 */
- (void)RestockFifties{

    int count = self.fifties;
    if ( self.fifties != 10) {
        int neededAmount = 10-count;
        int CompletedAmount = self.fifties+neededAmount;
        self.fifties = CompletedAmount;
    }
    NSLog(@"$50 - %d",self.fifties);


}


/*
 Restocks the Hundreds drawer to 10
 @Return: None
 */
- (void)RestockHundreds{
    int count = self.hundreds;
    if ( self.hundreds != 10) {
        int neededAmount = 10-count;
        int CompletedAmount = self.hundreds+neededAmount;
        self.hundreds = CompletedAmount;
    }
    NSLog(@"$100 - %d",self.hundreds);


}






#pragma mark Total cash functions

/*
 @Return: Return the amount of total cash items left in the entire machine
 */
- (BOOL)tellerMachineTotal{
    //Set a flag so we know what's happening by the end of this fxn.
    bool flag= true;
    
    //Grab the balance and cast to int from the NSUInteger type.
    NSLog(@"Machine Balance");
    
    //Output the values
     NSLog(@"$100 - %d",self.hundreds);
     NSLog(@"$50 - %d",self.fifties);
     NSLog(@"$20 - %d",self.twenties);
     NSLog(@"$10 - %d",self.tens);
     NSLog(@"$5 - %d",self.fives);
     NSLog(@"$1 - %d",self.ones);

    
    //If any of our amounts are less than 10 set the flag to false.
    if (self.ones < 5 || self.fives < 5 || self.tens < 5 || self.twenties < 5 || self.fifties < 5 || self.hundreds < 5){
        flag = false;
    }
    
    
    //if flag is false output: "Failure: insufficient" funds else output nothing.
    if (!flag){
        NSLog(@"Failure: insufficient funds");
    }
    
    return flag;
}



/*
 @Return: Return the amount of total cash left in the entire machine
 */
- (int)tellerMachineTotalAmount{
    
    
    return (self.ones*1)+(self.fives*5)+(self.tens*10)+(self.twenties*20)+(self.fifties*50)+(self.hundreds*100);


}

@end
