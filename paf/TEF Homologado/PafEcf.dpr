program PafEcf;

uses
  Forms,
  VendaDetalheVO in 'VO\VendaDetalheVO.pas',
  BancoVO in 'VO\BancoVO.pas',
  CaixaVO in 'VO\CaixaVO.pas',
  CFOPVO in 'VO\CFOPVO.pas',
  ChequeClienteVO in 'VO\ChequeClienteVO.pas',
  ClienteVO in 'VO\ClienteVO.pas',
  ConfiguracaoVO in 'VO\ConfiguracaoVO.pas',
  ContatoEmailVO in 'VO\ContatoEmailVO.pas',
  ContatoTelefoneVO in 'VO\ContatoTelefoneVO.pas',
  ContatoVO in 'VO\ContatoVO.pas',
  DAVDetalheVO in 'VO\DAVDetalheVO.pas',
  DAVVO in 'VO\DAVVO.pas',
  DocumentosEmitidosVO in 'VO\DocumentosEmitidosVO.pas',
  EmpresaVO in 'VO\EmpresaVO.pas',
  EnderecoVO in 'VO\EnderecoVO.pas',
  FuncionarioVO in 'VO\FuncionarioVO.pas',
  ImpressoraVO in 'VO\ImpressoraVO.pas',
  MovimentoVO in 'VO\MovimentoVO.pas',
  NF2CabecalhoVO in 'VO\NF2CabecalhoVO.pas',
  NF2DetalheVO in 'VO\NF2DetalheVO.pas',
  OperadorVO in 'VO\OperadorVO.pas',
  PreVendaDetalheVO in 'VO\PreVendaDetalheVO.pas',
  PreVendaVO in 'VO\PreVendaVO.pas',
  ProdutoVO in 'VO\ProdutoVO.pas',
  R02VO in 'VO\R02VO.pas',
  R03VO in 'VO\R03VO.pas',
  R06VO in 'VO\R06VO.pas',
  R07VO in 'VO\R07VO.pas',
  RecebimentoNaoFiscalVO in 'VO\RecebimentoNaoFiscalVO.pas',
  SangriaVO in 'VO\SangriaVO.pas',
  SituacaoClienteVO in 'VO\SituacaoClienteVO.pas',
  SuprimentoVO in 'VO\SuprimentoVO.pas',
  TipoEmailVO in 'VO\TipoEmailVO.pas',
  TipoPagamentoVO in 'VO\TipoPagamentoVO.pas',
  TipoTelefoneVO in 'VO\TipoTelefoneVO.pas',
  TotalTipoPagamentoVO in 'VO\TotalTipoPagamentoVO.pas',
  UnidadeVO in 'VO\UnidadeVO.pas',
  VendaCabecalhoVO in 'VO\VendaCabecalhoVO.pas',
  MovimentoController in 'Controller\MovimentoController.pas',
  ProdutoController in 'Controller\ProdutoController.pas',
  CaixaController in 'Controller\CaixaController.pas',
  OperadorController in 'Controller\OperadorController.pas',
  VendaController in 'Controller\VendaController.pas',
  TipoPagamentoController in 'Controller\TipoPagamentoController.pas',
  TotalTipoPagamentoController in 'Controller\TotalTipoPagamentoController.pas',
  UArquivoMFD in 'UArquivoMFD.pas' {FArquivoMfd},
  UCaixa in 'UCaixa.pas' {FCaixa},
  UDataModule in 'UDataModule.pas' {FDataModule: TDataModule},
  UDAVEmitidos in 'UDAVEmitidos.pas' {FDavEmitidos},
  UDescontoAcrescimo in 'UDescontoAcrescimo.pas' {FDescontoAcrescimo},
  UECF in 'UECF.pas',
  UEfetuaPagamento in 'UEfetuaPagamento.pas' {FEfetuaPagamento},
  UEncerraMovimento in 'UEncerraMovimento.pas' {FEncerraMovimento},
  UEspelhoMFD in 'UEspelhoMFD.pas' {FEspelhoMfd},
  UIdentificaCliente in 'UIdentificaCliente.pas' {FIdentificaCliente},
  UImportaCliente in 'UImportaCliente.pas' {FImportaCliente},
  UImportaNumero in 'UImportaNumero.pas' {FImportaNumero},
  UIniciaMovimento in 'UIniciaMovimento.pas' {FIniciaMovimento},
  ULMFC in 'ULMFC.pas' {FLmfc},
  ULMFS in 'ULMFS.pas' {FLmfs},
  UMeiosPagamento in 'UMeiosPagamento.pas' {FMeiosPagamento},
  UMesclaDAV in 'UMesclaDAV.pas' {FMesclaDAV},
  UMovimentoAberto in 'UMovimentoAberto.pas' {FMovimentoAberto},
  UPAF in 'UPAF.pas',
  UValorReal in 'UValorReal.pas' {FValorReal},
  UConfiguracao in 'UConfiguracao.pas' {FConfiguracao},
  PosicaoComponentesVO in 'VO\PosicaoComponentesVO.pas',
  ConfiguracaoController in 'Controller\ConfiguracaoController.pas',
  ContadorVO in 'VO\ContadorVO.pas',
  ResolucaoVO in 'VO\ResolucaoVO.pas',
  FichaTecnicaVO in 'VO\FichaTecnicaVO.pas',
  ProdutoPromocaoVO in 'VO\ProdutoPromocaoVO.pas',
  TurnoVO in 'VO\TurnoVO.pas',
  UImportaProduto in 'UImportaProduto.pas' {FImportaProduto},
  Biblioteca in 'Biblioteca.pas',
  VendedorController in 'Controller\VendedorController.pas',
  ClienteController in 'Controller\ClienteController.pas',
  PreVendaController in 'Controller\PreVendaController.pas',
  DAVController in 'Controller\DAVController.pas',
  EmpresaController in 'Controller\EmpresaController.pas',
  ImpressoraController in 'Controller\ImpressoraController.pas',
  EAD_Class in 'EAD_Class.pas',
  RegistroRController in 'Controller\RegistroRController.pas',
  R04VO in 'VO\R04VO.pas',
  R05VO in 'VO\R05VO.pas',
  MeiosPagamentoVO in 'VO\MeiosPagamentoVO.pas',
  USintegra in 'USintegra.pas',
  SintegraController in 'Controller\SintegraController.pas',
  Sintegra60AVO in 'VO\Sintegra60AVO.pas',
  Sintegra60MVO in 'VO\Sintegra60MVO.pas',
  Sintegra60DVO in 'VO\Sintegra60DVO.pas',
  USpedFiscal in 'USpedFiscal.pas',
  ContadorController in 'Controller\ContadorController.pas',
  UnidadeController in 'Controller\UnidadeController.pas',
  NF2Controller in 'Controller\NF2Controller.pas',
  UMesclaPreVenda in 'UMesclaPreVenda.pas' {FMesclaPreVenda},
  ULoginGerenteSupervisor in 'ULoginGerenteSupervisor.pas' {FLoginGerenteSupervisor},
  UMovimentoECF in 'UMovimentoECF.pas' {FMovimentoECF},
  UVendasPeriodo in 'UVendasPeriodo.pas' {FVendasPeriodo},
  R01VO in 'VO\R01VO.pas',
  Sintegra60RVO in 'VO\Sintegra60RVO.pas',
  Sintegra61RVO in 'VO\Sintegra61RVO.pas',
  SpedFiscalC390VO in 'VO\SpedFiscalC390VO.pas',
  SpedFiscalC321VO in 'VO\SpedFiscalC321VO.pas',
  SpedFiscalController in 'Controller\SpedFiscalController.pas',
  SpedFiscalC425VO in 'VO\SpedFiscalC425VO.pas',
  SpedFiscalC490VO in 'VO\SpedFiscalC490VO.pas',
  Constantes in 'Constantes.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'T2Ti PAF-ECF';
  Application.CreateForm(TFCaixa, FCaixa);
  Application.Run;
end.
