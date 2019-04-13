{ *******************************************************************************
  Title: T2Ti ERP
  Description: Janela Or�ameto Empresarial

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

  @author Fernando L Oliveira
  @version 1.0   |   Fernando  @version 1.0.0.10
  ******************************************************************************* }
unit UOrcamentoEmpresarial;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UTelaCadastro, DB, DBClient, Menus, StdCtrls, ExtCtrls, Buttons, Grids,
  DBGrids, JvExDBGrids, JvDBGrid, JvDBUltimGrid, ComCtrls, OrcamentoEmpresarialVO,
  OrcamentoEmpresarialController, Tipos, Atributos, Constantes, LabeledCtrls, JvToolEdit,
  Mask, JvExMask, JvBaseEdits, Math, StrUtils, ActnList, Generics.Collections,
  RibbonSilverStyleActnCtrls, ActnMan, ToolWin, ActnCtrls, DateUtils;

type
  [TFormDescription(TConstantes.MODULO_ORCAMENTO, 'Or�amento Empresarial')]

  TFOrcamentoEmpresarial = class(TFTelaCadastro)
    PanelParcelas: TPanel;
    PanelMestre: TPanel;
    EditIdOrcamentoPeriodo: TLabeledCalcEdit;
    EditOrcamentoPeriodo: TLabeledEdit;
    EditNome: TLabeledEdit;
    EditDataBase: TLabeledDateEdit;
    EditNumeroPeriodos: TLabeledCalcEdit;
    EditDataInicial: TLabeledDateEdit;
    PageControlItens: TPageControl;
    tsItens: TTabSheet;
    PanelItens: TPanel;
    GridOrcamentoDetalhe: TJvDBUltimGrid;
    ActionToolBarEdits: TActionToolBar;
    ActionManager: TActionManager;
    ActionGerarOrcamentoEmpresarial: TAction;
    ActionPegarRealizado: TAction;
    ActionCalcularVariacao: TAction;
    DSOrcamentoDetalhe: TDataSource;
    MemoDescricao: TLabeledMemo;
    CDSOrcamentoDetalhe: TClientDataSet;
    CDSOrcamentoDetalheID: TIntegerField;
    CDSOrcamentoDetalheID_NATUREZA_FINANCEIRA: TIntegerField;
    CDSOrcamentoDetalheID_ORCAMENTO_EMPRESARIAL: TIntegerField;
    CDSOrcamentoDetalheNATUREZA_FINANCEIRACLASSIFICACAO: TStringField;
    CDSOrcamentoDetalheNATUREZA_FINANCEIRADESCRICAO: TStringField;
    CDSOrcamentoDetalhePERIODO: TStringField;
    CDSOrcamentoDetalheVALOR_ORCADO: TFMTBCDField;
    CDSOrcamentoDetalheVALOR_REALIZADO: TFMTBCDField;
    CDSOrcamentoDetalheTAXA_VARIACAO: TFMTBCDField;
    CDSOrcamentoDetalheVALOR_VARIACAO: TFMTBCDField;
    CDSOrcamentoDetalhePERSISTE: TStringField;
    EditOrcamentoPeriodoCodigo: TLabeledEdit;
    procedure FormCreate(Sender: TObject);
    procedure EditIdOrcamentoPeriodoExit(Sender: TObject);
    procedure EditIdOrcamentoPeriodoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure GridDblClick(Sender: TObject);
    procedure GridOrcamentoDetalheKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure GridOrcamentoDetalheUserSort(Sender: TJvDBUltimGrid; var FieldsToSort: TSortFields; SortString: string; var SortOK: Boolean);
    procedure ActionGerarOrcamentoEmpresarialExecute(Sender: TObject);
    procedure ActionPegarRealizadoExecute(Sender: TObject);
    procedure ActionCalcularVariacaoExecute(Sender: TObject);
    procedure EditIdOrcamentoPeriodoKeyPress(Sender: TObject; var Key: Char);
    procedure CDSOrcamentoDetalheAfterEdit(DataSet: TDataSet);
    procedure CDSOrcamentoDetalheAfterPost(DataSet: TDataSet);

  private
    { Private declarations }
  public
    { Public declarations }
    procedure GridParaEdits; override;
    procedure LimparCampos; override;

    // Controles CRUD
    function DoInserir: Boolean; override;
    function DoEditar: Boolean; override;
    function DoExcluir: Boolean; override;
    function DoSalvar: Boolean; override;

    procedure ConfigurarLayoutTela;
  end;

var
  FOrcamentoEmpresarial: TFOrcamentoEmpresarial;

implementation

uses ULookup, Biblioteca, UDataModule, OrcamentoDetalheController,
  OrcamentoDetalheVO, NaturezaFinanceiraController, NaturezaFinanceiraVO,
  ViewFinTotalRecebimentosDiaController, ViewFinTotalPagamentosDiaController,
  ViewFinTotalRecebimentosDiaVO, ViewFinTotalPagamentosDiaVO,
  OrcamentoPeriodoVO, OrcamentoPeriodoController,
  PlanoNaturezaFinanceiraVO, PlanoNaturezaFinanceiraController;
{$R *.dfm}

{$REGION 'Infra'}
procedure TFOrcamentoEmpresarial.FormCreate(Sender: TObject);
begin
  ClasseObjetoGridVO := TOrcamentoEmpresarialVO;
  ObjetoController := TOrcamentoEmpresarialController.Create;

  inherited;
end;

procedure TFOrcamentoEmpresarial.LimparCampos;
begin
  inherited;
  CDSOrcamentoDetalhe.EmptyDataSet;
end;

procedure TFOrcamentoEmpresarial.ConfigurarLayoutTela;
begin
  PanelEdits.Enabled := True;

  if StatusTela = stNavegandoEdits then
  begin
    PanelMestre.Enabled := False;
    PanelItens.Enabled := True;
    ActionGerarOrcamentoEmpresarial.Enabled := False;
    ActionPegarRealizado.Enabled := False;
    ActionCalcularVariacao.Enabled := False;
  end
  else
  begin
    PanelMestre.Enabled := True;
    PanelItens.Enabled := True;
    ActionGerarOrcamentoEmpresarial.Enabled := True;
    ActionPegarRealizado.Enabled := True;
    ActionCalcularVariacao.Enabled := True
  end;
end;
{$ENDREGION}

{$REGION 'Controles CRUD'}
function TFOrcamentoEmpresarial.DoInserir: Boolean;
begin
  Result := inherited DoInserir;

  ConfigurarLayoutTela;
  if Result then
  begin
    EditIdOrcamentoPeriodo.SetFocus;
  end;
end;

function TFOrcamentoEmpresarial.DoEditar: Boolean;
begin
  Result := inherited DoEditar;

  ConfigurarLayoutTela;
  if Result then
  begin
    EditIdOrcamentoPeriodo.SetFocus;
  end;
end;

function TFOrcamentoEmpresarial.DoExcluir: Boolean;
begin
  if inherited DoExcluir then
  begin
    try
      Result := TOrcamentoEmpresarialController(ObjetoController).Exclui(IdRegistroSelecionado);
    except
      Result := False;
    end;
  end
  else
  begin
    Result := False;
  end;

  if Result then
    TOrcamentoEmpresarialController(ObjetoController).Consulta(Filtro, Pagina);
end;

function TFOrcamentoEmpresarial.DoSalvar: Boolean;
var
  OrcamentoDetalhe: TOrcamentoDetalheVO;
begin
  Result := inherited DoSalvar;

  DecimalSeparator := '.';

  if Result then
  begin
    try
      if not Assigned(ObjetoVO) then
        ObjetoVO := TOrcamentoEmpresarialVO.Create;

      TOrcamentoEmpresarialVO(ObjetoVO).IdOrcamentoPeriodo := EditIdOrcamentoPeriodo.AsInteger;
      TOrcamentoEmpresarialVO(ObjetoVO).OrcamentoPeriodoNome := EditOrcamentoPeriodo.Text;
      TOrcamentoEmpresarialVO(ObjetoVO).OrcamentoPeriodoCodigo := EditOrcamentoPeriodoCodigo.Text;
      TOrcamentoEmpresarialVO(ObjetoVO).Nome := EditNome.Text;
      TOrcamentoEmpresarialVO(ObjetoVO).Descricao := MemoDescricao.Text;
      TOrcamentoEmpresarialVO(ObjetoVO).DataInicial := EditDataInicial.Date;
      TOrcamentoEmpresarialVO(ObjetoVO).NumeroPeriodos := EditNumeroPeriodos.AsInteger;
      TOrcamentoEmpresarialVO(ObjetoVO).DataBase := EditDataBase.Date;

      if StatusTela = stEditando then
        TOrcamentoEmpresarialVO(ObjetoVO).Id := IdRegistroSelecionado;

      // Detalhes do or�amento
      TOrcamentoEmpresarialVO(ObjetoVO).ListaOrcamentoDetalheVO := TObjectList<TOrcamentoDetalheVO>.Create;
      CDSOrcamentoDetalhe.DisableControls;
      CDSOrcamentoDetalhe.First;
      while not CDSOrcamentoDetalhe.Eof do
      begin
        if (CDSOrcamentoDetalhePERSISTE.AsString = 'S') or (CDSOrcamentoDetalheID.AsInteger = 0) then
        begin
          OrcamentoDetalhe := TOrcamentoDetalheVO.Create;
          OrcamentoDetalhe.Id := CDSOrcamentoDetalheID.AsInteger;
          OrcamentoDetalhe.IdNaturezaFinanceira := CDSOrcamentoDetalheID_NATUREZA_FINANCEIRA.AsInteger;
          OrcamentoDetalhe.IdOrcamentoEmpresarial := CDSOrcamentoDetalheID_ORCAMENTO_EMPRESARIAL.AsInteger;
          OrcamentoDetalhe.Periodo := CDSOrcamentoDetalhePERIODO.AsString;
          OrcamentoDetalhe.ValorOrcado := CDSOrcamentoDetalheVALOR_ORCADO.AsExtended;
          OrcamentoDetalhe.ValorRealizado := CDSOrcamentoDetalheVALOR_REALIZADO.AsExtended;
          OrcamentoDetalhe.TaxaVariacao := CDSOrcamentoDetalheTAXA_VARIACAO.AsExtended;
          OrcamentoDetalhe.ValorVariacao := CDSOrcamentoDetalheVALOR_VARIACAO.AsExtended;
          TOrcamentoEmpresarialVO(ObjetoVO).ListaOrcamentoDetalheVO.Add(OrcamentoDetalhe);
        end;
        CDSOrcamentoDetalhe.Next;
      end;
      CDSOrcamentoDetalhe.EnableControls;

      // ObjetoVO - libera objetos vinculados (TAssociation) - n�o tem necessidade de subir
      TOrcamentoEmpresarialVO(ObjetoVO).OrcamentoPeriodoVO := Nil;

      // ObjetoOldVO - libera objetos vinculados (TAssociation) - n�o tem necessidade de subir
      if Assigned(ObjetoOldVO) then
      begin
        TOrcamentoEmpresarialVO(ObjetoOldVO).OrcamentoPeriodoVO := Nil;
      end;

      if StatusTela = stInserindo then
        Result := TOrcamentoEmpresarialController(ObjetoController).Insere(TOrcamentoEmpresarialVO(ObjetoVO))
      else if StatusTela = stEditando then
      begin
        if TOrcamentoEmpresarialVO(ObjetoVO).ToJSONString <> TOrcamentoEmpresarialVO(ObjetoOldVO).ToJSONString then
        begin
          Result := TOrcamentoEmpresarialController(ObjetoController).Altera(TOrcamentoEmpresarialVO(ObjetoVO), TOrcamentoEmpresarialVO(ObjetoOldVO));
        end
        else
          Application.MessageBox('Nenhum dado foi alterado.', 'Mensagem do Sistema', MB_OK + MB_ICONINFORMATION);
      end;
    except
      Result := False;
    end;
  end;

  DecimalSeparator := ',';
end;
{$ENDREGION}

{$REGION 'Controle de Grid'}
procedure TFOrcamentoEmpresarial.GridDblClick(Sender: TObject);
begin
  inherited;
  ConfigurarLayoutTela;
end;

procedure TFOrcamentoEmpresarial.GridParaEdits;
var
  OrcamentoDetalheEnumerator: TEnumerator<TOrcamentoDetalheVO>;
begin
  inherited;

  if not CDSGrid.IsEmpty then
  begin
    ObjetoVO := ObjetoController.VO<TOrcamentoEmpresarialVO>(IdRegistroSelecionado);
    if StatusTela = stEditando then
      ObjetoOldVO := ObjetoController.VO<TOrcamentoEmpresarialVO>(IdRegistroSelecionado);
  end;

  if Assigned(ObjetoVO) then
  begin
    EditIdOrcamentoPeriodo.AsInteger := TOrcamentoEmpresarialVO(ObjetoVO).IdOrcamentoPeriodo;
    EditOrcamentoPeriodo.Text := TOrcamentoEmpresarialVO(ObjetoVO).OrcamentoPeriodoNome;
    EditOrcamentoPeriodoCodigo.Text := TOrcamentoEmpresarialVO(ObjetoVO).OrcamentoPeriodoCodigo;
    EditNome.Text := TOrcamentoEmpresarialVO(ObjetoVO).Nome;
    MemoDescricao.Text := TOrcamentoEmpresarialVO(ObjetoVO).Descricao;
    EditDataInicial.Date := TOrcamentoEmpresarialVO(ObjetoVO).DataInicial;
    EditNumeroPeriodos.AsInteger := TOrcamentoEmpresarialVO(ObjetoVO).NumeroPeriodos;
    EditDataBase.Date := TOrcamentoEmpresarialVO(ObjetoVO).DataBase;

    // Detalhes do or�amento
    OrcamentoDetalheEnumerator := TOrcamentoEmpresarialVO(ObjetoVO).ListaOrcamentoDetalheVO.GetEnumerator;
    try
      with OrcamentoDetalheEnumerator do
      begin
        while MoveNext do
        begin
          CDSOrcamentoDetalhe.Append;
          CDSOrcamentoDetalheID.AsInteger := Current.Id;
          CDSOrcamentoDetalheID_ORCAMENTO_EMPRESARIAL.AsInteger := Current.IdOrcamentoEmpresarial;
          CDSOrcamentoDetalheID_NATUREZA_FINANCEIRA.AsInteger := Current.IdNaturezaFinanceira;
          CDSOrcamentoDetalheNATUREZA_FINANCEIRACLASSIFICACAO.AsString := Current.NaturezaFinanceiraVO.Classificacao; ;
          CDSOrcamentoDetalheNATUREZA_FINANCEIRADESCRICAO.AsString := Current.NaturezaFinanceiraVO.Descricao;
          CDSOrcamentoDetalhePERIODO.AsString := Current.Periodo;
          CDSOrcamentoDetalheVALOR_ORCADO.AsExtended := Current.ValorOrcado;
          CDSOrcamentoDetalheVALOR_REALIZADO.AsExtended := Current.ValorRealizado;
          CDSOrcamentoDetalheTAXA_VARIACAO.AsExtended := Current.TaxaVariacao;
          CDSOrcamentoDetalheVALOR_VARIACAO.AsExtended := Current.ValorVariacao;
          CDSOrcamentoDetalhe.Post;
        end;
      end;
    finally
      OrcamentoDetalheEnumerator.Free;
    end;
    TOrcamentoEmpresarialVO(ObjetoVO).ListaOrcamentoDetalheVO := Nil;
    if Assigned(TOrcamentoEmpresarialVO(ObjetoOldVO)) then
      TOrcamentoEmpresarialVO(ObjetoOldVO).ListaOrcamentoDetalheVO := Nil;
  end;
  ConfigurarLayoutTela;
end;

procedure TFOrcamentoEmpresarial.GridOrcamentoDetalheKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  If Key = VK_RETURN then
    GridOrcamentoDetalhe.SelectedIndex := GridOrcamentoDetalhe.SelectedIndex + 1;
end;

procedure TFOrcamentoEmpresarial.GridOrcamentoDetalheUserSort(Sender: TJvDBUltimGrid; var FieldsToSort: TSortFields; SortString: string; var SortOK: Boolean);
var
  IxDName: string;
  i: Integer;
  Fields, DescFields: string;
begin
  try
    Fields := '';
    DescFields := '';
    for i := 0 to Length(FieldsToSort) - 1 do
    begin
      Fields := Fields + FieldsToSort[i].Name + ';';
      if not FieldsToSort[i].Order then
        DescFields := DescFields + FieldsToSort[i].Name + ';';
    end;
    Fields := Copy(Fields, 1, Length(Fields) - 1);
    DescFields := Copy(DescFields, 1, Length(DescFields) - 1);

    IxDName := IntToStr(Length(FieldsToSort)) + '_' + FormatDateTime('hhmmssz', Now);
    CDSOrcamentoDetalhe.AddIndex(IxDName, Fields, [], DescFields);
    CDSOrcamentoDetalhe.IndexDefs.Update;
    CDSOrcamentoDetalhe.IndexName := IxDName;
    SortOK := True;
  except
    SortOK := False;
  end;
end;

procedure TFOrcamentoEmpresarial.CDSOrcamentoDetalheAfterEdit(DataSet: TDataSet);
begin
  CDSOrcamentoDetalhePERSISTE.AsString := 'S';
end;

procedure TFOrcamentoEmpresarial.CDSOrcamentoDetalheAfterPost(DataSet: TDataSet);
begin
  if CDSOrcamentoDetalheNATUREZA_FINANCEIRACLASSIFICACAO.AsString = '' then
    CDSOrcamentoDetalhe.Delete;
end;
{$ENDREGION}

{$REGION 'Campos Transientes'}
procedure TFOrcamentoEmpresarial.EditIdOrcamentoPeriodoExit(Sender: TObject);
var
  Filtro: String;
begin
  if EditIdOrcamentoPeriodo.Value <> 0 then
  begin
    try
      Filtro := 'ID = ' + EditIdOrcamentoPeriodo.Text;
      EditIdOrcamentoPeriodo.Clear;
      EditOrcamentoPeriodo.Clear;
      if not PopulaCamposTransientes(Filtro, TOrcamentoPeriodoVO, TOrcamentoPeriodoController) then
        PopulaCamposTransientesLookup(TOrcamentoPeriodoVO, TOrcamentoPeriodoController);
      if CDSTransiente.RecordCount > 0 then
      begin
        EditIdOrcamentoPeriodo.Text := CDSTransiente.FieldByName('ID').AsString;
        EditOrcamentoPeriodo.Text := CDSTransiente.FieldByName('NOME').AsString;
        EditOrcamentoPeriodoCodigo.Text := CDSTransiente.FieldByName('PERIODO').AsString;
      end
      else
      begin
        Exit;
        EditIdOrcamentoPeriodo.SetFocus;
      end;
    finally
      CDSTransiente.Close;
    end;
  end
  else
  begin
    EditOrcamentoPeriodo.Clear;
  end;
end;

procedure TFOrcamentoEmpresarial.EditIdOrcamentoPeriodoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F1 then
  begin
    EditIdOrcamentoPeriodo.Value := -1;
    EditNome.SetFocus;
  end;
end;

procedure TFOrcamentoEmpresarial.EditIdOrcamentoPeriodoKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    EditNome.SetFocus;
  end;
end;
{$ENDREGION}

{$REGION 'Actions'}
procedure TFOrcamentoEmpresarial.ActionGerarOrcamentoEmpresarialExecute(Sender: TObject);
var
  NaturezaFinanceira: TNaturezaFinanceiraVO;
  i, ContadorPeriodo: Integer;
begin
  CDSOrcamentoDetalhe.EmptyDataSet;
  try
    PopulaCamposTransientesLookup(TPlanoNaturezaFinanceiraVO, TPlanoNaturezaFinanceiraController);
    if CDSTransiente.RecordCount > 0 then
    begin
      ConsultaGenerica('ID_PLANO_NATUREZA_FINANCEIRA = ' + QuotedStr(IntToStr(CDSTransiente.FieldByName('ID').AsInteger)), TNaturezaFinanceiraVO, TNaturezaFinanceiraController);

      ContadorPeriodo := 0;

      // 01=Di�rio | 02=Semanal | 03=Mensal | 04=Bimestral | 05=Trimestral | 06=Semestral | 07=Anual
      for i := 1 to EditNumeroPeriodos.AsInteger do
      begin

        CDSConsultaGenerica.First;
        while not CDSConsultaGenerica.Eof do
        begin
          CDSOrcamentoDetalhe.Append;
          CDSOrcamentoDetalheID_NATUREZA_FINANCEIRA.AsInteger := CDSConsultaGenerica.FieldByName('ID').AsInteger;
          CDSOrcamentoDetalheNATUREZA_FINANCEIRACLASSIFICACAO.AsString := CDSConsultaGenerica.FieldByName('CLASSIFICACAO').AsString;
          CDSOrcamentoDetalheNATUREZA_FINANCEIRADESCRICAO.AsString := CDSConsultaGenerica.FieldByName('DESCRICAO').AsString;
          CDSOrcamentoDetalheVALOR_ORCADO.AsExtended := 0;
          CDSOrcamentoDetalheVALOR_REALIZADO.AsExtended := 0;
          CDSOrcamentoDetalheTAXA_VARIACAO.AsExtended := 0;
          CDSOrcamentoDetalheVALOR_VARIACAO.AsExtended := 0;
          CDSOrcamentoDetalhe.FieldByName('PERSISTE').AsString := 'S';

          case StrToInt(EditOrcamentoPeriodoCodigo.Text) of
            1: // di�rio
              CDSOrcamentoDetalhe.FieldByName('PERIODO').AsString := DateToStr(EditDataInicial.Date + ContadorPeriodo);
            2: // semanal
              CDSOrcamentoDetalhe.FieldByName('PERIODO').AsString := DateToStr(IncWeek(EditDataInicial.Date, ContadorPeriodo));
            3: // mensal
              CDSOrcamentoDetalhe.FieldByName('PERIODO').AsString := Copy(DateToStr(IncMonth(EditDataInicial.Date, ContadorPeriodo)), 4, 7);
            4: // bimestral
              CDSOrcamentoDetalhe.FieldByName('PERIODO').AsString := Copy(DateToStr(IncMonth(EditDataInicial.Date, ContadorPeriodo * 2)), 4, 7);
            5: // trimestral
              CDSOrcamentoDetalhe.FieldByName('PERIODO').AsString := Copy(DateToStr(IncMonth(EditDataInicial.Date, ContadorPeriodo * 3)), 4, 7);
            6: // semestral
              CDSOrcamentoDetalhe.FieldByName('PERIODO').AsString := Copy(DateToStr(IncMonth(EditDataInicial.Date, ContadorPeriodo * 6)), 4, 7);
            7: // anual
              CDSOrcamentoDetalhe.FieldByName('PERIODO').AsString := Copy(DateToStr(IncYear(EditDataInicial.Date, ContadorPeriodo)), 7, 4);
          end;
          CDSOrcamentoDetalhe.Post;
          CDSConsultaGenerica.Next;
        end;
        Inc(ContadorPeriodo);
      end;
      CDSConsultaGenerica.Close;
      GridOrcamentoDetalhe.SetFocus;
    end;
  finally
    CDSTransiente.Close;
  end;
end;

procedure TFOrcamentoEmpresarial.ActionPegarRealizadoExecute(Sender: TObject);
var
  FiltroRecebimento, FiltroPagamento: String;
  DataInicio, DataFim: TDateTime;
  RealizadoPagar, RealizadoReceber: Extended;
begin
  try
    CDSOrcamentoDetalhe.DisableControls;
    CDSOrcamentoDetalhe.First;
    while not CDSOrcamentoDetalhe.Eof do
    begin
      RealizadoPagar := 0;
      RealizadoReceber := 0;

      //Define o filtro
      if EditOrcamentoPeriodoCodigo.Text = '01' then //Di�rio
      begin
        DataInicio := StrToDate(CDSOrcamentoDetalhe.FieldByName('PERIODO').AsString);
        FiltroRecebimento := 'DATA_RECEBIMENTO='+QuotedStr(DataParaTexto(DataInicio));
        FiltroPagamento := 'DATA_PAGAMENTO='+QuotedStr(DataParaTexto(DataInicio));
      end
      else if EditOrcamentoPeriodoCodigo.Text = '02' then //Semanal
      begin
        DataInicio := StrToDate(CDSOrcamentoDetalhe.FieldByName('PERIODO').AsString);
        DataFim := StrToDate(CDSOrcamentoDetalhe.FieldByName('PERIODO').AsString) + 6;
        FiltroRecebimento := '(DATA_RECEBIMENTO between '+QuotedStr(DataParaTexto(DataInicio)) + ' and ' + QuotedStr(DataParaTexto(DataFim)) + ')';
        FiltroPagamento := '(DATA_PAGAMENTO between '+QuotedStr(DataParaTexto(DataInicio)) + ' and ' + QuotedStr(DataParaTexto(DataFim)) + ')';
      end
      else if EditOrcamentoPeriodoCodigo.Text = '03' then //Mensal
      begin
        DataInicio := StrToDate('01/'+CDSOrcamentoDetalhe.FieldByName('PERIODO').AsString);
        DataFim := StrToDate('01/'+CDSOrcamentoDetalhe.FieldByName('PERIODO').AsString) + 30;
        FiltroRecebimento := '(DATA_RECEBIMENTO between '+QuotedStr(DataParaTexto(DataInicio)) + ' and ' + QuotedStr(DataParaTexto(DataFim)) + ')';
        FiltroPagamento := '(DATA_PAGAMENTO between '+QuotedStr(DataParaTexto(DataInicio)) + ' and ' + QuotedStr(DataParaTexto(DataFim)) + ')';
      end
      else if EditOrcamentoPeriodoCodigo.Text = '04' then //Bimestral
      begin
        DataInicio := StrToDate('01/'+CDSOrcamentoDetalhe.FieldByName('PERIODO').AsString);
        DataFim := StrToDate('01/'+CDSOrcamentoDetalhe.FieldByName('PERIODO').AsString) + 60;
        FiltroRecebimento := '(DATA_RECEBIMENTO between '+QuotedStr(DataParaTexto(DataInicio)) + ' and ' + QuotedStr(DataParaTexto(DataFim)) + ')';
        FiltroPagamento := '(DATA_PAGAMENTO between '+QuotedStr(DataParaTexto(DataInicio)) + ' and ' + QuotedStr(DataParaTexto(DataFim)) + ')';
      end
      else if EditOrcamentoPeriodoCodigo.Text = '05' then //Trimestral
      begin
        DataInicio := StrToDate('01/'+CDSOrcamentoDetalhe.FieldByName('PERIODO').AsString);
        DataFim := StrToDate('01/'+CDSOrcamentoDetalhe.FieldByName('PERIODO').AsString) + 90;
        FiltroRecebimento := '(DATA_RECEBIMENTO between '+QuotedStr(DataParaTexto(DataInicio)) + ' and ' + QuotedStr(DataParaTexto(DataFim)) + ')';
        FiltroPagamento := '(DATA_PAGAMENTO between '+QuotedStr(DataParaTexto(DataInicio)) + ' and ' + QuotedStr(DataParaTexto(DataFim)) + ')';
      end
      else if EditOrcamentoPeriodoCodigo.Text = '06' then //Semestral
      begin
        DataInicio := StrToDate('01/'+CDSOrcamentoDetalhe.FieldByName('PERIODO').AsString);
        DataFim := StrToDate('01/'+CDSOrcamentoDetalhe.FieldByName('PERIODO').AsString) + 180;
        FiltroRecebimento := '(DATA_RECEBIMENTO between '+QuotedStr(DataParaTexto(DataInicio)) + ' and ' + QuotedStr(DataParaTexto(DataFim)) + ')';
        FiltroPagamento := '(DATA_PAGAMENTO between '+QuotedStr(DataParaTexto(DataInicio)) + ' and ' + QuotedStr(DataParaTexto(DataFim)) + ')';
      end
      else if EditOrcamentoPeriodoCodigo.Text = '07' then //Anual
      begin
        DataInicio := StrToDate('01/01/'+CDSOrcamentoDetalhe.FieldByName('PERIODO').AsString);
        DataFim := StrToDate('31/12/'+CDSOrcamentoDetalhe.FieldByName('PERIODO').AsString);
        FiltroRecebimento := '(DATA_RECEBIMENTO between '+QuotedStr(DataParaTexto(DataInicio)) + ' and ' + QuotedStr(DataParaTexto(DataFim)) + ')';
        FiltroPagamento := '(DATA_PAGAMENTO between '+QuotedStr(DataParaTexto(DataInicio)) + ' and ' + QuotedStr(DataParaTexto(DataFim)) + ')';
      end;

      //Realiza a consulta e pega os valores recebidos
      ConsultaGenerica(FiltroRecebimento, TViewFinTotalRecebimentosDiaVO, TViewFinTotalRecebimentosDiaController);
      CDSConsultaGenerica.First;
      while not CDSConsultaGenerica.Eof do
      begin
        RealizadoReceber := RealizadoReceber + CDSConsultaGenerica.FieldByName('TOTAL').AsExtended;
        CDSConsultaGenerica.Next;
      end;
      CDSConsultaGenerica.Close;

      //Realiza a consulta e pega os valores pagos
      ConsultaGenerica(FiltroPagamento, TViewFinTotalPagamentosDiaVO, TViewFinTotalPagamentosDiaController);
      CDSConsultaGenerica.First;
      while not CDSConsultaGenerica.Eof do
      begin
        RealizadoPagar := RealizadoPagar + CDSConsultaGenerica.FieldByName('TOTAL').AsExtended;
        CDSConsultaGenerica.Next;
      end;
      CDSConsultaGenerica.Close;

      //Grava os valores
      CDSOrcamentoDetalhe.Edit;
      CDSOrcamentoDetalhe.FieldByName('VALOR_REALIZADO').AsExtended := RealizadoPagar + RealizadoReceber;
      CDSOrcamentoDetalhe.Post;

      CDSOrcamentoDetalhe.Next;
    end;
    CDSOrcamentoDetalhe.First;
    CDSOrcamentoDetalhe.EnableControls;

    GridOrcamentoDetalhe.SetFocus;
  except
    on E: Exception do
      Application.MessageBox(PChar('Ocorreu um erro na consulta do realizado. Informe a mensagem ao Administrador do sistema.' + #13 + #13 + E.Message), 'Erro do sistema', MB_OK + MB_ICONERROR);
  end;
end;

procedure TFOrcamentoEmpresarial.ActionCalcularVariacaoExecute(Sender: TObject);
begin
  try
    CDSOrcamentoDetalhe.DisableControls;
    CDSOrcamentoDetalhe.First;
    while not CDSOrcamentoDetalhe.Eof do
    begin
      if (CDSOrcamentoDetalhe.FieldByName('VALOR_REALIZADO').AsExtended <> 0) and (CDSOrcamentoDetalhe.FieldByName('VALOR_ORCADO').AsExtended <> 0) then
      begin
        CDSOrcamentoDetalhe.Edit;
        CDSOrcamentoDetalhe.FieldByName('VALOR_VARIACAO').AsExtended := CDSOrcamentoDetalhe.FieldByName('VALOR_REALIZADO').AsExtended - CDSOrcamentoDetalhe.FieldByName('VALOR_ORCADO').AsExtended;
        CDSOrcamentoDetalhe.FieldByName('TAXA_VARIACAO').AsExtended := RoundTo(CDSOrcamentoDetalhe.FieldByName('VALOR_VARIACAO').AsExtended / CDSOrcamentoDetalhe.FieldByName('VALOR_ORCADO').AsExtended * 100, -2);
        CDSOrcamentoDetalhe.Post;
      end;
      CDSOrcamentoDetalhe.Next;
    end;
    CDSOrcamentoDetalhe.First;
    CDSOrcamentoDetalhe.EnableControls;
    GridOrcamentoDetalhe.SetFocus;
  except
    on E: Exception do
      Application.MessageBox(PChar('Ocorreu um erro ao calcular a varia��o. Informe a mensagem ao Administrador do sistema.' + #13 + #13 + E.Message), 'Erro do sistema', MB_OK + MB_ICONERROR);
  end;
end;
{$ENDREGION}

end.
