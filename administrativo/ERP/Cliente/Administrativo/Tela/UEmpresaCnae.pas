{*******************************************************************************
Title: T2Ti ERP
Description: Janela Cadastro de Empresa Cnae

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

@author F�bio Thomaz (fabio_thz@yahoo.com.br)
@version 1.0
*******************************************************************************}
unit UEmpresaCnae;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UTelaCadastro, DB, DBClient, Menus, StdCtrls, ExtCtrls, Buttons, Grids,
  DBGrids, JvExDBGrids, JvDBGrid, JvDBUltimGrid, ComCtrls, EmpresaCnaeVO,
  EmpresaCnaeController, Tipos, Atributos, Constantes, LabeledCtrls, JvToolEdit,
  Mask, JvExMask, JvBaseEdits, Math, StrUtils;

type
  [TFormDescription(TConstantes.MODULO_ADMINISTRATIVO, 'Empresa CNAE')]

  TFEmpresaCnae = class(TFTelaCadastro)
    BevelEdits: TBevel;
    EditDescricaoCnae: TLabeledEdit;
    EditEmpresa: TLabeledEdit;
    EditRamoAtividade: TLabeledEdit;
    MemoObjetoSocial: TLabeledMemo;
    ComboBoxPrincipal: TLabeledComboBox;
    EditIdEmpresa: TLabeledCalcEdit;
    EditIdCnae: TLabeledCalcEdit;
    procedure FormCreate(Sender: TObject);
    procedure EditIdEmpresaExit(Sender: TObject);
    procedure EditIdEmpresaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EditIdEmpresaKeyPress(Sender: TObject; var Key: Char);
    procedure EditIdCnaeExit(Sender: TObject);
    procedure EditIdCnaeKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EditIdCnaeKeyPress(Sender: TObject; var Key: Char);
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
  FEmpresaCnae: TFEmpresaCnae;

implementation

uses ULookup, Biblioteca, UDataModule, CnaeVO, CnaeController,
  EmpresaController, EmpresaVO;
{$R *.dfm}

{$REGION 'Infra'}
procedure TFEmpresaCnae.FormCreate(Sender: TObject);
begin
  ClasseObjetoGridVO := TEmpresaCnaeVO;
  ObjetoController := TEmpresaCnaeController.Create;

  inherited;
end;
{$ENDREGION}

{$REGION 'Controles CRUD'}
function TFEmpresaCnae.DoInserir: Boolean;
begin
  Result := inherited DoInserir;

  if Result then
  begin
    EditIdEmpresa.SetFocus;
  end;
end;

function TFEmpresaCnae.DoEditar: Boolean;
begin
  Result := inherited DoEditar;

  if Result then
  begin
    EditIdEmpresa.SetFocus;
  end;
end;

function TFEmpresaCnae.DoExcluir: Boolean;
begin
  if inherited DoExcluir then
  begin
    try
      Result := TEmpresaCnaeController(ObjetoController).Exclui(IdRegistroSelecionado);
    except
      Result := False;
    end;
  end
  else
  begin
    Result := False;
  end;

  if Result then
    TEmpresaCnaeController(ObjetoController).Consulta(Filtro, Pagina);
end;

function TFEmpresaCnae.DoSalvar: Boolean;
begin
  Result := inherited DoSalvar;

  if Result then
  begin
    try
      if not Assigned(ObjetoVO) then
        ObjetoVO := TEmpresaCnaeVO.Create;

      TEmpresaCnaeVO(ObjetoVO).IdCnae := EditIdCnae.AsInteger;
      TEmpresaCnaeVO(ObjetoVO).DescricaoCnae := EditDescricaoCnae.Text;
      TEmpresaCnaeVO(ObjetoVO).IdEmpresa := EditIdEmpresa.AsInteger;
      TEmpresaCnaeVO(ObjetoVO).RazaoSocial := EditEmpresa.Text;
      TEmpresaCnaeVO(ObjetoVO).Principal := Copy(ComboBoxPrincipal.Text, 1, 1);
      TEmpresaCnaeVO(ObjetoVO).RamoAtividade := EditRamoAtividade.Text;
      TEmpresaCnaeVO(ObjetoVO).ObjetoSocial := MemoObjetoSocial.Text;

      if StatusTela = stInserindo then
        Result := TEmpresaCnaeController(ObjetoController).Insere(TEmpresaCnaeVO(ObjetoVO))
      else if StatusTela = stEditando then
      begin
        if TEmpresaCnaeVO(ObjetoVO).ToJSONString <> TEmpresaCnaeVO(ObjetoOldVO).ToJSONString then
        begin
          TEmpresaCnaeVO(ObjetoVO).ID := IdRegistroSelecionado;
          Result := TEmpresaCnaeController(ObjetoController).Altera(TEmpresaCnaeVO(ObjetoVO), TEmpresaCnaeVO(ObjetoOldVO));
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

{$REGION 'Campos Transientes'}
procedure TFEmpresaCnae.EditIdCnaeExit(Sender: TObject);
var
  Filtro: String;
begin
  if EditIdCnae.Value <> 0 then
  begin
    try
      Filtro := 'ID = ' + EditIdCnae.Text;
      EditIdCnae.Clear;
      EditDescricaoCnae.Clear;
      if not PopulaCamposTransientes(Filtro, TCnaeVO, TCnaeController) then
        PopulaCamposTransientesLookup(TCnaeVO, TCnaeController);
      if CDSTransiente.RecordCount > 0 then
      begin
        EditIdCnae.Text := CDSTransiente.FieldByName('ID').AsString;
        EditDescricaoCnae.Text := CDSTransiente.FieldByName('DENOMINACAO').AsString;
      end
      else
      begin
        Exit;
        EditIdCnae.SetFocus;
      end;
    finally
      CDSTransiente.Close;
    end;
  end
  else
  begin
    EditDescricaoCnae.Clear;
  end;
end;

procedure TFEmpresaCnae.EditIdCnaeKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F1 then
  begin
    EditIdCnae.Value := -1;
    ComboBoxPrincipal.SetFocus;
  end;
end;

procedure TFEmpresaCnae.EditIdCnaeKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    ComboBoxPrincipal.SetFocus;
  end;
end;

procedure TFEmpresaCnae.EditIdEmpresaExit(Sender: TObject);
var
  Filtro: String;
begin
  if EditIdEmpresa.Value <> 0 then
  begin
    try
      Filtro := 'ID = ' + EditIdEmpresa.Text;
      EditIdEmpresa.Clear;
      EditEmpresa.Clear;
      if not PopulaCamposTransientes(Filtro, TEmpresaVO, TEmpresaController) then
        PopulaCamposTransientesLookup(TEmpresaVO, TEmpresaController);
      if CDSTransiente.RecordCount > 0 then
      begin
        EditIdEmpresa.Text := CDSTransiente.FieldByName('ID').AsString;
        EditEmpresa.Text := CDSTransiente.FieldByName('RAZAO_SOCIAL').AsString;
      end
      else
      begin
        Exit;
        EditIdEmpresa.SetFocus;
      end;
    finally
      CDSTransiente.Close;
    end;
  end
  else
  begin
    EditEmpresa.Clear;
  end;
end;

procedure TFEmpresaCnae.EditIdEmpresaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F1 then
  begin
    EditIdEmpresa.Value := -1;
    EditIdCnae.SetFocus;
  end;
end;

procedure TFEmpresaCnae.EditIdEmpresaKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    EditIdCnae.SetFocus;
  end;
end;
{$ENDREGION}

{$REGION 'Controle de Grid'}
procedure TFEmpresaCnae.GridParaEdits;
begin
  inherited;

  if not CDSGrid.IsEmpty then
  begin
    ObjetoVO := ObjetoController.VO<TEmpresaCnaeVO>(IdRegistroSelecionado);
    if StatusTela = stEditando then
      ObjetoOldVO := ObjetoVO.Clone;
  end;

  if Assigned(ObjetoVO) then
  begin
      EditIdCnae.AsInteger := TEmpresaCnaeVO(ObjetoVO).IdCnae;
      EditDescricaoCnae.Text := TEmpresaCnaeVO(ObjetoVO).DescricaoCnae;
      EditIdEmpresa.AsInteger := TEmpresaCnaeVO(ObjetoVO).IdEmpresa;
      EditEmpresa.Text := TEmpresaCnaeVO(ObjetoVO).RazaoSocial;
      ComboBoxPrincipal.ItemIndex := AnsiIndexStr(TEmpresaCnaeVO(ObjetoVO).Principal, ['S', 'N']);
      EditRamoAtividade.Text := TEmpresaCnaeVO(ObjetoVO).RamoAtividade;
      MemoObjetoSocial.Text := TEmpresaCnaeVO(ObjetoVO).ObjetoSocial;
  end;
end;
{$ENDREGION}

end.
