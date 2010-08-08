    //
//  TopViewController.m
//  HatenaKeyword
//
//  Created by Takayama Fumio on 10/05/30.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "TopViewController.h"
#import "KeywordViewController.h"
#import "SearchListViewController.h"
#import "CheckInternetConnection.h"
#import "Reachability.h"

@implementation TopViewController

@synthesize HotkeywordData;
@synthesize topTableView;


-(id) init{
	self = [super init];
		
	if(self != nil){
		HotkeywordData = [[NSMutableArray alloc] init];
		rssParser = [[myParser alloc] init];
		
		if([HotkeywordData count] == 0){
			SCNetworkReachabilityFlags con = [[[CheckInternetConnection alloc] init] connectedToNetwork];
			
			NetworkStatus nw = [[[Reachability alloc] init] networkStatusForFlags:con];
			
			if (nw == NotReachable){
				NSLog(@"Network Failed");
				UIAlertView *alert = [[[UIAlertView alloc] init] autorelease];
				alert.message = @"インターネットに接続されていません";
				[alert addButtonWithTitle:@"OK"];
				[alert show];
				
				return self;
			}
			NSString *path = @"http://d.hatena.ne.jp/hotkeyword?mode=rss";
			[rssParser parseXMLFileAtURL:path];
		}
		
	}
	NSLog(@"TopViewController init End");
	
	return self;
}

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/


// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
	[super loadView];
	
	CGRect bounds = [[UIScreen mainScreen] applicationFrame];
	
	self.navigationItem.title = @"はてなキーワード";
	
	searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0.0, 0.0, bounds.size.width, 48.0)];
	searchBar.delegate = self;
	searchBar.placeholder = @"好きなキーワードを検索できます";
	
	[self.view addSubview:searchBar];
	
	topTableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0, 0.0, bounds.size.width, bounds.size.height - 48.0)];
	
	topTableView.delegate = self;
	topTableView.dataSource = self;
	
	self.navigationItem.titleView = searchBar;
	self.navigationItem.titleView.frame = CGRectMake(0, 0, 320, 44);
	
	[self.view addSubview:topTableView];
	
}

- (void)viewWillAppear:(BOOL)animated{
	[super viewWillAppear:animated];
	// ハイライト解除
	[topTableView deselectRowAtIndexPath:[topTableView indexPathForSelectedRow] animated:YES];
	
}

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

//　テーブルのセクションの数を返す
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
	return 1;
	//return 2;
}

// セクションのタイトルを設定する
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
	//if(section == 0){
		return @"注目キーワード TOP20";
	/*}else if(section == 1){
		return @"最近ブックマークしたキーワード";*/
	//}
	
	return nil;
}

// テーブルのレコード数を返す
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
	//if (section == 0){
		return 20;
	/*}else{
		return 10;*/
	//}
}

// このメソッドはテーブルのレコード数だけループして呼ばれる。
// indexPathにはループのセル番号（0スタート）が入る
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	// セルのオブジェクトに付ける名前の文字列を生成する
	NSString *CellIdentifier = @"HotKeyword";
	
	// HotKeywordと言う名前の再利用可能なセルのオブジェクトを生成する
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	
	// もし生成されていなかったら、セルのオブジェクト生成する
	if(cell == nil){
		cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
	}
	
	int storyIndex = [indexPath indexAtPosition: [indexPath length] - 1];

	if(indexPath.section == 0){
		cell.textLabel.text = [[rssParser.keywordData objectAtIndex:storyIndex] objectForKey:@"title"];		
	}
	
	return cell;
}

// セルがタップされた
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

	KeywordViewController *keywordViewController = [[KeywordViewController alloc] init];
	
	int storyIndex = [indexPath indexAtPosition: [indexPath length] - 1];
	
	// 注目のキーワードが選択された場合
	if(indexPath.section == 0){
		NSString *tempWord = [[rssParser.keywordData objectAtIndex:storyIndex] objectForKey:@"title"];
		
		//if([tempWord isEqualToString:@""]){
		if(tempWord == nil){
			UIAlertView *alert = [[[UIAlertView alloc] init] autorelease];
			alert.message = @"データがありません";
			[alert addButtonWithTitle:@"OK"];
			[alert show];
			
			[topTableView deselectRowAtIndexPath:[topTableView indexPathForSelectedRow] animated:YES];
			[keywordViewController release];
			return;
		}
		
		NSLog(@"keywordData: %@", rssParser.keywordData);
		//NSLog(@"tempWord: %S", tempWord);

		// ¥n¥tを外す
		keywordViewController.selectedKeyword = [tempWord substringToIndex:[tempWord length]-2];	
		
	}
		
	// KeywordViewControllerへ移動する
	[self.navigationController pushViewController:keywordViewController animated:YES];
	[keywordViewController release];
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBarArg{
	searchBarArg.showsCancelButton = YES;
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBarArg{
	searchBarArg.showsCancelButton = NO;
}

// SearchBarで検索が実行された時
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBarArg{
	
	SCNetworkReachabilityFlags con = [[[CheckInternetConnection alloc] init] connectedToNetwork];
	
	NetworkStatus nw = [[[Reachability alloc] init] networkStatusForFlags:con];
	
	if (nw == NotReachable){
		NSLog(@"Network Failed");
		UIAlertView *alert = [[[UIAlertView alloc] init] autorelease];
		alert.message = @"インターネットに接続されていません";
		[alert addButtonWithTitle:@"OK"];
		[alert show];
		
		return;
	}
	
	SearchListViewController *searchListViewController = [[SearchListViewController alloc] init];
	
	searchListViewController.searchWord = searchBarArg.text;
	
	[searchBarArg resignFirstResponder];
	
	[self.navigationController pushViewController:searchListViewController animated:YES];
	[searchListViewController release];
}

// SearchBarでキャンセルボタンを押されたとき
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBarArg{
	// キーボードを隠す
	[searchBarArg resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[searchBar release];
	[topTableView release];
	[navController release];
	[HotkeywordData release];
	[rssParser release];
	
    [super dealloc];
}


@end
