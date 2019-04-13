{ *******************************************************************************
  Title: T2Ti ERP
  Description: Janela de concilia��o banc�ria - M�dulo Concilia��o Cont�bil

  The MIT License

  Copyright: Copyright (C) 2010 T2Ti.COM

  Permission is hereby granted, free of charge, to any person
  obtaining a copy of this software and associated documentation
  files (the "Software"), to deal in the Software without
  restriction, including without limitation the rights to use,
  copy, modify, merge, publish, distribute, sublicense, and/or sell
  copies of the Software, and to permit persons to whom the
  Software is furnished to do so, subject to the following
  conditions:

  The above copyright notice and this permission notice shall be
  included in all copies or substantial portions of the Software.

  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
  OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
  NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
  HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
  WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
  OTHER DEALINGS IN THE SOFTWARE.

  The author may be contacted at:
  t2ti.com@gmail.com</p>

  t2ti.com@gmail.com
  @author Albert Eije (T2Ti.COM)
  @version 1.0
  ******************************************************************************* }
unit UConciliacaoBancaria;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UTelaCadastro, DB, DBClient, Menus, StdCtrls, ExtCtrls, Buttons, Grids,
  DBGrids, JvExDBGrids, JvDBGrid, JvDBUltimGrid, ComCtrls, ContaCaixaVO,
  ContaCaixaController, Tipos, Atributos, Constantes, LabeledCtrls, JvToolEdit,
  Mask, JvExMask, JvBaseEdits, Math, StrUtils, CheckLst, ActnList, ToolWin,
  ActnMan, ActnCtrls, PlatformDefaultStyleActnCtrls, JvExExtCtrls,
  JvNetscapeSplitter;

type
  [TFormDescription(TConstantes.MODULO_CONCILIACAO_CONTABIL, 'Concilia��o Banc�ria')]

  TFConciliacaoBancaria = class(TFTelaCadastro)
    BevelEdits: TBevel;
    EditIdContabilConta: TLabeledCalcEdit;
    EditContabilConta: TLabeledEdit;
    CDSLancamentoExtrato: TClientDataSet;
    DSLancamentoExtrato: TDataSource;
    CDSLancamentoExtratoID: TIntegerField;
    CDSLancamentoExtratoID_CONTA_CAIXA: TIntegerField;
    CDSLancamentoExtratoMES: TStringField;
    CDSLancamentoExtratoANO: TStringField;
    CDSLancamentoExtratoDATA_MOVIMENTO: TDateField;
    CDSLancamentoExtratoDATA_BALANCETE: TDateField;
    CDSLancamentoExtratoHISTORICO: TStringField;
    CDSLancamentoExtratoVALOR: TFMTBCDField;
    CDSContabilLancamento: TClientDataSet;
    CDSContabilLancamentoID: TIntegerField;
    CDSContabilLancamentoID_CONTABIL_CONTA: TIntegerField;
    CDSContabilLancamentoID_CONTABIL_HISTORICO: TIntegerField;
    CDSContabilLancamentoID_CONTABIL_LANCAMENTO_CAB: TIntegerField;
    CDSContabilLancamentoHISTORICO: TStringField;
    CDSContabilLancamentoTIPO: TStringField;
    CDSContabilLancamentoVALOR: TFMTBCDField;
    DSContabilLancamento: TDataSource;
    GroupBox4: TGroupBox;
    JvDBUltimGrid2: TJvDBUltimGrid;
    CDSLancamentoConciliado: TClientDataSet;
    DSLancamentoConciliado: TDataSource;
    CDSLancamentoConciliadoMES: TStringField;
    CDSLancamentoConciliadoANO: TStringField;
    CDSLancamentoConciliadoDATA_MOVIMENTO: TDateField;
    CDSLancamentoConciliadoDATA_BALANCETE: TDateField;
    CDSLancamentoConciliadoHISTORICO_EXTRATO: TStringField;
    CDSLancamentoConciliadoVALOR_EXTRATO: TFMTBCDField;
    CDSLancamentoConciliadoCLASSIFICACAO: TStringField;
    CDSLancamentoConciliadoHISTORICO_CONTA: TStringField;
    CDSLancamentoConciliadoTIPO: TStringField;
    CDSLancamentoConciliadoVALOR_CONTA: TFMTBCDField;
    ActionManager1: TActionManager;
    ActionToolBar1: TActionToolBar;
    ActionListarLancamentos: TAction;
    ActionConciliacao: TAction;
    EditPeriodoInicial: TLabeledDateEdit;
    EditPeriodoFinal: TLabeledDateEdit;
    PanelLancamentos: TPanel;
    GroupBox2: TGroupBox;
    GridDetalhe: TJvDBUltimGrid;
    GroupBox3: TGroupBox;
    JvDBUltimGrid1: TJvDBUltimGrid;
    JvNetscapeSplitter1: TJvNetscapeSplitter;
    CDSContabilLancamentoCONTABIL_CONTACLASSIFICACAO: TStringField;
    procedure FormCreate(Sender: TObject);
    procedure GridDblClick(Sender: TObject);
    procedure ActionListarLancamentosExecute(Sender: TObject);
    procedure ActionConciliacaoExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure GridParaEdits; override;
    procedure ControlaBotoes; override;
    procedure LimparCampos; override;
  end;

var
  FConciliacaoBancaria: TFConciliacaoBancaria;

implementation

uses ULookup, Biblioteca, UDataModule, ContabilContaVO, ContabilLancamentoDetalheController,
FinExtratoContaBancoController;
{$R *.dfm}

{$REGION 'Controles Infra'}
procedure TFConciliacaoBancaria.FormCreate(Sender: TObject);
begin
  ClasseObjetoGridVO := TContaCaixaVO;
  ObjetoController := TContaCaixaController.Create;

  inherited;
end;

procedure TFConciliacaoBancaria.ControlaBotoes;
begin
  inherited;

  BotaoInserir.Visible := False;
  BotaoAlterar.Visible := False;
  BotaoExcluir.Visible := False;
  BotaoSalvar.Visible := False;
end;

procedure TFConciliacaoBancaria.LimparCampos;
begin
  inherited;
  CDSLancamentoExtrato.EmptyDataSet;
  CDSContabilLancamento.EmptyDataSet;
  CDSLancamentoConciliado.EmptyDataSet;
end;
{$ENDREGION}

{$REGION 'Controle de Grid'}
procedure TFConciliacaoBancaria.GridParaEdits;
begin
  inherited;

  if not CDSGrid.IsEmpty then
  begin
    ObjetoVO := ObjetoController.VO<TContaCaixaVO>(IdRegistroSelecionado);
  end;

  if Assigned(ObjetoVO) then
  begin
    EditIdContabilConta.Text := IntToStr(TContaCaixaVO(ObjetoVO).IdContabilConta);
    EditContabilConta.Text := TContaCaixaVO(ObjetoVO).ContabilContaClassificacao;
  end;
end;

procedure TFConciliacaoBancaria.GridDblClick(Sender: TObject);
begin
  inherited;
  PanelEdits.Enabled := True;
  EditPeriodoInicial.SetFocus;
  if TContaCaixaVO(ObjetoVO).IdContabilConta = 0 then
  begin
    Application.MessageBox('Conta caixa sem conta cont�bil vinculada.', 'Informa��o do Sistema', MB_OK + MB_IconInformation);
    BotaoCancelar.Click;
  end
end;
{$ENDREGION}

{$REGION 'Actions'}
procedure TFConciliacaoBancaria.ActionListarLancamentosExecute(Sender: TObject);
begin
  // Extrato Banc�rio
  TFinExtratoContaBancoController.SetDataSet(CDSLancamentoExtrato);
  TFinExtratoContaBancoController.Consulta('ID_CONTA_CAIXA=' + IntToStr(TContaCaixaVO(ObjetoVO).Id) + ' and (DATA_MOVIMENTO BETWEEN ' + QuotedStr(DataParaTexto(EditPeriodoInicial.Date)) + ' and ' + QuotedStr(DataParaTexto(EditPeriodoFinal.Date)) + ')', 0);

  // Lan�amentos Cont�beis
  TContabilLancamentoDetalheController.SetDataSet(CDSContabilLancamento);
  TContabilLancamentoDetalheController.Consulta('ID_CONTABIL_CONTA=' + IntToStr(TContaCaixaVO(ObjetoVO).IdContabilConta), 0);
end;

procedure TFConciliacaoBancaria.ActionConciliacaoExecute(Sender: TObject);
begin
  CDSLancamentoExtrato.DisableControls;
  CDSContabilLancamento.DisableControls;

  CDSLancamentoExtrato.First;
  while not CDSLancamentoExtrato.Eof do
  begin

    CDSContabilLancamento.First;
    while not CDSContabilLancamento.Eof do
    begin

      if CDSLancamentoExtratoVALOR.AsExtended = CDSContabilLancamentoVALOR.AsExtended then
      begin
        CDSLancamentoConciliado.Append;
        CDSLancamentoConciliadoMES.AsString := CDSLancamentoExtratoMES.AsString;
        CDSLancamentoConciliadoANO.AsString := CDSLancamentoExtratoANO.AsString;
        CDSLancamentoConciliadoDATA_MOVIMENTO.AsDateTime := CDSLancamentoExtratoDATA_MOVIMENTO.AsDateTime;
        CDSLancamentoConciliadoDATA_BALANCETE.AsDateTime := CDSLancamentoExtratoDATA_BALANCETE.AsDateTime;
        CDSLancamentoConciliadoHISTORICO_EXTRATO.AsString := CDSLancamentoExtratoHISTORICO.AsString;
        CDSLancamentoConciliadoVALOR_EXTRATO.AsExtended := CDSLancamentoExtratoVALOR.AsExtended;
        CDSLancamentoConciliadoCLASSIFICACAO.AsString := CDSContabilLancamentoCONTABIL_CONTACLASSIFICACAO.AsString;
        CDSLancamentoConciliadoHISTORICO_CONTA.AsString := CDSContabilLancamentoHISTORICO.AsString;
        CDSLancamentoConciliadoTIPO.AsString := CDSContabilLancamentoTIPO.AsString;
        CDSLancamentoConciliadoVALOR_CONTA.AsExtended := CDSContabilLancamentoVALOR.AsExtended;
        CDSLancamentoConciliado.Post;
      end;

      CDSContabilLancamento.Next;
    end;
    CDSLancamentoExtrato.Next;
  end;

  CDSLancamentoExtrato.EnableControls;
  CDSContabilLancamento.EnableControls;
end;
{$ENDREGION}

end.
