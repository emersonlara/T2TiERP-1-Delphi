{ *******************************************************************************
  Title: T2Ti ERP
  Description: Janela Cadastro de Cep

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
  ******************************************************************************* }
unit UCep;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UTelaCadastro, DB, DBClient, Menus, StdCtrls, ExtCtrls, Buttons, Grids,
  DBGrids, JvExDBGrids, JvDBGrid, JvDBUltimGrid, ComCtrls, CepVO,
  CepController, Tipos, Atributos, Constantes, Mask, JvExMask, JvToolEdit,
  JvBaseEdits, LabeledCtrls;

type
  [TFormDescription(TConstantes.MODULO_CADASTROS, 'Cep')]

  TFCep = class(TFTelaCadastro)
    BevelEdits: TBevel;
    EditCep: TLabeledEdit;
    EditLogradouro: TLabeledEdit;
    EditComplemento: TLabeledEdit;
    EditMunicipio: TLabeledEdit;
    EditBairro: TLabeledEdit;
    EditCodigoIBGEMunicipio: TLabeledEdit;
    EditUf: TLabeledEdit;
    procedure FormCreate(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
    procedure GridParaEdits; override;
    procedure ControlaBotoes; override;
  end;

var
  FCep: TFCep;

implementation

uses ULookup, MunicipioController, MunicipioVO, Biblioteca, UDataModule;
{$R *.dfm}

{$REGION 'Infra'}
procedure TFCep.FormCreate(Sender: TObject);
begin
  ClasseObjetoGridVO := TCepVO;
  ObjetoController := TCepController.Create;

  inherited;
end;

procedure TFCep.ControlaBotoes;
begin
  inherited;

  BotaoInserir.Visible := False;
  BotaoAlterar.Visible := False;
  BotaoExcluir.Visible := False;
  BotaoSalvar.Visible := False;
end;
{$ENDREGION}

{$REGION 'Controle de Grid'}
procedure TFCep.GridParaEdits;
begin
  inherited;

  if not CDSGrid.IsEmpty then
  begin
    ObjetoVO := ObjetoController.VO<TCepVO>(IdRegistroSelecionado);
  end;

  if Assigned(ObjetoVO) then
  begin
    EditCep.Text := TCepVO(ObjetoVO).Cep;
    EditLogradouro.Text := TCepVO(ObjetoVO).Logradouro;
    EditComplemento.Text := TCepVO(ObjetoVO).Complemento;
    EditBairro.Text := TCepVO(ObjetoVO).Bairro;
    EditMunicipio.Text := TCepVO(ObjetoVO).Municipio;
    EditUf.Text := TCepVO(ObjetoVO).Uf;
    EditCodigoIBGEMunicipio.Text := IntToStr(TCepVO(ObjetoVO).CodigoIbgeMunicipio);
  end;
end;
{$ENDREGION}

end.
