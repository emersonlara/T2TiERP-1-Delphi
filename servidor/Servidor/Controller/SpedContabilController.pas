{ *******************************************************************************
  Title: T2Ti ERP
  Description: Controller do lado Servidor relacionado ao Sped Cont�bil

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

  @author Albert Eije (t2ti.com@gmail.com)
  @version 1.0
  ******************************************************************************* }
unit SpedContabilController;

interface

uses
  Forms, Classes, SQLExpr, SysUtils, Generics.Collections, Controller, DBXJSON, DBXCommon,
  Biblioteca, ACBrECDBlocos;

type
  TSpedContabilController = class(TController)
  private
    procedure GerarBloco0;
    procedure GerarBlocoI;
    procedure GerarBlocoJ;
    function GerarArquivoSpedContabil: Boolean;
  protected
  public
    // consultar
    function SpedContabil(pSessao: String; pFiltro: String; pPagina: Integer): TJSONArray;
  end;

implementation

uses
  T2TiORM, SA, UDataModule,
  // VOs
  EmpresaVO, ContabilTermoVO, RegistroCartorioVO, ContabilContaVO,
  ContabilHistoricoVO, ContabilLancamentoCabecalhoVO, ContabilLivroVO,
  ContabilLancamentoDetalheVO, ContabilDreDetalheVO, ContadorVO,
  ViewSpedI155VO, PlanoContaVO;

{ TSpedContabilController }

var
  Empresa: TEmpresaVO;
  FormaEscrituracao, IdEmpresa, VersaoLayout: Integer;
  DataInicial, DataFinal, Arquivo, SessaoAtual, FiltroLocal, EscrituracaoForma: String;

{$REGION 'Informa��es Importantes'}

{

Fonte: Manual de Orienta��o da ECD

S�o previstas as seguintes formas de escritura��o:
G - Di�rio Geral;
R - Di�rio com Escritura��o Resumida (vinculado a livro auxiliar);
A - Di�rio Auxiliar;
Z - Raz�o Auxiliar; e
B - Livro de Balancetes Di�rios e Balan�os.

  - Todas as empresas devem utilizar o livro Di�rio contemplando todos os fatos cont�beis. Este livro �
    classificado, no Sped Cont�bil, como G - Livro Di�rio (completo, sem escritura��o auxiliar).
    � o livro Di�rio que independe de qualquer outro. Portanto, ele n�o pode coexistir, em rela��o a um mesmo
    per�odo, com quaisquer dos outros livros (R, A, Z ou B).

  - R - Livro Di�rio com Escritura��o Resumida (com escritura��o auxiliar): � o livro Di�rio que contem
    escritura��o resumida, nos termos do � 1o do art. 1.184 do C�digo Civil, acima transcrito. Ele obriga a
    exist�ncia de livros auxiliares (A ou Z) e n�o pode coexistir, em rela��o a um mesmo per�odo, com os livros G
    e B.

  - A - Livro Di�rio Auxiliar ao Di�rio com Escritura��o Resumida: � o livro auxiliar previsto no nos termos do
    � 1o do art. 1.184 do C�digo Civil supramencionado, contendo os lan�amentos individualizados das opera��es
    lan�adas no Di�rio com Escritura��o Resumida.

  - Z � Raz�o Auxiliar (Livro Cont�bil Auxiliar conforme leiaute definido pelo titular da escritura��o): O livro Z
    um livro auxiliar a ser utilizado quando o leiaute do livro Di�rio Auxiliar n�o se mostrar adequado. � uma
    �tabela� onde o titular da escritura��o define cada coluna e seu conte�do.

  - B - Livro Balancetes Di�rios e Balan�os: Somente o Banco Central regulamentou a utiliza��o deste livro e,
    praticamente, s� � encontrado em institui��es financeiras. A legisla��o n�o obsta a utiliza��o concomitante do
    livro �Balancetes Di�rios e Balan�os� e de livros auxiliares. Existe a controv�rsia sobre a obrigatoriedade de
    autentica��o, pelas empresas n�o regulamentadas pelo Banco Central, das fichas de lan�amento, conforme
    estabelecido no art. 1.181 do C�digo Civil, transcrito abaixo:
    Art. 1.181. Salvo disposi��o especial de lei, os livros obrigat�rios e, se for o caso, as fichas, antes de postos
    em uso, devem ser autenticados no Registro P�blico de Empresas Mercantis.

  - Se��o 1.7. Regras de Conviv�ncia entre os Livros Abrangidos pelo Sped Cont�bil

    A escritura��o G, Di�rio Geral, n�o pode conviver com nenhuma outra escritura��o no mesmo per�odo, ou
    seja, as escritura��es principais (G, R ou B) n�o podem coexistir.
    A escritura��o G n�o possui livros auxiliares (A ou Z), e, consequentemente, n�o pode conviver com esses
    tipos de escritura��o.
    A escritura��o resumida R pode conviver com os livros auxiliares (A ou Z).
    O livro de balancetes e balan�os di�rios B pode conviver com os livros auxiliares (A ou Z).
}
{$ENDREGION}

{$REGION 'REST'}
function TSpedContabilController.SpedContabil(pSessao, pFiltro: String; pPagina: Integer): TJSONArray;
var
  ConteudoFiltro: TStringList;
begin
  Result := TJSONArray.Create;
  try
    ConteudoFiltro := TStringList.Create;
    Split('|', pFiltro, ConteudoFiltro);
    {
      0 - Periodo Inicial
      1 - Periodo Final
      2 - Forma de Escritura��o
      3 - Layout da Vers�o
      }
    DataInicial := ConteudoFiltro[0];
    DataFinal := ConteudoFiltro[1];
    FormaEscrituracao := StrToInt(ConteudoFiltro[2]);
    VersaoLayout := StrToInt(ConteudoFiltro[3]);
    SessaoAtual := pSessao;
    //
    if GerarArquivoSpedContabil then
    begin
      Result.AddElement(TJSOnString.Create('OK'));
      Result.AddElement(TJSOnString.Create(Arquivo));
    end;
  except
    on E: Exception do
    begin
      Result.AddElement(TJSOnString.Create('ERRO'));
      Result.AddElement(TJSOnString.Create(E.Message));
    end;
  end;

  FSA.MemoResposta.Lines.Clear;
  FSA.MemoResposta.Lines.Add(Result.ToString);
end;
{$ENDREGION}

{$REGION 'Gera��o Arquivo'}

{$REGION 'Bloco 0 - Abertura, Identifica��o e Refer�ncias'}
procedure TSpedContabilController.GerarBloco0;
begin
  Empresa := TT2TiORM.ConsultarUmObjeto<TEmpresaVO>('ID=' + IntToStr(Sessao(SessaoAtual).IdEmpresa), True);

  FDataModule.ACBrSpedContabil.Bloco_0.LimpaRegistros;
  with FDataModule.ACBrSpedContabil.Bloco_0 do
  begin
    // REGISTRO 0000: ABERTURA DO ARQUIVO DIGITAL E IDENTIFICA��O DO EMPRES�RIO OU DA SOCIEDADE EMPRES�RIA
    with Registro0000 do
    begin
      DT_INI := TextoParaData(DataInicial);
      DT_FIN := TextoParaData(DataFinal);

      NOME := Empresa.RazaoSocial;
      CNPJ := Empresa.CNPJ;
      UF := Empresa.ListaEnderecoVO.Items[0].UF;
      IE := Empresa.InscricaoEstadual;
      COD_MUN := IntToStr(Empresa.CodigoIbgeCidade);
      IM := Empresa.InscricaoMunicipal;
      IND_SIT_ESP := '';
    end;

    // REGISTRO 0001: ABERTURA DO BLOCO 0
    Registro0001.IND_DAD := 0; // bloco com dados informados = 0 | sem dados inf = 1

    // REGISTRO 0007: OUTRAS INSCRI��ES CADASTRAIS DA PESSOA JUR�DICA
    { Implementado a crit�rio do Participante do T2Ti ERP }

    // REGISTRO 0020: ESCRITURA��O CONT�BIL DESCENTRALIZADA
    { Implementado a crit�rio do Participante do T2Ti ERP - Para o treinamento a escritura��o ser� centralizada }

    // REGISTRO 0150: TABELA DE CADASTRO DO PARTICIPANTE
    { Implementado a crit�rio do Participante do T2Ti ERP }

    // REGISTRO 0180: IDENTIFICA��O DO RELACIONAMENTO COM O PARTICIPANTE
    { Implementado a crit�rio do Participante do T2Ti ERP }
  end;
end;
{$ENDREGION}

{$REGION 'Bloco I - Lan�amentos Cont�beis'}
procedure TSpedContabilController.GerarBlocoI;
var
  PlanoConta: TPlanoContaVO;
  ContabilLivro: TContabilLivroVO;
  TermoLivro: TContabilTermoVO;
  RegistroCartorio: TRegistroCartorioVO;
  RegistroI155C, RegistroI155D: TViewSpedI155VO;
  ContaContabil: TContabilContaVO;
  ListaPlanoConta: TObjectList<TContabilContaVO>;
  ListaHistorico: TObjectList<TContabilHistoricoVO>;
  ListaLancamentoCabecalho: TObjectList<TContabilLancamentoCabecalhoVO>;
  ListaLancamentoDetalhe: TObjectList<TContabilLancamentoDetalheVO>;
  Niveis: TStringList;
  i, j: Integer;
  Credito, Debito, SaldoAnterior: Extended;
begin
  Credito := 0;
  Debito := 0;
  SaldoAnterior := 0;
  Niveis := TStringList.Create;
  FDataModule.ACBrSpedContabil.Bloco_I.LimpaRegistros;

  with FDataModule.ACBrSpedContabil.Bloco_I do
  begin
    // REGISTRO I001: ABERTURA DO BLOCO I
    RegistroI001.IND_DAD := 0;

    // REGISTRO I010: IDENTIFICA��O DA ESCRITURA��O CONT�BIL
    case FormaEscrituracao of
      0:
        RegistroI010.IND_ESC := 'G';
      1:
        RegistroI010.IND_ESC := 'R';
      2:
        RegistroI010.IND_ESC := 'A';
      3:
        RegistroI010.IND_ESC := 'B';
      4:
        RegistroI010.IND_ESC := 'Z';
    end;
    EscrituracaoForma := RegistroI010.IND_ESC;

    case VersaoLayout of
      0:
        RegistroI010.COD_VER_LC := '1.00';
      1:
        RegistroI010.COD_VER_LC := '2.00';
    end;

    // REGISTRO I012: LIVROS AUXILIARES AO DI�RIO
    { Implementado a crit�rio do Participante do T2Ti ERP }

    // REGISTRO I015: IDENTIFICA��O DAS CONTAS DA ESCRITURA��O RESUMIDA A QUE SE REFERE A ESCRITURA��O AUXILIAR
    { Implementado a crit�rio do Participante do T2Ti ERP }

    // REGISTRO I020: CAMPOS ADICIONAIS
    { Implementado a crit�rio do Participante do T2Ti ERP }

    // REGISTRO I030: TERMO DE ABERTURA
    ContabilLivro := TT2TiORM.ConsultarUmObjeto<TContabilLivroVO>('FORMA_ESCRITURACAO = ' + QuotedStr(EscrituracaoForma) +  ' and COMPETENCIA=' + QuotedStr(FormatDateTime('MM/YYYY', TextoParaData(DataInicial))), False);
    if Assigned(ContabilLivro) then
    begin
      TermoLivro := TT2TiORM.ConsultarUmObjeto<TContabilTermoVO>('ID_CONTABIL_LIVRO=' + IntToStr(ContabilLivro.Id) + ' and ABERTURA_ENCERRAMENTO=' + QuotedStr('A'), False);
      RegistroCartorio := TT2TiORM.ConsultarUmObjeto<TRegistroCartorioVO>('ID_EMPRESA=' + IntToStr(Sessao(SessaoAtual).IdEmpresa), False);

      with RegistroI030 do
      begin
        NUM_ORD := TermoLivro.NumeroRegistro;
        NAT_LIVR := ContabilLivro.Descricao;
        QTD_LIN := FDataModule.ACBrSpedContabil.Bloco_9.Registro9999.QTD_LIN;
        NOME := Empresa.RazaoSocial;
        NIRE := RegistroCartorio.NIRE;
        CNPJ := Empresa.CNPJ;
        DT_ARQ := RegistroCartorio.DataRegistro;
        DESC_MUN := Empresa.ListaEnderecoVO.Items[0].Cidade;
      end;
    end;


    // REGISTRO I050: PLANO DE CONTAS
    PlanoConta := TT2TiORM.ConsultarUmObjeto<TPlanoContaVO>('ID_EMPRESA=' + IntToStr(Sessao(SessaoAtual).IdEmpresa), False);
    if Assigned(PlanoConta) then
    begin
      ListaPlanoConta := TT2TiORM.Consultar<TContabilContaVO>('ID_PLANO_CONTA=' + IntToStr(PlanoConta.Id), False);
      if assigned(ListaPlanoConta) then
      begin
        for i := 0 to ListaPlanoConta.Count - 1 do
        begin
          with RegistroI050.New do
          begin
            DT_ALT := TContabilContaVO(ListaPlanoConta.Items[i]).DataInclusao;
            COD_NAT := TContabilContaVO(ListaPlanoConta.Items[i]).CodigoEfd;
            IND_CTA := TContabilContaVO(ListaPlanoConta.Items[i]).Tipo;
            Split('.', TContabilContaVO(ListaPlanoConta.Items[i]).Classificacao, Niveis);
            NIVEL := IntToStr(Niveis.Count);
            COD_CTA := TContabilContaVO(ListaPlanoConta.Items[i]).Classificacao;
            COD_CTA_SUP := '';
            CTA := TContabilContaVO(ListaPlanoConta.Items[i]).Descricao;

            // REGISTRO I051: PLANO DE CONTAS REFERENCIAL
            {
            Observa��o: A partir da vers�o 3.X e altera��es posteriores do PVA do Sped Cont�bil, n�o haver� o plano de
            contas referencial da RFB . Portanto, para as empresas que utilizavam esse plano, n�o ser� necess�rio o preenchimento
            do registro I051.

            Fonte: Manual de Orienta��o da ECD
            }
          end;
        end;
      end;
    end;

    // REGISTRO I052: INDICA��O DOS C�DIGOS DE AGLUTINA��O
    { Implementado a crit�rio do Participante do T2Ti ERP }


    // REGISTRO I075: TABELA DE HIST�RICO PADRONIZADO
    ListaHistorico := TT2TiORM.Consultar<TContabilHistoricoVO>('ID_EMPRESA=' + IntToStr(Sessao(SessaoAtual).IdEmpresa), False);
    if assigned(ListaHistorico) then
    begin
      for i := 0 to ListaHistorico.Count - 1 do
      begin
        with RegistroI075.New do
        begin
          COD_HIST := IntToStr(TContabilHistoricoVO(ListaHistorico.Items[i]).Id);
          DESCR_HIST := TContabilHistoricoVO(ListaHistorico.Items[i]).Historico;
        end;
      end;
    end;

    // REGISTRO I100: CENTRO DE CUSTOS
    { Implementado a crit�rio do Participante do T2Ti ERP }

    // REGISTRO I150: SALDOS PERI�DICOS � IDENTIFICA��O DO PER�ODO
    with RegistroI150.New do
    begin
      DT_INI := TextoParaData(DataInicial);
      DT_FIN := TextoParaData(DataFinal);

      // REGISTRO I151: Hash dos Arquivos que Cont�m as Fichas de Lan�amento Utilizadas no Per�odo
      { Implementado a crit�rio do Participante do T2Ti ERP }

      // REGISTRO I155: DETALHE DOS SALDOS PERI�DICOS
      with RegistroI155.New do
      begin
        for i := 0 to ListaPlanoConta.Count - 1 do
        begin
          // Saldo Anterior
          FiltroLocal := 'MES_ANO=' + QuotedStr(PeriodoAnterior(FormatDateTime('MM/YYYY', TextoParaData(DataInicial)))) + ' and TIPO=' + QuotedStr('C');
          RegistroI155C := TT2TiORM.ConsultarUmObjeto<TViewSpedI155VO>(FiltroLocal, False);
          if Assigned(RegistroI155C) then
            Credito := RegistroI155C.SomaValor
          else
            Credito := 0;

          FiltroLocal := 'MES_ANO=' + QuotedStr(PeriodoAnterior(FormatDateTime('MM/YYYY', TextoParaData(DataInicial)))) + ' and TIPO=' + QuotedStr('D');
          RegistroI155D := TT2TiORM.ConsultarUmObjeto<TViewSpedI155VO>(FiltroLocal, False);
          if Assigned(RegistroI155D) then
            Debito := RegistroI155D.SomaValor
          else
            Debito := 0;

          SaldoAnterior := Credito - Debito;

          COD_CTA := TContabilContaVO(ListaPlanoConta.Items[i]).Classificacao;
          COD_CCUS := '';
          VL_SLD_INI := SaldoAnterior;

          if SaldoAnterior < 0 then
            IND_DC_INI := 'D'
          else
            IND_DC_INI := 'C';

          // Saldo Atual
          FiltroLocal := 'MES_ANO=' + QuotedStr(FormatDateTime('MM/YYYY', TextoParaData(DataInicial))) + ' and TIPO=' + QuotedStr('C');
          RegistroI155C := TT2TiORM.ConsultarUmObjeto<TViewSpedI155VO>(FiltroLocal, False);
          if Assigned(RegistroI155C) then
            Credito := RegistroI155C.SomaValor
          else
            Credito := 0;

          FiltroLocal := 'MES_ANO=' + QuotedStr(FormatDateTime('MM/YYYY', TextoParaData(DataInicial))) + ' and TIPO=' + QuotedStr('D');
          RegistroI155D := TT2TiORM.ConsultarUmObjeto<TViewSpedI155VO>(FiltroLocal, False);
          if Assigned(RegistroI155D) then
            Debito := RegistroI155D.SomaValor
          else
            Debito := 0;

          VL_DEB := Debito;
          VL_CRED := Credito;
          VL_SLD_FIN := Credito - Debito;

          if (Credito - Debito) < 0 then
            IND_DC_FIN := 'D'
          else
            IND_DC_FIN := 'C';

          // REGISTRO I157: TRANSFER�NCIA DE SALDOS DE PLANO DE CONTAS ANTERIOR
          { Implementado a crit�rio do Participante do T2Ti ERP }
        end;
      end;
    end;

    // REGISTRO I200: LAN�AMENTO CONT�BIL
    FiltroLocal := 'ID_EMPRESA=' + IntToStr(Sessao(SessaoAtual).IdEmpresa) + ' and (DATA_LANCAMENTO BETWEEN ' + QuotedStr(DataInicial) + ' and ' + QuotedStr(DataFinal) + ')';
    ListaLancamentoCabecalho := TT2TiORM.Consultar<TContabilLancamentoCabecalhoVO>(FiltroLocal, False);
    if assigned(ListaLancamentoCabecalho) then
    begin
      for i := 0 to ListaLancamentoCabecalho.Count - 1 do
      begin
        with RegistroI200.New do
        begin
          NUM_LCTO := IntToStr(TContabilLancamentoCabecalhoVO(ListaLancamentoCabecalho.Items[i]).Id);
          DT_LCTO := TContabilLancamentoCabecalhoVO(ListaLancamentoCabecalho.Items[i]).DataLancamento;
          VL_LCTO := TContabilLancamentoCabecalhoVO(ListaLancamentoCabecalho.Items[i]).Valor;
          IND_LCTO := 'N';

          // REGISTRO I250: PARTIDAS DO LAN�AMENTO
          ListaLancamentoDetalhe := TT2TiORM.Consultar<TContabilLancamentoDetalheVO>('ID_CONTABIL_LANCAMENTO_CAB=' + NUM_LCTO, False);
          if assigned(ListaLancamentoDetalhe) then
          begin
            for j := 0 to ListaLancamentoDetalhe.Count - 1 do
            begin
              with RegistroI250.New do
              begin
                ContaContabil := TT2TiORM.ConsultarUmObjeto<TContabilContaVO>('ID=' + IntToStr(TContabilLancamentoDetalheVO(ListaLancamentoDetalhe.Items[i]).IdContabilConta), False);

                COD_CTA := ContaContabil.Classificacao;
                VL_DC := TContabilLancamentoDetalheVO(ListaLancamentoDetalhe.Items[i]).Valor;
                IND_DC := TContabilLancamentoDetalheVO(ListaLancamentoDetalhe.Items[i]).Tipo;
                COD_HIST_PAD := IntToStr(TContabilLancamentoDetalheVO(ListaLancamentoDetalhe.Items[i]).IdContabilHistorico);
                HIST := TContabilLancamentoDetalheVO(ListaLancamentoDetalhe.Items[i]).Historico;
              end;
            end;
          end;
        end;
      end;
    end;

    // REGISTRO I300: BALANCETES DI�RIOS � IDENTIFICA��O DA DATA
    // REGISTRO I310: DETALHES DO BALANCETE DI�RIO
    { Implementados a crit�rio do Participante do T2Ti ERP }

    // REGISTRO I350: SALDOS DAS CONTAS DE RESULTADO ANTES DO ENCERRAMENTO � IDENTIFICA��O DA DATA
    // REGISTRO I355: DETALHES DOS SALDOS DAS CONTAS DE RESULTADO ANTES DO ENCERRAMENTO
    { Implementados a crit�rio do Participante do T2Ti ERP }

    // REGISTRO I500: PAR�METROS DE IMPRESS�O E VISUALIZA��O DO LIVRO RAZ�O AUXILIAR COM LEIAUTE PARAMETRIZ�VEL
    // REGISTRO I510: DEFINI��O DE CAMPOS DO LIVRO RAZ�O AUXILIAR COM LEIAUTE PARAMETRIZ�VEL
    // REGISTRO I550: DETALHES DO LIVRO AUXILIAR COM LEIAUTE PARAMETRIZ�VEL
    // REGISTRO I555: TOTAIS NO LIVRO AUXILIAR COM LEIAUTE PARAMETRIZ�VEL
    { Implementados a crit�rio do Participante do T2Ti ERP }
  end;
end;
{$ENDREGION}

{$REGION 'Bloco J - Demonstra��es Cont�beis'}
procedure TSpedContabilController.GerarBlocoJ;
var
  i: Integer;
  ContabilLivro: TContabilLivroVO;
  TermoLivro: TContabilTermoVO;
  RegistroCartorio: TRegistroCartorioVO;
  ListaDreDetalhe: TObjectList<TContabilDreDetalheVO>;
  Contador: TContadorVO;
begin
  FDataModule.ACBrSpedContabil.Bloco_J.LimpaRegistros;

  with FDataModule.ACBrSpedContabil.Bloco_J do
  begin
    // REGISTRO J001: ABERTURA DO BLOCO J
    RegistroJ001.IND_DAD := 0;

    // REGISTRO J005: DEMONSTRA��ES CONT�BEIS
    { Implementado a crit�rio do Participante do T2Ti ERP }

    // REGISTRO J100: BALAN�O PATRIMONIAL
    { Implementado a crit�rio do Participante do T2Ti ERP }

    //REGISTRO J150: DEMONSTRA��O DO RESULTADO DO EXERC�CIO
    { Implementado a crit�rio do Participante do T2Ti ERP }
    ListaDreDetalhe := TT2TiORM.Consultar<TContabilDreDetalheVO>('ID>0', False);
    if assigned(ListaDreDetalhe) then
    begin
      for i := 0 to ListaDreDetalhe.Count - 1 do
      begin
      end;
    end;

    // REGISTRO J200: TABELA DE HIST�RICO DE FATOS CONT�BEIS QUE MODIFICAM A CONTA LUCROS ACUMULADOS OU A CONTA PREJU�ZOS ACUMULADOS OU TODO O PATRIM�NIO L�QUIDO
    // REGISTRO J210: DLPA � DEMONSTRA��O DE LUCROS OU PREJU�ZOS ACUMULADOS/DMPL � DEMONSTRA��O DE MUTA��ES DO PATRIM�NIO L�QUIDO
    // REGISTRO J215: FATO CONT�BIL QUE ALTERA A CONTA LUCROS ACUMULADOS OU A CONTA PREJU�ZOS ACUMULADOS OU TODO O PATRIM�NIO L�QUIDO
    { Implementados a crit�rio do Participante do T2Ti ERP }

    // REGISTRO J310: DEMONSTRA��O DO FLUXO DE CAIXA
    { Implementado a crit�rio do Participante do T2Ti ERP }

    // REGISTRO J410: DEMONSTRA��O DO VALOR ADICIONADO
    { Implementado a crit�rio do Participante do T2Ti ERP }

    // REGISTRO J800: OUTRAS INFORMA��ES
    { Implementado a crit�rio do Participante do T2Ti ERP }

    // REGISTRO J900: TERMO DE ENCERRAMENTO
    ContabilLivro := TT2TiORM.ConsultarUmObjeto<TContabilLivroVO>('FORMA_ESCRITURACAO = ' + QuotedStr(EscrituracaoForma) +  ' and COMPETENCIA=' + QuotedStr(FormatDateTime('MM/YYYY', TextoParaData(DataInicial))), False);
    if Assigned(ContabilLivro) then
    begin
      TermoLivro := TT2TiORM.ConsultarUmObjeto<TContabilTermoVO>('ID_CONTABIL_LIVRO=' + IntToStr(ContabilLivro.Id) + ' and ABERTURA_ENCERRAMENTO=' + QuotedStr('E'), False);
      RegistroCartorio := TT2TiORM.ConsultarUmObjeto<TRegistroCartorioVO>('ID_EMPRESA=' + IntToStr(Sessao(SessaoAtual).IdEmpresa), False);

      with RegistroJ900 do
      begin
        NUM_ORD := TermoLivro.NumeroRegistro;
        NAT_LIVRO := ContabilLivro.Descricao;
        QTD_LIN := FDataModule.ACBrSpedContabil.Bloco_9.Registro9999.QTD_LIN;
        NOME := Empresa.RazaoSocial;
        DT_INI_ESCR := TermoLivro.EscrituracaoInicio;
        DT_FIN_ESCR := TermoLivro.EscrituracaoFim;
      end;
    end;

    // REGISTRO J930: IDENTIFICA��O DOS SIGNAT�RIOS DA ESCRITURA��O
    Contador := TT2TiORM.ConsultarUmObjeto<TContadorVO>('ID=1', True);
    with RegistroJ930.New do
    begin
      IDENT_NOM := Contador.PessoaNome;
      IDENT_CPF := Contador.PessoaVO.PessoaFisicaVO.Cpf;
      IDENT_QUALIF := 'Contador';
      COD_ASSIN := '900';
      IND_CRC := Contador.InscricaoCrc;
    end;
  end;
end;
{$ENDREGION}

{$REGION 'Gerar Arquivo'}
function TSpedContabilController.GerarArquivoSpedContabil: Boolean;
begin
  Result := False;
  try
    with FDataModule.ACBrSpedContabil do
    begin
      DT_INI := TextoParaData(DataInicial);
      DT_FIN := TextoParaData(DataFinal);
    end;

    GerarBloco0;
    GerarBlocoI;
    GerarBlocoJ;

    Arquivo := 'SpedContabil' + FormatDateTime('DDMMYYYYhhmmss', Now) + '.txt';

    FDataModule.ACBrSPEDContabil.Path := ExtractFilePath(Application.ExeName) + 'Arquivos\Sped\';
    FDataModule.ACBrSpedContabil.SaveFileTXT(Arquivo);

    Result := True;
  except
    Result := False;
  end;
end;
{$ENDREGION}

{$ENDREGION}

end.
