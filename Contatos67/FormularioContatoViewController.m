//
//  ViewController.m
//  Contatos67
//
//  Created by Eric Vinicius Camargo De Campos on 18/01/16.
//  Copyright © 2016 Caelum. All rights reserved.
//

#import "FormularioContatoViewController.h"
#import "Contato.h"
#import "Utils.h"
#import "ToastView.h"

@interface FormularioContatoViewController ()

@end

NSInteger clicks = 0;
NSInteger maxClicks = 8;

@implementation FormularioContatoViewController

- (void)viewDidLoad {
    if(self.contato){
        [self criaBarraDeEdicao];
        
        self.nome.text = self.contato.nome;
        self.telefone.text = self.contato.telefone;
        self.site.text = self.contato.site;
        self.email.text = self.contato.email;
        self.endereco.text = self.contato.endereco;
        self.maroto.on = self.contato.ehMaroto;
        self.numeroDaImagem = self.contato.numeroImagem;
        self.imagemSatan.image = [[Utils UtilsIntance] pegaImagemDaPosicao: self.numeroDaImagem];
        self.latitude.text = [self.contato.latitude stringValue];
        self.longitude.text = [self.contato.longitude stringValue];
        
        if(self.contato.foto){
            [self.foto setBackgroundImage:self.contato.foto forState:UIControlStateNormal];
            [self.foto setTitle:nil forState:UIControlStateNormal];
        }
    }
}

- (void) criaBarraDeEdicao{
    self.navigationItem.title = @"†Alterando Satan†";
    UIBarButtonItem *confirmar = [[UIBarButtonItem alloc]
                                  initWithTitle:@"Marotizar"
                                  style:UIBarButtonItemStylePlain
                                  target:self action:@selector(atualizaContato)];
    self.navigationItem.rightBarButtonItem = confirmar;
}

- (void) atualizaContato{
    [self pegaDadosDoFormulario];
    if(self.delegate){
        [self.delegate contatoAtualizado:self.contato];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)pegaDadosDoFormulario{
    if(!self.contato){
        self.contato = [self.dao novoContato];
    }
    
    self.contato.nome = [self.nome text];
    self.contato.telefone = [self.telefone text];
    self.contato.email = [self.email text];
    self.contato.site = [self.site text];
    self.contato.endereco = [self.endereco text];
    self.contato.ehMaroto = [self.maroto isOn];
    self.contato.numeroImagem = self.numeroDaImagem;
    self.contato.latitude = [NSNumber numberWithFloat:[self.latitude.text floatValue]];
    self.contato.longitude = [NSNumber numberWithFloat:[self.longitude.text floatValue]];
    
    if([self.foto backgroundImageForState:UIControlStateNormal]){
        self.contato.foto = [self.foto backgroundImageForState:UIControlStateNormal];
    }
}

- (IBAction)limpaFormulario{
    self.nome.text = @"";
    self.telefone.text = @"";
    self.email.text = @"";
    self.site.text = @"";
    self.endereco.text = @"";
    self.maroto.on = false;
    
    [self verificaSeMostraEasterEgg];
}

- (void) verificaSeMostraEasterEgg{
    if(clicks == maxClicks){
        self.imagemEasterEgg.image = [[Utils UtilsIntance] pegaEasterEgg];
        clicks = 0;
        [self performSelector:@selector(hideEasterEgg) withObject:nil afterDelay:1.0];
    } else if(clicks >= 3) {
        [ToastView showToastInParentView:self.view
                                withText:[NSString stringWithFormat:@"Faltam %ld clicks!", (maxClicks - (clicks++))]
                           withDuaration:0.5];
    } else {
        clicks++;
    }
}

- (void) hideEasterEgg{
    self.imagemEasterEgg.image = nil;
}

- (void) criaContato{
    [self pegaDadosDoFormulario];
    [self.dao adicionaContato:self.contato];
    
    if(self.delegate){
        [self.delegate contatoAdicionado:self.contato];
    }
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (UIBarButtonItem *) criaBotaoAdicionar{
    UIImage *compose = [UIImage imageNamed:@"compose.png"];
    UIButton *composeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    composeButton.bounds = CGRectMake( 0, 0, compose.size.width, compose.size.height );
    [composeButton setImage:compose forState:UIControlStateNormal];
    [composeButton addTarget:self action:@selector(criaContato) forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:composeButton];
}

- (id) initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    
    if(self){
        self.dao = [ContatoDao contatoDaoIntance];
        self.navigationItem.title = @"†Novo Contato Maroto†";
        self.navigationItem.rightBarButtonItem = [self criaBotaoAdicionar];
    }
    return self;
}

- (IBAction)mostraImagemAleatoria{
    self.imagemSatan.image = [[Utils UtilsIntance] pegaImagemDaPosicao: ++self.numeroDaImagem];
}

- (IBAction)selecionaFoto:(id)sender{
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        UIActionSheet *sheet =[[UIActionSheet alloc] initWithTitle:@"Escolha Foto" delegate: self cancelButtonTitle:@"Cancelar" destructiveButtonTitle: nil otherButtonTitles:@"Camera", @"Album", nil];
        [sheet showInView:self.view];
    } else{
        UIImagePickerController *picker = [UIImagePickerController new];
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        picker.allowsEditing = YES;
        picker.delegate = self;
        [self presentViewController:picker animated:YES completion:nil];
    }
}

- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    UIImage *imagemSelecionada = [info valueForKey:UIImagePickerControllerEditedImage];
    [self.foto setBackgroundImage:imagemSelecionada forState:UIControlStateNormal];
    [self.foto setTitle:nil forState:UIControlStateNormal];
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void) actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex{
    UIImagePickerController *picker = [UIImagePickerController new];
    picker.delegate = self;
    picker.allowsEditing = YES;
    
    switch (buttonIndex) {
        case 0:
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            break;
            
        default:
            picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            break;
    }
    
    
    [self presentViewController:picker animated:YES completion:nil];
}

- (IBAction)buscarCoordenadas:(id)sender{
    [self.loading startAnimating];
    CLGeocoder *geo = [CLGeocoder new];
    self.botaoGeoLoc.hidden = YES;
    [geo geocodeAddressString:self.endereco.text completionHandler:^(NSArray *resultados, NSError *error){
        if(error == nil && [resultados count] > 0){
            CLPlacemark *resultado = resultados[0];
            CLLocationCoordinate2D coordenada = resultado.location.coordinate;
            self.latitude.text = [NSString stringWithFormat:@"%f", coordenada.latitude];
            self.longitude.text = [NSString stringWithFormat:@"%f", coordenada.longitude];
        }
        [self.loading stopAnimating];
        self.botaoGeoLoc.hidden = NO;
    }];
    
}

@end
