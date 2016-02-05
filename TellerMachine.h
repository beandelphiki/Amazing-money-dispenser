//
//  TellerMachine.h
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


#import <Foundation/Foundation.h>
@interface TellerMachine : NSObject


#pragma mark Properties for the the trays class
/*
 Each array of a denomination represents a tray in the Teller machine.
 */
@property (nonatomic) int ones;
@property (nonatomic) int fives;
@property (nonatomic) int tens;
@property (nonatomic) int twenties;
@property (nonatomic) int fifties;
@property (nonatomic) int hundreds;
@property (nonatomic) int machineAmount;



#pragma mark helper methods
/*
 @Return: Initialize our Teller Machine class instance.
 */
- (id)init;


#pragma mark Tray counting functions
/*
 @Return: Return the total of money denominations left in the machine based on a list of denominations presented.
 */
- (void)TrayPhysicalCount:(NSMutableArray*)denoms;




#pragma mark Withdrawal functions
/*
 @Return: Return true if you could withdraw the amount asked for by the user
 */
- (BOOL)withdrawFunds:(int)amount;





#pragma mark Restocking functions

/*
 Restocks all the drawers to 10 of each denomination
 @Return: None
 */
- (void)RestockAll;

/*
 Restocks the Ones drawer to 10
 @Return: None
 */
- (void)RestockOnes;


/*
 Restocks the Fives drawer to 10
 @Return: None
 */
- (void)RestockFives;


/*
 Restocks the Tens drawer to 10
 @Return: None
 */
- (void)RestockTens;


/*
 Restocks the Twenties drawer to 10
 @Return: None
 */
- (void)RestockTwenties;

/*
 Restocks the Fifties drawer to 10
 @Return: None
 */
- (void)RestockFifties;


/*
 Restocks the Hundreds drawer to 10
 @Return: None
 */
- (void)RestockHundreds;








#pragma mark Total cash functions

/*
 @Return: Return the amount of total cash items left in the entire machine
 */
- (BOOL)tellerMachineTotal;


/*
 @Return: Return the amount of total left in the entire machine
 */
- (int)tellerMachineTotalAmount;
@end
