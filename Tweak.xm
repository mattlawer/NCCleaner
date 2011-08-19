#import <Foundation/Foundation.h>
#import "SpringBoard/SBBulletinListController.h"
#import "SpringBoard/SBBulletinClearButton.h"
#import "SpringBoard/SBBulletinHeaderView.h"
/*
#import "SpringBoard/SBWeeApp.h"
#import "SpringBoard/SBBulletinListSection.h"*/


%hook SBBulletinClearButton

- (void)_pressAction {
	BOOL showingClear = MSHookIvar<BOOL>(self, "_showingClear");
	if (showingClear) {
		%orig;
	}else {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:nil];
        [alert addButtonWithTitle:@"Clear these notifications"];
        [alert addButtonWithTitle:@"Clear all notifications"];
        [alert addButtonWithTitle:@"Cancel"];
        [alert show];
        [alert release];
	}
}

%new(v@:@i)
- (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
	NSLog(@"Button : %i",buttonIndex);
    switch (buttonIndex) {
        case 0:{
        	[self _setShowsClear:YES animated:NO];
            [self _pressAction];  
        }break;
        case 1:{
            SBBulletinListController *listController = [%c(SBBulletinListController) sharedInstance];
            NSMutableDictionary *headers = MSHookIvar<NSMutableDictionary *>(listController, "_headerViewsBySectionID");
            int headerCount;
            do {
            	NSLog(@"Start cleaning : %@",headers);
        		for (NSString *keyHeader in [headers allKeys]) {
        			SBBulletinHeaderView *header = [headers objectForKey:keyHeader];
        			SBBulletinClearButton *anotherButton = MSHookIvar<SBBulletinClearButton *>(header, "_clearButton");
        			[anotherButton _setShowsClear:YES animated:NO];
            		[anotherButton _pressAction];
            		[headers removeObjectForKey:keyHeader];
        		}
            	
        		headers = MSHookIvar<NSMutableDictionary *>(listController, "_headerViewsBySectionID");
        		NSLog(@"End cleaning : %@",headers);
        		headerCount = [[headers allKeys] count];
            
            }while (headerCount > 0);
            
        }break;   
    }
}

%end


%ctor {
	%init
}

