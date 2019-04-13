{ *******************************************************************************
  Title: T2Ti ERP
  Description: Janela Cadastro de Estado Civil

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

unit UEstadoCivil;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UTelaCadastro, Menus, StdCtrls, ExtCtrls, Buttons, Grids, DBGrids,
  JvExDBGrids, JvDBGrid, JvDBUltimGrid, ComCtrls, LabeledCtrls, Atributos,
  Constantes;

type
  [TFormDescription(TConstantes.MODULO_CADASTROS, 'Estado Civil')]

  TFEstadoCivil = class(TFTelaCadastro)
    EditNome: TLabeledEdit;
    BevelEdits: TBevel;
    MemoDescricao: TLabeledMemo;
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
  FEstadoCivil: TFEstadoCivil;

implementation

uses EstadoCivilController, EstadoCivilVO, NotificationService;
{$R *.dfm}

{$REGION 'Infra'}
procedure TFEstadoCivil.FormCreate(Sender: TObject);
begin
  ClasseObjetoGridVO := TEstadoCivilVO;
  ObjetoController := TEstadoCivilController.Create;

  inherited;
end;
{$ENDREGION}

{$REGION 'Controles CRUD'}
function TFEstadoCivil.DoInserir: Boolean;
begin
  Result := inherited DoInserir;

  if Result then
  begin
    EditNome.SetFocus;
  end;
end;

function TFEstadoCivil.DoEditar: Boolean;
begin
  Result := inherited DoEditar;

  if Result then
  begin
    EditNome.SetFocus;
  end;
end;

function TFEstadoCivil.DoExcluir: Boolean;
begin
  if inherited DoExcluir then
  begin
    try
      Result := TEstadoCivilController(ObjetoController).Exclui(IdRegistroSelecionado);
    except
      Result := False;
    end;
  end
  else
  begin
    Result := False;
  end;

  if Result then
    TEstadoCivilController(ObjetoController).Consulta(Filtro, Pagina);
end;

function TFEstadoCivil.DoSalvar: Boolean;
begin
  Result := inherited DoSalvar;

  if Result then
  begin
    try
      if not Assigned(ObjetoVO) then
        ObjetoVO := TEstadoCivilVO.Create;

      TEstadoCivilVO(ObjetoVO).Nome := EditNome.Text;
      TEstadoCivilVO(ObjetoVO).Descricao := MemoDescricao.Text;

      if StatusTela = stInserindo then
        Result := TEstadoCivilController(ObjetoController).Insere(TEstadoCivilVO(ObjetoVO))
      else if StatusTela = stEditando then
      begin
        if TEstadoCivilVO(ObjetoVO).ToJSONString <> TEstadoCivilVO(ObjetoOldVO).ToJSONString then
        begin
          TEstadoCivilVO(ObjetoVO).Id := IdRegistroSelecionado;
          Result := TEstadoCivilController(ObjetoController).Altera(TEstadoCivilVO(ObjetoVO), TEstadoCivilVO(ObjetoOldVO));
        end
        else
          Application.MessageBox('Nenhum dado foi alterado.', 'Mensagem do Sistema', MB_OK + MB_ICONINFORMATION);
      end;
      GetNotificationService.SendMessage(Self, TConstantes.IF_EstadoCivil);
    except
      Result := False;
    end;
  end;
end;
{$ENDREGION}

{$REGION 'Controle de Grid'}
procedure TFEstadoCivil.GridParaEdits;
begin
  inherited;

  if not CDSGrid.IsEmpty then
  begin
    ObjetoVO := ObjetoController.VO<TEstadoCivilVO>(IdRegistroSelecionado);
    if StatusTela = stEditando then
      ObjetoOldVO := ObjetoVO.Clone;
  end;

  if Assigned(ObjetoVO) then
  begin
    EditNome.Text := TEstadoCivilVO(ObjetoVO).Nome;
    MemoDescricao.Text := TEstadoCivilVO(ObjetoVO).Descricao;
  end;
end;
{$ENDREGION}

end.
