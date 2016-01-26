#import "AppDelegate.h"

@interface AppDelegate ()
@property (weak) IBOutlet NSWindow *window;
@property (weak) IBOutlet NSTextField *label;
-(IBAction)loadDemoClicked:(id)sender;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
}

- (void)applicationWillTerminate:(NSNotification *)aNotification
{
    // Insert code here to tear down your application
}

-(IBAction)loadDemoClicked:(id)sender
{
    NSOpenPanel *openPanel = [NSOpenPanel openPanel];
    [openPanel setAllowedFileTypes:@[@"lmp"]];
    [openPanel beginSheetModalForWindow:self.window completionHandler:^(NSInteger result)
    {
        if(result != NSFileHandlingPanelOKButton)
            return;
        [self handleDemo:openPanel.URL];
    }];
}

-(void)handleDemo:(NSURL*)demoURL
{
    NSData *ddata = [NSData dataWithContentsOfURL:demoURL];
    if(!ddata)
    {
        NSBeep();
        return;
    }

    self.label.stringValue = demoURL.path;

    const uint8_t *data = [ddata bytes];
    size_t len = [ddata length];

    // TODO: process this info

}

@end
