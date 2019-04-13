{*******************************************************************************
Title: T2Ti ERP
Description: Unit para armazenas as constantes do sistema

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

@author Albert Eije (T2Ti.COM)   | Jose Rodrigues de Oliveira Junior
@version 1.1
*******************************************************************************}
unit LogImportacaoVO;

interface

type
  TLogImportacaoVO = class
  private
    FID: Integer;
    FDATA_IMPORTACAO: String;
    FHORA_IMPORTACAO: String;
    FLOG_ERRO: String;

  public
    property Id: Integer  read FID write FID;
    property DataImportacao: String  read FDATA_IMPORTACAO write FDATA_IMPORTACAO;
    property HoraImportacao: String  read FHORA_IMPORTACAO write FHORA_IMPORTACAO;
    property LogErro: String  read FLOG_ERRO write FLOG_ERRO;

  end;

implementation



end.

