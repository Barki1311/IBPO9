xmlport 67004 "UTT O9UOMConversion"
{
    Caption = 'UTT O9UOMConversion';
    Format = VariableText;
    Direction = Export;
    TextEncoding = UTF8;
    UseRequestPage = false;
    FileName = 'IVMK_UOMConversion.dsv';
    TableSeparator = '<NewLine>';
    FieldSeparator = '|';
    schema
    {
        textelement(Root)
        {
            tableelement(Integer; Integer)
            {
                XmlName = 'Header';
                SourceTableView = SORTING(Number) WHERE(Number = CONST(1));
                textelement(Matl_NumberLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        Matl_NumberLbl := 'MatlNumber';
                        IBPO9Buffer."Field 1" := Matl_NumberLbl;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(From_UnitLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        From_UnitLbl := 'FromUnit';
                        IBPO9Buffer."Field 2" := From_UnitLbl;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(To_UnitLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        To_UnitLbl := 'ToUnit';
                        IBPO9Buffer."Field 3" := To_UnitLbl;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(FactorLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        FactorLbl := 'Factor';
                        IBPO9Buffer."Field 4" := FactorLbl;
                        IBPO9Buffer.Modify();
                    end;
                }

                trigger OnAfterGetRecord()
                var
                    EntryNo: Integer;
                begin
                    EntryNo := IBPO9Buffer.getNextEntry();
                    IBPO9Buffer.Init();
                    IBPO9Buffer."Entry No." := EntryNo;
                    IBPO9Buffer."Export Date" := CurrentDateTime();
                    IBPO9Buffer."Export Batch ID" := o9ProjectLib.GetCurrentXMLPortName(67004);
                    IBPO9Buffer.Insert();
                end;
            }

            tableelement(Item; Item)
            {
                XmlName = 'ItemDim';
                RequestFilterFields = "No.";
                textelement(Matl_Number)
                {
                    trigger OnBeforePassVariable()
                    begin
                        Matl_Number := Item."No.";
                        IBPO9Buffer."Field 1" := Matl_Number;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(From_Unit)
                {
                    trigger OnBeforePassVariable()
                    begin
                        From_Unit := Item."Base Unit of Measure";
                        IBPO9Buffer."Field 2" := From_Unit;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(TO_Unit)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        TO_Unit := 'KG';
                        IBPO9Buffer."Field 3" := TO_Unit;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(Factor)
                {
                    trigger OnBeforePassVariable()
                    begin
                        if item."Base Unit of Measure" = 'KG' then
                            Factor := '1'
                        else
                            Factor := format(item."Net Weight", 0, 9);
                        IBPO9Buffer."Field 4" := Factor;
                        IBPO9Buffer.Modify();
                    end;
                }

                trigger OnAfterGetRecord()
                var
                    ItemledEntry: Record "Item Ledger Entry";
                    PolymerNA: Boolean;
                    EntryNo: Integer;
                begin
                    if (item."KVSTEX Item Type" = item."KVSTEX Item Type"::Standard) then
                        if item."KVSTEX Composition Key Total" = '' then
                            if item."Gen. Prod. Posting Group" in ['OPW LAMFOL', 'SILIKON', 'SON BETRST', 'YARN', 'EKA', 'HILO'] then
                                PolymerNA := true
                            else
                                currXMLport.skip;

                    if item."Base Unit of Measure" = '' then
                        currXMLport.Skip();

                    Clear(Plant);
                    CompanyInfo.get();
                    case CompanyInfo."Country/Region Code" of
                        'DE':
                            Plant := 'IVMK';
                        'MX':
                            Plant := 'IVMP';
                    end;

                    EntryNo := IBPO9Buffer.getNextEntry();
                    IBPO9Buffer.Init();
                    IBPO9Buffer."Entry No." := EntryNo;
                    IBPO9Buffer."Export Date" := CurrentDateTime();
                    IBPO9Buffer."Export Batch ID" := o9ProjectLib.GetCurrentXMLPortName(67004);
                    IBPO9Buffer.Insert();
                end;

                trigger OnPreXmlItem()
                var
                    myInt: Integer;
                begin
                    item.SetFilter("KVS Default Location Code", '<>%1&<>%2&<>%3&<>%4&<>%5', 'ERSATZTEIL', 'REFACCIONE', 'REVISTA', 'MAGAZIN', 'PRODUCION');
                    item.SetFilter("Net Weight", '>=%1', 0);
                end;
            }
        }
    }

    local procedure IsInBOMSalesExist(No: Code[20]): Boolean
    var
        BOMLine: Record "Production BOM Line";
        IsExist: Boolean;
        SalesLine: Record "Sales Line";
    begin
        BOMLine.SetRange("No.", No);
        if BOMLine.FindFirst then
            IsExist := true;
        SalesLine.SetRange("No.", No);
        if SalesLine.FindFirst then
            IsExist := true;
        exit(IsExist)
    end;

    var
        CompanyInfo: Record "Company Information";
        Plant: text;
        IBPO9Buffer: Record "UTT IBPO9 Buffer";
        o9ProjectLib: Codeunit "UTT O9 Project Lib";
}
