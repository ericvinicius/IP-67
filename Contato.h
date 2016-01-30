//
//  Contato.h
//  Contatos67
//
//  Created by Eric Vinicius Camargo De Campos on 18/01/16.
//  Copyright © 2016 Caelum. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <MapKit/MKAnnotation.h>
#import <CoreData/CoreData.h>

@interface Contato : NSManagedObject <MKAnnotation>

@property (strong) NSString *nome;
@property (strong) NSString *telefone;
@property (strong) NSString *email;
@property (strong) NSString *site;
@property (strong) NSString *endereco;
@property (strong) NSNumber *latitude;
@property (strong) NSNumber *longitude;
@property (strong) UIImage *foto;
@property NSInteger numeroImagem;
@property BOOL ehMaroto;

@end