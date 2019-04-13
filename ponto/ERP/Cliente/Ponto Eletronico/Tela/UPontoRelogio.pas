{ *******************************************************************************
  Title: T2Ti ERP
  Description: Janela Cadastro de Rel�gios para o Ponto Eletr�nico

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
unit UPontoRelogio;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UTelaCadastro, DB, DBClient, Menus, StdCtrls, ExtCtrls, Buttons, Grids,
  DBGrids, JvExDBGrids, JvDBGrid, JvDBUltimGrid, ComCtrls, PontoRelogioVO,
  PontoRelogioController, Tipos, Atributos, Constantes, LabeledCtrls, Mask,
  JvExMask, JvToolEdit, JvBaseEdits, StrUtils;

type
  [TFormDescription(TConstantes.MODULO_PONTO_ELETRONICO, 'Ponto Rel�gios')]

  TFPontoRelogio = class(TFTelaCadastro)
    BevelEdits: TBevel;
    EditLocalizacao: TLabeledEdit;
    ComboboxUtilizacao: TLabeledComboBox;
    EditMarca: TLabeledEdit;
    EditNumeroSerie: TLabeledEdit;
    EditFabricante: TLabeledEdit;
    procedure FormCreate(Sender: TObject);
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
  FPontoRelogio: TFPontoRelogio;

implementation

{$R *.dfm}

{$REGION 'Infra'}
procedure TFPontoRelogio.FormCreate(Sender: TObject);
begin
  ClasseObjetoGridVO := TPontoRelogioVO;
  ObjetoController := TPontoRelogioController.Create;

  inherited;
end;
{$ENDREGION}

{$REGION 'Controles CRUD'}
function TFPontoRelogio.DoInserir: Boolean;
begin
  Result := inherited DoInserir;

  if Result then
  begin
    EditLocalizacao.SetFocus;
  end;
end;

function TFPontoRelogio.DoEditar: Boolean;
begin
  Result := inherited DoEditar;

  if Result then
  begin
    EditLocalizacao.SetFocus;
  end;
end;

function TFPontoRelogio.DoExcluir: Boolean;
begin
  if inherited DoExcluir then
  begin
    try
      Result := TPontoRelogioController(ObjetoController).Exclui(IdRegistroSelecionado);
    except
      Result := False;
    end;
  end
  else
  begin
    Result := False;
  end;

  if Result then
    TPontoRelogioController(ObjetoController).Consulta(Filtro, Pagina);
end;

function TFPontoRelogio.DoSalvar: Boolean;
begin
  Result := inherited DoSalvar;

  if Result then
  begin
    try
      if not Assigned(ObjetoVO) then
        ObjetoVO := TPontoRelogioVO.Create;

      TPontoRelogioVO(ObjetoVO).IdEmpresa := Sessao.IdEmpresa;
      TPontoRelogioVO(ObjetoVO).Localizacao := EditLocalizacao.Text;
      TPontoRelogioVO(ObjetoVO).Marca := EditMarca.Text;
      TPontoRelogioVO(ObjetoVO).NumeroSerie := EditNumeroSerie.Text;
      TPontoRelogioVO(ObjetoVO).Fabricante := EditFabricante.Text;
      TPontoRelogioVO(ObjetoVO).Utilizacao := Copy(ComboboxUtilizacao.Text, 1, 1);

      if StatusTela = stInserindo then
        Result := TPontoRelogioController(ObjetoController).Insere(TPontoRelogioVO(ObjetoVO))
      else if StatusTela = stEditando then
        if TPontoRelogioVO(ObjetoVO).ToJSONString <> TPontoRelogioVO(ObjetoOldVO).ToJSONString then
        begin
          TPontoRelogioVO(ObjetoVO).Id := IdRegistroSelecionado;
          Result := TPontoRelogioController(ObjetoController).Altera(TPontoRelogioVO(ObjetoVO), TPontoRelogioVO(ObjetoOldVO));
        end
        else
          Application.MessageBox('Nenhum dado foi alterado.', 'Mensagem do Sistema', MB_OK + MB_ICONINFORMATION);
    except
      Result := False;
    end;
  end;
end;
{$ENDREGION}

{$REGION 'Controle de Grid'}
procedure TFPontoRelogio.GridParaEdits;
begin
  inherited;

  if not CDSGrid.IsEmpty then
  begin
    ObjetoVO := ObjetoController.VO<TPontoRelogioVO>(IdRegistroSelecionado);
    if StatusTela = stEditando then
      ObjetoOldVO := ObjetoController.VO<TPontoRelogioVO>(IdRegistroSelecionado);
  end;

  if Assigned(ObjetoVO) then
  begin
    EditLocalizacao.Text := TPontoRelogioVO(ObjetoVO).Localizacao;
    EditMarca.Text := TPontoRelogioVO(ObjetoVO).Marca;
    EditNumeroSerie.Text := TPontoRelogioVO(ObjetoVO).NumeroSerie;
    EditFabricante.Text := TPontoRelogioVO(ObjetoVO).Fabricante;

    case AnsiIndexStr(TPontoRelogioVO(ObjetoVO).Utilizacao, ['P', 'R', 'C']) of
      0:
        ComboboxUtilizacao.ItemIndex := 0;
      1:
        ComboboxUtilizacao.ItemIndex := 1;
      2:
        ComboboxUtilizacao.ItemIndex := 2;
    end;
  end;
end;
{$ENDREGION}

end.
