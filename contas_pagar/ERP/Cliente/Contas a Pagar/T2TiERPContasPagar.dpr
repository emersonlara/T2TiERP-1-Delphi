program T2TiERPContasPagar;

uses
  Forms,
  Windows,
  Dialogs,
  Tipos in '..\Comum\Tipos.pas',
  Conversor in '..\Comum\Conversor.pas',
  NotificationService in '..\Comum\NotificationService.pas',
  SessaoUsuario in '..\Comum\SessaoUsuario.pas',
  UsuarioController in '..\Comum\Controller\UsuarioController.pas',
  Controller in '..\Comum\Controller\Controller.pas',
  FuncaoController in '..\Comum\Controller\FuncaoController.pas',
  PapelController in '..\Comum\Controller\PapelController.pas',
  PapelFuncaoController in '..\Comum\Controller\PapelFuncaoController.pas',
  UTelaCadastro in '..\Comum\Tela\UTelaCadastro.pas' {FTelaCadastro},
  UTela in '..\Comum\Tela\UTela.pas' {FTela},
  ULookup in '..\Comum\Tela\ULookup.pas' {FLookup},
  UBase in '..\Comum\Tela\UBase.pas' {FBase},
  UDataModule in '..\Comum\Tela\UDataModule.pas' {FDataModule: TDataModule},
  UFiltro in '..\Comum\Tela\UFiltro.pas' {FFiltro},
  ULogin in '..\Comum\Tela\ULogin.pas' {FLogin},
  UMenu in 'Tela\UMenu.pas' {FMenu},
  Atributos in '..\..\Comum\Atributos.pas',
  Biblioteca in '..\..\Comum\Biblioteca.pas',
  Constantes in '..\..\Comum\Constantes.pas',
  FuncaoVO in '..\..\Comum\VO\FuncaoVO.pas',
  JSonVO in '..\..\Comum\VO\JSonVO.pas',
  UsuarioVO in '..\..\Comum\VO\UsuarioVO.pas',
  PapelVO in '..\..\Comum\VO\PapelVO.pas',
  PapelFuncaoVO in '..\..\Comum\VO\PapelFuncaoVO.pas',
  FinLancamentoPagarController in 'Controller\FinLancamentoPagarController.pas',
  NaturezaFinanceiraController in 'Controller\NaturezaFinanceiraController.pas',
  FinParcelaPagamentoController in 'Controller\FinParcelaPagamentoController.pas',
  FinTipoPagamentoController in 'Controller\FinTipoPagamentoController.pas',
  FinLancamentoPagarVO in '..\..\Comum\VO\FinLancamentoPagarVO.pas',
  NaturezaFinanceiraVO in '..\..\Comum\VO\NaturezaFinanceiraVO.pas',
  FinParcelaPagarVO in '..\..\Comum\VO\FinParcelaPagarVO.pas',
  FinTipoPagamentoVO in '..\..\Comum\VO\FinTipoPagamentoVO.pas',
  UFinTipoPagamento in 'Tela\UFinTipoPagamento.pas' {FFinTipoPagamento},
  UFinDocumentoOrigem in 'Tela\UFinDocumentoOrigem.pas' {FFinDocumentoOrigem},
  FinDocumentoOrigemVO in '..\..\Comum\VO\FinDocumentoOrigemVO.pas',
  FinDocumentoOrigemController in 'Controller\FinDocumentoOrigemController.pas',
  PlanoCentroResultadoController in 'Controller\PlanoCentroResultadoController.pas',
  PlanoCentroResultadoVO in '..\..\Comum\VO\PlanoCentroResultadoVO.pas',
  UPlanoCentroResultado in 'Tela\UPlanoCentroResultado.pas' {FPlanoCentroResultado},
  UCentroResultado in 'Tela\UCentroResultado.pas' {FCentroResultado},
  CentroResultadoVO in '..\..\Comum\VO\CentroResultadoVO.pas',
  CentroResultadoController in 'Controller\CentroResultadoController.pas',
  PlanoNaturezaFinanceiraController in 'Controller\PlanoNaturezaFinanceiraController.pas',
  PlanoNaturezaFinanceiraVO in '..\..\Comum\VO\PlanoNaturezaFinanceiraVO.pas',
  UPlanoNaturezaFinanceira in 'Tela\UPlanoNaturezaFinanceira.pas' {FPlanoNaturezaFinanceira},
  UNaturezaFinanceira in 'Tela\UNaturezaFinanceira.pas' {FNaturezaFinanceira},
  ContabilContaController in '..\Cadastros Base\Controller\ContabilContaController.pas',
  ContabilContaVO in '..\..\Comum\VO\ContabilContaVO.pas',
  FinStatusParcelaVO in '..\..\Comum\VO\FinStatusParcelaVO.pas',
  UFinStatusParcela in 'Tela\UFinStatusParcela.pas' {FFinStatusParcela},
  FinStatusParcelaController in 'Controller\FinStatusParcelaController.pas',
  UFinLancamentoPagar in 'Tela\UFinLancamentoPagar.pas' {FFinLancamentoPagar},
  PessoaVO in '..\..\Comum\VO\PessoaVO.pas',
  EnderecoVO in '..\..\Comum\VO\EnderecoVO.pas',
  ContatoVO in '..\..\Comum\VO\ContatoVO.pas',
  PessoaFisicaVO in '..\..\Comum\VO\PessoaFisicaVO.pas',
  PessoaJuridicaVO in '..\..\Comum\VO\PessoaJuridicaVO.pas',
  PessoaController in '..\Cadastros Base\Controller\PessoaController.pas',
  UFinParcelaPagamento in 'Tela\UFinParcelaPagamento.pas' {FFinParcelaPagamento},
  FinParcelaPagamentoVO in '..\..\Comum\VO\FinParcelaPagamentoVO.pas',
  FinParcelaPagarController in 'Controller\FinParcelaPagarController.pas',
  ColaboradorVO in '..\..\Comum\VO\ColaboradorVO.pas',
  SetorVO in '..\..\Comum\VO\SetorVO.pas',
  CargoVO in '..\..\Comum\VO\CargoVO.pas',
  EmpresaVO in '..\..\Comum\VO\EmpresaVO.pas',
  UfVO in '..\..\Comum\VO\UfVO.pas',
  PaisVO in '..\..\Comum\VO\PaisVO.pas',
  ContadorVO in '..\..\Comum\VO\ContadorVO.pas',
  FpasVO in '..\..\Comum\VO\FpasVO.pas',
  SindicatoVO in '..\..\Comum\VO\SindicatoVO.pas',
  NivelFormacaoVO in '..\..\Comum\VO\NivelFormacaoVO.pas',
  TipoColaboradorVO in '..\..\Comum\VO\TipoColaboradorVO.pas',
  SituacaoColaboradorVO in '..\..\Comum\VO\SituacaoColaboradorVO.pas',
  TipoAdmissaoVO in '..\..\Comum\VO\TipoAdmissaoVO.pas',
  FinLctoPagarNtFinanceiraVO in '..\..\Comum\VO\FinLctoPagarNtFinanceiraVO.pas',
  FornecedorPessoaVO in '..\..\Comum\VO\FornecedorPessoaVO.pas',
  EmpresaSessaoVO in '..\..\Comum\VO\EmpresaSessaoVO.pas',
  AdministrativoFormularioVO in '..\..\Comum\VO\AdministrativoFormularioVO.pas',
  EmpresaController in '..\Comum\Controller\EmpresaController.pas',
  ViewSessaoEmpresaController in '..\Comum\Controller\ViewSessaoEmpresaController.pas',
  ViewSessaoEmpresaVO in '..\..\Comum\VO\ViewSessaoEmpresaVO.pas',
  ContaCaixaVO in '..\..\Comum\VO\ContaCaixaVO.pas',
  ContaCaixaController in '..\Cadastros Base\Controller\ContaCaixaController.pas',
  AgenciaBancoVO in '..\..\Comum\VO\AgenciaBancoVO.pas',
  BancoVO in '..\..\Comum\VO\BancoVO.pas',
  FornecedorController in 'Controller\FornecedorController.pas',
  FornecedorVO in '..\..\Comum\VO\FornecedorVO.pas',
  AtividadeForCliVO in '..\..\Comum\VO\AtividadeForCliVO.pas',
  SituacaoForCliVO in '..\..\Comum\VO\SituacaoForCliVO.pas',
  ViewFinLancamentoPagarController in 'Controller\ViewFinLancamentoPagarController.pas',
  ViewFinLancamentoPagarVO in '..\..\Comum\VO\ViewFinLancamentoPagarVO.pas',
  FinChequeEmitidoVO in '..\..\Comum\VO\FinChequeEmitidoVO.pas',
  ChequeVO in '..\..\Comum\VO\ChequeVO.pas',
  TalonarioChequeVO in '..\..\Comum\VO\TalonarioChequeVO.pas',
  USelecionaCheque in 'Tela\USelecionaCheque.pas' {FSelecionaCheque},
  ViewFinChequesEmSerController in 'Controller\ViewFinChequesEmSerController.pas',
  ViewFinChequesEmSerVO in '..\..\Comum\VO\ViewFinChequesEmSerVO.pas',
  PlanoContaVO in '..\..\Comum\VO\PlanoContaVO.pas',
  PlanoContaRefSpedVO in '..\..\Comum\VO\PlanoContaRefSpedVO.pas',
  AdmParametroVO in '..\..\Comum\VO\AdmParametroVO.pas',
  AdmParametroController in '..\Comum\Controller\AdmParametroController.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'T2Ti ERP Contas a Pagar';
  Application.CreateForm(TFMenu, FMenu);
  Application.CreateForm(TFDataModule, FDataModule);
  Application.Run;
end.