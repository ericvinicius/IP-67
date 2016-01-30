//
//  AppDelegate.m
//  Contatos67
//
//  Created by Eric Vinicius Camargo De Campos on 18/01/16.
//  Copyright © 2016 Caelum. All rights reserved.
//

#import "AppDelegate.h"
#import "ListaContatosViewController.h"
#import "ContatosNoMapaViewController.h"
#import "DAO.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    self.dao = [ContatoDao contatoDaoIntance];
    
    ListaContatosViewController *lista = [ListaContatosViewController new];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:lista];
    
    ContatosNoMapaViewController *mapa = [ContatosNoMapaViewController new];
    UINavigationController *navMapa = [[UINavigationController alloc] initWithRootViewController:mapa];
    
    UITabBarController *tabs = [UITabBarController new];
    tabs.viewControllers = @[nav, navMapa];
    
    self.window.rootViewController = tabs;

    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    [[DAO new] saveContext];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [[DAO new] saveContext];
}

@end
