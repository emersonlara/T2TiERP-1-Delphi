{ *******************************************************************************
  Title: T2Ti ERP
  Description: Janela para armazenar os tipos de documentos do GED

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

  @author Albert Eije (T2Ti.COM)
  @version 1.1
  ******************************************************************************* }
unit UGedTipoDocumento;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UTelaCadastro, Menus, StdCtrls, ExtCtrls, Buttons, Grids, DBGrids,
  JvExDBGrids, JvDBGrid, JvDBUltimGrid, ComCtrls, JvExStdCtrls, JvEdit,
  JvValidateEdit, Atributos, Constantes, LabeledCtrls, Mask, JvExMask,
  JvToolEdit, JvBaseEdits;

type
  [TFormDescription(TConstantes.MODULO_GED, 'Tipo de Documento')]

  TFGedTipoDocumento = class(TFTelaCadastro)
    BevelEdits: TBevel;
    EditNome: TLabeledEdit;
    EditTamanhoMaximo: TLabeledCalcEdit;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    procedure GridParaEdits; override;

    // Controles CRUD
    function DoInserir: Boolean; override;
    function DoEditar: Boolean; override;
    function DoExcluir: Boolean; override;
    function DoSalvar: Boolean; override;
  public
    { Public declarations }
  end;

implementation

uses GedTipoDocumentoVO, GedTipoDocumentoController, Tipos, NotificationService;
{$R *.dfm}

{$REGION 'Infra'}
procedure TFGedTipoDocumento.FormCreate(Sender: TObject);
begin
  ClasseObjetoGridVO := TGedTipoDocumentoVO;
  ObjetoController := TGedTipoDocumentoController.Create;

  inherited;
end;
{$ENDREGION}

{$REGION 'Controles CRUD'}
function TFGedTipoDocumento.DoInserir: Boolean;
begin
  Result := inherited DoInserir;

  if Result then
  begin
    EditNome.SetFocus;
  end;
end;

function TFGedTipoDocumento.DoEditar: Boolean;
begin
  Result := inherited DoEditar;

  if Result then
  begin
    EditNome.SetFocus;
  end;
end;

function TFGedTipoDocumento.DoExcluir: Boolean;
begin
  if inherited DoExcluir then
  begin
    try
      Result := TGedTipoDocumentoController(ObjetoController).Exclui(IdRegistroSelecionado);
    except
      Result := False;
    end;
  end
  else
  begin
    Result := False;
  end;

  if Result then
    TGedTipoDocumentoController(ObjetoController).Consulta(Filtro, Pagina);
end;

function TFGedTipoDocumento.DoSalvar: Boolean;
begin
  Result := inherited DoSalvar;

  if Result then
  begin
    try
      if not Assigned(ObjetoVO) then
        ObjetoVO := TGedTipoDocumentoVO.Create;

      TGedTipoDocumentoVO(ObjetoVO).IdEmpresa := Sessao.IdEmpresa;
      TGedTipoDocumentoVO(ObjetoVO).Nome := EditNome.Text;
      TGedTipoDocumentoVO(ObjetoVO).TamanhoMaximo := EditTamanhoMaximo.Value;

      if StatusTela = stInserindo then
        Result := TGedTipoDocumentoController(ObjetoController).Insere(TGedTipoDocumentoVO(ObjetoVO))
      else if StatusTela = stEditando then
        if TGedTipoDocumentoVO(ObjetoVO).ToJSONString <> TGedTipoDocumentoVO(ObjetoOldVO).ToJSONString then
        begin
          TGedTipoDocumentoVO(ObjetoVO).Id := IdRegistroSelecionado;
          Result := TGedTipoDocumentoController(ObjetoController).Altera(TGedTipoDocumentoVO(ObjetoVO), TGedTipoDocumentoVO(ObjetoOldVO));
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
procedure TFGedTipoDocumento.GridParaEdits;
begin
  inherited;
  if not CDSGrid.IsEmpty then
  begin
    ObjetoVO := ObjetoController.VO<TGedTipoDocumentoVO>(IdRegistroSelecionado);
    if StatusTela = stEditando then
      ObjetoOldVO := ObjetoController.VO<TGedTipoDocumentoVO>(IdRegistroSelecionado);
  end;

  if Assigned(ObjetoVO) then
  begin
    EditNome.Text := TGedTipoDocumentoVO(ObjetoVO).Nome;
    EditTamanhoMaximo.Value := TGedTipoDocumentoVO(ObjetoVO).TamanhoMaximo;
  end;
end;
{$ENDREGION}

end.
