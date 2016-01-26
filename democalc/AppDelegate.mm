#import "AppDelegate.h"
#include "Demo.h"

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

    const uint8_t *data = static_cast<const uint8_t *>([ddata bytes]);
    size_t len = [ddata length];

    try
    {
        Demo demo(data, len);
    }
    catch(const Demo::Exception &e)
    {
        NSAlert *alert = [[NSAlert alloc] init];
        alert.messageText = @"Demo error";
        alert.informativeText = [NSString stringWithUTF8String:e.message().c_str()];
        [alert addButtonWithTitle:@"Fine"];
        [alert beginSheetModalForWindow:self.window completionHandler:^(NSModalResponse returnCode) {
        }];
    }

}

@end
