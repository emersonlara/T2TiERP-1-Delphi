{ *******************************************************************************
  Title: T2Ti ERP
  Description: Janela Cadastro dos tipos de pedido de compra

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
  @version 1.0   |   Fernando  @version 1.0.0.10
  ******************************************************************************* }
unit UCompraTipoPedido;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UTelaCadastro, DB, DBClient, Menus, StdCtrls, ExtCtrls, Buttons, Grids,
  DBGrids, JvExDBGrids, JvDBGrid, JvDBUltimGrid, ComCtrls, CompraTipoPedidoVO,
  CompraTipoPedidoController, Tipos, Atributos, Constantes, LabeledCtrls;

type
  [TFormDescription(TConstantes.MODULO_COMPRAS, 'Tipo Pedido')]

  TFCompraTipoPedido = class(TFTelaCadastro)
    BevelEdits: TBevel;
    EditCodigo: TLabeledEdit;
    EditNome: TLabeledEdit;
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
  FCompraTipoPedido: TFCompraTipoPedido;

implementation

{$R *.dfm}

{$REGION 'Infra'}
procedure TFCompraTipoPedido.FormCreate(Sender: TObject);
begin
  ClasseObjetoGridVO := TCompraTipoPedidoVO;
  ObjetoController := TCompraTipoPedidoController.Create;

  inherited;
end;
{$ENDREGION}

{$REGION 'Controles CRUD'}
function TFCompraTipoPedido.DoInserir: Boolean;
begin
  Result := inherited DoInserir;

  if Result then
  begin
    EditCodigo.SetFocus;
  end;
end;

function TFCompraTipoPedido.DoEditar: Boolean;
begin
  if IdRegistroSelecionado in [1, 2, 3] then
  begin
    Application.MessageBox('Esse registro n�o pode ser alterado.', 'Mensagem do Sistema', MB_OK + MB_ICONINFORMATION);
    Exit(False);
  end;

  Result := inherited DoEditar;

  if Result then
  begin
    EditCodigo.SetFocus;
  end;
end;

function TFCompraTipoPedido.DoExcluir: Boolean;
begin
  if IdRegistroSelecionado in [1, 2, 3] then
  begin
    Application.MessageBox('Esse registro n�o pode ser exclu�do.', 'Mensagem do Sistema', MB_OK + MB_ICONINFORMATION);
    Exit(False);
  end;

  if inherited DoExcluir then
  begin
    try
      Result := TCompraTipoPedidoController(ObjetoController).Exclui(IdRegistroSelecionado);
    except
      Result := False;
    end;
  end
  else
  begin
    Result := False;
  end;

  if Result then
    TCompraTipoPedidoController(ObjetoController).Consulta(Filtro, Pagina);
end;

function TFCompraTipoPedido.DoSalvar: Boolean;
begin
  Result := inherited DoSalvar;

  if Result then
  begin
    try
      if not Assigned(ObjetoVO) then
        ObjetoVO := TCompraTipoPedidoVO.Create;

      TCompraTipoPedidoVO(ObjetoVO).Codigo := EditCodigo.Text;
      TCompraTipoPedidoVO(ObjetoVO).Nome := EditNome.Text;
      TCompraTipoPedidoVO(ObjetoVO).Descricao := MemoDescricao.Text;

      if StatusTela = stInserindo then
        Result := TCompraTipoPedidoController(ObjetoController).Insere(TCompraTipoPedidoVO(ObjetoVO))
      else if StatusTela = stEditando then
        if TCompraTipoPedidoVO(ObjetoVO).ToJSONString <> TCompraTipoPedidoVO(ObjetoOldVO).ToJSONString then
        begin
          TCompraTipoPedidoVO(ObjetoVO).Id := IdRegistroSelecionado;
          Result := TCompraTipoPedidoController(ObjetoController).Altera(TCompraTipoPedidoVO(ObjetoVO), TCompraTipoPedidoVO(ObjetoOldVO));
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
procedure TFCompraTipoPedido.GridParaEdits;
begin
  inherited;

  if not CDSGrid.IsEmpty then
  begin
    ObjetoVO := ObjetoController.VO<TCompraTipoPedidoVO>(IdRegistroSelecionado);
    if StatusTela = stEditando then
      ObjetoOldVO := ObjetoController.VO<TCompraTipoPedidoVO>(IdRegistroSelecionado);
  end;

  if Assigned(ObjetoVO) then
  begin
    EditCodigo.Text := TCompraTipoPedidoVO(ObjetoVO).Codigo;
    EditNome.Text := TCompraTipoPedidoVO(ObjetoVO).Nome;
    MemoDescricao.Text := TCompraTipoPedidoVO(ObjetoVO).Descricao;
  end;
end;
{$ENDREGION}

end.
