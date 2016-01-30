//
//  Contato.m
//  Contatos67
//
//  Created by Eric Vinicius Camargo De Campos on 18/01/16.
//  Copyright © 2016 Caelum. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Contato.h"

@implementation Contato

@dynamic nome, telefone, email, endereco, site, ehMaroto, latitude, longitude, numeroImagem, foto;

- (NSString *) description{
    return [NSString stringWithFormat:@"|Nome: %@ | Telefone: %@ | Email: %@ | Endereco: %@ | Site: %@ | Eh Maroto: %@", self.nome, self.telefone, self.email, self.endereco, self.site, self.ehMaroto ? @"SIM!" : @"nao..."];
}

- (CLLocationCoordinate2D) coordinate{
    return CLLocationCoordinate2DMake([self.latitude doubleValue], [self.longitude doubleValue]);
}

- (NSString *) title{
    return self.nome;
}

- (NSString *) subtitle{
    return [NSString stringWithFormat:@"%@ | %@", self.endereco, self.telefone];
}



@end