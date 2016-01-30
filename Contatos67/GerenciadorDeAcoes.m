//
//  GerenciadorDeAcoes.m
//  Contatos67
//
//  Created by Eric Vinicius Camargo De Campos on 22/01/16.
//  Copyright © 2016 Caelum. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GerenciadorDeAcoes.h"
#import "FormularioContatoViewController.h"

@interface GerenciadorDeAcoes ()

@end

@implementation GerenciadorDeAcoes

- (id) initWithContato: (Contato *) contato{
    self = [super init];
    if (self){
        self.contato = contato;
    }
    return self;
}

- (void) acoesDoController: (UIViewController *) controller{
    self.controller = controller;
    UIActionSheet *opcoes = [[UIActionSheet alloc] initWithTitle:self.contato.nome delegate:self cancelButtonTitle: @"Cancelar" destructiveButtonTitle: nil otherButtonTitles: @"Ligar", @"Enviar Email", @"Site", @"Mapa", @"666", nil];
    [opcoes showInView:controller.view];
}

- (void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
   
    switch (buttonIndex) {
        case 0:
            [self ligar];
            break;
        case 1:
            [self enviarEmail];
            break;
        case 2:
            [self abrirSite];
            break;
        case 3:
            [self mostrarMapa];
            break;
        case 4:
            [self siteMaroto];
            
        default:
            break;
    }
}

- (void) enviarEmail{
    if([MFMailComposeViewController canSendMail]){
        MFMailComposeViewController *envEmail = [MFMailComposeViewController new];
        envEmail.mailComposeDelegate = self;
        [envEmail setToRecipients:@[self.contato.email]];
        [envEmail setSubject:@"Caelum"];
        
        [self.controller presentViewController:envEmail animated:YES completion:nil];
        
    } else {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"FUDEU!" message:@"Azar seu" delegate:nil
                                             cancelButtonTitle:@"OK!!!!!" otherButtonTitles:nil];
        [alert show];
        
    }
}

- (void) siteMaroto{
    [self abrirAplicativoComUrl:@"www.alura.com.br"];
}

- (void) abrirSite{
    [self abrirAplicativoComUrl:self.contato.site];
}

- (void) mostrarMapa{
    NSString *url = [[NSString stringWithFormat:@"http://maps.google.com/maps?q=%@", self.contato.endereco] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [self abrirAplicativoComUrl:url];
}

- (void) abrirAplicativoComUrl: (NSString *) url{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: url]];
}

- (void) ligar{
    UIDevice *device = [UIDevice currentDevice];
    if([device.model isEqualToString:@"iPhone"]){
        NSString *numero = [NSString stringWithFormat:@"tel:%@ ", self.contato.telefone];
        [self abrirAplicativoComUrl: numero];
    } else {
        
    }
}

@end