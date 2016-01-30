//
//  ContatosNoMapaViewController.h
//  Contatos67
//
//  Created by Eric Vinicius Camargo De Campos on 26/01/16.
//  Copyright © 2016 Caelum. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface ContatosNoMapaViewController : UIViewController<MKMapViewDelegate>

@property (nonatomic, weak) IBOutlet MKMapView *mapa;
@property CLLocationManager *manager;
@property (nonatomic, weak) NSMutableArray *contatos;

@end
