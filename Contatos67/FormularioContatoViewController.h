//
//  ViewController.h
//  Contatos67
//
//  Created by Eric Vinicius Camargo De Campos on 18/01/16.
//  Copyright © 2016 Caelum. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ContatoDao.h"
#import "Contato.h"
#import <CoreLocation/CoreLocation.h>

@protocol FormularioContatoViewControllerDelegate <NSObject>

- (void) contatoAtualizado: (Contato *) contato;
- (void) contatoAdicionado: (Contato *) contato;

@end

@interface FormularioContatoViewController : UIViewController<UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIActionSheetDelegate>

@property IBOutlet UITextField *nome;
@property IBOutlet UITextField *telefone;
@property IBOutlet UITextField *email;
@property IBOutlet UITextField *site;
@property IBOutlet UITextField *endereco;
@property IBOutlet UITextField *latitude;
@property IBOutlet UITextField *longitude;
@property IBOutlet UISwitch *maroto;
@property IBOutlet UIImageView *imagemSatan;
@property IBOutlet UIImageView *imagemEasterEgg;
@property IBOutlet UIButton *foto;
@property IBOutlet UIButton *botaoGeoLoc;
@property (nonatomic, weak) IBOutlet UIActivityIndicatorView *loading;

@property NSInteger numeroDaImagem;
@property ContatoDao *dao;

@property (strong) Contato *contato;

@property (weak) id<FormularioContatoViewControllerDelegate> delegate;

- (IBAction)limpaFormulario;

- (IBAction)mostraImagemAleatoria;

- (IBAction)selecionaFoto:(id)sender;

- (IBAction)buscarCoordenadas:(id)sender;

@end

