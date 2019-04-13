{*******************************************************************************
Title: T2Ti ERP                                                                 
Description: Controller do lado Servidor relacionado � tabela [PATRIM_TAXA_DEPRECIACAO] 
                                                                                
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
                                                                                
@author Albert Eije (t2ti.com@gmail.com)                    
@version 1.0                                                                    
*******************************************************************************}
unit PatrimTaxaDepreciacaoController;

interface

uses
  Classes, SQLExpr, SysUtils, Generics.Collections, Controller, DBXJSON, DBXCommon;

type
  TPatrimTaxaDepreciacaoController = class(TController)
  protected
  public
    //consultar
    function PatrimTaxaDepreciacao(pSessao: String; pFiltro: String; pPagina: Integer): TJSONArray;
    //inserir
    function AcceptPatrimTaxaDepreciacao(pSessao: String; pObjeto: TJSONValue): TJSONArray;
    //alterar
    function UpdatePatrimTaxaDepreciacao(pSessao: String; pObjeto: TJSONValue): TJSONArray;
    //excluir
    function CancelPatrimTaxaDepreciacao(pSessao: String; pId: Integer): TJSONArray;
  end;

implementation

uses
  PatrimTaxaDepreciacaoVO, T2TiORM, SA;

{ TPatrimTaxaDepreciacaoController }

var
  objPatrimTaxaDepreciacao: TPatrimTaxaDepreciacaoVO;
  Resultado: Boolean;

function TPatrimTaxaDepreciacaoController.PatrimTaxaDepreciacao(pSessao, pFiltro: String; pPagina: Integer): TJSONArray;
begin
  Result := TJSONArray.Create;
  try
    Result := TT2TiORM.Consultar<TPatrimTaxaDepreciacaoVO>(pFiltro, pPagina);
  except
    on E: Exception do
    begin
      Result.AddElement(TJSOnString.Create('ERRO'));
      Result.AddElement(TJSOnString.Create(E.Message));
    end;
  end;
end;

function TPatrimTaxaDepreciacaoController.AcceptPatrimTaxaDepreciacao(pSessao: String; pObjeto: TJSONValue): TJSONArray;
var
  UltimoID:Integer;
begin
  objPatrimTaxaDepreciacao := TPatrimTaxaDepreciacaoVO.Create(pObjeto);
  Result := TJSONArray.Create;
  try
    try
      UltimoID := TT2TiORM.Inserir(objPatrimTaxaDepreciacao);
      Result := PatrimTaxaDepreciacao(pSessao, 'ID = ' + IntToStr(UltimoID), 0);
    except
      on E: Exception do
      begin
        Result.AddElement(TJSOnString.Create('ERRO'));
        Result.AddElement(TJSOnString.Create(E.Message));
      end;
    end;
  finally
    objPatrimTaxaDepreciacao.Free;
  end;
end;

function TPatrimTaxaDepreciacaoController.UpdatePatrimTaxaDepreciacao(pSessao: String; pObjeto: TJSONValue): TJSONArray;
begin
  objPatrimTaxaDepreciacao := TPatrimTaxaDepreciacaoVO.Create(pObjeto);
  Result := TJSONArray.Create;
  try
    try
      Resultado := TT2TiORM.Alterar(objPatrimTaxaDepreciacao);
    except
      on E: Exception do
      begin
        Result.AddElement(TJSOnString.Create('ERRO'));
        Result.AddElement(TJSOnString.Create(E.Message));
      end;
    end;
  finally
    if Resultado then
    begin
      Result.AddElement(TJSONTrue.Create);
    end;
    objPatrimTaxaDepreciacao.Free;
  end;
end;

function TPatrimTaxaDepreciacaoController.CancelPatrimTaxaDepreciacao(pSessao: String; pId: Integer): TJSONArray;
begin
  objPatrimTaxaDepreciacao := TPatrimTaxaDepreciacaoVO.Create;
  Result := TJSONArray.Create;
  try
    objPatrimTaxaDepreciacao.Id := pId;
    try
      Resultado := TT2TiORM.Excluir(objPatrimTaxaDepreciacao);
    except
      on E: Exception do
      begin
        Result.AddElement(TJSOnString.Create('ERRO'));
        Result.AddElement(TJSOnString.Create(E.Message));
      end;
    end;
  finally
    if Resultado then
    begin
      Result.AddElement(TJSONTrue.Create);
    end;
    objPatrimTaxaDepreciacao.Free;
  end;
end;

end.
