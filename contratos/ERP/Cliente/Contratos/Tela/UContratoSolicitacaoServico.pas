{ *******************************************************************************
  Title: T2Ti ERP
  Description: Janela de Solicita��o de Servi�os - Gest�o de Contratos

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
  t2ti.com@gmail.com

  @author Albert Eije (alberteije@gmail.com)
  @version 1.0
  ******************************************************************************* }
unit UContratoSolicitacaoServico;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UTelaCadastro, Menus, StdCtrls, ExtCtrls, Buttons, Grids, DBGrids,
  JvExDBGrids, JvDBGrid, JvDBUltimGrid, ComCtrls, LabeledCtrls, Atributos, Constantes,
  Mask, JvExMask, JvToolEdit, JvBaseEdits, StrUtils;

type
  [TFormDescription(TConstantes.MODULO_CONTRATOS, 'Solicita��o de Servi�os')]

  TFContratoSolicitacaoServico = class(TFTelaCadastro)
    BevelEdits: TBevel;
    ComboBoxUrgente: TLabeledComboBox;
    EditIdCliente: TLabeledCalcEdit;
    EditCliente: TLabeledEdit;
    EditIdFornecedor: TLabeledCalcEdit;
    EditFornecedor: TLabeledEdit;
    EditIdSetor: TLabeledCalcEdit;
    EditSetor: TLabeledEdit;
    EditColaborador: TLabeledEdit;
    EditIdColaborador: TLabeledCalcEdit;
    EditTipoServico: TLabeledEdit;
    EditIdTipoServico: TLabeledCalcEdit;
    EditDataSolicitacao: TLabeledDateEdit;
    EditDataDesejadaInicio: TLabeledDateEdit;
    ComboBoxStatusSolicitacao: TLabeledComboBox;
    RadioGroupTipoContratacao: TRadioGroup;
    EditDescricao: TLabeledEdit;
    procedure FormCreate(Sender: TObject);
    procedure EditIdClienteKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure RadioGroupTipoContratacaoClick(Sender: TObject);
    procedure EditIdClienteExit(Sender: TObject);
    procedure EditIdClienteKeyPress(Sender: TObject; var Key: Char);
    procedure EditIdFornecedorExit(Sender: TObject);
    procedure EditIdFornecedorKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EditIdFornecedorKeyPress(Sender: TObject; var Key: Char);
    procedure EditIdSetorKeyPress(Sender: TObject; var Key: Char);
    procedure EditIdSetorKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EditIdSetorExit(Sender: TObject);
    procedure EditIdColaboradorExit(Sender: TObject);
    procedure EditIdColaboradorKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EditIdColaboradorKeyPress(Sender: TObject; var Key: Char);
    procedure EditIdTipoServicoKeyPress(Sender: TObject; var Key: Char);
    procedure EditIdTipoServicoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EditIdTipoServicoExit(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    { Public declarations }
    procedure GridParaEdits; override;
    procedure ControlaBotoes; override;
    procedure ControlaPopupMenu; override;

    // Controles CRUD
    function DoInserir: Boolean; override;
    function DoEditar: Boolean; override;
    function DoExcluir: Boolean; override;
    function DoSalvar: Boolean; override;
  end;

var
  FContratoSolicitacaoServico: TFContratoSolicitacaoServico;

implementation

uses ContratoSolicitacaoServicoController, ContratoSolicitacaoServicoVO,
  NotificationService, ULookup, ClienteVO, ClienteController, FornecedorVO,
  FornecedorController, SetorVO, SetorController, ColaboradorVO, ColaboradorController,
  ContratoTipoServicoVO, ContratoTipoServicoController;
{$R *.dfm}

{$REGION 'Infra'}
procedure TFContratoSolicitacaoServico.FormCreate(Sender: TObject);
begin
  ClasseObjetoGridVO := TContratoSolicitacaoServicoVO;
  ObjetoController := TContratoSolicitacaoServicoController.Create;

  inherited;
end;

procedure TFContratoSolicitacaoServico.ControlaBotoes;
begin
  inherited;

  BotaoImprimir.Visible := False;
end;

procedure TFContratoSolicitacaoServico.ControlaPopupMenu;
begin
  inherited;

  MenuImprimir.Visible := False;
end;

procedure TFContratoSolicitacaoServico.RadioGroupTipoContratacaoClick(Sender: TObject);
begin
  if RadioGroupTipoContratacao.ItemIndex = 0 then
  begin
    EditIdCliente.Visible := True;
    EditCliente.Visible := True;
    EditIdFornecedor.Visible := False;
    EditFornecedor.Visible := False;
    EditIdFornecedor.Clear;
    EditFornecedor.Clear;
    EditIdCliente.SetFocus;
  end
  else
  begin
    EditIdCliente.Visible := False;
    EditCliente.Visible := False;
    EditIdCliente.Clear;
    EditCliente.Clear;
    EditIdFornecedor.Visible := True;
    EditFornecedor.Visible := True;
    EditIdFornecedor.SetFocus;
  end;
end;
{$ENDREGION}

{$REGION 'Controles CRUD'}
function TFContratoSolicitacaoServico.DoInserir: Boolean;
begin
  Result := inherited DoInserir;

  if Result then
  begin
    EditIdSetor.SetFocus;
  end;
end;

function TFContratoSolicitacaoServico.DoEditar: Boolean;
begin
  Result := inherited DoEditar;

  if Result then
  begin
    EditIdSetor.SetFocus;
  end;
end;

function TFContratoSolicitacaoServico.DoExcluir: Boolean;
begin
  if inherited DoExcluir then
  begin
    try
      Result := TContratoSolicitacaoServicoController(ObjetoController).Exclui(IdRegistroSelecionado);
    except
      Result := False;
    end;
  end
  else
  begin
    Result := False;
  end;

  if Result then
    TContratoSolicitacaoServicoController(ObjetoController).Consulta(Filtro, Pagina);
end;

function TFContratoSolicitacaoServico.DoSalvar: Boolean;
begin
  if RadioGroupTipoContratacao.ItemIndex = -1 then
  begin
    Application.MessageBox('� necess�rio informar o tipo de contrata��o.', 'Mensagem do Sistema', MB_OK + MB_ICONINFORMATION);
    Exit(False);
  end
  else if RadioGroupTipoContratacao.ItemIndex = 0 then
  begin
    if EditIdCliente.AsInteger = 0 then
    begin
      Application.MessageBox('� necess�rio informar o cliente.', 'Mensagem do Sistema', MB_OK + MB_ICONINFORMATION);
      EditIdCliente.SetFocus;
      Exit(False);
    end;
  end
  else if RadioGroupTipoContratacao.ItemIndex = 1 then
  begin
    if EditIdFornecedor.AsInteger = 0 then
    begin
      Application.MessageBox('� necess�rio informar o fornecedor.', 'Mensagem do Sistema', MB_OK + MB_ICONINFORMATION);
      EditIdFornecedor.SetFocus;
      Exit(False);
    end;
  end;

  if EditIdSetor.AsInteger = 0 then
  begin
    Application.MessageBox('� necess�rio informar o setor.', 'Mensagem do Sistema', MB_OK + MB_ICONINFORMATION);
    EditIdSetor.SetFocus;
    Exit(False);
  end;
  if EditIdColaborador.AsInteger = 0 then
  begin
    Application.MessageBox('� necess�rio informar o colaborador.', 'Mensagem do Sistema', MB_OK + MB_ICONINFORMATION);
    EditIdColaborador.SetFocus;
    Exit(False);
  end;
  if EditIdTipoServico.AsInteger = 0 then
  begin
    Application.MessageBox('� necess�rio informar o tipo do servi�o.', 'Mensagem do Sistema', MB_OK + MB_ICONINFORMATION);
    EditIdTipoServico.SetFocus;
    Exit(False);
  end;

  Result := inherited DoSalvar;

  if Result then
  begin
    try
      ObjetoVO := TContratoSolicitacaoServicoVO.Create;

      TContratoSolicitacaoServicoVO(ObjetoVO).IdCliente := EditIdCliente.AsInteger;
      TContratoSolicitacaoServicoVO(ObjetoVO).ClientePessoaNome := EditCliente.Text;
      TContratoSolicitacaoServicoVO(ObjetoVO).IdFornecedor := EditIdFornecedor.AsInteger;
      TContratoSolicitacaoServicoVO(ObjetoVO).FornecedorPessoaNome := EditFornecedor.Text;
      TContratoSolicitacaoServicoVO(ObjetoVO).IdSetor := EditIdSetor.AsInteger;
      TContratoSolicitacaoServicoVO(ObjetoVO).SetorNome := EditSetor.Text;
      TContratoSolicitacaoServicoVO(ObjetoVO).IdColaborador := EditIdColaborador.AsInteger;
      TContratoSolicitacaoServicoVO(ObjetoVO).ColaboradorPessoaNome := EditColaborador.Text;
      TContratoSolicitacaoServicoVO(ObjetoVO).IdContratoTipoServico := EditIdTipoServico.AsInteger;
      TContratoSolicitacaoServicoVO(ObjetoVO).ContratoTipoServicoNome := EditTipoServico.Text;
      TContratoSolicitacaoServicoVO(ObjetoVO).Descricao := EditDescricao.Text;
      TContratoSolicitacaoServicoVO(ObjetoVO).DataSolicitacao := EditDataSolicitacao.Date;
      TContratoSolicitacaoServicoVO(ObjetoVO).DataDesejadaInicio := EditDataDesejadaInicio.Date;
      TContratoSolicitacaoServicoVO(ObjetoVO).Urgente := IfThen(ComboBoxUrgente.ItemIndex = 0, 'S', 'N');
      TContratoSolicitacaoServicoVO(ObjetoVO).StatusSolicitacao := Copy(ComboBoxStatusSolicitacao.Text, 1, 1);

      if StatusTela = stInserindo then
        Result := TContratoSolicitacaoServicoController(ObjetoController).Insere(TContratoSolicitacaoServicoVO(ObjetoVO))
      else if StatusTela = stEditando then
        if TContratoSolicitacaoServicoVO(ObjetoVO).ToJSONString <> TContratoSolicitacaoServicoVO(ObjetoOldVO).ToJSONString then
        begin
          TContratoSolicitacaoServicoVO(ObjetoVO).Id := IdRegistroSelecionado;
          Result := TContratoSolicitacaoServicoController(ObjetoController).Altera(TContratoSolicitacaoServicoVO(ObjetoVO), TContratoSolicitacaoServicoVO(ObjetoOldVO));
        end
        else
          Application.MessageBox('Nenhum dado foi alterado.', 'Mensagem do Sistema', MB_OK + MB_ICONINFORMATION);
    except
      Result := False;
    end;
  end;
end;
{$ENDREGION}

{$REGION 'Campos Transientes'}
procedure TFContratoSolicitacaoServico.EditIdClienteExit(Sender: TObject);
var
  Filtro: String;
begin
  if EditIdCliente.Value <> 0 then
  begin
    try
      Filtro := 'ID = ' + EditIdCliente.Text;
      EditIdCliente.Clear;
      EditCliente.Clear;
      if not PopulaCamposTransientes(Filtro, TClienteVO, TClienteController) then
        PopulaCamposTransientesLookup(TClienteVO, TClienteController);
      if CDSTransiente.RecordCount > 0 then
      begin
        EditIdCliente.Text := CDSTransiente.FieldByName('ID').AsString;
        EditCliente.Text := CDSTransiente.FieldByName('PESSOA.NOME').AsString;
      end
      else
      begin
        Exit;
        EditIdCliente.SetFocus;
      end;
    finally
      CDSTransiente.Close;
    end;
  end
  else
  begin
    EditIdCliente.Clear;
  end;
end;

procedure TFContratoSolicitacaoServico.EditIdClienteKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F1 then
  begin
    EditIdCliente.Value := -1;
    EditIdSetor.SetFocus;
  end;
end;

procedure TFContratoSolicitacaoServico.EditIdClienteKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    EditIdSetor.SetFocus;
  end;
end;

procedure TFContratoSolicitacaoServico.EditIdColaboradorExit(Sender: TObject);
var
  Filtro: String;
begin
  if EditIdColaborador.Value <> 0 then
  begin
    try
      Filtro := 'ID = ' + EditIdColaborador.Text;
      EditIdColaborador.Clear;
      EditColaborador.Clear;
      if not PopulaCamposTransientes(Filtro, TColaboradorVO, TColaboradorController) then
        PopulaCamposTransientesLookup(TColaboradorVO, TColaboradorController);
      if CDSTransiente.RecordCount > 0 then
      begin
        EditIdColaborador.Text := CDSTransiente.FieldByName('ID').AsString;
        EditColaborador.Text := CDSTransiente.FieldByName('PESSOA.NOME').AsString;
      end
      else
      begin
        Exit;
        EditIdColaborador.SetFocus;
      end;
    finally
      CDSTransiente.Close;
    end;
  end
  else
  begin
    EditIdColaborador.Clear;
  end;
end;

procedure TFContratoSolicitacaoServico.EditIdColaboradorKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F1 then
  begin
    EditIdColaborador.Value := -1;
    EditIdTipoServico.SetFocus;
  end;
end;

procedure TFContratoSolicitacaoServico.EditIdColaboradorKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    EditIdTipoServico.SetFocus;
  end;
end;

procedure TFContratoSolicitacaoServico.EditIdFornecedorExit(Sender: TObject);
var
  Filtro: String;
begin
  if EditIdFornecedor.Value <> 0 then
  begin
    try
      Filtro := 'ID = ' + EditIdFornecedor.Text;
      EditIdFornecedor.Clear;
      EditFornecedor.Clear;
      if not PopulaCamposTransientes(Filtro, TFornecedorVO, TFornecedorController) then
        PopulaCamposTransientesLookup(TFornecedorVO, TFornecedorController);
      if CDSTransiente.RecordCount > 0 then
      begin
        EditIdFornecedor.Text := CDSTransiente.FieldByName('ID').AsString;
        EditFornecedor.Text := CDSTransiente.FieldByName('PESSOA.NOME').AsString;
      end
      else
      begin
        Exit;
        EditIdFornecedor.SetFocus;
      end;
    finally
      CDSTransiente.Close;
    end;
  end
  else
  begin
    EditIdFornecedor.Clear;
  end;
end;

procedure TFContratoSolicitacaoServico.EditIdFornecedorKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F1 then
  begin
    EditIdFornecedor.Value := -1;
    EditIdSetor.SetFocus;
  end;
end;

procedure TFContratoSolicitacaoServico.EditIdFornecedorKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    EditIdSetor.SetFocus;
  end;
end;

procedure TFContratoSolicitacaoServico.EditIdSetorExit(Sender: TObject);
var
  Filtro: String;
begin
  if EditIdSetor.Value <> 0 then
  begin
    try
      Filtro := 'ID = ' + EditIdSetor.Text;
      EditIdSetor.Clear;
      EditSetor.Clear;
      if not PopulaCamposTransientes(Filtro, TSetorVO, TSetorController) then
        PopulaCamposTransientesLookup(TSetorVO, TSetorController);
      if CDSTransiente.RecordCount > 0 then
      begin
        EditIdSetor.Text := CDSTransiente.FieldByName('ID').AsString;
        EditSetor.Text := CDSTransiente.FieldByName('NOME').AsString;
      end
      else
      begin
        Exit;
        EditIdSetor.SetFocus;
      end;
    finally
      CDSTransiente.Close;
    end;
  end
  else
  begin
    EditIdSetor.Clear;
  end;
end;

procedure TFContratoSolicitacaoServico.EditIdSetorKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F1 then
  begin
    EditIdSetor.Value := -1;
    EditIdColaborador.SetFocus;
  end;
end;

procedure TFContratoSolicitacaoServico.EditIdSetorKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    EditIdColaborador.SetFocus;
  end;
end;

procedure TFContratoSolicitacaoServico.EditIdTipoServicoExit(Sender: TObject);
var
  Filtro: String;
begin
  if EditIdTipoServico.Value <> 0 then
  begin
    try
      Filtro := 'ID = ' + EditIdTipoServico.Text;
      EditIdTipoServico.Clear;
      EditTipoServico.Clear;
      if not PopulaCamposTransientes(Filtro, TContratoTipoServicoVO, TContratoTipoServicoController) then
        PopulaCamposTransientesLookup(TContratoTipoServicoVO, TContratoTipoServicoController);
      if CDSTransiente.RecordCount > 0 then
      begin
        EditIdTipoServico.Text := CDSTransiente.FieldByName('ID').AsString;
        EditTipoServico.Text := CDSTransiente.FieldByName('NOME').AsString;
      end
      else
      begin
        Exit;
        EditIdTipoServico.SetFocus;
      end;
    finally
      CDSTransiente.Close;
    end;
  end
  else
  begin
    EditIdTipoServico.Clear;
  end;
end;

procedure TFContratoSolicitacaoServico.EditIdTipoServicoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F1 then
  begin
    EditIdTipoServico.Value := -1;
    EditDescricao.SetFocus;
  end;
end;

procedure TFContratoSolicitacaoServico.EditIdTipoServicoKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    EditDescricao.SetFocus;
  end;
end;
{$ENDREGION}

{$REGION 'Controle de Grid'}
procedure TFContratoSolicitacaoServico.GridParaEdits;
begin
  inherited;

  if not CDSGrid.IsEmpty then
  begin
    ObjetoVO := ObjetoController.VO<TContratoSolicitacaoServicoVO>(IdRegistroSelecionado);
    if StatusTela = stEditando then
      ObjetoOldVO := ObjetoController.VO<TContratoSolicitacaoServicoVO>(IdRegistroSelecionado);
  end;

  if Assigned(ObjetoVO) then
  begin
    if TContratoSolicitacaoServicoVO(ObjetoVO).IdCliente > 0 then
    begin
      EditIdCliente.AsInteger := TContratoSolicitacaoServicoVO(ObjetoVO).IdCliente;
      EditCliente.Text := TContratoSolicitacaoServicoVO(ObjetoVO).ClientePessoaNome;
      EditIdCliente.Visible := True;
      EditCliente.Visible := True;
      EditIdFornecedor.Visible := False;
      EditFornecedor.Visible := False;
      RadioGroupTipoContratacao.ItemIndex := 0;
    end
    else if TContratoSolicitacaoServicoVO(ObjetoVO).IdFornecedor > 0 then
    begin
      EditIdFornecedor.AsInteger := TContratoSolicitacaoServicoVO(ObjetoVO).IdFornecedor;
      EditFornecedor.Text := TContratoSolicitacaoServicoVO(ObjetoVO).FornecedorPessoaNome;
      EditIdCliente.Visible := False;
      EditCliente.Visible := False;
      EditIdFornecedor.Visible := True;
      EditFornecedor.Visible := True;
      RadioGroupTipoContratacao.ItemIndex := 1;
    end;

    EditIdSetor.AsInteger := TContratoSolicitacaoServicoVO(ObjetoVO).IdSetor;
    EditSetor.Text := TContratoSolicitacaoServicoVO(ObjetoVO).SetorNome;
    EditIdColaborador.AsInteger := TContratoSolicitacaoServicoVO(ObjetoVO).IdColaborador;
    EditColaborador.Text := TContratoSolicitacaoServicoVO(ObjetoVO).ColaboradorPessoaNome;
    EditIdTipoServico.AsInteger := TContratoSolicitacaoServicoVO(ObjetoVO).IdContratoTipoServico;
    EditTipoServico.Text := TContratoSolicitacaoServicoVO(ObjetoVO).ContratoTipoServicoNome;
    EditDescricao.Text := TContratoSolicitacaoServicoVO(ObjetoVO).Descricao;
    EditDataSolicitacao.Date := TContratoSolicitacaoServicoVO(ObjetoVO).DataSolicitacao;
    EditDataDesejadaInicio.Date := TContratoSolicitacaoServicoVO(ObjetoVO).DataDesejadaInicio;
    ComboBoxUrgente.ItemIndex := StrToInt(IfThen(TContratoSolicitacaoServicoVO(ObjetoVO).Urgente = 'S', '0', '1'));

    case AnsiIndexStr(TContratoSolicitacaoServicoVO(ObjetoVO).StatusSolicitacao, ['A', 'D', 'I']) of
      0:
        ComboBoxStatusSolicitacao.ItemIndex := 0;
      1:
        ComboBoxStatusSolicitacao.ItemIndex := 1;
      2:
        ComboBoxStatusSolicitacao.ItemIndex := 2;
    else
      ComboBoxStatusSolicitacao.ItemIndex := -1;
    end;
  end;
end;
{$ENDREGION}

end.
