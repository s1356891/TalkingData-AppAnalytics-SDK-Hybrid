//
//  ViewController.m
//  TalkingData-HTML
//
//  Created by liweiqiang on 14-7-8.
//  Copyright (c) 2014年 TendCloud. All rights reserved.
//

#import "ViewController.h"
#import "TalkingDataHTML.h"
#import "TalkingData.h"

@interface ViewController () <UIWebViewDelegate>

@end

@implementation ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    webView.delegate = self;
    [self.view addSubview:webView];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"index" ofType:@"html"];
    NSURL *url = [NSURL fileURLWithPath:path];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSString * url = [[request URL] absoluteString];
    NSString *parameters = [url stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    if ([TalkingDataHTML execute:parameters webView:webView]) {
        return NO;
    }
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [webView stringByEvaluatingJavaScriptFromString:@"setWebViewFlag()"];
    if([webView.request.URL.absoluteString hasSuffix:@"/index.html"])
        [TalkingData trackPageBegin:@"index.html"];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    
}

@end
