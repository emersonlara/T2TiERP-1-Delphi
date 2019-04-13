unit UFolha;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ACBrFolha, ComCtrls, StdCtrls, ExtCtrls;

type
  TForm1 = class(TForm)
    ACBrFolha: TACBrFolha;
    PageControl1: TPageControl;
    TabSheet2: TTabSheet;
    EditCnpj: TLabeledEdit;
    EditInscricaoEstadual: TLabeledEdit;
    EditRazaoSocial: TLabeledEdit;
    Memo2: TMemo;
    Button2: TButton;
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button2Click(Sender: TObject);
var
  i: Integer;
begin
  ACBrFolha.Folha_Sefip.LimpaRegistros;

  // REGISTRO TIPO 00 – Informações do Responsável (Header do arquivo)
  ACBrFolha.Folha_Sefip.RegistroTipo00.TipoRemessa := '1'; //1=GFIP
  ACBrFolha.Folha_Sefip.RegistroTipo00.TipoInscricaoResponsavel := '1'; //1=CNPJ
  ACBrFolha.Folha_Sefip.RegistroTipo00.InscricaoResponsavel := EditCnpj.Text;
  ACBrFolha.Folha_Sefip.RegistroTipo00.NomeResponsavelRazaoSocial := EditRazaoSocial.Text;
  ACBrFolha.Folha_Sefip.RegistroTipo00.NomePessoaContato := 'PESSOA CONTATO';
  ACBrFolha.Folha_Sefip.RegistroTipo00.Logradouro := 'LOGRADOURO';
  ACBrFolha.Folha_Sefip.RegistroTipo00.Bairro := 'BAIRRO';
  ACBrFolha.Folha_Sefip.RegistroTipo00.Cep := '71000000';
  ACBrFolha.Folha_Sefip.RegistroTipo00.Cidade := 'CIDADE';
  ACBrFolha.Folha_Sefip.RegistroTipo00.UnidadeFederacao := 'DF';
  ACBrFolha.Folha_Sefip.RegistroTipo00.TelefoneContato := '6130425277';
  ACBrFolha.Folha_Sefip.RegistroTipo00.EnderecoInternetContato := 't2ti.com@gmail.com';
  ACBrFolha.Folha_Sefip.RegistroTipo00.Competencia := now;

  ACBrFolha.Folha_Sefip.RegistroTipo00.CodigoRecolhimento := '115'; // 115 Recolhimento ao FGTS e informações à Previdência Social.
  ACBrFolha.Folha_Sefip.RegistroTipo00.IndicadorRecolhimentoFGTS := '1';
  ACBrFolha.Folha_Sefip.RegistroTipo00.ModalidadeArquivo := '1';
  ACBrFolha.Folha_Sefip.RegistroTipo00.TipoInscricaoFornecedorFolhaPagamento := '1'; //1=CNPJ
  ACBrFolha.Folha_Sefip.RegistroTipo00.InscricaoFornecedorFolhaPagamento := EditCnpj.Text;

  //REGISTRO TIPO 10 – Informações da Empresa (Header da empresa )
  ACBrFolha.Folha_Sefip.RegistroTipo10.TipoInscricaoEmpresa := '1'; //1=CNPJ
  ACBrFolha.Folha_Sefip.RegistroTipo10.InscricaoEmpresa := EditCnpj.Text;
  ACBrFolha.Folha_Sefip.RegistroTipo10.NomeEmpresaRazaoSocial := EditRazaoSocial.Text;
  ACBrFolha.Folha_Sefip.RegistroTipo10.Logradouro := 'LOGRADOURO';
  ACBrFolha.Folha_Sefip.RegistroTipo10.Bairro := 'BAIRRO';
  ACBrFolha.Folha_Sefip.RegistroTipo10.Cep := '71000000';
  ACBrFolha.Folha_Sefip.RegistroTipo10.Cidade := 'CIDADE';
  ACBrFolha.Folha_Sefip.RegistroTipo10.UnidadeFederacao := 'DF';
  ACBrFolha.Folha_Sefip.RegistroTipo10.TelefoneContato := '6130425277';
  ACBrFolha.Folha_Sefip.RegistroTipo10.IndicadorAlteracaoEndereco := 'N';
  ACBrFolha.Folha_Sefip.RegistroTipo10.CNAE:= '1234567';
  ACBrFolha.Folha_Sefip.RegistroTipo10.IndicadorAlteracaoCNAE := 'N';
  ACBrFolha.Folha_Sefip.RegistroTipo10.AliquotaRAT := '10';
  ACBrFolha.Folha_Sefip.RegistroTipo10.CodigoCentralizacao := '1';
  ACBrFolha.Folha_Sefip.RegistroTipo10.SIMPLES := '2';
  ACBrFolha.Folha_Sefip.RegistroTipo10.FPAS := '123';
  ACBrFolha.Folha_Sefip.RegistroTipo10.CodigoOutrasEntidades := '1234';
  ACBrFolha.Folha_Sefip.RegistroTipo10.CodigoPagamentoGPS := '1234';

  //REGISTRO TIPO 12 – Informações Adicionais do Recolhimento da Empresa (Opcional)

  //REGISTRO TIPO 13 – Alteração Cadastral Trabalhador (Opcional)

  //REGISTRO TIPO 14 – Inclusão/Alteração Endereço do Trabalhador (Opcional)

  //REGISTRO TIPO 20 – Registro do Tomador de Serviço/Obra de Construção Civil (Opcional)

  //REGISTRO TIPO 21 - Registro de informações adicionais do Tomador de Serviço/Obra de Const. Civil (Opcional)

  //REGISTRO TIPO 30 - Registro do Trabalhador
  for i := 0 to 10 do
  begin
    with ACBrFolha.Folha_Sefip.RegistroTipo30.New do
    begin
      TipoInscricaoEmpresa := ACBrFolha.Folha_Sefip.RegistroTipo10.TipoInscricaoEmpresa;
      InscricaoEmpresa := ACBrFolha.Folha_Sefip.RegistroTipo10.TipoInscricaoEmpresa;
      PISPASEPCI := '11111111111';
      DataAdmissao := now;
      CategoriaTrabalhador := '01';
      NomeTrabalhador := 'Trabalhador ' + IntToStr(i);
      NumeroCTPS := '1234567';
      SerieCTPS := '12345';
    end;
  end;

  //REGISTRO TIPO 32 – Movimentação do Trabalhador (Opcional)

  //REGISTRO TIPO 50– Empresa Com Recolhimento pelos códigos 027, 046, 604 e 736 (Header da empresa ) (PARA IMPLEMENTAÇÃO FUTURA)

  //REGISTRO TIPO 51 - Registro de Individualização de valores recolhidos pelos códigos 027, 046, 604 e 736 (PARA IMPLEMENTAÇÃO FUTURA)

  //Gera arquivo
  ACBrFolha.SaveFileTXT_Sefip('SEFIP.RE');
  ShowMessage('Arquivo gerado com sucesso!');
end;

end.
