program T2TiERPCadastrosBase;

uses
  Forms,
  Windows,
  Dialogs,
  UDataModule in '..\Comum\Tela\UDataModule.pas' { FDataModule: TDataModule },
  UFiltro in '..\Comum\Tela\UFiltro.pas' { FFiltro },
  ULogin in '..\Comum\Tela\ULogin.pas' { FLogin },
  ULookup in '..\Comum\Tela\ULookup.pas' { FLookup },
  UBanco in 'Tela\UBanco.pas' { FBanco },
  BancoController in 'Controller\BancoController.pas',
  UnidadeProdutoController in 'Controller\UnidadeProdutoController.pas',
  SessaoUsuario in '..\Comum\SessaoUsuario.pas',
  Tipos in '..\Comum\Tipos.pas',
  Atributos in '..\..\Comum\Atributos.pas',
  Biblioteca in '..\..\Comum\Biblioteca.pas',
  BancoVO in '..\..\Comum\VO\BancoVO.pas',
  ColaboradorVO in '..\..\Comum\VO\ColaboradorVO.pas',
  FuncaoVO in '..\..\Comum\VO\FuncaoVO.pas',
  JSonVO in '..\..\Comum\VO\JSonVO.pas',
  PaisVO in '..\..\Comum\VO\PaisVO.pas',
  PapelFuncaoVO in '..\..\Comum\VO\PapelFuncaoVO.pas',
  PapelVO in '..\..\Comum\VO\PapelVO.pas',
  UnidadeProdutoVO in '..\..\Comum\VO\UnidadeProdutoVO.pas',
  UsuarioVO in '..\..\Comum\VO\UsuarioVO.pas',
  Controller in '..\Comum\Controller\Controller.pas',
  UsuarioController in '..\Comum\Controller\UsuarioController.pas',
  PaisController in 'Controller\PaisController.pas',
  NotificationService in '..\Comum\NotificationService.pas',
  Constantes in '..\..\Comum\Constantes.pas',
  UUnidadeProduto in 'Tela\UUnidadeProduto.pas' { FUnidadeProduto },
  Conversor in '..\Comum\Conversor.pas',
  UEstadoCivil in 'Tela\UEstadoCivil.pas' { FEstadoCivil },
  UPessoa in 'Tela\UPessoa.pas' { FPessoa },
  EstadoCivilVO in '..\..\Comum\VO\EstadoCivilVO.pas',
  EstadoCivilController in 'Controller\EstadoCivilController.pas',
  PessoaFisicaVO in '..\..\Comum\VO\PessoaFisicaVO.pas',
  PessoaJuridicaVO in '..\..\Comum\VO\PessoaJuridicaVO.pas',
  PessoaVO in '..\..\Comum\VO\PessoaVO.pas',
  PessoaController in 'Controller\PessoaController.pas',
  FuncaoController in '..\Comum\Controller\FuncaoController.pas',
  PapelController in '..\Comum\Controller\PapelController.pas',
  PapelFuncaoController in '..\Comum\Controller\PapelFuncaoController.pas',
  UMarcaProduto in 'Tela\UMarcaProduto.pas' { FMarcaProduto },
  UPais in 'Tela\UPais.pas' { FPais },
  ContatoVO in '..\..\Comum\VO\ContatoVO.pas',
  EnderecoVO in '..\..\Comum\VO\EnderecoVO.pas',
  SetorVO in '..\..\Comum\VO\SetorVO.pas',
  USetor in 'Tela\USetor.pas' { FSetor },
  SetorController in 'Controller\SetorController.pas',
  UAgenciaBanco in 'Tela\UAgenciaBanco.pas' { FAgenciaBanco },
  AgenciaBancoVO in '..\..\Comum\VO\AgenciaBancoVO.pas',
  AgenciaBancoController in 'Controller\AgenciaBancoController.pas',
  UGrupoProduto in 'Tela\UGrupoProduto.pas' { FGrupoProduto },
  USubGrupoProduto in 'Tela\USubGrupoProduto.pas' { FSubGrupoProduto },
  UAlmoxarifado in 'Tela\UAlmoxarifado.pas' { FAlmoxarifado },
  AlmoxarifadoVO in '..\..\Comum\VO\AlmoxarifadoVO.pas',
  NcmVO in '..\..\Comum\VO\NcmVO.pas',
  AlmoxarifadoController in 'Controller\AlmoxarifadoController.pas',
  UNcm in 'Tela\UNcm.pas' { FNcm },
  NcmController in 'Controller\NcmController.pas',
  ColaboradorController in '..\Comum\Controller\ColaboradorController.pas',
  MunicipioController in 'Controller\MunicipioController.pas',
  UfController in 'Controller\UfController.pas',
  MunicipioVO in '..\..\Comum\VO\MunicipioVO.pas',
  UfVO in '..\..\Comum\VO\UfVO.pas',
  UUf in 'Tela\UUf.pas' { FUf },
  UMunicipio in 'Tela\UMunicipio.pas' { FMunicipio },
  TipoRelacionamentoController in 'Controller\TipoRelacionamentoController.pas',
  TipoRelacionamentoVO in '..\..\Comum\VO\TipoRelacionamentoVO.pas',
  UTipoRelacionamento in 'Tela\UTipoRelacionamento.pas' { FTipoRelacionamento },
  TipoAdmissaoVO in '..\..\Comum\VO\TipoAdmissaoVO.pas',
  TipoAdmissaoController in 'Controller\TipoAdmissaoController.pas',
  UTipoAdmissao in 'Tela\UTipoAdmissao.pas' { FTipoAdmissao },
  NivelFormacaoVO in '..\..\Comum\VO\NivelFormacaoVO.pas',
  NivelFormacaoController in 'Controller\NivelFormacaoController.pas',
  UNivelFormacao in 'Tela\UNivelFormacao.pas' { FNivelFormacao },
  CfopController in 'Controller\CfopController.pas',
  CfopVO in '..\..\Comum\VO\CfopVO.pas',
  UCfop in 'Tela\UCfop.pas' { FCfop },
  CboController in 'Controller\CboController.pas',
  CboVO in '..\..\Comum\VO\CboVO.pas',
  UCbo in 'Tela\UCbo.pas' { FCbo },
  CargoController in 'Controller\CargoController.pas',
  CargoVO in '..\..\Comum\VO\CargoVO.pas',
  UCargo in 'Tela\UCargo.pas' { FCargo },
  SituacaoForCliController in 'Controller\SituacaoForCliController.pas',
  AtividadeForCliController in 'Controller\AtividadeForCliController.pas',
  SituacaoForCliVO in '..\..\Comum\VO\SituacaoForCliVO.pas',
  AtividadeForCliVO in '..\..\Comum\VO\AtividadeForCliVO.pas',
  USituacaoForCli in 'Tela\USituacaoForCli.pas' { FSituacaoForCli },
  UAtividadeForCli in 'Tela\UAtividadeForCli.pas' { FAtividadeForCli },
  ProdutoController in 'Controller\ProdutoController.pas',
  UProduto in 'Tela\UProduto.pas' { FProduto },
  ProdutoVO in '..\..\Comum\VO\ProdutoVO.pas',
  UBaseCreditoPis in 'Tela\UBaseCreditoPis.pas' { FBaseCreditoPis },
  BaseCreditoPisController in 'Controller\BaseCreditoPisController.pas',
  BaseCreditoPisVO in '..\..\Comum\VO\BaseCreditoPisVO.pas',
  UCep in 'Tela\UCep.pas' { FCep },
  CepController in 'Controller\CepController.pas',
  CepVO in '..\..\Comum\VO\CepVO.pas',
  UCheque in 'Tela\UCheque.pas' { FCheque },
  ChequeController in 'Controller\ChequeController.pas',
  ChequeVO in '..\..\Comum\VO\ChequeVO.pas',
  UTalonarioCheque in 'Tela\UTalonarioCheque.pas' { FTalonarioCheque },
  TalonarioChequeController in 'Controller\TalonarioChequeController.pas',
  TalonarioChequeVO in '..\..\Comum\VO\TalonarioChequeVO.pas',
  UContaCaixa in 'Tela\UContaCaixa.pas' { FContaCaixa },
  ContaCaixaController in 'Controller\ContaCaixaController.pas',
  ContaCaixaVO in '..\..\Comum\VO\ContaCaixaVO.pas',
  ContabilContaController in 'Controller\ContabilContaController.pas',
  ContabilContaVO in '..\..\Comum\VO\ContabilContaVO.pas',
  ConvenioVO in '..\..\Comum\VO\ConvenioVO.pas',
  ConvenioController in 'Controller\ConvenioController.pas',
  UConvenio in 'Tela\UConvenio.pas' { FConvenio },
  UOperadoraCartao in 'Tela\UOperadoraCartao.pas' { FOperadoraCartao },
  OperadoraCartaoController in 'Controller\OperadoraCartaoController.pas',
  OperadoraCartaoVO in '..\..\Comum\VO\OperadoraCartaoVO.pas',
  UOperadoraPlanoSaude in 'Tela\UOperadoraPlanoSaude.pas' { FOperadoraPlanoSaude },
  OperadoraPlanoSaudeController in 'Controller\OperadoraPlanoSaudeController.pas',
  OperadoraPlanoSaudeVO in '..\..\Comum\VO\OperadoraPlanoSaudeVO.pas',
  USindicato in 'Tela\USindicato.pas' { FSindicato },
  SindicatoController in 'Controller\SindicatoController.pas',
  SindicatoVO in '..\..\Comum\VO\SindicatoVO.pas',
  USituacaoColaborador in 'Tela\USituacaoColaborador.pas' { FSituacaoColaborador },
  SituacaoColaboradorController in 'Controller\SituacaoColaboradorController.pas',
  SituacaoColaboradorVO in '..\..\Comum\VO\SituacaoColaboradorVO.pas',
  UTipoColaborador in 'Tela\UTipoColaborador.pas' { FTipoColaborador },
  TipoColaboradorController in 'Controller\TipoColaboradorController.pas',
  TipoColaboradorVO in '..\..\Comum\VO\TipoColaboradorVO.pas',
  TributGrupoTributarioVO in '..\..\Comum\VO\TributGrupoTributarioVO.pas',
  USalarioMinimo in 'Tela\USalarioMinimo.pas' { FSalarioMinimo },
  SalarioMinimoController in 'Controller\SalarioMinimoController.pas',
  SalarioMinimoVO in '..\..\Comum\VO\SalarioMinimoVO.pas',
  UTipoDesligamento in 'Tela\UTipoDesligamento.pas' { FTipoDesligamento },
  CodigoGpsController in 'Controller\CodigoGpsController.pas',
  CodigoGpsVO in '..\..\Comum\VO\CodigoGpsVO.pas',
  UCodigoGps in 'Tela\UCodigoGps.pas' { FCodigoGps },
  TipoDesligamentoController in 'Controller\TipoDesligamentoController.pas',
  TipoDesligamentoVO in '..\..\Comum\VO\TipoDesligamentoVO.pas',
  SefipCodigoMovimentacaoController in 'Controller\SefipCodigoMovimentacaoController.pas',
  SefipCodigoMovimentacaoVO in '..\..\Comum\VO\SefipCodigoMovimentacaoVO.pas',
  SefipCodigoRecolhimentoController in 'Controller\SefipCodigoRecolhimentoController.pas',
  SefipCodigoRecolhimentoVO in '..\..\Comum\VO\SefipCodigoRecolhimentoVO.pas',
  USefipCategoriaTrabalho in 'Tela\USefipCategoriaTrabalho.pas' { FSefipCategoriaTrabalho },
  SefipCategoriaTrabalhoController in 'Controller\SefipCategoriaTrabalhoController.pas',
  SefipCategoriaTrabalhoVO in '..\..\Comum\VO\SefipCategoriaTrabalhoVO.pas',
  USpedPis4313 in 'Tela\USpedPis4313.pas' { FSpedPis4313 },
  UTipoItemSped in 'Tela\UTipoItemSped.pas' { FTipoItemSped },
  TipoItemSpedController in 'Controller\TipoItemSpedController.pas',
  TipoItemSpedVO in '..\..\Comum\VO\TipoItemSpedVO.pas',
  USefipCodigoMovimentacao in 'Tela\USefipCodigoMovimentacao.pas' { FSefipCodigoMovimentacao },
  SpedPis4310Controller in 'Controller\SpedPis4310Controller.pas',
  SpedPis4310VO in '..\..\Comum\VO\SpedPis4310VO.pas',
  USefipCodigoRecolhimento in 'Tela\USefipCodigoRecolhimento.pas' { FSefipCodigoRecolhimento },
  SpedPis4313Controller in 'Controller\SpedPis4313Controller.pas',
  SpedPis4313VO in '..\..\Comum\VO\SpedPis4313VO.pas',
  USpedPis4310 in 'Tela\USpedPis4310.pas' { FSpedPis4310 },
  SpedPis439Controller in 'Controller\SpedPis439Controller.pas',
  SpedPis4314Controller in 'Controller\SpedPis4314Controller.pas',
  SpedPis4315Controller in 'Controller\SpedPis4315Controller.pas',
  SpedPis4316Controller in 'Controller\SpedPis4316Controller.pas',
  SpedPis4316VO in '..\..\Comum\VO\SpedPis4316VO.pas',
  SpedPis439VO in '..\..\Comum\VO\SpedPis439VO.pas',
  SpedPis4314VO in '..\..\Comum\VO\SpedPis4314VO.pas',
  SpedPis4315VO in '..\..\Comum\VO\SpedPis4315VO.pas',
  USpedPis439 in 'Tela\USpedPis439.pas' { FSpedPis439 },
  USpedPis4316 in 'Tela\USpedPis4316.pas' { FSpedPis4316 },
  USpedPis4315 in 'Tela\USpedPis4315.pas' { FSpedPis4315 },
  USpedPis4314 in 'Tela\USpedPis4314.pas' { FSpedPis4314 },
  TipoCreditoPisController in 'Controller\TipoCreditoPisController.pas',
  UTipoCreditoPis in 'Tela\UTipoCreditoPis.pas' { FTipoCreditoPis },
  TipoCreditoPisVO in '..\..\Comum\VO\TipoCreditoPisVO.pas',
  SituacaoDocumentoController in 'Controller\SituacaoDocumentoController.pas',
  USituacaoDocumento in 'Tela\USituacaoDocumento.pas' { FSituacaoDocumento },
  SituacaoDocumentoVO in '..\..\Comum\VO\SituacaoDocumentoVO.pas',
  FeriadosController in 'Controller\FeriadosController.pas',
  CstIpiController in 'Controller\CstIpiController.pas',
  CstPisController in 'Controller\CstPisController.pas',
  CstCofinsController in 'Controller\CstCofinsController.pas',
  CstIcmsBController in 'Controller\CstIcmsBController.pas',
  CstIcmsAController in 'Controller\CstIcmsAController.pas',
  CsosnBController in 'Controller\CsosnBController.pas',
  CsosnAController in 'Controller\CsosnAController.pas',
  FeriadosVO in '..\..\Comum\VO\FeriadosVO.pas',
  CstIpiVO in '..\..\Comum\VO\CstIpiVO.pas',
  CstPisVO in '..\..\Comum\VO\CstPisVO.pas',
  CstCofinsVO in '..\..\Comum\VO\CstCofinsVO.pas',
  CstIcmsBVO in '..\..\Comum\VO\CstIcmsBVO.pas',
  CstIcmsAVO in '..\..\Comum\VO\CstIcmsAVO.pas',
  CsosnBVO in '..\..\Comum\VO\CsosnBVO.pas',
  CsosnAVO in '..\..\Comum\VO\CsosnAVO.pas',
  UCsosnA in 'Tela\UCsosnA.pas' { FCsosnA },
  UCsosnB in 'Tela\UCsosnB.pas' { FCsosnB },
  UCstIcmsA in 'Tela\UCstIcmsA.pas' { FCstIcmsA },
  UCstIcmsB in 'Tela\UCstIcmsB.pas' { FCstIcmsB },
  UCstPis in 'Tela\UCstPis.pas' { FCstPis },
  UCstCofins in 'Tela\UCstCofins.pas' { FCstCofins },
  UCstIpi in 'Tela\UCstIpi.pas' { FCstIpi },
  UFeriados in 'Tela\UFeriados.pas' { FFeriados },
  EmpresaVO in '..\..\Comum\VO\EmpresaVO.pas',
  UContador in 'Tela\UContador.pas' { FContador },
  ContadorVO in '..\..\Comum\VO\ContadorVO.pas',
  ContadorController in 'Controller\ContadorController.pas',
  TributGrupoTributarioController in 'Controller\TributGrupoTributarioController.pas',
  FpasVO in '..\..\Comum\VO\FpasVO.pas',
  ContatoController in 'Controller\ContatoController.pas',
  EnderecoController in 'Controller\EnderecoController.pas',
  FpasController in 'Controller\FpasController.pas',
  AdministrativoFormularioVO in '..\..\Comum\VO\AdministrativoFormularioVO.pas',
  EmpresaSessaoVO in '..\..\Comum\VO\EmpresaSessaoVO.pas',
  EmpresaController in '..\Comum\Controller\EmpresaController.pas',
  ViewSessaoEmpresaController in '..\Comum\Controller\ViewSessaoEmpresaController.pas',
  ViewSessaoEmpresaVO in '..\..\Comum\VO\ViewSessaoEmpresaVO.pas',
  UBase in '..\Comum\Tela\UBase.pas' {FBase},
  UTela in '..\Comum\Tela\UTela.pas' {FTela},
  UTelaCadastro in '..\Comum\Tela\UTelaCadastro.pas' {FTelaCadastro},
  UMenu in 'Tela\UMenu.pas' {FMenu},
  UAtualizaEXE in '..\Comum\Tela\UAtualizaEXE.pas' {FAtualizaEXE},
  ProdutoSubGrupoController in 'Controller\ProdutoSubGrupoController.pas',
  ProdutoGrupoController in 'Controller\ProdutoGrupoController.pas',
  ProdutoMarcaController in 'Controller\ProdutoMarcaController.pas',
  ProdutoSubGrupoVO in '..\..\Comum\VO\ProdutoSubGrupoVO.pas',
  ProdutoGrupoVO in '..\..\Comum\VO\ProdutoGrupoVO.pas',
  ProdutoMarcaVO in '..\..\Comum\VO\ProdutoMarcaVO.pas',
  TributIcmsCustomCabController in 'Controller\TributIcmsCustomCabController.pas',
  TributIcmsCustomCabVO in '..\..\Comum\VO\TributIcmsCustomCabVO.pas',
  TributIcmsCustomDetVO in '..\..\Comum\VO\TributIcmsCustomDetVO.pas',
  PlanoContaVO in '..\..\Comum\VO\PlanoContaVO.pas',
  PlanoContaRefSpedVO in '..\..\Comum\VO\PlanoContaRefSpedVO.pas',
  UCliente in 'Tela\UCliente.pas' {FCliente},
  ClienteVO in '..\..\Comum\VO\ClienteVO.pas',
  TributOperacaoFiscalVO in '..\..\Comum\VO\TributOperacaoFiscalVO.pas',
  ClienteController in 'Controller\ClienteController.pas',
  TributOperacaoFiscalController in 'Controller\TributOperacaoFiscalController.pas',
  UFornecedor in 'Tela\UFornecedor.pas' {FFornecedor},
  FornecedorVO in '..\..\Comum\VO\FornecedorVO.pas',
  FornecedorController in 'Controller\FornecedorController.pas',
  UTransportadora in 'Tela\UTransportadora.pas' {FTransportadora},
  TransportadoraController in 'Controller\TransportadoraController.pas',
  TransportadoraVO in '..\..\Comum\VO\TransportadoraVO.pas',
  UColaborador in 'Tela\UColaborador.pas' {FColaborador};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'T2Ti ERP Cadastros Base';
  Application.CreateForm(TFAtualizaEXE, FAtualizaEXE);
  Application.Run;

end.
