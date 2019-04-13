{*******************************************************************************
Title: T2Ti ERP                                                                 
Description: Controller do lado Servidor relacionado � tabela [TRANSPORTADORA] 
                                                                                
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
unit TransportadoraController;

interface

uses
  Classes, SQLExpr, SysUtils, Generics.Collections, Controller, DBXJSON, DBXCommon;

type
  TTransportadoraController = class(TController)
  protected
  public
    // consultar
    function Transportadora(pSessao: String; pFiltro: String; pPagina: Integer): TJSONArray;
    // inserir
    function AcceptTransportadora(pSessao: String; pObjeto: TJSONValue): TJSONArray;
    // alterar
    function UpdateTransportadora(pSessao: String; pObjeto: TJSONValue): TJSONArray;
    // excluir
    function CancelTransportadora(pSessao: String; pId: Integer): TJSONArray;
  end;

implementation

uses
  TransportadoraVO, T2TiORM, SA;

{ TTransportadoraController }

var
  objTransportadora: TTransportadoraVO;
  Resultado: Boolean;

function TTransportadoraController.Transportadora(pSessao, pFiltro: String; pPagina: Integer): TJSONArray;
begin
  Result := TJSONArray.Create;
  try
    if Pos('ID=', pFiltro) > 0 then
      Result := TT2TiORM.Consultar<TTransportadoraVO>(pFiltro, pPagina, True)
    else
      Result := TT2TiORM.Consultar<TTransportadoraVO>(pFiltro, pPagina, False);
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

function TTransportadoraController.AcceptTransportadora(pSessao: String; pObjeto: TJSONValue): TJSONArray;
var
  UltimoID: Integer;
begin
  objTransportadora := TTransportadoraVO.Create(pObjeto);
  Result := TJSONArray.Create;
  try
    try
      UltimoID := TT2TiORM.Inserir(objTransportadora);
      Result := Transportadora(pSessao, 'ID = ' + IntToStr(UltimoID), 0);
    except
      on E: Exception do
      begin
        Result.AddElement(TJSOnString.Create('ERRO'));
        Result.AddElement(TJSOnString.Create(E.Message));
      end;
    end;
  finally
    objTransportadora.Free;
  end;
end;

function TTransportadoraController.UpdateTransportadora(pSessao: String; pObjeto: TJSONValue): TJSONArray;
var
  objTransportadoraOld: TTransportadoraVO;
begin
  // Objeto Novo
  objTransportadora := TTransportadoraVO.Create((pObjeto as TJSONArray).Get(0));
  // Objeto Antigo
  objTransportadoraOld := TTransportadoraVO.Create((pObjeto as TJSONArray).Get(1));
  Result := TJSONArray.Create;
  try
    // Verifica se houve altera��es no objeto principal
    if objTransportadora.MainObject.ToJSONString <> objTransportadoraOld.MainObject.ToJSONString then
    begin
    try
      Resultado := TT2TiORM.Alterar(objTransportadora, objTransportadoraOld);
    except
      on E: Exception do
      begin
        Result.AddElement(TJSOnString.Create('ERRO'));
        Result.AddElement(TJSOnString.Create(E.Message));
      end;
     end;
    end;
  finally
    if Resultado then
    begin
      Result.AddElement(TJSONTrue.Create);
    end;
    objTransportadora.Free;
  end;
end;

function TTransportadoraController.CancelTransportadora(pSessao: String; pId: Integer): TJSONArray;
begin
  objTransportadora := TTransportadoraVO.Create;
  Result := TJSONArray.Create;
  try
    objTransportadora.Id := pId;
    try
      Resultado := TT2TiORM.Excluir(objTransportadora);
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
    objTransportadora.Free;
  end;
end;

end.
