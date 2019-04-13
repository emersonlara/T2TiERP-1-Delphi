program T2TiERPConciliacaoContabil;

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
  PessoaFisicaVO in '..\..\Comum\VO\PessoaFisicaVO.pas',
  PessoaJuridicaVO in '..\..\Comum\VO\PessoaJuridicaVO.pas',
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
  UConciliacaoBancaria in 'Tela\UConciliacaoBancaria.pas' {FConciliacaoBancaria},
  ContaCaixaController in 'Controller\ContaCaixaController.pas',
  ContaCaixaVO in '..\..\Comum\VO\ContaCaixaVO.pas',
  ContabilContaController in 'Controller\ContabilContaController.pas',
  AgenciaBancoVO in '..\..\Comum\VO\AgenciaBancoVO.pas',
  BancoVO in '..\..\Comum\VO\BancoVO.pas',
  ContabilLancamentoDetalheVO in '..\..\Comum\VO\ContabilLancamentoDetalheVO.pas',
  ContabilLancamentoDetalheController in 'Controller\ContabilLancamentoDetalheController.pas',
  PessoaVO in '..\..\Comum\VO\PessoaVO.pas',
  UConciliacaoCliente in 'Tela\UConciliacaoCliente.pas' {FConciliacaoCliente},
  ParcelaRecebimentoController in 'Controller\ParcelaRecebimentoController.pas',
  PessoaController in 'Controller\PessoaController.pas',
  UConciliacaoFornecedor in 'Tela\UConciliacaoFornecedor.pas' {FConciliacaoFornecedor},
  ParcelaPagamentoController in 'Controller\ParcelaPagamentoController.pas',
  ContabilLancamentoCabecalhoController in 'Controller\ContabilLancamentoCabecalhoController.pas',
  UConciliaContabilLancamento in 'Tela\UConciliaContabilLancamento.pas' {FConciliaContabilLancamento},
  ContabilLancamentoCabecalhoVO in '..\..\Comum\VO\ContabilLancamentoCabecalhoVO.pas',
  ContabilLoteVO in '..\..\Comum\VO\ContabilLoteVO.pas',
  UComposicaoSaldo in 'Tela\UComposicaoSaldo.pas' {FComposicaoSaldo},
  ContabilContaVO in '..\..\Comum\VO\ContabilContaVO.pas',
  ViewSessaoEmpresaController in '..\Comum\Controller\ViewSessaoEmpresaController.pas',
  EmpresaController in '..\Comum\Controller\EmpresaController.pas',
  ViewSessaoEmpresaVO in '..\..\Comum\VO\ViewSessaoEmpresaVO.pas',
  EmpresaSessaoVO in '..\..\Comum\VO\EmpresaSessaoVO.pas',
  AdministrativoFormularioVO in '..\..\Comum\VO\AdministrativoFormularioVO.pas',
  PlanoContaVO in '..\..\Comum\VO\PlanoContaVO.pas',
  PlanoContaRefSpedVO in '..\..\Comum\VO\PlanoContaRefSpedVO.pas',
  FinExtratoContaBancoVO in '..\..\Comum\VO\FinExtratoContaBancoVO.pas',
  FinParcelaPagamentoVO in '..\..\Comum\VO\FinParcelaPagamentoVO.pas',
  FinParcelaRecebimentoVO in '..\..\Comum\VO\FinParcelaRecebimentoVO.pas',
  FinTipoRecebimentoVO in '..\..\Comum\VO\FinTipoRecebimentoVO.pas',
  FinChequeRecebidoVO in '..\..\Comum\VO\FinChequeRecebidoVO.pas',
  FinTipoPagamentoVO in '..\..\Comum\VO\FinTipoPagamentoVO.pas',
  FinChequeEmitidoVO in '..\..\Comum\VO\FinChequeEmitidoVO.pas',
  ChequeVO in '..\..\Comum\VO\ChequeVO.pas',
  TalonarioChequeVO in '..\..\Comum\VO\TalonarioChequeVO.pas',
  FinExtratoContaBancoController in 'Controller\FinExtratoContaBancoController.pas',
  PessoaFisicaJuridicaVO in '..\..\Comum\VO\PessoaFisicaJuridicaVO.pas',
  ClienteController in 'Controller\ClienteController.pas',
  ClienteVO in '..\..\Comum\VO\ClienteVO.pas',
  SituacaoForCliVO in '..\..\Comum\VO\SituacaoForCliVO.pas',
  ContatoVO in '..\..\Comum\VO\ContatoVO.pas',
  EnderecoVO in '..\..\Comum\VO\EnderecoVO.pas',
  AtividadeForCliVO in '..\..\Comum\VO\AtividadeForCliVO.pas',
  TributOperacaoFiscalVO in '..\..\Comum\VO\TributOperacaoFiscalVO.pas',
  CfopVO in '..\..\Comum\VO\CfopVO.pas',
  ViewConciliaClienteController in 'Controller\ViewConciliaClienteController.pas',
  ViewConciliaClienteVO in '..\..\Comum\VO\ViewConciliaClienteVO.pas',
  ViewConciliaFornecedorVO in '..\..\Comum\VO\ViewConciliaFornecedorVO.pas',
  ViewConciliaFornecedorController in 'Controller\ViewConciliaFornecedorController.pas',
  FornecedorController in 'Controller\FornecedorController.pas',
  FornecedorVO in '..\..\Comum\VO\FornecedorVO.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'T2Ti ERP Concilia��o Cont�bil';
  Application.CreateForm(TFMenu, FMenu);
  Application.CreateForm(TFDataModule, FDataModule);
  Application.Run;
end.
