{*******************************************************************************
Title: T2Ti ERP
Description: Janela Cadastro de Feriados

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

t2ti.com@gmail.com | fernandololiver@gmail.com
@author Albert Eije (T2Ti.COM) | Fernando L Oliveira
@version 1.0
*******************************************************************************}
unit UFeriados;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UTelaCadastro, DB, DBClient, Menus, StdCtrls, ExtCtrls, Buttons, Grids,
  DBGrids, JvExDBGrids, JvDBGrid, JvDBUltimGrid, ComCtrls, FeriadosVO,
  FeriadosController, Tipos, Atributos, Constantes, LabeledCtrls, Mask, JvExMask,
  JvToolEdit,StrUtils,Math, JvBaseEdits;

type
  [TFormDescription(TConstantes.MODULO_CADASTROS,'Feriados')]
  TFFeriados = class(TFTelaCadastro)
    BevelEdits: TBevel;
    EditAno: TLabeledEdit;
    EditNome: TLabeledEdit;
    EditUf: TLabeledEdit;
    EditDataFeriado: TLabeledDateEdit;
    EditMunicipioIbge: TLabeledCalcEdit;
    ComboboxAbrangencia: TLabeledComboBox;
    ComboBoxTipo: TLabeledComboBox;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure GridParaEdits; override;

    //Controles CRUD
    function DoInserir: Boolean; override;
    function DoEditar: Boolean; override;
    function DoExcluir: Boolean; override;
    function DoSalvar: Boolean; override;
  end;

var
  FFeriados: TFFeriados;

implementation

{$R *.dfm}

{$REGION 'Infra'}
procedure TFFeriados.FormCreate(Sender: TObject);
begin
  ClasseObjetoGridVO := TFeriadosVO;
  ObjetoController := TFeriadosController.Create;

  inherited;
end;
{$ENDREGION}

{$REGION 'Controles CRUD'}
function TFFeriados.DoInserir: Boolean;
begin
  Result := inherited DoInserir;

  if Result then
  begin
    EditAno.SetFocus;
  end;
end;

function TFFeriados.DoEditar: Boolean;
begin
  Result := inherited DoEditar;

  if Result then
  begin
    EditAno.SetFocus;
  end;
end;

function TFFeriados.DoExcluir: Boolean;
begin
  if inherited DoExcluir then
  begin
    try
      Result := TFeriadosController(ObjetoController).Exclui(IdRegistroSelecionado);
    except
      Result := False;
    end;
  end
  else
  begin
    Result := False;
  end;

  if Result then
    TFeriadosController(ObjetoController).Consulta(Filtro, Pagina);
end;

function TFFeriados.DoSalvar: Boolean;
begin
  Result := inherited DoSalvar;

  if Result then
  begin
    try
      if not Assigned(ObjetoVO) then
        ObjetoVO := TFeriadosVO.Create;

      TFeriadosVO(ObjetoVO).Ano := EditAno.Text;
      TFeriadosVO(ObjetoVO).Nome := EditNome.Text;
      TFeriadosVO(ObjetoVO).Abrangencia := Copy(ComboboxAbrangencia.Text, 1, 1);
      TFeriadosVO(ObjetoVO).Uf := EditUf.Text;
      TFeriadosVO(ObjetoVO).MunicipioIbge := EditMunicipioIbge.AsInteger;
      TFeriadosVO(ObjetoVO).Tipo := Copy(ComboBoxTipo.Text, 1, 1);
      TFeriadosVO(ObjetoVO).DataFeriado := EditDataFeriado.Date;

      if StatusTela = stInserindo then
        Result := TFeriadosController(ObjetoController).Insere(TFeriadosVO(ObjetoVO))
      else if StatusTela = stEditando then
      begin
        if TFeriadosVO(ObjetoVO).ToJSONString <> TFeriadosVO(ObjetoOldVO).ToJSONString then
        begin
          TFeriadosVO(ObjetoVO).Id := IdRegistroSelecionado;
          Result := TFeriadosController(ObjetoController).Altera(TFeriadosVO(ObjetoVO), TFeriadosVO(ObjetoOldVO));
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
procedure TFFeriados.GridParaEdits;
begin
  inherited;

  if not CDSGrid.IsEmpty then
  begin
    ObjetoVO := ObjetoController.VO<TFeriadosVO>(IdRegistroSelecionado);
    if StatusTela = stEditando then
      ObjetoOldVO := ObjetoVO.Clone;
  end;

  if Assigned(ObjetoVO) then
  begin
    EditAno.Text := TFeriadosVO(ObjetoVO).Ano;
    EditNome.Text := TFeriadosVO(ObjetoVO).Nome;
    ComboboxAbrangencia.ItemIndex := AnsiIndexStr(TFeriadosVO(ObjetoVO).Abrangencia, ['F','E','M']);
    EditUf.Text := TFeriadosVO(ObjetoVO).Uf;
    EditMunicipioIbge.AsInteger := TFeriadosVO(ObjetoVO).MunicipioIbge;
    ComboboxTipo.ItemIndex := AnsiIndexStr(TFeriadosVO(ObjetoVO).Tipo, ['F','M']);
    EditDataFeriado.Date := TFeriadosVO(ObjetoVO).DataFeriado;
  end;
end;
{$ENDREGION}

end.
