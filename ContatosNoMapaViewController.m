//
//  ContatosNoMapaViewController.m
//  Contatos67
//
//  Created by Eric Vinicius Camargo De Campos on 26/01/16.
//  Copyright © 2016 Caelum. All rights reserved.
//

#import "ContatosNoMapaViewController.h"
#import "ContatoDao.h"
#import "Contato.h"
#import "Utils.h"

@interface ContatosNoMapaViewController ()

@end

@implementation ContatosNoMapaViewController

- (id) init{
    self = [super init];
    if(self){
        self.contatos = [[ContatoDao contatoDaoIntance] contatos];
        UIImage *imagemDaAba = [UIImage imageNamed:@"ufo.png"];
        UITabBarItem *itemDaBarra = [[UITabBarItem alloc] initWithTitle:@"Mapa" image:imagemDaAba tag:0];
        self.tabBarItem = itemDaBarra;
        
        self.navigationItem.title = @"Localizacao";
    }
    return self;
}

- (void) viewWillAppear:(BOOL)animated{
    [self.mapa addAnnotations:self.contatos];
}

- (void) viewWillDisappear:(BOOL)animated{
    [self.mapa removeAnnotations:self.contatos];
}

- (void)viewDidLoad {
    
    MKUserTrackingBarButtonItem *btLocalizacao = [[MKUserTrackingBarButtonItem alloc] initWithMapView:self.mapa];
    self.navigationItem.rightBarButtonItem = btLocalizacao;
    self.manager = [CLLocationManager new];
    [self.manager requestWhenInUseAuthorization];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
    if([annotation isKindOfClass:[MKUserLocation class]]){
        return nil;
    }
    
    static NSString *indetifier = @"pino";
    MKPinAnnotationView *pino = (MKPinAnnotationView *) [self.mapa dequeueReusableAnnotationViewWithIdentifier:indetifier];
    if(!pino){
        pino = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:indetifier];
    } else {
        pino.annotation = annotation;
    }
    Contato *contato = (Contato *) annotation;
    if(contato.ehMaroto){
        pino.pinTintColor = [UIColor purpleColor];
    } else {
        pino.pinTintColor = [UIColor redColor];
    }
    
    pino.canShowCallout = YES;
    
    UIImageView *imagem = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, 32.0, 32.0)];
    if(contato.foto){
        imagem.image = contato.foto;
        pino.leftCalloutAccessoryView = imagem;
    } else {
        imagem.image = [[Utils UtilsIntance] pegaImagemDaPosicao:contato.numeroImagem];
        pino.rightCalloutAccessoryView = imagem;
    }
    
    return pino;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
