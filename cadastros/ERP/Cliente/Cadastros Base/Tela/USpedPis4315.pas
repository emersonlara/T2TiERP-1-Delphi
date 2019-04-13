{*******************************************************************************
Title: T2Ti ERP
Description: Janela Cadastro de SpedPis4315

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
unit USpedPis4315;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UTelaCadastro, DB, DBClient, Menus, StdCtrls, ExtCtrls, Buttons, Grids,
  DBGrids, JvExDBGrids, JvDBGrid, JvDBUltimGrid, ComCtrls, SpedPis4315VO,
  SpedPis4315Controller, Tipos, Atributos, Constantes, LabeledCtrls,
  Mask, JvExMask, JvToolEdit, JvBaseEdits;

type
  [TFormDescription(TConstantes.MODULO_CADASTROS,'Sped Pis 4315')]
  TFSpedPis4315 = class(TFTelaCadastro)
    BevelEdits: TBevel;
    MemoDescricao: TLabeledMemo;
    MemoObservacao: TLabeledMemo;
    EditInicioVigencia: TLabeledDateEdit;
    EditFimVigencia: TLabeledDateEdit;
    EditCodigo: TLabeledCalcEdit;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure GridParaEdits; override;
    procedure ControlaBotoes; override;
  end;

var
  FSpedPis4315: TFSpedPis4315;

implementation

{$R *.dfm}

{$REGION 'Infra'}
procedure TFSpedPis4315.FormCreate(Sender: TObject);
begin
  ClasseObjetoGridVO := TSpedPis4315VO;
  ObjetoController := TSpedPis4315Controller.Create;

  inherited;
end;

procedure TFSpedPis4315.ControlaBotoes;
begin
  inherited;

  BotaoInserir.Visible := False;
  BotaoAlterar.Visible := False;
  BotaoExcluir.Visible := False;
  BotaoSalvar.Visible := False;
end;
{$ENDREGION}

{$REGION 'Controle de Grid'}
procedure TFSpedPis4315.GridParaEdits;
begin
  inherited;

  if not CDSGrid.IsEmpty then
  begin
    ObjetoVO := ObjetoController.VO<TSpedPis4315VO>(IdRegistroSelecionado);
  end;

  if Assigned(ObjetoVO) then
  begin
    EditCodigo.AsInteger    := TSpedPis4315VO(ObjetoVO).Codigo;
    MemoDescricao.Text      := TSpedPis4315VO(ObjetoVO).Descricao;
    MemoOBservacao.Text     := TSpedPis4315VO(ObjetoVO).Observacao;
    EditInicioVigencia.Date := TSpedPis4315VO(ObjetoVO).InicioVigencia;
    EditFimVigencia.Date    := TSpedPis4315VO(ObjetoVO).FimVigencia;
  end;
end;
{$ENDREGION}

end.
