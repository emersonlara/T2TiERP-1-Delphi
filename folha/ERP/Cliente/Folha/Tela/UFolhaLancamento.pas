{ *******************************************************************************
  Title: T2Ti ERP
  Description: Janela de Lan�amentos para a Folha de Pagamento

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

  @author Albert Eije (alberteije@gmail.com)
  @version 1.0
  ******************************************************************************* }
unit UFolhaLancamento;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UTelaCadastro, DB, DBClient, Menus, StdCtrls, ExtCtrls, Buttons, Grids,
  DBGrids, JvExDBGrids, JvDBGrid, JvDBUltimGrid, ComCtrls, FolhaLancamentoCabecalhoVO,
  FolhaLancamentoCabecalhoController, Tipos, Atributos, Constantes, LabeledCtrls, JvToolEdit,
  Mask, JvExMask, JvBaseEdits, Math, StrUtils, ActnList, Generics.Collections,
  RibbonSilverStyleActnCtrls, ActnMan, ToolWin, ActnCtrls, ColaboradorVO;

type
  [TFormDescription(TConstantes.MODULO_FOLHA_PAGAMENTO, 'Lan�amentos')]

  TFFolhaLancamento = class(TFTelaCadastro)
    DSFolhaLancamentoDetalhe: TDataSource;
    CDSFolhaLancamentoDetalhe: TClientDataSet;
    PanelMestre: TPanel;
    EditIdColaborador: TLabeledCalcEdit;
    EditColaborador: TLabeledEdit;
    PageControlItens: TPageControl;
    tsItens: TTabSheet;
    PanelItens: TPanel;
    GridDetalhe: TJvDBUltimGrid;
    EditCompetencia: TLabeledMaskEdit;
    ComboBoxTipo: TLabeledComboBox;
    CDSFolhaLancamentoDetalheID: TIntegerField;
    CDSFolhaLancamentoDetalheID_FOLHA_EVENTO: TIntegerField;
    CDSFolhaLancamentoDetalheID_FOLHA_LANCAMENTO_CABECALHO: TIntegerField;
    CDSFolhaLancamentoDetalheORIGEM: TFMTBCDField;
    CDSFolhaLancamentoDetalhePROVENTO: TFMTBCDField;
    CDSFolhaLancamentoDetalheDESCONTO: TFMTBCDField;
    CDSFolhaLancamentoDetalhePERSISTE: TStringField;
    CDSFolhaLancamentoDetalheFOLHA_EVENTONOME: TStringField;
    procedure FormCreate(Sender: TObject);
    procedure EditIdColaboradorExit(Sender: TObject);
    procedure GridDblClick(Sender: TObject);
    procedure EditIdColaboradorKeyPress(Sender: TObject; var Key: Char);
    procedure EditIdColaboradorKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure CDSFolhaLancamentoDetalheAfterEdit(DataSet: TDataSet);
    procedure GridDetalheKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);

  private
    { Private declarations }
  public
    { Public declarations }
    procedure GridParaEdits; override;
    procedure LimparCampos; override;
    procedure ControlaBotoes; override;
    procedure ControlaPopupMenu; override;

    // Controles CRUD
    function DoInserir: Boolean; override;
    function DoEditar: Boolean; override;
    function DoExcluir: Boolean; override;
    function DoSalvar: Boolean; override;

    procedure ConfigurarLayoutTela;
  end;

var
  FFolhaLancamento: TFFolhaLancamento;
  Colaborador: TColaboradorVO;

implementation

uses ULookup, Biblioteca, UDataModule, FolhaLancamentoDetalheVO,
ColaboradorController, FolhaEventoVO, FolhaEventoController;
{$R *.dfm}

{$REGION 'Controles Infra'}
procedure TFFolhaLancamento.FormCreate(Sender: TObject);
begin
  ClasseObjetoGridVO := TFolhaLancamentoCabecalhoVO;
  ObjetoController := TFolhaLancamentoCabecalhoController.Create;

  inherited;
end;

procedure TFFolhaLancamento.LimparCampos;
begin
  inherited;
  CDSFolhaLancamentoDetalhe.EmptyDataSet;
end;

procedure TFFolhaLancamento.ConfigurarLayoutTela;
begin
  PanelEdits.Enabled := True;

  if StatusTela = stNavegandoEdits then
  begin
    PanelMestre.Enabled := False;
    PanelItens.Enabled := False;
  end
  else
  begin
    PanelMestre.Enabled := True;
    PanelItens.Enabled := True;
  end;
end;

procedure TFFolhaLancamento.ControlaBotoes;
begin
  inherited;

  BotaoImprimir.Visible := False;
end;

procedure TFFolhaLancamento.ControlaPopupMenu;
begin
  inherited;

  MenuImprimir.Visible := False;
end;
{$ENDREGION}

{$REGION 'Controles CRUD'}
function TFFolhaLancamento.DoInserir: Boolean;
begin
  Result := inherited DoInserir;

  ConfigurarLayoutTela;
  if Result then
  begin
    EditIdColaborador.SetFocus;
  end;
end;

function TFFolhaLancamento.DoEditar: Boolean;
begin
  Result := inherited DoEditar;

  ConfigurarLayoutTela;
  if Result then
  begin
    EditIdColaborador.SetFocus;
  end;
end;

function TFFolhaLancamento.DoExcluir: Boolean;
begin
  if inherited DoExcluir then
  begin
    try
      Result := TFolhaLancamentoCabecalhoController(ObjetoController).Exclui(IdRegistroSelecionado);
    except
      Result := False;
    end;
  end
  else
  begin
    Result := False;
  end;

  if Result then
    TFolhaLancamentoCabecalhoController(ObjetoController).Consulta(Filtro, Pagina);
end;

function TFFolhaLancamento.DoSalvar: Boolean;
var
  FolhaLancamentoDetalhe: TFolhaLancamentoDetalheVO;
begin
  DecimalSeparator := '.';
  Result := inherited DoSalvar;

  if Result then
  begin
    try
      if not Assigned(ObjetoVO) then
        ObjetoVO := TFolhaLancamentoCabecalhoVO.Create;

      TFolhaLancamentoCabecalhoVO(ObjetoVO).IdColaborador := EditIdColaborador.AsInteger;
      TFolhaLancamentoCabecalhoVO(ObjetoVO).ColaboradorNome := EditColaborador.Text;
      TFolhaLancamentoCabecalhoVO(ObjetoVO).Competencia := EditCompetencia.Text;
      TFolhaLancamentoCabecalhoVO(ObjetoVO).Tipo := Copy(ComboBoxTipo.Text, 1, 1);

      // Detalhes
      TFolhaLancamentoCabecalhoVO(ObjetoVO).ListaFolhaLancamentoDetalheVO := TObjectList<TFolhaLancamentoDetalheVO>.Create;
      CDSFolhaLancamentoDetalhe.DisableControls;
      CDSFolhaLancamentoDetalhe.First;
      while not CDSFolhaLancamentoDetalhe.Eof do
      begin
        if (CDSFolhaLancamentoDetalhePERSISTE.AsString = 'S') or (CDSFolhaLancamentoDetalheID.AsInteger = 0) then
        begin
          FolhaLancamentoDetalhe := TFolhaLancamentoDetalheVO.Create;
          FolhaLancamentoDetalhe.Id := CDSFolhaLancamentoDetalheID.AsInteger;
          FolhaLancamentoDetalhe.IdFolhaLancamentoCabecalho := TFolhaLancamentoCabecalhoVO(ObjetoVO).Id;
          FolhaLancamentoDetalhe.IdFolhaEvento := CDSFolhaLancamentoDetalheID_FOLHA_EVENTO.AsInteger;
          FolhaLancamentoDetalhe.Origem := CDSFolhaLancamentoDetalheORIGEM.AsFloat;
          FolhaLancamentoDetalhe.Provento := CDSFolhaLancamentoDetalhePROVENTO.AsFloat;
          FolhaLancamentoDetalhe.Desconto := CDSFolhaLancamentoDetalheDESCONTO.AsFloat;
          TFolhaLancamentoCabecalhoVO(ObjetoVO).ListaFolhaLancamentoDetalheVO.Add(FolhaLancamentoDetalhe);
        end;

        CDSFolhaLancamentoDetalhe.Next;
      end;
      CDSFolhaLancamentoDetalhe.EnableControls;

      TFolhaLancamentoCabecalhoVO(ObjetoVO).ColaboradorVO := Nil;
      if Assigned(ObjetoOldVO) then
      begin
        TFolhaLancamentoCabecalhoVO(ObjetoOldVO).ColaboradorVO := Nil;
      end;

      if StatusTela = stInserindo then
        Result := TFolhaLancamentoCabecalhoController(ObjetoController).Insere(TFolhaLancamentoCabecalhoVO(ObjetoVO))
      else if StatusTela = stEditando then
      begin
        if TFolhaLancamentoCabecalhoVO(ObjetoVO).ToJSONString <> TFolhaLancamentoCabecalhoVO(ObjetoOldVO).ToJSONString then
        begin
          Result := TFolhaLancamentoCabecalhoController(ObjetoController).Altera(TFolhaLancamentoCabecalhoVO(ObjetoVO), TFolhaLancamentoCabecalhoVO(ObjetoOldVO));
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
procedure TFFolhaLancamento.CDSFolhaLancamentoDetalheAfterEdit(DataSet: TDataSet);
begin
  CDSFolhaLancamentoDetalhePERSISTE.AsString := 'S';
end;

procedure TFFolhaLancamento.GridDblClick(Sender: TObject);
begin
  inherited;
  ConfigurarLayoutTela;
end;

procedure TFFolhaLancamento.GridDetalheKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F1 then
  begin
    try
      PopulaCamposTransientesLookup(TFolhaEventoVO, TFolhaEventoController);
      if CDSTransiente.RecordCount > 0 then
      begin
        CDSFolhaLancamentoDetalhe.Append;

        CDSFolhaLancamentoDetalheID_FOLHA_EVENTO.AsInteger := CDSTransiente.FieldByName('ID').AsInteger;
        CDSFolhaLancamentoDetalheFOLHA_EVENTONOME.AsString := CDSTransiente.FieldByName('NOME').AsString;
        { Campo BASE_CALCULO da tabela FOLHA_EVENTO
          01=Sal�rio contratual: define que a base de c�lculo deve ser calculada sobre o valor do sal�rio contratual;
          02=Sal�rio m�nimo: define que a base de c�lculo deve ser calculada sobre o valor do sal�rio m�nimo;
          03=Piso Salarial: define que a base de c�lculo deve ser calculada sobre o valor do piso salarial definido no cadastro de sindicatos;
          04=L�quido: define que a base de c�lculo deve ser calculada sobre o l�quido da folha;
        }
        { Os demais casos devem ser implementados a crit�rio do Participante do T2Ti ERP }
        if CDSTransiente.FieldByName('BASE_CALCULO').AsString = '01' then
        begin
          CDSFolhaLancamentoDetalheORIGEM.AsExtended := Colaborador.CargoVO.Salario;
        end;

        // Provento ou Desconto
        if CDSTransiente.FieldByName('TIPO').AsString = 'P' then
        begin
          CDSFolhaLancamentoDetalhePROVENTO.AsExtended := ArredondaTruncaValor('A', CDSFolhaLancamentoDetalheORIGEM.AsExtended * CDSTransiente.FieldByName('TAXA').AsExtended / 100, 2);
          CDSFolhaLancamentoDetalheDESCONTO.AsExtended := 0;
        end
        else
        begin
          CDSFolhaLancamentoDetalhePROVENTO.AsExtended := 0;
          CDSFolhaLancamentoDetalheDESCONTO.AsExtended := ArredondaTruncaValor('A', CDSFolhaLancamentoDetalheORIGEM.AsExtended * CDSTransiente.FieldByName('TAXA').AsExtended / 100, 2);
        end;
        CDSFolhaLancamentoDetalhe.Post;
      end;
    finally
      CDSTransiente.Close;
    end;
  end;
  If Key = VK_RETURN then
    EditIdColaborador.SetFocus;
end;

procedure TFFolhaLancamento.GridParaEdits;
var
  FolhaLancamentoDetalheEnumerator: TEnumerator<TFolhaLancamentoDetalheVO>;
begin
  inherited;

  if not CDSGrid.IsEmpty then
  begin
    ObjetoVO := ObjetoController.VO<TFolhaLancamentoCabecalhoVO>(IdRegistroSelecionado);
    if StatusTela = stEditando then
      ObjetoOldVO := ObjetoController.VO<TFolhaLancamentoCabecalhoVO>(IdRegistroSelecionado);
  end;

  if Assigned(ObjetoVO) then
  begin
    EditIdColaborador.AsInteger := TFolhaLancamentoCabecalhoVO(ObjetoVO).IdColaborador;
    EditColaborador.Text := TFolhaLancamentoCabecalhoVO(ObjetoVO).ColaboradorNome;
    EditCompetencia.Text := TFolhaLancamentoCabecalhoVO(ObjetoVO).Competencia;
    ComboBoxTipo.ItemIndex := StrToInt(TFolhaLancamentoCabecalhoVO(ObjetoVO).Tipo) - 1;

    Colaborador := TColaboradorController.VO<TColaboradorVO>(EditIdColaborador.AsInteger);

    // Detalhes
    FolhaLancamentoDetalheEnumerator := TFolhaLancamentoCabecalhoVO(ObjetoVO).ListaFolhaLancamentoDetalheVO.GetEnumerator;
    try
      with FolhaLancamentoDetalheEnumerator do
      begin
        while MoveNext do
        begin
          CDSFolhaLancamentoDetalhe.Append;
          CDSFolhaLancamentoDetalheID.AsInteger := Current.id;
          CDSFolhaLancamentoDetalheID_FOLHA_LANCAMENTO_CABECALHO.AsInteger := Current.IdFolhaLancamentoCabecalho;
          CDSFolhaLancamentoDetalheID_FOLHA_EVENTO.AsInteger := Current.IdFolhaEvento;
          CDSFolhaLancamentoDetalheFOLHA_EVENTONOME.AsString := Current.FolhaEventoVO.Nome;
          CDSFolhaLancamentoDetalheORIGEM.AsFloat := Current.Origem;
          CDSFolhaLancamentoDetalhePROVENTO.AsFloat := Current.Provento;
          CDSFolhaLancamentoDetalheDESCONTO.AsFloat := Current.Desconto;
          CDSFolhaLancamentoDetalhe.Post;
        end;
      end;
    finally
      FolhaLancamentoDetalheEnumerator.Free;
    end;

    TFolhaLancamentoCabecalhoVO(ObjetoVO).ListaFolhaLancamentoDetalheVO := Nil;
    if Assigned(TFolhaLancamentoCabecalhoVO(ObjetoOldVO)) then
      TFolhaLancamentoCabecalhoVO(ObjetoOldVO).ListaFolhaLancamentoDetalheVO := Nil;
  end;

  ConfigurarLayoutTela;
end;
{$ENDREGION}

{$REGION 'Campos Transientes'}
procedure TFFolhaLancamento.EditIdColaboradorExit(Sender: TObject);
var
  Filtro: String;
begin
  if EditIdColaborador.Value <> 0 then
  begin
    try
      Filtro := 'ID = ' + EditIdColaborador.Text;
      EditIdColaborador.Clear;
      EditColaborador.Clear;
      if not PopulaCamposTransientes(Filtro, TColaboradorVO, TColaboradorController) then
        PopulaCamposTransientesLookup(TColaboradorVO, TColaboradorController);
      if CDSTransiente.RecordCount > 0 then
      begin
        EditIdColaborador.Text := CDSTransiente.FieldByName('ID').AsString;
        EditColaborador.Text := CDSTransiente.FieldByName('PESSOA.NOME').AsString;
        Colaborador := TColaboradorController.VO<TColaboradorVO>(EditIdColaborador.AsInteger);
      end
      else
      begin
        Exit;
        EditIdColaborador.SetFocus;
      end;
    finally
      CDSTransiente.Close;
    end;
  end
  else
  begin
    EditColaborador.Clear;
  end;
end;

procedure TFFolhaLancamento.EditIdColaboradorKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F1 then
  begin
    EditIdColaborador.Value := -1;
    EditCompetencia.SetFocus;
  end;
end;

procedure TFFolhaLancamento.EditIdColaboradorKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    EditCompetencia.SetFocus;
  end;
end;
{$ENDREGION}

end.
