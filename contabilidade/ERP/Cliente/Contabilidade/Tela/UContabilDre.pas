{ *******************************************************************************
  Title: T2Ti ERP
  Description: Janela de DRE para o m�dulo Contabilidade

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
unit UContabilDre;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UTelaCadastro, DB, DBClient, Menus, StdCtrls, ExtCtrls, Buttons, Grids,
  DBGrids, JvExDBGrids, JvDBGrid, JvDBUltimGrid, ComCtrls, ContabilDreCabecalhoVO,
  ContabilDreCabecalhoController, Tipos, Atributos, Constantes, LabeledCtrls, JvToolEdit,
  Mask, JvExMask, JvBaseEdits, Math, StrUtils, ActnList, Generics.Collections,
  RibbonSilverStyleActnCtrls, ActnMan, ToolWin, ActnCtrls;

type
  [TFormDescription(TConstantes.MODULO_CONTABILIDADE, 'DRE')]

  TFContabilDre = class(TFTelaCadastro)
    DSContabilDreDetalhe: TDataSource;
    CDSContabilDreDetalhe: TClientDataSet;
    PanelMestre: TPanel;
    PageControlItens: TPageControl;
    tsItens: TTabSheet;
    PanelItens: TPanel;
    GridDetalhe: TJvDBUltimGrid;
    ComboBoxPadrao: TLabeledComboBox;
    EditDescricao: TLabeledEdit;
    EditPeriodoInicial: TLabeledMaskEdit;
    EditPeriodoFinal: TLabeledMaskEdit;
    CDSContabilDreDetalheID: TIntegerField;
    CDSContabilDreDetalheID_CONTABIL_DRE_CABECALHO: TIntegerField;
    CDSContabilDreDetalheCLASSIFICACAO: TStringField;
    CDSContabilDreDetalheDESCRICAO: TStringField;
    CDSContabilDreDetalheFORMA_CALCULO: TStringField;
    CDSContabilDreDetalheSINAL: TStringField;
    CDSContabilDreDetalheNATUREZA: TStringField;
    CDSContabilDreDetalheVALOR: TFMTBCDField;
    procedure FormCreate(Sender: TObject);
    procedure GridDblClick(Sender: TObject);

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
  FContabilDre: TFContabilDre;

implementation

uses ULookup, Biblioteca, UDataModule, ContabilDreDetalheVO, ContabilLoteVO,
ContabilLoteController;
{$R *.dfm}

{$REGION 'Controles Infra'}
procedure TFContabilDre.FormCreate(Sender: TObject);
begin
  ClasseObjetoGridVO := TContabilDreCabecalhoVO;
  ObjetoController := TContabilDreCabecalhoController.Create;

  inherited;
end;

procedure TFContabilDre.LimparCampos;
begin
  inherited;
  CDSContabilDreDetalhe.EmptyDataSet;
end;

procedure TFContabilDre.ConfigurarLayoutTela;
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

procedure TFContabilDre.ControlaBotoes;
begin
  inherited;

  BotaoImprimir.Visible := False;
end;

procedure TFContabilDre.ControlaPopupMenu;
begin
  inherited;

  MenuImprimir.Visible := False;
end;
{$ENDREGION}

{$REGION 'Controles CRUD'}
function TFContabilDre.DoInserir: Boolean;
begin
  Result := inherited DoInserir;

  ConfigurarLayoutTela;
  if Result then
  begin
    EditDescricao.SetFocus;
  end;
end;

function TFContabilDre.DoEditar: Boolean;
begin
  Result := inherited DoEditar;

  ConfigurarLayoutTela;
  if Result then
  begin
    EditDescricao.SetFocus;
  end;
end;

function TFContabilDre.DoExcluir: Boolean;
begin
  if inherited DoExcluir then
  begin
    try
      Result := TContabilDreCabecalhoController(ObjetoController).Exclui(IdRegistroSelecionado);
    except
      Result := False;
    end;
  end
  else
  begin
    Result := False;
  end;

  if Result then
    TContabilDreCabecalhoController(ObjetoController).Consulta(Filtro, Pagina);
end;

function TFContabilDre.DoSalvar: Boolean;
var
  ContabilDreDetalhe: TContabilDreDetalheVO;
begin
  DecimalSeparator := '.';
  Result := inherited DoSalvar;

  if Result then
  begin
    try
      if not Assigned(ObjetoVO) then
        ObjetoVO := TContabilDreCabecalhoVO.Create;

      TContabilDreCabecalhoVO(ObjetoVO).IdEmpresa := Sessao.IdEmpresa;
      TContabilDreCabecalhoVO(ObjetoVO).Descricao := EditDescricao.Text;
      TContabilDreCabecalhoVO(ObjetoVO).Padrao := IfThen(ComboBoxPadrao.ItemIndex = 0, 'S', 'N');
      TContabilDreCabecalhoVO(ObjetoVO).PeriodoInicial := EditPeriodoInicial.Text;
      TContabilDreCabecalhoVO(ObjetoVO).PeriodoFinal := EditPeriodoFinal.Text;

      // Detalhes
      TContabilDreCabecalhoVO(ObjetoVO).ListaContabilDreDetalheVO := TObjectList<TContabilDreDetalheVO>.Create;
      CDSContabilDreDetalhe.DisableControls;
      CDSContabilDreDetalhe.First;
      while not CDSContabilDreDetalhe.Eof do
      begin
        ContabilDreDetalhe := TContabilDreDetalheVO.Create;
        ContabilDreDetalhe.Id := CDSContabilDreDetalheID.AsInteger;
        ContabilDreDetalhe.IdContabilDreCabecalho := TContabilDreCabecalhoVO(ObjetoVO).Id;
        ContabilDreDetalhe.Classificacao := CDSContabilDreDetalheCLASSIFICACAO.AsString;
        ContabilDreDetalhe.Descricao := CDSContabilDreDetalheDESCRICAO.AsString;
        ContabilDreDetalhe.FormaCalculo := CDSContabilDreDetalheFORMA_CALCULO.AsString;
        ContabilDreDetalhe.Sinal := CDSContabilDreDetalheSINAL.AsString;
        ContabilDreDetalhe.Natureza := CDSContabilDreDetalheNATUREZA.AsString;
        ContabilDreDetalhe.Valor := CDSContabilDreDetalheVALOR.AsFloat;
        TContabilDreCabecalhoVO(ObjetoVO).ListaContabilDreDetalheVO.Add(ContabilDreDetalhe);
        CDSContabilDreDetalhe.Next;
      end;
      CDSContabilDreDetalhe.EnableControls;

      if StatusTela = stInserindo then
        Result := TContabilDreCabecalhoController(ObjetoController).Insere(TContabilDreCabecalhoVO(ObjetoVO))
      else if StatusTela = stEditando then
      begin
        if TContabilDreCabecalhoVO(ObjetoVO).ToJSONString <> TContabilDreCabecalhoVO(ObjetoOldVO).ToJSONString then
        begin
          Result := TContabilDreCabecalhoController(ObjetoController).Altera(TContabilDreCabecalhoVO(ObjetoVO), TContabilDreCabecalhoVO(ObjetoOldVO));
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
procedure TFContabilDre.GridDblClick(Sender: TObject);
begin
  inherited;
  ConfigurarLayoutTela;
end;

procedure TFContabilDre.GridParaEdits;
var
  ContabilDreDetalheEnumerator: TEnumerator<TContabilDreDetalheVO>;
begin
  inherited;

  if not CDSGrid.IsEmpty then
  begin
    ObjetoVO := ObjetoController.VO<TContabilDreCabecalhoVO>(IdRegistroSelecionado);
    if StatusTela = stEditando then
      ObjetoOldVO := ObjetoController.VO<TContabilDreCabecalhoVO>(IdRegistroSelecionado);
  end;

  if Assigned(ObjetoVO) then
  begin
    EditDescricao.Text := TContabilDreCabecalhoVO(ObjetoVO).Descricao;
    ComboBoxPadrao.ItemIndex := IfThen(TContabilDreCabecalhoVO(ObjetoVO).Padrao = 'S', 0, 1);
    EditPeriodoInicial.Text := TContabilDreCabecalhoVO(ObjetoVO).PeriodoInicial;
    EditPeriodoFinal.Text := TContabilDreCabecalhoVO(ObjetoVO).PeriodoFinal;

    // Detalhes
    ContabilDreDetalheEnumerator := TContabilDreCabecalhoVO(ObjetoVO).ListaContabilDreDetalheVO.GetEnumerator;
    try
      with ContabilDreDetalheEnumerator do
      begin
        while MoveNext do
        begin
          CDSContabilDreDetalhe.Append;
          CDSContabilDreDetalheID.AsInteger := Current.id;
          CDSContabilDreDetalheID_CONTABIL_DRE_CABECALHO.AsInteger := Current.IdContabilDreCabecalho;
          CDSContabilDreDetalheCLASSIFICACAO.AsString := Current.Classificacao;
          CDSContabilDreDetalheDESCRICAO.AsString := Current.Descricao;
          CDSContabilDreDetalheFORMA_CALCULO.AsString := Current.FormaCalculo;
          CDSContabilDreDetalheSINAL.AsString := Current.Sinal;
          CDSContabilDreDetalheNATUREZA.AsString := Current.Natureza;
          CDSContabilDreDetalheVALOR.AsExtended := Current.Valor;
          CDSContabilDreDetalhe.Post;
        end;
      end;
    finally
      ContabilDreDetalheEnumerator.Free;
    end;

    TContabilDreCabecalhoVO(ObjetoVO).ListaContabilDreDetalheVO := Nil;
    if Assigned(TContabilDreCabecalhoVO(ObjetoOldVO)) then
      TContabilDreCabecalhoVO(ObjetoOldVO).ListaContabilDreDetalheVO := Nil;
  end;

  ConfigurarLayoutTela;
end;
{$ENDREGION}

end.
