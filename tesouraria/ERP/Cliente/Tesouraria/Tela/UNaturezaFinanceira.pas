{ *******************************************************************************
  Title: T2Ti ERP
  Description: Janela Cadastro de Natureza Financeira

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

  @author Albert Eije (t2ti.com@gmail.com)
  @version 1.0
  ******************************************************************************* }
unit UNaturezaFinanceira;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UTelaCadastro, DB, DBClient, Menus, StdCtrls, ExtCtrls, Buttons, Grids,
  DBGrids, JvExDBGrids, JvDBGrid, JvDBUltimGrid, ComCtrls, NaturezaFinanceiraVO,
  NaturezaFinanceiraController, Tipos, Atributos, Constantes, LabeledCtrls, JvToolEdit,
  Mask, JvExMask, JvBaseEdits, Math, StrUtils;

type
  [TFormDescription(TConstantes.MODULO_FINANCEIRO, 'Natureza Financeira')]

  TFNaturezaFinanceira = class(TFTelaCadastro)
    BevelEdits: TBevel;
    EditPlanoNaturezaFinanceira: TLabeledEdit;
    EditContabilConta: TLabeledEdit;
    EditAplicacao: TLabeledEdit;
    EditDescricao: TLabeledEdit;
    EditClassificacao: TLabeledEdit;
    EditIdPlanoNaturezaFinanceira: TLabeledCalcEdit;
    EditIdContabilConta: TLabeledCalcEdit;
    GroupBoxOpcoes: TGroupBox;
    ComboBoxTipo: TLabeledComboBox;
    ComboBoxAPagar: TLabeledComboBox;
    ComboBoxAReceber: TLabeledComboBox;
    procedure FormCreate(Sender: TObject);
    procedure EditIdPlanoNaturezaFinanceiraExit(Sender: TObject);
    procedure EditIdContabilContaExit(Sender: TObject);
    procedure EditIdPlanoNaturezaFinanceiraKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EditIdContabilContaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EditIdPlanoNaturezaFinanceiraKeyPress(Sender: TObject; var Key: Char);
    procedure EditIdContabilContaKeyPress(Sender: TObject; var Key: Char);

  private
    { Private declarations }
  public
    { Public declarations }
    procedure GridParaEdits; override;

    // Controles CRUD
    function DoInserir: Boolean; override;
    function DoEditar: Boolean; override;
    function DoExcluir: Boolean; override;
    function DoSalvar: Boolean; override;

  end;

var
  FNaturezaFinanceira: TFNaturezaFinanceira;

implementation

uses ULookup, Biblioteca, UDataModule, PlanoNaturezaFinanceiraVO, PlanoNaturezaFinanceiraController,
  CentroResultadoVO, CentroResultadoController, ContabilContaVO, ContabilContaController;
{$R *.dfm}

{$REGION 'Infra'}
procedure TFNaturezaFinanceira.FormCreate(Sender: TObject);
begin
  ClasseObjetoGridVO := TNaturezaFinanceiraVO;
  ObjetoController := TNaturezaFinanceiraController.Create;

  inherited;
end;
{$ENDREGION}

{$REGION 'Controles CRUD'}
function TFNaturezaFinanceira.DoInserir: Boolean;
begin
  Result := inherited DoInserir;

  if Result then
  begin
    EditIdPlanoNaturezaFinanceira.SetFocus;
  end;
end;

function TFNaturezaFinanceira.DoEditar: Boolean;
begin
  Result := inherited DoEditar;

  if Result then
  begin
    EditIdPlanoNaturezaFinanceira.SetFocus;
  end;
end;

function TFNaturezaFinanceira.DoExcluir: Boolean;
begin
  if inherited DoExcluir then
  begin
    try
      Result := TNaturezaFinanceiraController(ObjetoController).Exclui(IdRegistroSelecionado);
    except
      Result := False;
    end;
  end
  else
  begin
    Result := False;
  end;

  if Result then
    TNaturezaFinanceiraController(ObjetoController).Consulta(Filtro, Pagina);
end;

function TFNaturezaFinanceira.DoSalvar: Boolean;
begin
  Result := inherited DoSalvar;

  if Result then
  begin
    try
      if not Assigned(ObjetoVO) then
        ObjetoVO := TNaturezaFinanceiraVO.Create;

      TNaturezaFinanceiraVO(ObjetoVO).IdPlanoNaturezaFinanceira := EditIdPlanoNaturezaFinanceira.AsInteger;
      TNaturezaFinanceiraVO(ObjetoVO).PlanoNaturezaFinanceiraNome := EditPlanoNaturezaFinanceira.Text;
      TNaturezaFinanceiraVO(ObjetoVO).IdContabilConta := EditIdContabilConta.AsInteger;
      TNaturezaFinanceiraVO(ObjetoVO).ContabilContaClassificacao := EditContabilConta.Text;
      TNaturezaFinanceiraVO(ObjetoVO).Descricao := EditDescricao.Text;
      TNaturezaFinanceiraVO(ObjetoVO).Classificacao := EditClassificacao.Text;
      TNaturezaFinanceiraVO(ObjetoVO).Aplicacao := EditAplicacao.Text;
      TNaturezaFinanceiraVO(ObjetoVO).Tipo := IfThen(ComboBoxTipo.ItemIndex = 0, 'R', 'D');
      TNaturezaFinanceiraVO(ObjetoVO).ApareceAPagar := IfThen(ComboBoxAPagar.ItemIndex = 0, 'S', 'N');
      TNaturezaFinanceiraVO(ObjetoVO).ApareceAReceber := IfThen(ComboBoxAReceber.ItemIndex = 0, 'S', 'N');

      // ObjetoVO - libera objetos vinculados (TAssociation) - n�o tem necessidade de subir
      TNaturezaFinanceiraVO(ObjetoVO).PlanoNaturezaFinanceiraVO:= Nil;
      TNaturezaFinanceiraVO(ObjetoVO).ContabilContaVO := Nil;
      if Assigned(ObjetoOldVO) then
      begin
        TNaturezaFinanceiraVO(ObjetoOldVO).PlanoNaturezaFinanceiraVO:= Nil;
        TNaturezaFinanceiraVO(ObjetoOldVO).ContabilContaVO := Nil;
      end;

      if StatusTela = stInserindo then
        Result := TNaturezaFinanceiraController(ObjetoController).Insere(TNaturezaFinanceiraVO(ObjetoVO))
      else if StatusTela = stEditando then
      begin
        if TNaturezaFinanceiraVO(ObjetoVO).ToJSONString <> TNaturezaFinanceiraVO(ObjetoOldVO).ToJSONString then
        begin
          TNaturezaFinanceiraVO(ObjetoVO).Id := IdRegistroSelecionado;
          Result := TNaturezaFinanceiraController(ObjetoController).Altera(TNaturezaFinanceiraVO(ObjetoVO), TNaturezaFinanceiraVO(ObjetoOldVO));
        end
        else
          Application.MessageBox('Nenhum dado foi alterado.', 'Mensagem do Sistema', MB_OK + MB_ICONINFORMATION);
      end;
    except
      Result := False;
    end;
  end;
end;
{$ENDREGION}

{$REGION 'Controle de Grid'}
procedure TFNaturezaFinanceira.GridParaEdits;
begin
  inherited;

  if not CDSGrid.IsEmpty then
  begin
    ObjetoVO := ObjetoController.VO<TNaturezaFinanceiraVO>(IdRegistroSelecionado);
    if StatusTela = stEditando then
      ObjetoOldVO := ObjetoController.VO<TNaturezaFinanceiraVO>(IdRegistroSelecionado);
  end;

  if Assigned(ObjetoVO) then
  begin
    EditIdPlanoNaturezaFinanceira.AsInteger := TNaturezaFinanceiraVO(ObjetoVO).IdPlanoNaturezaFinanceira;
    EditPlanoNaturezaFinanceira.Text := TNaturezaFinanceiraVO(ObjetoVO).PlanoNaturezaFinanceiraNome;
    EditIdContabilConta.AsInteger := TNaturezaFinanceiraVO(ObjetoVO).IdContabilConta;
    EditContabilConta.Text := TNaturezaFinanceiraVO(ObjetoVO).ContabilContaClassificacao;
    EditDescricao.Text := TNaturezaFinanceiraVO(ObjetoVO).Descricao;
    EditClassificacao.Text := TNaturezaFinanceiraVO(ObjetoVO).Classificacao;
    EditAplicacao.Text := TNaturezaFinanceiraVO(ObjetoVO).Aplicacao;
    ComboBoxTipo.ItemIndex := IfThen(TNaturezaFinanceiraVO(ObjetoVO).Tipo = 'R', 0, 1);
    ComboBoxAPagar.ItemIndex := IfThen(TNaturezaFinanceiraVO(ObjetoVO).ApareceAPagar = 'S', 0, 1);
    ComboBoxAReceber.ItemIndex := IfThen(TNaturezaFinanceiraVO(ObjetoVO).ApareceAReceber = 'S', 0, 1);
  end;
end;
{$ENDREGION}

{$REGION 'Campos Transientes'}
procedure TFNaturezaFinanceira.EditIdPlanoNaturezaFinanceiraExit(Sender: TObject);
var
  Filtro: String;
begin
   if EditIdPlanoNaturezaFinanceira.Value <> 0 then
  begin
    try
      Filtro := 'ID = ' + EditIdPlanoNaturezaFinanceira.Text;
      EditIdPlanoNaturezaFinanceira.Clear;
      EditPlanoNaturezaFinanceira.Clear;
      if not PopulaCamposTransientes(Filtro, TPlanoNaturezaFinanceiraVO,TPlanoNaturezaFinanceiraController) then
        PopulaCamposTransientesLookup(TPlanoNaturezaFinanceiraVO, TPlanoNaturezaFinanceiraController);
      if CDSTransiente.RecordCount > 0 then
      begin
        EditIdPlanoNaturezaFinanceira.Text := CDSTransiente.FieldByName('ID').AsString;
        EditPlanoNaturezaFinanceira.Text := CDSTransiente.FieldByName('NOME').AsString + ' [' + CDSTransiente.FieldByName('MASCARA').AsString + ']';
      end
      else
      begin
        Exit;
        EditIdPlanoNaturezaFinanceira.SetFocus;
      end;
    finally
      CDSTransiente.Close;
    end;
  end
  else
  begin
    EditPlanoNaturezaFinanceira.Clear;
  end;
end;

procedure TFNaturezaFinanceira.EditIdPlanoNaturezaFinanceiraKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F1 then
  begin
    EditIdPlanoNaturezaFinanceira.Value := -1;
    EditIdContabilConta.SetFocus;
  end;
end;

procedure TFNaturezaFinanceira.EditIdPlanoNaturezaFinanceiraKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    EditIdContabilConta.SetFocus;
  end;
end;

procedure TFNaturezaFinanceira.EditIdContabilContaExit(Sender: TObject);
var
  Filtro: String;
begin
   if EditIdContabilConta.Value <> 0 then
  begin
    try
      Filtro := 'ID = ' + EditIdContabilConta.Text;
      EditIdContabilConta.Clear;
      EditContabilConta.Clear;
      if not PopulaCamposTransientes(Filtro, TContabilContaVO,TContabilContaController) then
        PopulaCamposTransientesLookup(TContabilContaVO, TContabilContaController);
      if CDSTransiente.RecordCount > 0 then
      begin
        EditIdContabilConta.Text := CDSTransiente.FieldByName('ID').AsString;
        EditContabilConta.Text := CDSTransiente.FieldByName('CLASSIFICACAO').AsString;
      end
      else
      begin
        Exit;
        EditIdContabilConta.SetFocus;
      end;
    finally
      CDSTransiente.Close;
    end;
  end
  else
  begin
    EditContabilConta.Clear;
  end;
end;

procedure TFNaturezaFinanceira.EditIdContabilContaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F1 then
  begin
    EditIdContabilConta.Value := -1;
    EditDescricao.SetFocus;
  end;
end;

procedure TFNaturezaFinanceira.EditIdContabilContaKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    EditDescricao.SetFocus;
  end;
end;
{$ENDREGION}

end.
