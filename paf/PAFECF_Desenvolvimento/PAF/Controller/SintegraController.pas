{ *******************************************************************************
  Title: T2Ti ERP
  Description: Classe de controle do Sintegra.

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
  @version 1.0
  ******************************************************************************* }
unit SintegraController;

interface

uses
  Classes, SQLExpr, SysUtils, Sintegra60MVO, Sintegra60AVO, Sintegra60DVO, Generics.Collections,
  Biblioteca, Sintegra60RVO, Sintegra61RVO, Constantes, SintegraVO, StrUtils, UCaixa;

type
  TSintegraController = class
  protected
  public
    class function Grava60M(Sintegra60M: TSintegra60MVO): TSintegra60MVO;
    class procedure Grava60A(Lista60A: TObjectList<TSintegra60AVO>);
    class function Tabela50(DataInicio: String; DataFim: String): TObjectList<TSintegraVO>;
    class function Tabela54(DataInicio: String; DataFim: String): TObjectList<TSintegraVO>;
    class function Tabela51(DataInicio: String; DataFim: String): TObjectList<TSintegraVO>;
    class function Tabela60M(DataInicio: String; DataFim: String): TObjectList<TSintegra60MVO>;
    class function Tabela60A(Id: Integer): TObjectList<TSintegra60AVO>;
    class function Tabela60D(DataInicio: String; DataFim: String): TObjectList<TSintegra60DVO>;
    class function Tabela60R(DataInicio: String; DataFim: String): TObjectList<TSintegra60RVO>;
    class function Tabela61R(DataInicio: String; DataFim: String): TObjectList<TSintegra61RVO>;
    class Function Registro54e75(Id : String): TObjectList<TSintegraVO>;

 end;

implementation

uses UDataModule;

var
  ConsultaSQL: String;
  Query: TSQLQuery;

class function TSintegraController.Grava60M(Sintegra60M: TSintegra60MVO): TSintegra60MVO;
begin
  ConsultaSQL :=
    'insert into SINTEGRA_60M (' +
    'DATA_EMISSAO,' +
    'NUMERO_SERIE_ECF,' +
    'NUMERO_EQUIPAMENTO,' +
    'MODELO_DOCUMENTO_FISCAL,' +
    'COO_INICIAL,' +
    'COO_FINAL,' +
    'CRZ,' +
    'CRO,' +
    'VALOR_VENDA_BRUTA,' +
    'VALOR_GRANDE_TOTAL) values (' +
    ':pDataEmissao,' +
    ':pSerieImpressora,' +
    ':pNumeroEquipamento,' +
    ':pModeloDocumentoFiscal,' +
    ':pCOOInicial,' +
    ':pCOOFinal,' +
    ':pCRZ,' +
    ':pCRO,' +
    ':pVendaBruta,' +
    ':pGrandeTotal)';

  try
    try
      Query := TSQLQuery.Create(nil);
      Query.SQLConnection := FDataModule.Conexao;
      Query.sql.Text := ConsultaSQL;
      Query.ParamByName('pDataEmissao').AsString := Sintegra60M.DataEmissao;
      Query.ParamByName('pSerieImpressora').AsString := Sintegra60M.SerieImpressora;
      Query.ParamByName('pNumeroEquipamento').AsInteger := Sintegra60M.NumeroEquipamento;
      Query.ParamByName('pModeloDocumentoFiscal').AsString := Sintegra60M.ModeloDocumentoFiscal;
      Query.ParamByName('pCOOInicial').AsInteger := Sintegra60M.COOInicial;
      Query.ParamByName('pCOOFinal').AsInteger := Sintegra60M.COOFinal;
      Query.ParamByName('pCRZ').Asinteger := Sintegra60M.CRZ;
      Query.ParamByName('pCRO').Asinteger := Sintegra60M.CRO;
      Query.ParamByName('pVendaBruta').AsFloat := Sintegra60M.VendaBruta;
      Query.ParamByName('pGrandeTotal').AsFloat := Sintegra60M.GrandeTotal;
      Query.ExecSQL();

      ConsultaSQL := 'select max(ID) as ID from SINTEGRA_60M';
      Query.sql.Text := ConsultaSQL;
      Query.Open();

      Sintegra60M.Id := Query.FieldByName('ID').AsInteger;
      result := Sintegra60M;
    except
    end;
  finally
    Query.Free;
  end;
end;

class function TSintegraController.Tabela60M(DataInicio: String; DataFim: String): TObjectList<TSintegra60MVO>;
var
  Lista60M: TObjectList<TSintegra60MVO>;
  Sintegra60M: TSintegra60MVO;
  TotalRegistros: Integer;
begin
  DataInicio := FormatDateTime('yyyy-mm-dd', StrToDate(DataInicio));
  DataFim := FormatDateTime('yyyy-mm-dd', StrToDate(DataFim));

  ConsultaSQL := 'select count(*) as TOTAL from SINTEGRA_60M where ' +
  '(DATA_EMISSAO between ' +
    QuotedStr(DataInicio) + ' and ' + QuotedStr(DataFim) + ')';

  try
    try
      Query := TSQLQuery.Create(nil);
      Query.SQLConnection := FDataModule.Conexao;
      Query.sql.Text := ConsultaSQL;
      Query.Open;
      TotalRegistros := Query.FieldByName('TOTAL').AsInteger;
      if TotalRegistros > 0 then
      begin
        Lista60M := TObjectList<TSintegra60MVO>.Create;

        ConsultaSQL := 'select * from SINTEGRA_60M where ' +
        '(DATA_EMISSAO between ' +
          QuotedStr(DataInicio) + ' and ' + QuotedStr(DataFim) + ')';

        Query.sql.Text := ConsultaSQL;
        Query.Open;
        Query.First;
        while not Query.Eof do
        begin
          Sintegra60M := TSintegra60MVO.Create;
          Sintegra60M.Id := Query.FieldByName('ID').AsInteger;
          Sintegra60M.DataEmissao := Query.FieldByName('DATA_EMISSAO').AsString;
          Sintegra60M.SerieImpressora := Query.FieldByName('NUMERO_SERIE_ECF').AsString;
          Sintegra60M.NumeroEquipamento := Query.FieldByName('NUMERO_EQUIPAMENTO').AsInteger;
          Sintegra60M.ModeloDocumentoFiscal := Query.FieldByName('MODELO_DOCUMENTO_FISCAL').AsString;
          Sintegra60M.COOInicial := Query.FieldByName('COO_INICIAL').AsInteger;
          Sintegra60M.COOFinal := Query.FieldByName('COO_FINAL').AsInteger;
          Sintegra60M.CRZ := Query.FieldByName('CRZ').AsInteger;
          Sintegra60M.CRO := Query.FieldByName('CRO').AsInteger;
          Sintegra60M.VendaBruta := Query.FieldByName('VALOR_VENDA_BRUTA').AsFloat;
          Sintegra60M.GrandeTotal := Query.FieldByName('VALOR_GRANDE_TOTAL').AsFloat;
          Lista60M.Add(Sintegra60M);
          Query.next;
        end;
        result := Lista60M;
      end
      else
        result := nil;
    except
      result := nil;
    end;
  finally
    Query.Free;
  end;
end;

class procedure TSintegraController.Grava60A(Lista60A: TObjectList<TSintegra60AVO>);
var
  i: Integer;
begin
  for i := 0 to Lista60A.Count - 1 do
  begin
    ConsultaSQL :=
    'insert into SINTEGRA_60A (' +
    'ID_SINTEGRA_60M,' +
    'SITUACAO_TRIBUTARIA,' +
    'VALOR) values (' +
    ':pId60M,' +
    ':pST,' +
    ':pValor)';
    try
      try
        Query := TSQLQuery.Create(nil);
        Query.SQLConnection := FDataModule.Conexao;
        Query.sql.Text := ConsultaSQL;
        Query.ParamByName('pId60M').AsInteger := TSintegra60AVO(Lista60A.Items[i]).Id60M;
        Query.ParamByName('pST').AsString := TSintegra60AVO(Lista60A.Items[i]).SituacaoTributaria;
        Query.ParamByName('pValor').AsFloat := TSintegra60AVO(Lista60A.Items[i]).Valor;
        Query.ExecSQL();
      except
      end;
    finally
      Query.Free;
    end;
  end;
end;

class function TSintegraController.Tabela50(DataInicio, DataFim: String): TObjectList<TSintegraVO>;
var
  ListaSintegra: TObjectList<TSintegraVO>;
  Sintegra: TSintegraVO;
  TotalRegistros: Integer;
begin
  DataInicio := FormatDateTime('yyyy-mm-dd', StrToDate(DataInicio));
  DataFim := FormatDateTime('yyyy-mm-dd', StrToDate(DataFim));

  ConsultaSQL :=  ' select count(*) as TOTAL '+
                  ' from NFE_CABECALHO '+
                  ' where DATA_EMISSAO between '+QuotedStr(DataInicio)+' and '+QuotedStr(DataFim);

  try
    try
      Query := TSQLQuery.Create(nil);
      Query.SQLConnection := FDataModule.ConexaoBalcao;
      Query.sql.Text := ConsultaSQL;
      Query.Open;
      TotalRegistros := Query.FieldByName('TOTAL').AsInteger;
      if TotalRegistros > 0 then
      begin
        ListaSintegra := TObjectList<TSintegraVO>.Create;

        ConsultaSQL := 'select '+
                       ' C.ID, '+
                       ' P.CPF_CNPJ, '+
                       ' P.INSCRICAO_ESTADUAL, '+
                       ' C.DATA_EMISSAO, '+
                       ' C.SERIE, '+
                       ' C.NUMERO, '+
                       ' E.UF, '+
                     //  ' C.CFOP, '+
                       ' C.VALOR_TOTAL, '+
                       ' C.BASE_CALCULO_ICMS, '+
                       ' C.VALOR_ICMS, '+
                       ' P.TIPO '+
                       ' from '+
                       ' NFE_CABECALHO C, PESSOA P, PESSOA_ENDERECO E '+
                       'where '+
                       ' C.ID_CLIENTE = P.ID '+
                       ' and E.ID_PESSOA = P.ID '+
                       ' and C.DATA_EMISSAO between '+QuotedStr(DataInicio)+' and '+QuotedStr(DataFim);


        Query.sql.Text := ConsultaSQL;
        Query.Open;
        Query.First;
        while not Query.Eof do
        begin
          Sintegra := TSintegraVO.Create;
          Sintegra.Id := Query.FieldByName('ID').AsInteger;
          Sintegra.CPFCNPJ := Query.FieldByName('CPF_CNPJ').AsString;
          if Query.FieldByName('TIPO').AsString = 'J' then
             begin
             if Trim(Query.FieldByName('INSCRICAO_ESTADUAL').AsString) <> '' then
                Sintegra.Inscricao := Query.FieldByName('INSCRICAO_ESTADUAL').AsString
             else
//             Sintegra.Inscricao := '00000000';
               Sintegra.Inscricao := 'ISENTO';
             end
          else
             Sintegra.Inscricao := 'ISENTO';

          Sintegra.DataDocumento := Query.FieldByName('DATA_EMISSAO').AsDateTime;
          Sintegra.Serie := '001';//Query.FieldByName('SERIE').AsString;
          Sintegra.Numero := RightStr(Query.FieldByName('NUMERO').AsString,6);
          Sintegra.UF := Query.FieldByName('UF').AsString;
          Sintegra.ValorContabil := Query.FieldByName('VALOR_TOTAL').AsFloat;
          Sintegra.Cfop := IntToStr(Configuracao.CFOPNF2);
//          Sintegra.Cfop := Query.FieldByName('CFOP').AsString;
          Sintegra.BasedeCalculo := Query.FieldByName('BASE_CALCULO_ICMS').AsFloat;
          Sintegra.Icms := Query.FieldByName('VALOR_ICMS').AsFloat;
          Sintegra.ValorOutras := 0;
          Sintegra.ValorIsentas := 0;
          Sintegra.Isentas := 0;
          Sintegra.Aliquota := 0;
          Sintegra.AliquotaICMS := (Query.FieldByName('VALOR_ICMS').AsFloat * 100) / Query.FieldByName('VALOR_TOTAL').AsFloat;

          Sintegra.EmissorDocumento := 'P'; //emissao propria
          Sintegra.Situacao := 'N';
          Sintegra.Modelo := '55';
          ListaSintegra.Add(Sintegra);
          Query.next;
        end;
        result := ListaSintegra;
      end
      else
        result := nil;
    except
      result := nil;
    end;
  finally
    Query.Free;
  end;
end;


class function TSintegraController.Tabela54(DataInicio, DataFim: String): TObjectList<TSintegraVO>;
var
  ListaSintegra: TObjectList<TSintegraVO>;
  Sintegra: TSintegraVO;
  TotalRegistros: Integer;
begin
  DataInicio := FormatDateTime('yyyy-mm-dd', StrToDate(DataInicio));
  DataFim := FormatDateTime('yyyy-mm-dd', StrToDate(DataFim));

  ConsultaSQL :=  ' select count(*) as TOTAL '+
                  ' from NFE_CABECALHO C, NFE_DETALHE D'+
                  ' where C.ID=D.ID_NFE_CABECALHO '+
                  ' and C.DATA_EMISSAO between '+QuotedStr(DataInicio)+' and '+QuotedStr(DataFim);

  try
    try
      Query := TSQLQuery.Create(nil);
      Query.SQLConnection := FDataModule.ConexaoBalcao;
      Query.sql.Text := ConsultaSQL;
      Query.Open;
      TotalRegistros := Query.FieldByName('TOTAL').AsInteger;
      if TotalRegistros > 0 then
      begin
        ListaSintegra := TObjectList<TSintegraVO>.Create;

        ConsultaSQL := 'select '+
                       ' C.ID, '+
                       ' P.CPF_CNPJ, '+
                       ' P.INSCRICAO_ESTADUAL, '+
                       ' C.DATA_EMISSAO, '+
                       ' C.SERIE, '+
                       ' C.NUMERO, '+
                       ' E.UF, '+
                       ' D.CFOP, '+
                       ' D.VALOR_TOTAL, '+
                       ' D.BASE_CALCULO_ICMS, '+
                       ' D.VALOR_ICMS, '+
                       ' D.VALOR_OUTRAS_DESPESAS, '+
                       ' P.TIPO '+
                       ' from '+
                       ' NFE_CABECALHO C, NFE_DETALHE D, PESSOA P, PESSOA_ENDERECO E '+
                       'where '+
                       ' C.ID=D.ID_NFE_CABECALHO '+
                       ' and C.ID_CLIENTE = P.ID '+
                       ' and E.ID_PESSOA = P.ID '+
                       ' and C.DATA_EMISSAO between '+QuotedStr(DataInicio)+' and '+QuotedStr(DataFim);


        Query.sql.Text := ConsultaSQL;
        Query.Open;
        Query.First;
        while not Query.Eof do
        begin
          Sintegra := TSintegraVO.Create;
          Sintegra.Id := Query.FieldByName('ID').AsInteger;
          Sintegra.CPFCNPJ := Query.FieldByName('CPF_CNPJ').AsString;
          if Query.FieldByName('TIPO').AsString = 'J' then
             begin
             if Trim(Query.FieldByName('INSCRICAO_ESTADUAL').AsString) <> '' then
                Sintegra.Inscricao := Query.FieldByName('INSCRICAO_ESTADUAL').AsString
             else
//             Sintegra.Inscricao := '00000000';
               Sintegra.Inscricao := 'ISENTO';
             end
          else
             Sintegra.Inscricao := 'ISENTO';

          Sintegra.DataDocumento := Query.FieldByName('DATA_EMISSAO').AsDateTime;
          Sintegra.Serie := '001';//Query.FieldByName('SERIE').AsString;
          Sintegra.Numero := RightStr(Query.FieldByName('NUMERO').AsString,6);
          Sintegra.UF := Query.FieldByName('UF').AsString;
          Sintegra.Cfop := IntToStr(Configuracao.CFOPNF2);
//          Sintegra.Cfop := Query.FieldByName('CFOP').AsString;
          Sintegra.ValorContabil := Query.FieldByName('VALOR_TOTAL').AsFloat;
          Sintegra.BasedeCalculo := Query.FieldByName('BASE_CALCULO_ICMS').AsFloat;
          Sintegra.Icms := Query.FieldByName('VALOR_ICMS').AsFloat;
          Sintegra.ValorOutras := Query.FieldByName('VALOR_OUTRAS_DESPESAS').AsFloat;
          Sintegra.ValorIsentas := 0;
          Sintegra.Isentas := 0;
          Sintegra.Aliquota := 0;
          Sintegra.EmissorDocumento := 'P'; //emissao propria
          Sintegra.Situacao := 'N';
          Sintegra.Modelo := '55';
          ListaSintegra.Add(Sintegra);
          Query.next;
        end;
        result := ListaSintegra;
      end
      else
        result := nil;
    except
      result := nil;
    end;
  finally
    Query.Free;
  end;
end;


class function TSintegraController.Tabela51(DataInicio, DataFim: String): TObjectList<TSintegraVO>;
var
  ListaSintegra: TObjectList<TSintegraVO>;
  Sintegra: TSintegraVO;
  TotalRegistros: Integer;
begin
  DataInicio := FormatDateTime('yyyy-mm-dd', StrToDate(DataInicio));
  DataFim := FormatDateTime('yyyy-mm-dd', StrToDate(DataFim));

  ConsultaSQL :=  ' select count(*) as TOTAL '+
                  ' from NFE_CABECALHO C, NFE_DETALHE D'+
                  ' where C.ID=D.ID_NFE_CABECALHO '+
                  ' and C.DATA_EMISSAO between '+QuotedStr(DataInicio)+' and '+QuotedStr(DataFim);

  try
    try
      Query := TSQLQuery.Create(nil);
      Query.SQLConnection := FDataModule.ConexaoBalcao;
      Query.sql.Text := ConsultaSQL;
      Query.Open;
      TotalRegistros := Query.FieldByName('TOTAL').AsInteger;
      if TotalRegistros > 0 then
      begin
        ListaSintegra := TObjectList<TSintegraVO>.Create;

        ConsultaSQL := 'select '+
                       ' D.ID, '+
                       ' D.CPF_CNPJ, '+
                       ' D.IE, '+
                       ' D.DATA_EMISSAO, '+
                       ' D.SERIE, '+
                       ' D.NUMERO, '+
                       ' D.CFOP, '+
                       ' D.VALOR_TOTAL, '+
                       ' D.VALOR_IPI, '+
                       ' D.VALOR_DESPESAS_ACESSORIAS, '+
                       ' D.SITUACAO_NOTA '+
                       'from '+
                       ' NFE_CABECALHO C, NFE_DETALHE D '+
                       'where '+
                       ' C.ID=D.ID_NFE_CABECALHO '+
                       ' and C.DATA_EMISSAO between '+QuotedStr(DataInicio)+' and '+QuotedStr(DataFim);

        Query.sql.Text := ConsultaSQL;
        Query.Open;
        Query.First;
        while not Query.Eof do
        begin
          Sintegra := TSintegraVO.Create;
          Sintegra.Id := Query.FieldByName('ID').AsInteger;
          Sintegra.CPFCNPJ := Query.FieldByName('CPF_CNPJ').AsString;
          Sintegra.Inscricao := Query.FieldByName('IE').AsString;
          Sintegra.DataDocumento := Query.FieldByName('DATA_EMISSAO').AsDateTime;
          Sintegra.Serie := Query.FieldByName('SERIE').AsString;
          Sintegra.Numero := Query.FieldByName('NUMERO').AsString;
          Sintegra.Cfop := Query.FieldByName('CFOP').AsString;
          Sintegra.ValorContabil := Query.FieldByName('VALOR_TOTAL').AsInteger;
          Sintegra.ValorIpi := Query.FieldByName('VALOR_IPI').AsInteger;
          Sintegra.ValorOutras := Query.FieldByName('VALOR_DESPESAS_ACESSORIAS').AsFloat;
          Sintegra.ValorIsentas := 0;
          Sintegra.Situacao := Query.FieldByName('SITUACAO_NOTA').asString;
          ListaSintegra.Add(Sintegra);
          Query.next;
        end;
        result := ListaSintegra;
      end
      else
        result := nil;
    except
      result := nil;
    end;
  finally
    Query.Free;
  end;
end;

class function TSintegraController.Tabela60A(Id: Integer): TObjectList<TSintegra60AVO>;
var
  Lista60A: TObjectList<TSintegra60AVO>;
  Sintegra60A: TSintegra60AVO;
  TotalRegistros: Integer;
begin
  ConsultaSQL := 'select count(*) AS TOTAL from SINTEGRA_60A where ID_SINTEGRA_60M='+IntToStr(Id);
  try
    try
      Query := TSQLQuery.Create(nil);
      Query.SQLConnection := FDataModule.Conexao;
      Query.sql.Text := ConsultaSQL;
      Query.Open;
      TotalRegistros := Query.FieldByName('TOTAL').AsInteger;

      if TotalRegistros > 0 then
      begin
        Lista60A := TObjectList<TSintegra60AVO>.Create;

        ConsultaSQL := 'select * from SINTEGRA_60A where ID_SINTEGRA_60M='+IntToStr(Id);
        Query.sql.Text := ConsultaSQL;
        Query.Open;
        Query.First;
        while not Query.Eof do
        begin
          Sintegra60A := TSintegra60AVO.Create;
          Sintegra60A.Id := Query.FieldByName('ID').AsInteger;
          Sintegra60A.Id60M := Query.FieldByName('ID_SINTEGRA_60M').AsInteger;
          Sintegra60A.SituacaoTributaria := Query.FieldByName('SITUACAO_TRIBUTARIA').AsString;
          Sintegra60A.Valor := Query.FieldByName('VALOR').AsFloat;
          Lista60A.Add(Sintegra60A);
          Query.next;
        end;
        result := Lista60A;
      end
      else
        result := nil;
    except
      result := nil;
    end;
  finally
    Query.Free;
  end;
end;

class function TSintegraController.Tabela60D(DataInicio: String; DataFim: String): TObjectList<TSintegra60DVO>;
var
  Lista60D: TObjectList<TSintegra60DVO>;
  Sintegra60D: TSintegra60DVO;
begin
  DataInicio := FormatDateTime('yyyy-mm-dd', StrToDate(DataInicio));
  DataFim := FormatDateTime('yyyy-mm-dd', StrToDate(DataFim));

  ConsultaSQL :=
    'select * from VIEW_60D '+
    'where DATA_EMISSAO between ' +
    QuotedStr(DataInicio) + ' and ' + QuotedStr(DataFim);

  try
    try
      Lista60D := TObjectList<TSintegra60DVO>.Create;

      Query := TSQLQuery.Create(nil);
      Query.SQLConnection := FDataModule.Conexao;
      Query.sql.Text := ConsultaSQL;
      Query.Open;
      Query.First;
      while not Query.Eof do
      begin
        Sintegra60D := TSintegra60DVO.Create;
        Sintegra60D.GTIN := Query.FieldByName('GTIN').AsString;
        Sintegra60D.DataEmissao := Query.FieldByName('DATA_EMISSAO').AsString;
        Sintegra60D.SerieECF := Query.FieldByName('SERIE').AsString;
        Sintegra60D.SomaQuantidade := TruncaValor(Query.FieldByName('SOMA_QUANTIDADE').AsFloat,Constantes.TConstantes.DECIMAIS_QUANTIDADE);
        Sintegra60D.SomaValor := TruncaValor(Query.FieldByName('SOMA_ITEM').AsFloat,Constantes.TConstantes.DECIMAIS_VALOR);
        Sintegra60D.SomaBaseICMS := TruncaValor(Query.FieldByName('SOMA_BASE_ICMS').AsFloat,Constantes.TConstantes.DECIMAIS_VALOR);
        Sintegra60D.SomaValorICMS := TruncaValor(Query.FieldByName('SOMA_ICMS').AsFloat,Constantes.TConstantes.DECIMAIS_VALOR);
        Sintegra60D.SituacaoTributaria := Query.FieldByName('ECF_ICMS_ST').AsString;
        Lista60D.Add(Sintegra60D);
        Query.next;
      end;
      result := Lista60D;
    except
      result := nil;
    end;
  finally
    Query.Free;
  end;
end;

class function TSintegraController.Tabela60R(DataInicio: String; DataFim: String): TObjectList<TSintegra60RVO>;
var
  Lista60R: TObjectList<TSintegra60RVO>;
  Sintegra60R: TSintegra60RVO;
begin
  DataInicio := FormatDateTime('yyyy-mm-dd', StrToDate(DataInicio));
  DataFim := FormatDateTime('yyyy-mm-dd', StrToDate(DataFim));

  ConsultaSQL :=
    'select * from VIEW_60R '+
    'where DATA_EMISSAO between ' +
    QuotedStr(DataInicio) + ' and ' + QuotedStr(DataFim);
  try
    try
      Lista60R := TObjectList<TSintegra60RVO>.Create;

      Query := TSQLQuery.Create(nil);
      Query.SQLConnection := FDataModule.Conexao;
      Query.sql.Text := ConsultaSQL;
      Query.Open;
      Query.First;
      while not Query.Eof do
      begin
        Sintegra60R := TSintegra60RVO.Create;
        Sintegra60R.GTIN := Query.FieldByName('GTIN').AsString;
        Sintegra60R.DataEmissao := Query.FieldByName('DATA_EMISSAO').AsString;
        Sintegra60R.MesEmissao := Query.FieldByName('MES_EMISSAO').AsString;
        Sintegra60R.MesEmissao := StringOfChar('0',2-Length(Sintegra60R.MesEmissao)) + Sintegra60R.MesEmissao;
        Sintegra60R.AnoEmissao := Query.FieldByName('ANO_EMISSAO').AsString;
        Sintegra60R.SomaQuantidade := TruncaValor(Query.FieldByName('SOMA_QUANTIDADE').AsFloat,Constantes.TConstantes.DECIMAIS_QUANTIDADE);
        Sintegra60R.SomaValor := TruncaValor(Query.FieldByName('SOMA_ITEM').AsFloat,Constantes.TConstantes.DECIMAIS_VALOR);
        Sintegra60R.SomaBaseICMS := TruncaValor(Query.FieldByName('SOMA_BASE_ICMS').AsFloat,Constantes.TConstantes.DECIMAIS_VALOR);
        Sintegra60R.SituacaoTributaria := Query.FieldByName('ECF_ICMS_ST').AsString;
        Lista60R.Add(Sintegra60R);
        Query.next;
      end;
      result := Lista60R;
    except
      result := nil;
    end;
  finally
    Query.Free;
  end;
end;

class function TSintegraController.Tabela61R(DataInicio:String; DataFim:String): TObjectList<TSintegra61RVO>;
var
  Lista61R: TObjectList<TSintegra61RVO>;
  Sintegra61R: TSintegra61RVO;
begin
  DataInicio := FormatDateTime('yyyy-mm-dd', StrToDate(DataInicio));
  DataFim := FormatDateTime('yyyy-mm-dd', StrToDate(DataFim));

  ConsultaSQL :=
    'select * from VIEW_61R '+
    'where DATA_EMISSAO between ' +
    QuotedStr(DataInicio) + ' and ' + QuotedStr(DataFim);

  try
    try
      Lista61R := TObjectList<TSintegra61RVO>.Create;

      Query := TSQLQuery.Create(nil);
      Query.SQLConnection := FDataModule.Conexao;
      Query.sql.Text := ConsultaSQL;
      Query.Open;
      Query.First;
      while not Query.Eof do
      begin
        Sintegra61R := TSintegra61RVO.Create;
        Sintegra61R.GTIN := Query.FieldByName('GTIN').AsString;
        Sintegra61R.DataEmissao := Query.FieldByName('DATA_EMISSAO').AsString;
        Sintegra61R.MesEmissao := Query.FieldByName('MES_EMISSAO').AsString;
        Sintegra61R.MesEmissao := StringOfChar('0',2-Length(Sintegra61R.MesEmissao)) + Sintegra61R.MesEmissao;
        Sintegra61R.AnoEmissao := Query.FieldByName('ANO_EMISSAO').AsString;
        Sintegra61R.SomaQuantidade := TruncaValor(Query.FieldByName('SOMA_QUANTIDADE').AsFloat,Constantes.TConstantes.DECIMAIS_QUANTIDADE);
        Sintegra61R.SomaValor := TruncaValor(Query.FieldByName('SOMA_ITEM').AsFloat,Constantes.TConstantes.DECIMAIS_VALOR);
        Sintegra61R.SomaBaseICMS := TruncaValor(Query.FieldByName('SOMA_BASE_ICMS').AsFloat,Constantes.TConstantes.DECIMAIS_VALOR);
        Sintegra61R.SituacaoTributaria := Query.FieldByName('ECF_ICMS_ST').AsString;
        Lista61R.Add(Sintegra61R);
        Query.next;
      end;
      result := Lista61R;
    except
      result := nil;
    end;
  finally
    Query.Free;
  end;
end;

class function TSintegraController.Registro54e75(Id: String): TObjectList<TSintegraVO>;
var
  ListaSintegra: TObjectList<TSintegraVO>;
  Sintegra: TSintegraVO;
  TotalRegistros: Integer;
begin
  ConsultaSQL :=   ' select count(*) as total '+
                 ' from NFE_DETALHE '+
                 ' where ID_NFE_CABECALHO='+ID;
  try
    try
      Query := TSQLQuery.Create(nil);
      Query.SQLConnection := FDataModule.ConexaoBalcao;
      Query.sql.Text := ConsultaSQL;
      Query.Open;
      TotalRegistros := Query.FieldByName('TOTAL').AsInteger;
      if TotalRegistros > 0 then
      begin
        ListaSintegra := TObjectList<TSintegraVO>.Create;

        ConsultaSQL := 'select '+
                       ' numero_item, '+
                       ' nome_produto, '+
                       ' cst_icms, '+
                       ' codigo_produto, '+
                       ' cfop, '+
                       ' quantidade_comercial, '+
                       ' valor_total, '+
                       ' base_calculo_icms, '+
                       ' base_calculo_icms_st, '+
                       ' valor_ipi, '+
                       ' aliquota_icms, '+
                       ' ncm, '+
                       ' unidade_comercial, '+
                       ' aliquota_ipi, '+
                       ' reducao_bc_icms_st '+
                       'from '+
                       ' nfe_detalhe '+
                       'where '+
                       ' id_nfe_cabecalho='+ID;

        Query.sql.Text := ConsultaSQL;
        Query.Open;
        Query.First;
        while not Query.Eof do
        begin

          Sintegra := TSintegraVO.Create;
          Sintegra.NumeroItem := Query.FieldByName('numero_item').AsString;
          Sintegra.Descricao := Query.FieldByName('nome_produto').AsString;
          Sintegra.CST := Query.FieldByName('cst_icms').AsString;
          Sintegra.Codigo := Query.FieldByName('codigo_produto').AsString;
          Sintegra.Cfop := Query.FieldByName('cfop').AsString;
          Sintegra.Quantidade := Query.FieldByName('quantidade_comercial').AsExtended;
          Sintegra.Valor := Query.FieldByName('valor_total').AsExtended;
          Sintegra.BasedeCalculo := Query.FieldByName('valor_total').AsExtended;
//          Sintegra.BasedeCalculo := Query.FieldByName('base_calculo_icms').AsExtended;
          Sintegra.BaseST := Query.FieldByName('base_calculo_icms_st').AsExtended;
          Sintegra.Despesas := 0;
          Sintegra.ValorIpi := Query.FieldByName('valor_ipi').AsExtended;
          Sintegra.AliquotaICMS := Query.FieldByName('aliquota_icms').AsExtended;
          Sintegra.NCM := Query.FieldByName('ncm').AsString;
          Sintegra.Unidade := Query.FieldByName('unidade_comercial').AsString;
          Sintegra.AliquotaIpi := Query.FieldByName('aliquota_ipi').AsExtended;
          Sintegra.Reducao := Query.FieldByName('reducao_bc_icms_st').AsExtended;
          ListaSintegra.Add(Sintegra);
          Query.next;
        end;
        result := ListaSintegra;
      end
      else
        result := nil;
    except
      result := nil;
    end;
  finally
    Query.Free;
  end;
end;

end.
