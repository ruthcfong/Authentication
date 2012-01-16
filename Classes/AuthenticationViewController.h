//
//  AuthenticationViewController.h
//  Authentication
//
//  Created by Ruth Fong on 12/21/11.
//  Copyright 2011 Harvard College. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface AuthenticationViewController : UIViewController 
{
	NSData* responseData; 
	NSDictionary* user;
	NSString* sessionID;
	NSHTTPCookieStorage *cookieJar;
	NSDictionary* cookies;
	NSArray* keys;
	NSArray* objects;
    
    UITextField* huid;
    UITextField* pin;
}

@property (nonatomic, retain) NSData* responseData;
@property (nonatomic, retain) NSDictionary* user;
@property (nonatomic, retain) NSString* sessionID;
@property (nonatomic, retain) NSHTTPCookieStorage *cookieJar;
@property (nonatomic, retain) NSDictionary* cookies;
@property (nonatomic, retain) NSArray* keys;
@property (nonatomic, retain) NSArray* objects;

@property (retain, nonatomic) IBOutlet UITextField* huid;
@property (retain, nonatomic) IBOutlet UITextField* pin;

- (void) connection:(NSURLConnection *)connection didFailWithError:(NSError *)error;
- (void) connectionDidFinishLoading:(NSURLConnection *)connection;
- (void) connection:(NSURLConnection *)connection didReceiveData:(NSData *)data;
- (void) connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response;
- (void) sendGET;
- (void) buyStock;
- (void) createACookieWithName: (NSString *) cookieName andValue: (NSString *) cookieValue andURL: (NSURL *) url;
- (void) addCookieToRequest: (NSMutableURLRequest *) request withName: (NSString *) cookieName withValue: (NSString *) cookieValue;

- (IBAction)submit:(id)sender;

@end

