//
//  AppDelegate.m
//  TextKitLayout
//
//  Created by Jean-Luc on 14/04/2014.
//
//

#import "AppDelegate.h"

#import "CIMLua/CIMLua.h"
#import "CIMLua/CIMLuaContextMonitor.h"

@implementation AppDelegate
{
    CIMLuaContext* _luaContext;
    CIMLuaContextMonitor* _contextMonitor;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Create the Lua context
    _luaContext = [[CIMLuaContext alloc] initWithName:@"TextKitLayout"];
    _contextMonitor = [[CIMLuaContextMonitor alloc] initWithLuaContext:_luaContext connectionTimeout:5.0];
    
    // Extend the ViewController class in Lua
    [_luaContext loadLuaModuleNamed:@"ViewController" withCompletionBlock:^(id result) {
        
        if (result != nil) {
            [(id<CIMLuaObject>)self.window.rootViewController promoteAsLuaObject];
        }
    }];
    

    return YES;
}

@end
