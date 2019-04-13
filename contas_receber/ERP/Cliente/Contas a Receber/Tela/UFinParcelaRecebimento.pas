{ *******************************************************************************
  Title: T2Ti ERP
  Description: Janela de Recebimento das Parcelas

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

  @author Albert Eije
  @version 1.0
  ******************************************************************************* }
unit UFinParcelaRecebimento;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Atributos,
  Dialogs, UTelaCadastro, DB, DBClient, Menus, StdCtrls, ExtCtrls, Buttons, Grids,
  DBGrids, JvExDBGrids, JvDBGrid, JvDBUltimGrid, ComCtrls, ViewFinLancamentoReceberVO,
  ViewFinLancamentoReceberController, Tipos, Constantes, LabeledCtrls,
  ActnList, RibbonSilverStyleActnCtrls, ActnMan, Mask, JvExMask, JvToolEdit,
  JvExStdCtrls, JvEdit, JvValidateEdit, ToolWin, ActnCtrls, JvBaseEdits,
  Generics.Collections, Biblioteca, RTTI, FinChequeRecebidoVO, AdmParametroVO;

type
  [TFormDescription(TConstantes.MODULO_CONTAS_RECEBER, 'Recebimento')]

  TFFinParcelaRecebimento = class(TFTelaCadastro)
    BevelEdits: TBevel;
    PanelEditsInterno: TPanel;
    EditDataRecebimento: TLabeledDateEdit;
    EditTaxaJuro: TLabeledCalcEdit;
    EditValorJuro: TLabeledCalcEdit;
    EditValorMulta: TLabeledCalcEdit;
    EditValorDesconto: TLabeledCalcEdit;
    EditTaxaDesconto: TLabeledCalcEdit;
    EditTaxaMulta: TLabeledCalcEdit;
    MemoHistorico: TLabeledMemo;
    ActionManager: TActionManager;
    ActionBaixarParcela: TAction;
    DSParcelaRecebimento: TDataSource;
    CDSParcelaRecebimento: TClientDataSet;
    EditIdTipoRecebimento: TLabeledCalcEdit;
    EditCodigoTipoRecebimento: TLabeledEdit;
    EditTipoRecebimento: TLabeledEdit;
    EditIdContaCaixa: TLabeledCalcEdit;
    EditContaCaixa: TLabeledEdit;
    EditValorRecebido: TLabeledCalcEdit;
    EditValorAReceber: TLabeledCalcEdit;
    EditDataVencimento: TLabeledDateEdit;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    EditDataInicio: TLabeledDateEdit;
    EditDataFim: TLabeledDateEdit;
    PanelParcelaPaga: TPanel;
    GridRecebimentos: TJvDBUltimGrid;
    ActionToolBar1: TActionToolBar;
    ComboBoxTipoBaixa: TLabeledComboBox;
    PopupMenuExluiParcela: TPopupMenu;
    ExcluirParcelaPaga1: TMenuItem;
    PanelTotaisPagos: TPanel;
    CDSParcelaRecebimentoID: TIntegerField;
    CDSParcelaRecebimentoID_FIN_PARCELA_RECEBER: TIntegerField;
    CDSParcelaRecebimentoID_FIN_CHEQUE_RECEBIDO: TIntegerField;
    CDSParcelaRecebimentoID_FIN_TIPO_RECEBIMENTO: TIntegerField;
    CDSParcelaRecebimentoID_CONTA_CAIXA: TIntegerField;
    CDSParcelaRecebimentoDATA_RECEBIMENTO: TDateField;
    CDSParcelaRecebimentoTAXA_JURO: TFMTBCDField;
    CDSParcelaRecebimentoTAXA_MULTA: TFMTBCDField;
    CDSParcelaRecebimentoTAXA_DESCONTO: TFMTBCDField;
    CDSParcelaRecebimentoVALOR_JURO: TFMTBCDField;
    CDSParcelaRecebimentoVALOR_MULTA: TFMTBCDField;
    CDSParcelaRecebimentoVALOR_DESCONTO: TFMTBCDField;
    CDSParcelaRecebimentoVALOR_RECEBIDO: TFMTBCDField;
    CDSParcelaRecebimentoCONTA_CAIXANOME: TStringField;
    CDSParcelaRecebimentoTIPO_RECEBIMENTODESCRICAO: TStringField;
    CDSParcelaRecebimentoCHEQUENUMERO: TIntegerField;
    CDSParcelaRecebimentoHISTORICO: TStringField;
    procedure FormCreate(Sender: TObject);
    procedure ActionBaixarParcelaExecute(Sender: TObject);
    procedure CalcularTotalPago(Sender: TObject);
    procedure EditIdTipoRecebimentoExit(Sender: TObject);
    procedure EditIdTipoRecebimentoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EditIdTipoRecebimentoKeyPress(Sender: TObject; var Key: Char);
    procedure EditIdContaCaixaExit(Sender: TObject);
    procedure EditIdContaCaixaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EditIdContaCaixaKeyPress(Sender: TObject; var Key: Char);
    procedure BotaoConsultarClick(Sender: TObject);
    procedure BotaoSalvarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ExcluirParcelaPaga1Click(Sender: TObject);
    procedure BaixarParcela;
    procedure BaixarParcelaCheque;
    procedure CalcularTotais;
    procedure GridDblClick(Sender: TObject);
    procedure GridCellClick(Column: TColumn);
    procedure GridDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    function VerificarPacoteRecebimentoCheque: Boolean;
  private
    { Private declarations }
  public
    { Public declarations }
    procedure GridParaEdits; override;
    procedure ControlaBotoes; override;
    procedure ControlaPopupMenu; override;
    procedure LimparCampos; override;
    function MontaFiltro: string; override;

    // Controles CRUD
    function DoEditar: Boolean; override;
  end;

var
  FFinParcelaRecebimento: TFFinParcelaRecebimento;
  ChequeRecebido: TFinChequeRecebidoVO;
  SomaCheque: Extended;
  AdmParametroVO: TAdmParametroVO;

implementation

uses
  FinParcelaRecebimentoVO, FinParcelaRecebimentoController, FinParcelaReceberVO,
  FinParcelaReceberController, FinTipoRecebimentoVO, FinTipoRecebimentoController,
  ContaCaixaVO, ContaCaixaController, UTela, USelecionaCheque, UDataModule,
  AdmParametroController;

{$R *.dfm}

{$REGION 'Infra'}
procedure TFFinParcelaRecebimento.FormCreate(Sender: TObject);
begin
  ClasseObjetoGridVO := TViewFinLancamentoReceberVO;
  ObjetoController := TViewFinLancamentoReceberController.Create;

  inherited;

  AdmParametroVO := TAdmParametroController.VO<TAdmParametroVO>('ID_EMPRESA', IntToStr(Sessao.IdEmpresa));
end;

procedure TFFinParcelaRecebimento.FormShow(Sender: TObject);
begin
  inherited;
  EditDataInicio.Date := Now;
  EditDataFim.Date := Now;
end;

procedure TFFinParcelaRecebimento.ControlaBotoes;
begin
  inherited;

  BotaoInserir.Visible := False;
  BotaoExcluir.Visible := False;
  BotaoCancelar.Visible := False;
  BotaoAlterar.Caption := 'Confirmar [F3]';
  BotaoSalvar.Caption := 'Retornar [F12]';
end;

procedure TFFinParcelaRecebimento.ControlaPopupMenu;
begin
  inherited;

  MenuInserir.Visible := False;
  MenuExcluir.Visible := False;
  MenuCancelar.Visible := False;
  MenuAlterar.Caption := 'Confirmar [F3]';
  menuSalvar.Caption := 'Retornar [F12]';
end;

procedure TFFinParcelaRecebimento.LimparCampos;
var
  DataInicioInformada, DataFimInformada: TDateTime;
begin
  DataInicioInformada := EditDataInicio.Date;
  DataFimInformada := EditDataFim.Date;
  inherited;
  CDSParcelaRecebimento.EmptyDataSet;
  EditDataInicio.Date := DataInicioInformada;
  EditDataFim.Date := DataFimInformada;
end;
{$ENDREGION}

{$REGION 'Controles CRUD'}
function TFFinParcelaRecebimento.DoEditar: Boolean;
begin
  if VerificarPacoteRecebimentoCheque then
  begin
    ChequeRecebido := TFinChequeRecebidoVO.Create;

    Application.CreateForm(TFSelecionaCheque, FSelecionaCheque);
    FSelecionaCheque.EditValorCheque.Value := SomaCheque;
    FSelecionaCheque.EditDataEmissao.Date := Now;

    FSelecionaCheque.ShowModal;

    if FSelecionaCheque.Confirmou then
    begin
      ChequeRecebido.IdPessoa := FSelecionaCheque.EditIdPessoa.AsInteger;
      ChequeRecebido.Nome := FSelecionaCheque.EditPessoa.Text;
      ChequeRecebido.CpfCnpj := FSelecionaCheque.EditCpfCnpj.Text;
      ChequeRecebido.CodigoBanco := FSelecionaCheque.EditCodigoBanco.Text;
      ChequeRecebido.CodigoAgencia := FSelecionaCheque.EditCodigoAgencia.Text;
      ChequeRecebido.Conta := FSelecionaCheque.EditNumeroConta.Text;
      ChequeRecebido.Numero := FSelecionaCheque.EditNumeroCheque.AsInteger;
      ChequeRecebido.DataEmissao := FSelecionaCheque.EditDataEmissao.Date;
      ChequeRecebido.Valor := FSelecionaCheque.EditValorCheque.Value;
      ChequeRecebido.BomPara := FSelecionaCheque.EditBomPara.Date;
      BaixarParcelaCheque;
      FreeAndNil(FSelecionaCheque);
    end;
  end
  else
  begin
    Result := inherited DoEditar;

    if Result then
    begin
      ComboBoxTipoBaixa.SetFocus;
    end;
  end;
end;

function TFFinParcelaRecebimento.VerificarPacoteRecebimentoCheque: Boolean;
var
  LinhaAtual: TBookMark;
  ParcelasVencidas: Boolean;
begin
  Result := False;
  ParcelasVencidas := False;
  LinhaAtual := CDSGrid.GetBookmark;
  SomaCheque := 0;

  CDSGrid.DisableControls;
  CDSGrid.First;
  while not CDSGrid.Eof do
  begin
    if CDSGrid.FieldByName('EmitirCheque').AsString = 'S' then
      SomaCheque := SomaCheque + CDSGrid.FieldByName('VALOR_PARCELA').AsFloat;
    ParcelasVencidas := CDSGrid.FieldByName('DATA_VENCIMENTO').AsDateTime < Date;
    CDSGrid.Next;
  end;

  if CDSGrid.BookmarkValid(LinhaAtual) then
  begin
    CDSGrid.GotoBookmark(LinhaAtual);
    CDSGrid.FreeBookmark(LinhaAtual);
  end;
  CDSGrid.EnableControls;

  if SomaCheque = 0 then
    Exit;

  if ParcelasVencidas then
  begin
    Application.MessageBox('Procedimento n�o permitido. Parcela sem valores ou vencidas.', 'Mensagem do Sistema', MB_OK + MB_ICONINFORMATION);
    CDSGrid.EnableControls;
    Exit;
  end;

  Result := True;
end;
{$ENDREGION}

{$REGION 'Campos Transientes'}
procedure TFFinParcelaRecebimento.EditIdContaCaixaExit(Sender: TObject);
var
  Filtro: String;
begin
   if EditIdContaCaixa.Value <> 0 then
  begin
    try
      Filtro := 'ID = ' + EditIdContaCaixa.Text;
      EditIdContaCaixa.Clear;
      EditContaCaixa.Clear;
      if not PopulaCamposTransientes(Filtro, TContaCaixaVO, TContaCaixaController) then
        PopulaCamposTransientesLookup(TContaCaixaVO, TContaCaixaController);
      if CDSTransiente.RecordCount > 0 then
      begin
        EditIdContaCaixa.Text := CDSTransiente.FieldByName('ID').AsString;
        EditContaCaixa.Text := CDSTransiente.FieldByName('NOME').AsString;
      end
      else
      begin
        Exit;
        EditIdContaCaixa.SetFocus;
      end;
    finally
      CDSTransiente.Close;
    end;
  end
  else
  begin
    EditContaCaixa.Clear;
  end;
end;

procedure TFFinParcelaRecebimento.EditIdContaCaixaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F1 then
  begin
    EditIdContaCaixa.Value := -1;
    EditDataVencimento.SetFocus;
  end;
end;

procedure TFFinParcelaRecebimento.EditIdContaCaixaKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    EditDataVencimento.SetFocus;
  end;
end;

procedure TFFinParcelaRecebimento.EditIdTipoRecebimentoExit(Sender: TObject);
var
  Filtro: String;
begin
   if EditIdTipoRecebimento.Value <> 0 then
  begin
    try
      Filtro := 'ID = ' + EditIdTipoRecebimento.Text;
      EditIdTipoRecebimento.Clear;
      EditCodigoTipoRecebimento.Clear;
      EditTipoRecebimento.Clear;
      if not PopulaCamposTransientes(Filtro, TFinTipoRecebimentoVO, TFinTipoRecebimentoController) then
        PopulaCamposTransientesLookup(TFinTipoRecebimentoVO, TFinTipoRecebimentoController);
      if CDSTransiente.RecordCount > 0 then
      begin
        EditIdTipoRecebimento.Text := CDSTransiente.FieldByName('ID').AsString;
        EditCodigoTipoRecebimento.Text := CDSTransiente.FieldByName('TIPO').AsString;
        EditTipoRecebimento.Text := CDSTransiente.FieldByName('DESCRICAO').AsString;
      end
      else
      begin
        Exit;
        EditIdTipoRecebimento.SetFocus;
      end;
    finally
      CDSTransiente.Close;
    end;
  end
  else
  begin
    EditCodigoTipoRecebimento.Clear;
    EditTipoRecebimento.Clear;
  end;
end;

procedure TFFinParcelaRecebimento.EditIdTipoRecebimentoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F1 then
  begin
    EditIdTipoRecebimento.Value := -1;
    EditIdContaCaixa.SetFocus;
  end;
end;

procedure TFFinParcelaRecebimento.EditIdTipoRecebimentoKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    EditIdContaCaixa.SetFocus;
  end;
end;
{$ENDREGION}

{$REGION 'Controle de Grid'}
procedure TFFinParcelaRecebimento.GridCellClick(Column: TColumn);
begin
  if Column.Index = 0 then
  begin
    if CDSGrid.FieldByName('SITUACAO_PARCELA').AsString = '02' then
    begin
      Application.MessageBox('Procedimento n�o permitido. Parcela j� quitada.', 'Mensagem do Sistema', MB_OK + MB_ICONINFORMATION);
    end
    else
    begin
      CDSGrid.Edit;
      if CDSGrid.FieldByName('EmitirCheque').AsString = '' then
        CDSGrid.FieldByName('EmitirCheque').AsString := 'S'
      else
        CDSGrid.FieldByName('EmitirCheque').AsString := '';
      CDSGrid.Post;
    end;
  end;
end;

procedure TFFinParcelaRecebimento.GridDblClick(Sender: TObject);
begin
  //
end;

procedure TFFinParcelaRecebimento.GridDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
var
  lIcone : TBitmap;
  lRect: TRect;
begin
  lRect := Rect;
  lIcone := TBitmap.Create;

  if Column.Index = 0 then
  begin
    if Grid.Columns[0].Width <> 32 then
      Grid.Columns[0].Width := 32;

    try
      if Grid.Columns[1].Field.Value = '' then
      begin
        FDataModule.ImagensCheck.GetBitmap(0, lIcone);
        Grid.Canvas.Draw(Rect.Left+8 ,Rect.Top+1, lIcone);
      end
      else if Grid.Columns[1].Field.Value = 'S' then
      begin
        FDataModule.ImagensCheck.GetBitmap(1, lIcone);
        Grid.Canvas.Draw(Rect.Left+8,Rect.Top+1, lIcone);
      end
    finally
      lIcone.Free;
    end;
  end;
end;

procedure TFFinParcelaRecebimento.GridParaEdits;
var
  ParcelaReceberEnumerator: TEnumerator<TFinParcelaReceberVO>;
begin
  inherited;

  if not CDSGrid.IsEmpty then
  begin
    ObjetoVO := ObjetoController.VO<TViewFinLancamentoReceberVO>(IdRegistroSelecionado);
  end;

  if Assigned(ObjetoVO) then
  begin
    EditIdContaCaixa.AsInteger := TViewFinLancamentoReceberVO(ObjetoVO).IdContaCaixa;
    EditContaCaixa.Text := TViewFinLancamentoReceberVO(ObjetoVO).NomeContaCaixa;
    EditDataVencimento.Date := TViewFinLancamentoReceberVO(ObjetoVO).DataVencimento;
    EditValorAReceber.Value := TViewFinLancamentoReceberVO(ObjetoVO).ValorParcela;
    EditTaxaJuro.Value := TViewFinLancamentoReceberVO(ObjetoVO).TaxaJuro;
    EditValorJuro.Value := TViewFinLancamentoReceberVO(ObjetoVO).ValorJuro;
    EditTaxaMulta.Value := TViewFinLancamentoReceberVO(ObjetoVO).TaxaMulta;
    EditValorMulta.Value := TViewFinLancamentoReceberVO(ObjetoVO).ValorMulta;
    EditTaxaDesconto.Value := TViewFinLancamentoReceberVO(ObjetoVO).TaxaDesconto;
    EditValorDesconto.Value := TViewFinLancamentoReceberVO(ObjetoVO).ValorDesconto;
    CalcularTotalPago(nil);

    TFinParcelaRecebimentoController.SetDataSet(CDSParcelaRecebimento);
    TFinParcelaRecebimentoController.Consulta('ID_FIN_PARCELA_RECEBER=' + QuotedStr(IntToStr(CDSGrid.FieldByName('ID_PARCELA_RECEBER').AsInteger)), 0);
    CalcularTotais;
  end;
end;

procedure TFFinParcelaRecebimento.ExcluirParcelaPaga1Click(Sender: TObject);
var
  ParcelaReceber, ParcelaReceberOld: TFinParcelaReceberVO;
begin
  DecimalSeparator := '.';
  if CDSParcelaRecebimentoID.AsInteger > 0 then
    TFinParcelaRecebimentoController.Exclui(CDSParcelaRecebimentoID.AsInteger);
  CDSParcelaRecebimento.Delete;

  if CDSParcelaRecebimento.IsEmpty then
  begin
    ParcelaReceberOld := TFinParcelaReceberController.VO<TFinParcelaReceberVO>(CDSGrid.FieldByName('ID_PARCELA_RECEBER').AsInteger);
    ParcelaReceber := TFinParcelaReceberController.VO<TFinParcelaReceberVO>(CDSGrid.FieldByName('ID_PARCELA_RECEBER').AsInteger);
    ParcelaReceber.IdFinStatusParcela := 1;
    TFinParcelaReceberController.Altera(ParcelaReceber, ParcelaReceberOld);
  end;
  DecimalSeparator := ',';
  CalcularTotais;
end;
{$ENDREGION}

{$REGION 'Actions'}
procedure TFFinParcelaRecebimento.ActionBaixarParcelaExecute(Sender: TObject);
begin
  if EditIdTipoRecebimento.AsInteger <= 0 then
  begin
    Application.MessageBox('� necess�rio informar o tipo de Recebimento.', 'Mensagem do Sistema', MB_OK + MB_ICONINFORMATION);
    EditIdTipoRecebimento.SetFocus;
    Exit;
  end;
  if EditIdContaCaixa.AsInteger <= 0 then
  begin
    Application.MessageBox('� necess�rio informar a conta caixa.', 'Mensagem do Sistema', MB_OK + MB_ICONINFORMATION);
    EditIdContaCaixa.SetFocus;
    Exit;
  end;

  ChequeRecebido := TFinChequeRecebidoVO.Create;

  if EditCodigoTipoRecebimento.Text = '02' then
  begin
    Application.CreateForm(TFSelecionaCheque, FSelecionaCheque);
    FSelecionaCheque.EditDataEmissao.Date := Now;
    FSelecionaCheque.EditBomPara.Date := EditDataRecebimento.Date;
    FSelecionaCheque.EditValorCheque.Value := EditValorRecebido.Value;
    FSelecionaCheque.MemoHistorico.Text := MemoHistorico.Text;
    FSelecionaCheque.EditIdContaCaixa.AsInteger := EditIdContaCaixa.AsInteger;
    FSelecionaCheque.EditContaCaixa.Text := EditContaCaixa.Text;
    FSelecionaCheque.ShowModal;

    if FSelecionaCheque.Confirmou then
    begin
      ChequeRecebido.IdPessoa := FSelecionaCheque.EditIdPessoa.AsInteger;
      ChequeRecebido.Nome := FSelecionaCheque.EditPessoa.Text;
      ChequeRecebido.CpfCnpj := FSelecionaCheque.EditCpfCnpj.Text;
      ChequeRecebido.CodigoBanco := FSelecionaCheque.EditCodigoBanco.Text;
      ChequeRecebido.CodigoAgencia := FSelecionaCheque.EditCodigoAgencia.Text;
      ChequeRecebido.Conta := FSelecionaCheque.EditNumeroConta.Text;
      ChequeRecebido.Numero := FSelecionaCheque.EditNumeroCheque.AsInteger;
      ChequeRecebido.DataEmissao := FSelecionaCheque.EditDataEmissao.Date;
      ChequeRecebido.Valor := FSelecionaCheque.EditValorCheque.Value;
      ChequeRecebido.BomPara := FSelecionaCheque.EditBomPara.Date;
      BaixarParcela;
      FreeAndNil(FSelecionaCheque);
    end;
  end
  else
    BaixarParcela;
end;

procedure TFFinParcelaRecebimento.BaixarParcela;
var
  ParcelaReceber: TFinParcelaReceberVO;
  ParcelaRecebimento: TFinParcelaRecebimentoVO;
begin
  DecimalSeparator := '.';
  ParcelaReceber := TFinParcelaReceberController.VO<TFinParcelaReceberVO>(CDSGrid.FieldByName('ID_PARCELA_RECEBER').AsInteger);

  if ComboBoxTipoBaixa.ItemIndex = 0 then
    ParcelaReceber.IdFinStatusParcela := AdmParametroVO.FinParcelaQuitado
  else if ComboBoxTipoBaixa.ItemIndex = 1 then
    ParcelaReceber.IdFinStatusParcela := AdmParametroVO.FinParcelaQuitadoParcial;

  ParcelaRecebimento := TFinParcelaRecebimentoVO.Create;

  ParcelaRecebimento.IdFinTipoRecebimento := EditIdTipoRecebimento.AsInteger;
  ParcelaRecebimento.IdFinParcelaReceber := ParcelaReceber.Id;
  ParcelaRecebimento.IdContaCaixa := EditIdContaCaixa.AsInteger;
  ParcelaRecebimento.DataRecebimento := EditDataRecebimento.Date;
  ParcelaRecebimento.TaxaJuro := EditTaxaJuro.Value;
  ParcelaRecebimento.ValorJuro := EditValorJuro.Value;
  ParcelaRecebimento.TaxaMulta := EditTaxaMulta.Value;
  ParcelaRecebimento.ValorMulta := EditValorMulta.Value;
  ParcelaRecebimento.TaxaDesconto := EditTaxaDesconto.Value;
  ParcelaRecebimento.ValorDesconto := EditValorDesconto.Value;
  ParcelaRecebimento.Historico := Trim(MemoHistorico.Text);
  ParcelaRecebimento.ValorRecebido := EditValorRecebido.Value;

  TFinParcelaRecebimentoController.Altera(ParcelaReceber, ParcelaRecebimento, ChequeRecebido);
  TFinParcelaRecebimentoController.SetDataSet(CDSParcelaRecebimento);
  TFinParcelaRecebimentoController.Consulta('ID_FIN_PARCELA_RECEBER=' + QuotedStr(IntToStr(CDSGrid.FieldByName('ID_PARCELA_RECEBER').AsInteger)), 0);
  DecimalSeparator := ',';
  CalcularTotais;
end;

procedure TFFinParcelaRecebimento.BaixarParcelaCheque;
var
  ParcelaReceber: TFinParcelaReceberVO;
  ParcelaRecebimento: TFinParcelaRecebimentoVO;
  ListaParcelaReceber: TObjectList<TFinParcelaReceberVO>;
  ListaParcelaRecebimento: TObjectList<TFinParcelaRecebimentoVO>;
begin
  DecimalSeparator := '.';
  ListaParcelaReceber := TObjectList<TFinParcelaReceberVO>.Create;
  ListaParcelaRecebimento := TObjectList<TFinParcelaRecebimentoVO>.Create;

  CDSGrid.DisableControls;
  CDSGrid.First;
  while not CDSGrid.Eof do
  begin
    if CDSGrid.FieldByName('EmitirCheque').AsString = 'S' then
    begin
      ParcelaReceber := TFinParcelaReceberController.VO<TFinParcelaReceberVO>(CDSGrid.FieldByName('ID_PARCELA_RECEBER').AsInteger);

      ParcelaReceber.IdFinStatusParcela := AdmParametroVO.FinParcelaQuitado;

      ParcelaRecebimento := TFinParcelaRecebimentoVO.Create;

      ParcelaRecebimento.IdFinTipoRecebimento := AdmParametroVO.FinTipoRecebimentoEdi;
      ParcelaRecebimento.IdFinParcelaReceber := ParcelaReceber.Id;
      ParcelaRecebimento.IdContaCaixa := FSelecionaCheque.EditIdContaCaixa.AsInteger;
      ParcelaRecebimento.DataRecebimento := FSelecionaCheque.EditBomPara.Date;
      ParcelaRecebimento.Historico := FSelecionaCheque.MemoHistorico.Text;
      ParcelaRecebimento.ValorRecebido := ParcelaReceber.Valor;

      ListaParcelaReceber.Add(ParcelaReceber);
      ListaParcelaRecebimento.Add(ParcelaRecebimento);
    end;
    CDSGrid.Next;
  end;
  CDSGrid.First;
  CDSGrid.EnableControls;

  TFinParcelaRecebimentoController.Altera(ListaParcelaReceber, ListaParcelaRecebimento, ChequeRecebido);
  DecimalSeparator := ',';
  BotaoConsultar.Click;
end;

procedure TFFinParcelaRecebimento.BotaoConsultarClick(Sender: TObject);
var
  Contexto: TRttiContext;
  Tipo: TRttiType;
begin
  Filtro := MontaFiltro;

  if Filtro <> 'ERRO' then
  begin
    Pagina := 0;
    Contexto := TRttiContext.Create;
    try
      Tipo := Contexto.GetType(ObjetoController.ClassType);
      ObjetoController.SetDataSet(CDSGrid);
      Tipo.GetMethod('Consulta').Invoke(ObjetoController.ClassType, [Trim(Filtro), Pagina]);
      ControlaBotoesNavegacaoPagina;
    finally
      Contexto.Free;
    end;

    if not CDSGrid.IsEmpty then
      Grid.SetFocus;
  end
  else
    EditCriterioRapido.SetFocus;
end;

procedure TFFinParcelaRecebimento.BotaoSalvarClick(Sender: TObject);
begin
  inherited;
  BotaoConsultar.Click;
end;

function TFFinParcelaRecebimento.MontaFiltro: string;
var
  Item: TItemComboBox;
  Idx: Integer;
  DataSetField: TField;
  DataSet: TClientDataSet;
begin
  DataSet := CDSGrid;
  if ComboBoxCampos.ItemIndex <> -1 then
  begin
    if Trim(EditCriterioRapido.Text) = '' then
      EditCriterioRapido.Text := '*';

    Idx := ComboBoxCampos.ItemIndex;
    Item := TItemComboBox(ComboBoxCampos.Items.Objects[Idx]);
    DataSetField := DataSet.FindField(Item.Campo);
    if DataSetField.DataType = ftDateTime then
    begin
      try
        Result := '[' + Item.Campo + '] IN ' + '(' + QuotedStr(FormatDateTime('yyyy-mm-dd', StrToDate(EditCriterioRapido.Text))) + ')';
      except
        Application.MessageBox('Data informada inv�lida.', 'Erro', MB_OK + MB_ICONERROR);
        Result := 'ERRO';
      end;
    end
    else
      Result := '([DATA_VENCIMENTO] between ' + QuotedStr(DataParaTexto(EditDataInicio.Date)) + ' and ' + QuotedStr(DataParaTexto(EditDataFim.Date)) + ') and [' + Item.Campo + '] LIKE ' + QuotedStr('%' + EditCriterioRapido.Text + '%');
  end
  else
  begin
    Result := ' 1=1 ';
  end;
end;

procedure TFFinParcelaRecebimento.CalcularTotalPago(Sender: TObject);
begin
  EditValorJuro.Value := (EditValorAReceber.Value * (EditTaxaJuro.Value / 30) / 100) * (Now - EditDataVencimento.Date);
  EditValorMulta.Value := EditValorAReceber.Value * (EditTaxaMulta.Value / 100);
  EditValorDesconto.Value := EditValorAReceber.Value * (EditTaxaDesconto.Value / 100);
  EditValorRecebido.Value := EditValorAReceber.Value + EditValorJuro.Value + EditValorMulta.Value - EditValorDesconto.Value;
end;

procedure TFFinParcelaRecebimento.CalcularTotais;
var
  Juro, Multa, Desconto, Total, Saldo: Extended;
begin
  Juro := 0;
  Multa := 0;
  Desconto := 0;
  Total := 0;
  Saldo := 0;
  //
  CDSParcelaRecebimento.DisableControls;
  CDSParcelaRecebimento.First;
  while not CDSParcelaRecebimento.Eof do
  begin
    Juro := Juro + CDSParcelaRecebimento.FieldByName('VALOR_JURO').AsExtended;
    Multa := Multa + CDSParcelaRecebimento.FieldByName('VALOR_MULTA').AsExtended;
    Desconto := Desconto + CDSParcelaRecebimento.FieldByName('VALOR_DESCONTO').AsExtended;
    Total := Total + CDSParcelaRecebimento.FieldByName('VALOR_RECEBIDO').AsExtended;
    CDSParcelaRecebimento.Next;
  end;
  CDSParcelaRecebimento.First;
  CDSParcelaRecebimento.EnableControls;
  //
  PanelTotaisPagos.Caption := '|      Juros: ' +  FloatToStrF(Juro, ffCurrency, 15, 2) +
                        '      |      Multa: ' +   FloatToStrF(Multa, ffCurrency, 15, 2) +
                        '      |      Desconto: ' +   FloatToStrF(Desconto, ffCurrency, 15, 2) +
                        '      |      Total Recebido: ' +   FloatToStrF(Total, ffCurrency, 15, 2) +
                        '      |      Saldo: ' +   FloatToStrF(Total - EditValorAReceber.Value, ffCurrency, 15, 2) + '      |';
end;
{$ENDREGION}

end.
