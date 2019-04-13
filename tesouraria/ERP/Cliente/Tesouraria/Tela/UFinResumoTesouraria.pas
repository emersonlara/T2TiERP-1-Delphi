{ *******************************************************************************
  Title: T2Ti ERP
  Description: Janela de Resumo da Tesouraria

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
unit UFinResumoTesouraria;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Atributos,
  Dialogs, UTelaCadastro, DB, DBClient, Menus, StdCtrls, ExtCtrls, Buttons, Grids,
  DBGrids, JvExDBGrids, JvDBGrid, JvDBUltimGrid, ComCtrls, ViewFinResumoTesourariaVO,
  ViewFinResumoTesourariaController, Tipos, Constantes, LabeledCtrls,
  ActnList, RibbonSilverStyleActnCtrls, ActnMan, Mask, JvExMask, JvToolEdit,
  JvExStdCtrls, JvEdit, JvValidateEdit, ToolWin, ActnCtrls, JvBaseEdits,
  Generics.Collections, Biblioteca, RTTI;

type
  [TFormDescription(TConstantes.MODULO_FINANCEIRO, 'Resumo da Tesouraria')]

  TFFinResumoTesouraria = class(TFTelaCadastro)
    BevelEdits: TBevel;
    PanelEditsInterno: TPanel;
    DSResumoTesouraria: TDataSource;
    CDSResumoTesouraria: TClientDataSet;
    EditIdContaCaixa: TLabeledCalcEdit;
    EditContaCaixa: TLabeledEdit;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    EditDataInicio: TLabeledDateEdit;
    EditDataFim: TLabeledDateEdit;
    PanelGridInterna: TPanel;
    GridPagamentos: TJvDBUltimGrid;
    PanelTotais: TPanel;
    CDSResumoTesourariaID_CONTA_CAIXA: TIntegerField;
    CDSResumoTesourariaNOME_CONTA_CAIXA: TStringField;
    CDSResumoTesourariaNOME_PESSOA: TStringField;
    CDSResumoTesourariaDATA_LANCAMENTO: TDateField;
    CDSResumoTesourariaDATA_PAGO_RECEBIDO: TDateField;
    CDSResumoTesourariaHISTORICO: TStringField;
    CDSResumoTesourariaVALOR: TFMTBCDField;
    CDSResumoTesourariaDESCRICAO_DOCUMENTO_ORIGEM: TStringField;
    CDSResumoTesourariaOPERACAO: TStringField;
    PanelTotaisGeral: TPanel;
    procedure FormCreate(Sender: TObject);
    procedure BotaoConsultarClick(Sender: TObject);
    procedure BotaoSalvarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure CalcularTotais;
    procedure CalcularTotaisGeral;
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
  FFinResumoTesouraria: TFFinResumoTesouraria;

implementation

uses
  UTela;

{$R *.dfm}

{$REGION 'Infra'}
procedure TFFinResumoTesouraria.FormCreate(Sender: TObject);
begin
  ClasseObjetoGridVO := TViewFinResumoTesourariaVO;
  ObjetoController := TViewFinResumoTesourariaController.Create;

  inherited;
end;

procedure TFFinResumoTesouraria.FormShow(Sender: TObject);
begin
  inherited;
  EditDataInicio.Date := Now;
  EditDataFim.Date := Now;
end;

procedure TFFinResumoTesouraria.ControlaBotoes;
begin
  inherited;

  BotaoImprimir.Visible := False;
  BotaoInserir.Visible := False;
  BotaoExcluir.Visible := False;
  BotaoCancelar.Visible := False;
  BotaoAlterar.Caption := 'Filtrar Conta [F3]';
  BotaoAlterar.Hint := 'Filtrar Conta [F3]';
  BotaoAlterar.Width := 120;
  BotaoSalvar.Caption := 'Retornar [F12]';
  BotaoSalvar.Hint := 'Retornar [F12]';
end;

procedure TFFinResumoTesouraria.ControlaPopupMenu;
begin
  inherited;

  MenuImprimir.Visible := False;
  MenuInserir.Visible := False;
  MenuExcluir.Visible := False;
  MenuCancelar.Visible := False;
  MenuAlterar.Caption := 'Filtrar Conta [F3]';
  menuSalvar.Caption := 'Retornar [F12]';
end;

procedure TFFinResumoTesouraria.LimparCampos;
var
  DataInicioInformada, DataFimInformada: TDateTime;
begin
  DataInicioInformada := EditDataInicio.Date;
  DataFimInformada := EditDataFim.Date;
  inherited;
  CDSResumoTesouraria.EmptyDataSet;
  EditDataInicio.Date := DataInicioInformada;
  EditDataFim.Date := DataFimInformada;
end;
{$ENDREGION}

{$REGION 'Controles CRUD'}
function TFFinResumoTesouraria.DoEditar: Boolean;
begin
  Result := inherited DoEditar;
  if Result then
  begin
    EditIdContaCaixa.SetFocus;
  end;
end;
{$ENDREGION}

{$REGION 'Controle de Grid'}
procedure TFFinResumoTesouraria.GridParaEdits;
begin
  inherited;

  EditIdContaCaixa.AsInteger := CDSGrid.FieldByName('ID_CONTA_CAIXA').AsInteger;
  EditContaCaixa.Text := CDSGrid.FieldByName('NOME_CONTA_CAIXA').AsString;
  TViewFinResumoTesourariaController.SetDataSet(CDSResumoTesouraria);
  TViewFinResumoTesourariaController.Consulta('ID_CONTA_CAIXA=' + QuotedStr(EditIdContaCaixa.Text), 0);

  CalcularTotais;
end;
{$ENDREGION}

{$REGION 'Actions'}
procedure TFFinResumoTesouraria.BotaoConsultarClick(Sender: TObject);
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

    CalcularTotaisGeral;
  end
  else
    EditCriterioRapido.SetFocus;
end;

procedure TFFinResumoTesouraria.BotaoSalvarClick(Sender: TObject);
begin
  inherited;
  //BotaoConsultar.Click;
end;

function TFFinResumoTesouraria.MontaFiltro: string;
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
      Result := '([DATA_PAGO_RECEBIDO] between ' + QuotedStr(DataParaTexto(EditDataInicio.Date)) + ' and ' + QuotedStr(DataParaTexto(EditDataFim.Date)) + ') and [' + Item.Campo + '] LIKE ' + QuotedStr('%' + EditCriterioRapido.Text + '%');
  end
  else
  begin
    Result := ' 1=1 ';
  end;
end;

procedure TFFinResumoTesouraria.CalcularTotais;
var
  Recebimentos, Pagamentos, Saldo: Extended;
begin
  Recebimentos := 0;
  Pagamentos := 0;
  Saldo := 0;
  //
  CDSResumoTesouraria.DisableControls;
  CDSResumoTesouraria.First;
  while not CDSResumoTesouraria.Eof do
  begin
    if CDSResumoTesouraria.FieldByName('OPERACAO').AsString = 'S' then
      Pagamentos := Pagamentos + CDSResumoTesouraria.FieldByName('VALOR').AsExtended
    else if CDSResumoTesouraria.FieldByName('OPERACAO').AsString = 'E' then
      Recebimentos := Recebimentos + CDSResumoTesouraria.FieldByName('VALOR').AsExtended;
    CDSResumoTesouraria.Next;
  end;
  CDSResumoTesouraria.First;
  CDSResumoTesouraria.EnableControls;
  //
  PanelTotais.Caption := '|      Recebimentos: ' +  FloatToStrF(Recebimentos, ffCurrency, 15, 2) +
                        '      |      Pagamentos: ' +   FloatToStrF(Pagamentos, ffCurrency, 15, 2) +
                        '      |      Saldo: ' +   FloatToStrF(Recebimentos - Pagamentos, ffCurrency, 15, 2) + '      |';
end;

procedure TFFinResumoTesouraria.CalcularTotaisGeral;
var
  Recebimentos, Pagamentos, Saldo: Extended;
begin
  Recebimentos := 0;
  Pagamentos := 0;
  Saldo := 0;
  //
  CDSGrid.DisableControls;
  CDSGrid.First;
  while not CDSGrid.Eof do
  begin
    if CDSGrid.FieldByName('OPERACAO').AsString = 'S' then
      Pagamentos := Pagamentos + CDSGrid.FieldByName('VALOR').AsExtended
    else if CDSGrid.FieldByName('OPERACAO').AsString = 'E' then
      Recebimentos := Recebimentos + CDSGrid.FieldByName('VALOR').AsExtended;
    CDSGrid.Next;
  end;
  CDSGrid.First;
  CDSGrid.EnableControls;
  //
  PanelTotaisGeral.Caption := '|      Recebimentos: ' +  FloatToStrF(Recebimentos, ffCurrency, 15, 2) +
                        '      |      Pagamentos: ' +   FloatToStrF(Pagamentos, ffCurrency, 15, 2) +
                        '      |      Saldo: ' +   FloatToStrF(Recebimentos - Pagamentos, ffCurrency, 15, 2) + '      |';
end;
{$ENDREGION}

end.
