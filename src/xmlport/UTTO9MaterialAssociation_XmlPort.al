xmlport 67017 "UTT O9MaterialAssoc"
{
    Caption = 'UTT O9 MAterialAssoc';
    Format = VariableText;
    Direction = Export;
    TextEncoding = UTF8;
    UseRequestPage = false;
    FileName = 'IVMK_MaterialAsso.dsv';
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
                textelement(MaterialLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        MaterialLbl := 'Material';
                        IBPO9Buffer."Field 1" := MaterialLbl;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(LocationLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        LocationLbl := 'Location Code';
                        IBPO9Buffer."Field 2" := LocationLbl;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(MaterialAssociationLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        MaterialAssociationLbl := 'Material Association';
                        IBPO9Buffer."Field 3" := MaterialAssociationLbl;
                        IBPO9Buffer.Modify();
                    end;
                }

                trigger OnAfterGetRecord()
var
    EntryNo: Integer;
                begin
                      EntryNo:= IBPO9Buffer.getNextEntry();
                    IBPO9Buffer.Init(); 
                    IBPO9Buffer."Entry No.":= EntryNo;
                    IBPO9Buffer."Export Date" := CurrentDateTime();
                    IBPO9Buffer."Export Batch ID" := o9ProjectLib.GetCurrentXMLPortName(67017);
                    IBPO9Buffer.Insert();
                end;
            }

            tableelement(Item; Item)
            {
                XmlName = 'ItemDim';
                RequestFilterFields = "No.";
                textelement(Materia) 
                {
                    trigger OnBeforePassVariable()
                    begin
                        Materia := Item."No.";
                        IBPO9Buffer."Field 1" := Materia;
                        IBPO9Buffer.Modify();
                    end;
                 }
                textelement(LocationCode)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        case CompanyInfo."Country/Region Code" of
                            'DE':
                                LocationCode := 'IVMK';
                            'MX':
                                LocationCode := 'IVMP';
                        end;
                        IBPO9Buffer."Field 2" := LocationCode;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(MatAssoc)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        MatAssoc := '1';
                        IBPO9Buffer."Field 3" := MatAssoc;
                        IBPO9Buffer.Modify();
                    end;
                }

                trigger OnAfterGetRecord()
                var
    EntryNo: Integer;
                    myInt: Integer;
                    ItemledEntry: Record "Item Ledger Entry";
                    PolymerNA: Boolean;
                begin
                    if (item."KVSTEX Item Type" = item."KVSTEX Item Type"::Standard) then
                        if item."KVSTEX Composition Key Total" = '' then
                            if item."Gen. Prod. Posting Group" in ['OPW LAMFOL', 'SILIKON', 'YARN', 'EKA', 'HILO'] then
                                PolymerNA := true
                            else
                                currXMLport.skip;

                    itemledEntry.SetCurrentKey("Item No.");
                    itemledEntry.SetRange("Item No.", item."No.");
                    if itemledEntry.IsEmpty then
                        currXMLport.skip;

                    EntryNo:= IBPO9Buffer.getNextEntry();
                    IBPO9Buffer.Init(); 
                    IBPO9Buffer."Entry No.":= EntryNo;
                    IBPO9Buffer."Export Date" := CurrentDateTime();
                    IBPO9Buffer."Export Batch ID" := o9ProjectLib.GetCurrentXMLPortName(67017);
                    IBPO9Buffer.Insert();
                end;

                trigger OnPreXmlItem()
                var
                    myInt: Integer;
                begin
                    item.SetFilter("KVS Default Location Code", '<>%1&<>%2&<>%3&<>%4&<>%5', 'ERSATZTEIL', 'REFACCIONE', 'REVISTA', 'MAGAZIN', 'PRODUCION');
                    companyInfo.get();
                end;
            }
        }
    }

    var
        companyInfo: Record "Company Information";
        IBPO9Buffer: Record "UTT IBPO9 Buffer";
        o9ProjectLib: Codeunit "UTT O9 Project Lib";
}
