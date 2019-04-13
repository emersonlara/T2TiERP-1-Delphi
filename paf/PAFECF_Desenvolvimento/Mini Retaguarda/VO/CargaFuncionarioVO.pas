{*******************************************************************************
Title: T2Ti ERP                                                                 
Description:  VO  relacionado � tabela [CargaFuncionario]
                                                                                
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
                                                                                
@author  Marcos Leite
@version 1.0                                                                    
*******************************************************************************}
unit CargaFuncionarioVO;

interface

uses
  Atributos;

type
  [TEntity]
  [TTable('CARGA_FUNCIONARIO')]
  TCargaFuncionarioVO = class
  private
    FID: Integer;
    FNOME: String;
    FFONE1: String;
    FCELULAR: String;
    FEMAIL: String;
    FNIVEL_AUTORIZACAO_ECF: String;

  public 
    [TId('ID')]
    [TGeneratedValue('AUTO')]
    property Id: Integer  read FID write FID;
    [TColumn('NOME','Nome',ldGridLookup ,False)]
    property Nome: String  read FNOME write FNOME;
    [TColumn('FONE1','Fone1',ldGridLookup ,False)]
    property Fone1: String  read FFONE1 write FFONE1;
    [TColumn('CELULAR','Celular',ldGridLookup ,False)]
    property Celular: String  read FCELULAR write FCELULAR;
    [TColumn('EMAIL','Email',ldGridLookup ,False)]
    property Email: String  read FEMAIL write FEMAIL;
    [TColumn('NIVEL_AUTORIZACAO_ECF','Nivel Autorizacao Ecf',ldGridLookup ,False)]
    property NivelAutorizacaoEcf: String  read FNIVEL_AUTORIZACAO_ECF write FNIVEL_AUTORIZACAO_ECF;

  end;

implementation



end.
