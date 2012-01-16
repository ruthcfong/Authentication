//
//  AuthenticationViewController.m
//  Authentication
//
//  Created by Ruth Fong on 12/21/11.
//  Copyright 2011 Harvard College. All rights reserved.
//

#import "AuthenticationViewController.h"
#import "ConnectionDelegate.h"
#import "Constants.h"

@implementation AuthenticationViewController

@synthesize responseData;
@synthesize user;
@synthesize	sessionID;
@synthesize cookieJar;
@synthesize cookies;
@synthesize keys;
@synthesize objects;

@synthesize huid, pin;

- (IBAction)submit:(id)sender
{
    NSURL *url = [NSURL URLWithString: @"http://cloud.cs50.net/~ruthfong/pin.php"]; 
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
	
	NSData *requestData = [[NSString stringWithFormat:@"huid=%@&password%@", huid.text, pin.text]
                           dataUsingEncoding:NSUTF8StringEncoding];
    
	[request setHTTPMethod:@"POST"];
	[request setValue:@"text/html,application/xhtml+xml,application/xml;q=0.9,*//*;q=0.8" forHTTPHeaderField:@"Accept"];
	[request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
	[request setValue:[NSString stringWithFormat:@"%d", [requestData length]] forHTTPHeaderField:@"Content-Length"];
	[request setHTTPBody: requestData];
		
	[[NSURLConnection alloc] initWithRequest:request delegate:self];
    
}

- (void) viewDidLoad
{
    pin.secureTextEntry = YES;
	// initialize cookie jar
	/*cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage];
	
	NSArray* keys = [NSArray arrayWithObject:@"PHPSESSID"];
	NSArray* objects = [NSArray arrayWithObject:@"sessid"];
	NSDictionary* cookies = [NSDictionary dictionaryWithObject:objects forKey:keys];*/
	
	//[self sendGET];
	//[self buyStock];
	/*NSHTTPCookie *cookie;
	for (cookie in [cookieJar cookies]) 
	{
		NSLog(@"%@", cookie);
	}*/
}


- (void) addCookieToRequest: (NSMutableURLRequest *) request withName: (NSString *) cookieName withValue: (NSString *) cookieValue
{
	/*NSString* value = [NSString stringWithFormat:@"%@=%@", cookieName, cookieValue];
	NSLog(@"%@", value);
	[request addValue:value forHTTPHeaderField:@"Cookie"];
	return;*/
	
	[request addValue:[NSString stringWithFormat:@"PHPSESSID=%@", [self.user valueForKey:@"sessid"]]
   forHTTPHeaderField:@"Cookie"];
}

/* (void)
 * sendGET
 *
 * Submit the order by making a GET submission to the HUDS website.
 */
- (void) sendGET
{
	// login into an account - works; need to say the site being submitted to
	// Following tutorial here: http://toranbillups.com/blog/archive/2011/04/10/Submit-data-using-an-http-post-in-objective-c
	
	NSURL *url = [NSURL URLWithString: @"http://cloud.cs50.net/~ruthfong/pin.php"]; //@"http://192.168.56.50/~jharvard/pin.php"];//@"https://www.pin1.harvard.edu/pin/submit-login"];//[NSURL URLWithString:@"http://cloud.cs50.net/~ruthfong/pset7/register2.php"];
	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
	
	/*NSData *requestData = [[NSString stringWithFormat:@"username=%@&password=%@&password2=%@", @"test18", @"password18", @"password18"]
						   dataUsingEncoding:NSUTF8StringEncoding];*/
	
	/*NSData *requestData = [[NSString stringWithFormat:@"%@", @"__authen_application=VPA_HUDS_MYHUDS&__authen_login_type=PIN&__authen_id=50834735&__authen_password=1lif3UG%3Dme"]
								   dataUsingEncoding:NSUTF8StringEncoding];
	*/
	
	/*NSData *requestData = [[NSString stringWithFormat:@"huid=%@&password%@", , ]
	 dataUsingEncoding:NSUTF8StringEncoding];*/
	 
	[request setHTTPMethod:@"GET"];
	/*[request setValue:@"text/html,application/xhtml+xml,application/xml;q=0.9,*//*;q=0.8" forHTTPHeaderField:@"Accept"];
	[request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
	[request setValue:[NSString stringWithFormat:@"%d", [requestData length]] forHTTPHeaderField:@"Content-Length"];
	[request setHTTPBody: requestData];*/
	
	//[self addCookieToRequest:request withName:@"PHPSESSID" withValue:[self.user valueForKey:@"sessid"]];
	
	/*for (NSString* key in cookies)
	{
		[request addValue:
		 [NSString stringWithFormat:@"%@=%@", key, [self.user valueForKey:[cookies valueForKey:key]] ]
				 forHTTPHeaderField:@"Cookie"];
	}*/
	
	// pin-test-cookie; 
	// Harvard-University-PIN-SCookie=XtigG3zZ6T+qtJO7Re2ptzsuPXEcp6fVQy2R8r6V41SSi7BY/Yk0VYYtCqxaxSQB+ucgIIJnfaXEbnWUqxJBqA==; 
	// Harvard-University-PIN-Success=8fI+Z4bgYKKKqkmdvFBlewJfE1RoTyQ+qZk/LAOOOp23viZ+gh3fLOYRuPguYIUsPVo0QqUTlV03sQSgU6d87v/BwYrA3FSfQHMHu+7vnkOKLDeZXCqFIm3LDIubhE6TSPashiLwRDrFqh42ZhRFxF5RcGm/YwwfgvmWk9XmQ1KTcQ8nKujpqLecvgE4iZkGeG1OK2hpZ3/2hfEafYYRxBj2qpghUZvcjOrfje2GI1HKDEuoOFEMvqCNyR007BOgkP9rtWrPANdDsJP+t+8Uhblcg1CPOHYziLLn7KCrXAwbAC//VI8yjRbhx4jAHc0RwZ19FoKz69kzrO4pjLdlSj7GPvylgAWF+aCDLywsTmN3SOmxgKffzYXYeMC9AUil5aMC9G891Y20WSTOYhgn5yY0EN18XN27vHDqkbFcyNJIUKCU1XM2Xrqi4jTjhBfANnH9LvGmKT6Wi6sU8eqbWxiyIZWI2/0pxAS8tJ1GHCUdLzU+7WYfnQWFleo4IVpJ+SXuPKQaCCk1EKZBcGY2RXV0T02aIro9oueP+W+l4J1yrrMaWKHd4CAtdTfrax52Ro1NHIb04Qn2Xrv7KLVKtIc+Iypb24Xm5mB/WdvRpC2ascjEbFH+hzhu66w/14PtgLGRcqnzCT0gZihc/I6I8HaG+NLgZ5Su3pPUzpzPwPU=; 
	// __utma=73372042.816681127.1324702275.1324702275.1326253939.2; 
	// __utmz=73372042.1326253939.2.2.utmcsr=my.harvard.edu|utmccn=(referral)|utmcmd=referral|utmcct=/icb/icb.do; 
	// JSESSIONID=1c2GPRhTmXGrzbTTJldR4sVs8qy7JGGrY3QlzX0NTvTbmGz1NQpn!1013905595
	
	// added
	/*[request addValue:[NSString stringWithFormat:@"PHPSESSID=%@", [self.user valueForKey:@"phpsessid"]]
   forHTTPHeaderField:@"Cookie"];
	[request addValue:[NSString stringWithFormat:@"pin-test-cookie=%@", [self.user valueForKey:@"pin"]]
   forHTTPHeaderField:@"Cookie"];
	[request addValue:[NSString stringWithFormat:@"Harvard-University-PIN-SCookie=%@", [self.user valueForKey:@"pincookie"]]
   forHTTPHeaderField:@"Cookie"];
	[request addValue:[NSString stringWithFormat:@"__utma=%@", [self.user valueForKey:@"utma"]]
   forHTTPHeaderField:@"Cookie"];
	[request addValue:[NSString stringWithFormat:@"__utmz=%@", [self.user valueForKey:@"utmz"]]
   forHTTPHeaderField:@"Cookie"];
	[request addValue:[NSString stringWithFormat:@"JSESSIONID=%@", [self.user valueForKey:@"jsessid"]]
   forHTTPHeaderField:@"Cookie"];*/
	
	/*[request addValue:[NSString stringWithFormat:@"Harvard-University-PIN-State=%@", [self.user valueForKey:@"pinstate"]]
   forHTTPHeaderField:@"Cookie"];
	[request addValue:[NSString stringWithFormat:@"JSESSIONID=%@", [self.user valueForKey:@"jsessid"]]
   forHTTPHeaderField:@"Cookie"];
	[request addValue:[NSString stringWithFormat:@"Harvard-University-PIN-SCookie=%@", [self.user valueForKey:@"scookie"]]
   forHTTPHeaderField:@"Cookie"];
	[request addValue:[NSString stringWithFormat:@"Harvard-University-PIN-Success=%@", [self.user valueForKey:@"pinsuccess"]]
   forHTTPHeaderField:@"Cookie"];
	[request addValue:[NSString stringWithFormat:@"ObSSOCookie=%@", [self.user valueForKey:@"SSOcookie"]]
   forHTTPHeaderField:@"Cookie"];
	[request addValue:[NSString stringWithFormat:@"PHPSESSID=%@", [self.user valueForKey:@"phpsessid"]]
   forHTTPHeaderField:@"Cookie"];
	[request addValue:[NSString stringWithFormat:@"__authen_pgp_signature=%@", [self.user valueForKey:@"pinstate"]]
   forHTTPHeaderField:@"Cookie"];
	[request addValue:[NSString stringWithFormat:@"__authen_time=%@", [self.user valueForKey:@"pinstate"]]
   forHTTPHeaderField:@"Cookie"];
	[request addValue:[NSString stringWithFormat:@"__authen_application=%@", [self.user valueForKey:@"application"]]
   forHTTPHeaderField:@"Cookie"];
	[request addValue:[NSString stringWithFormat:@"__authen_ip=%@", [self.user valueForKey:@"ip"]]
   forHTTPHeaderField:@"Cookie"];
	[request addValue:[NSString stringWithFormat:@"__authen_pgp_version=%@", [self.user valueForKey:@"version"]]
   forHTTPHeaderField:@"Cookie"];
	[request addValue:[NSString stringWithFormat:@"__authen_huid=%@", [self.user valueForKey:@"huid"]]
   forHTTPHeaderField:@"Cookie"];*/
	
	
	//[self createACookieWithName:@"PHPSESSID" andValue:@"sessid" andURL:url];
	
	[[NSURLConnection alloc] initWithRequest:request delegate:self];

	/*NSDictionary *properties = [NSDictionary dictionaryWithObjectsAndKeys:
								@"cloud.cs50.net", NSHTTPCookieDomain,
								@"\\", NSHTTPCookiePath,  // IMPORTANT!
								@"testCookies", NSHTTPCookieName,
								@"1", NSHTTPCookieValue,
								nil];
	
	NSHTTPCookie *cookie = [NSHTTPCookie cookieWithProperties:properties];
	
	NSArray* cookies = [NSArray arrayWithObjects: cookie, nil];
	
	NSDictionary * headers = [NSHTTPCookie requestHeaderFieldsWithCookies:cookies];
	
	[request setAllHTTPHeaderFields:headers];*/
	
		
	//Cookie Jar Code
	 
	 //cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage];
	 
	
	//Cookie Jar Code: http://stackoverflow.com/questions/5954382/ios-is-it-possible-to-set-a-cookie-manually-using-sharedhttpcookiestorage-for-a
	 /*[NSMutableDictionary *cookieProperties = [NSMutableDictionary dictionary];
	 [cookieProperties setObject:@"testCookie" forKey:NSHTTPCookieName];
	 [cookieProperties setObject:@"someValue123456" forKey:NSHTTPCookieValue];
	 [cookieProperties setObject:@"www.example.com" forKey:NSHTTPCookieDomain];
	 [cookieProperties setObject:@"www.example.com" forKey:NSHTTPCookieOriginURL];
	 [cookieProperties setObject:@"/" forKey:NSHTTPCookiePath];
	 [cookieProperties setObject:@"0" forKey:NSHTTPCookieVersion];
	 
	 // set expiration to one month from now or any NSDate of your choosing
	 // this makes the cookie sessionless and it will persist across web sessions and app launches
	 /// if you want the cookie to be destroyed when your app exits, don't set this
	 [cookieProperties setObject:[[NSDate date] dateByAddingTimeInterval:2629743] forKey:NSHTTPCookieExpires];
	 
	 NSHTTPCookie *cookie = [NSHTTPCookie cookieWithProperties:cookieProperties];
	 [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookie];*/
	 
	
	
	
	/*NSHTTPCookie *cookie;
	NSHTTPCookieStorage *cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage];
	for (cookie in [cookieJar cookies]) {
		NSLog(@"%@", cookie);
	}*/
	
	//http://lists.apple.com/archives/Webkitsdk-dev/2003/Sep/msg00003.html
	
	// creating the URL
	//NSURL *_server_url = [NSURL URLWithString:@"http://cloud.cs50.net/~ruthfong/pset7/register2.php"];
	
	// creation the cookie
	/*NSHTTPCookie *cook = [NSHTTPCookie cookieWithProperties:
						  [NSDictionary dictionaryWithObjectsAndKeys:
						   [url host], NSHTTPCookieDomain,
						   [url path], NSHTTPCookiePath,
						   @"MY_COOKIE_NAME",  NSHTTPCookieName,
						   @"MY_COOKIE_VALUE", NSHTTPCookieValue,
						   nil]];*/
	
	// Posting the cookie
	//[[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cook];
	
	/*NSHTTPCookie *c;
	for (c in [cook cookies])
	{
		NSLog(@"%@", c);
	}*/
	
}

- (void) createACookieWithName: (NSString *) cookieName andValue: (NSString *) cookieValue andURL: (NSURL *) url
{
	NSMutableDictionary *cookieProperties = [NSMutableDictionary dictionary];
	 
	 [cookieProperties setObject:cookieName forKey:NSHTTPCookieName];
	 [cookieProperties setObject:cookieValue forKey:NSHTTPCookieValue];
	 [cookieProperties setObject: [url host] forKey:NSHTTPCookieDomain];
	 [cookieProperties setObject: [url path] forKey:NSHTTPCookieOriginURL];
	 [cookieProperties setObject:@"/" forKey:NSHTTPCookiePath];
	 [cookieProperties setObject:@"0" forKey:NSHTTPCookieVersion];
	
	 NSHTTPCookie* cookie = [NSHTTPCookie cookieWithProperties:cookieProperties];
	 
	 [cookieJar setCookie:cookie];
	 
	 return;
}
	 
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [responseData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [responseData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    // Show error
	NSLog(@"%@", error);
	NSLog(@"something very bad happened here");
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    // Once this method is invoked, "responseData" contains the complete result
	[connection release];
	
	NSString* responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
	NSLog(@"the html from google was %@", responseString);
	
	[responseString release];
}

- (void) buyStock
{
	// Buy a stock
	// URL: http://cloud.cs50.net/~ruthfong/pset7/login.php
	// January 10, 2012 - Taken from Tommy's code
	
	//ConnectionDelegate* d2 = [[ConnectionDelegate alloc] init];
	
	// create comma separated list of question ids
	
	//NSURL *url = [NSURL URLWithString:@"http://cloud.cs50.net/~ruthfong/pset7/buy2.php"];
	
	NSURL *url = [NSURL URLWithString:@"http://www.dining.harvard.edu/myhuds/students/lunch/"];
	
	NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:url];
	
	/*NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:
									[NSURL URLWithString:@"http://www.dining.harvard.edu/myhuds/students/lunch/?action=submit&pickup=2012-01-15&order[location_id]=FD&order[delivery_time]=09%3A00&sandwiches[0][type]=Gluten-Free%20Salad&sandwiches[0][dressing]=Blue%20Cheese"]];
	*/
	
	//NSString* params = [NSString stringWithFormat:@"symbol=%@&shares=%@", @"A", @"50"];
	NSString* params = [NSString stringWithFormat:@"%@", @"pickup=2012-01-16&order[location_id]=FD&order[delivery_time]=09%3A00&sandwiches[0][type]=Gluten-Free%20Salad&sandwiches[0][dressing]=Blue%20Cheese"];
	
	//NSString* params = @"lunch/?action=submit&pickup=2012-01-15&order[location_id]=FD&order[delivery_time]=09%3A00&sandwiches[0][type]=Gluten-Free%20Salad&sandwiches[0][dressing]=Blue%20Cheese";
	request.HTTPMethod = @"POST";
	//request.HTTPMethod = @"GET";
	request.HTTPBody = [params dataUsingEncoding:NSUTF8StringEncoding];
	
	// pin-test-cookie; 
	// Harvard-University-PIN-SCookie=XtigG3zZ6T+qtJO7Re2ptzsuPXEcp6fVQy2R8r6V41SSi7BY/Yk0VYYtCqxaxSQB+ucgIIJnfaXEbnWUqxJBqA==; 
	// Harvard-University-PIN-Success=8fI+Z4bgYKKKqkmdvFBlewJfE1RoTyQ+qZk/LAOOOp23viZ+gh3fLOYRuPguYIUsPVo0QqUTlV03sQSgU6d87v/BwYrA3FSfQHMHu+7vnkOKLDeZXCqFIm3LDIubhE6TSPashiLwRDrFqh42ZhRFxF5RcGm/YwwfgvmWk9XmQ1KTcQ8nKujpqLecvgE4iZkGeG1OK2hpZ3/2hfEafYYRxBj2qpghUZvcjOrfje2GI1HKDEuoOFEMvqCNyR007BOgkP9rtWrPANdDsJP+t+8Uhblcg1CPOHYziLLn7KCrXAwbAC//VI8yjRbhx4jAHc0RwZ19FoKz69kzrO4pjLdlSj7GPvylgAWF+aCDLywsTmN3SOmxgKffzYXYeMC9AUil5aMC9G891Y20WSTOYhgn5yY0EN18XN27vHDqkbFcyNJIUKCU1XM2Xrqi4jTjhBfANnH9LvGmKT6Wi6sU8eqbWxiyIZWI2/0pxAS8tJ1GHCUdLzU+7WYfnQWFleo4IVpJ+SXuPKQaCCk1EKZBcGY2RXV0T02aIro9oueP+W+l4J1yrrMaWKHd4CAtdTfrax52Ro1NHIb04Qn2Xrv7KLVKtIc+Iypb24Xm5mB/WdvRpC2ascjEbFH+hzhu66w/14PtgLGRcqnzCT0gZihc/I6I8HaG+NLgZ5Su3pPUzpzPwPU=; 
	// __utma=73372042.816681127.1324702275.1324702275.1326253939.2; 
	// __utmz=73372042.1326253939.2.2.utmcsr=my.harvard.edu|utmccn=(referral)|utmcmd=referral|utmcct=/icb/icb.do; 
	// JSESSIONID=1c2GPRhTmXGrzbTTJldR4sVs8qy7JGGrY3QlzX0NTvTbmGz1NQpn!1013905595
	
	/*NSArray *myCookies = [NSMutableArray arrayWithObjects: @"pin-test-cookie", @"Harvard-University-PIN-SCookie=", 
						  @"Harvard-University-PIN-Success=", @"__utma=", @"__utmz=", @"JSESSIONID=", nil];*/
	
	/*[request addValue:[NSString stringWithFormat:@"pin-test-cookie", [self.user valueForKey:@""]
							  forHTTPHeaderField:@"Cookie"];*/
	
	/*[request addValue:[NSString stringWithFormat:@"JSESSIONID=%@", [self.user valueForKey:@"sessid"]]
   forHTTPHeaderField:@"Cookie"];*/
	
	/*[request addValue:[NSString stringWithFormat:@"PHPSESSID=%@", [self.user valueForKey:@"phpsessid"]]
   forHTTPHeaderField:@"Cookie"];
	[request addValue:[NSString stringWithFormat:@"pin-test-cookie=%@", [self.user valueForKey:@"pin"]]
   forHTTPHeaderField:@"Cookie"];
	[request addValue:[NSString stringWithFormat:@"Harvard-University-PIN-SCookie=%@", [self.user valueForKey:@"pincookie"]]
   forHTTPHeaderField:@"Cookie"];
	[request addValue:[NSString stringWithFormat:@"__utma=%@", [self.user valueForKey:@"utma"]]
   forHTTPHeaderField:@"Cookie"];
	[request addValue:[NSString stringWithFormat:@"__utmz=%@", [self.user valueForKey:@"utmz"]]
   forHTTPHeaderField:@"Cookie"];
	[request addValue:[NSString stringWithFormat:@"JSESSIONID=%@", [self.user valueForKey:@"jsessid"]]
   forHTTPHeaderField:@"Cookie"];*/
	
	[request addValue:[NSString stringWithFormat:@"Harvard-University-PIN-State=%@", [self.user valueForKey:@"pinstate"]]
   forHTTPHeaderField:@"Cookie"];
	[request addValue:[NSString stringWithFormat:@"JSESSIONID=%@", [self.user valueForKey:@"jsessid"]]
   forHTTPHeaderField:@"Cookie"];
	[request addValue:[NSString stringWithFormat:@"Harvard-University-PIN-SCookie=%@", [self.user valueForKey:@"scookie"]]
   forHTTPHeaderField:@"Cookie"];
	[request addValue:[NSString stringWithFormat:@"Harvard-University-PIN-Success=%@", [self.user valueForKey:@"pinsuccess"]]
   forHTTPHeaderField:@"Cookie"];
	[request addValue:[NSString stringWithFormat:@"ObSSOCookie=%@", [self.user valueForKey:@"SSOcookie"]]
   forHTTPHeaderField:@"Cookie"];
	[request addValue:[NSString stringWithFormat:@"PHPSESSID=%@", [self.user valueForKey:@"phpsessid"]]
   forHTTPHeaderField:@"Cookie"];
	[request addValue:[NSString stringWithFormat:@"__authen_pgp_signature=%@", [self.user valueForKey:@"pinstate"]]
   forHTTPHeaderField:@"Cookie"];
	[request addValue:[NSString stringWithFormat:@"__authen_time=%@", [self.user valueForKey:@"pinstate"]]
   forHTTPHeaderField:@"Cookie"];
	[request addValue:[NSString stringWithFormat:@"__authen_application=%@", [self.user valueForKey:@"application"]]
   forHTTPHeaderField:@"Cookie"];
	[request addValue:[NSString stringWithFormat:@"__authen_ip=%@", [self.user valueForKey:@"ip"]]
   forHTTPHeaderField:@"Cookie"];
	[request addValue:[NSString stringWithFormat:@"__authen_pgp_version=%@", [self.user valueForKey:@"version"]]
   forHTTPHeaderField:@"Cookie"];
	[request addValue:[NSString stringWithFormat:@"__authen_huid=%@", [self.user valueForKey:@"huid"]]
   forHTTPHeaderField:@"Cookie"];

	
	//[self addCookieToRequest:request withName:@"PHPSESSID" withValue:[self.user valueForKey:@"sessid"]];
	
	//[self createACookieWithName:@"PHPSESSID" andValue:@"sessid" andURL:url];
	
	/*for (NSString* key in cookies)
	{
		[request addValue:
		 [NSString stringWithFormat:@"%@=%@", key, [self.user valueForKey:[cookies valueForKey:key]] ]
	   forHTTPHeaderField:@"Cookie"];
	}*/
	
	NSURLConnection* connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
	[connection start];
}

/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/


/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
    self.huid = nil;
    self.pin = nil;
}


- (void)dealloc {
    [super dealloc];
}

@end
