xmlport 67027 "UTT O9InCoTerm"
{
    Caption = 'UTT O9IncoTerm';
    Format = VariableText;
    Direction = Export;
    TextEncoding = UTF8;
    UseRequestPage = false;
    FileName = 'IVMK_IncoTerm.csv';
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
                textelement(MaterialDescLbl)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        MaterialDescLbl := 'MaterialDescription';
                        IBPO9Buffer."Field 2" := MaterialDescLbl;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(QualityLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        QualityLbl := 'Quality';
                        IBPO9Buffer."Field 3" := QualityLbl;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(FromLocationCodeLbl)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        FromLocationCodeLbl := 'FromLocationCode';
                        IBPO9Buffer."Field 4" := FromLocationCodeLbl;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(ShipToLbl)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        ShipToLbl := 'ShipTo';
                        IBPO9Buffer."Field 5" := ShipToLbl;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(SoldToLbl)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        SoldToLbl := 'SoldTo';
                        IBPO9Buffer."Field 6" := SoldToLbl;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(TransmodeCodeLbl)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        TransmodeCodeLbl := 'TransmodeCode';
                        IBPO9Buffer."Field 7" := TransmodeCodeLbl;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(TransmodeDescriptionLbl)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        TransmodeDescriptionLbl := 'TransmodeDescription';
                        IBPO9Buffer."Field 8" := TransmodeDescriptionLbl;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(LeadTimeLbl)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        LeadTimeLbl := 'LeadTime';
                        IBPO9Buffer."Field 9" := LeadTimeLbl;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(IncotermLbl)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        IncotermLbl := 'Incoterm';
                        IBPO9Buffer."Field 10" := IncotermLbl;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(InvoiceDatedefinitionLbl)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        InvoiceDatedefinitionLbl := 'InvoiceDatedefinition';
                        IBPO9Buffer."Field 11" := InvoiceDatedefinitionLbl;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(InventoryStorageTypeLbl)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        InventoryStorageTypeLbl := 'InventoryStorageType';
                        IBPO9Buffer."Field 12" := InventoryStorageTypeLbl;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(IncotermsPlaceLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        IncotermsPlaceLbl := 'IncotermsPlace';
                        IBPO9Buffer."Field 13" := IncotermsPlaceLbl;
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
                    IBPO9Buffer."Export Batch ID" := o9ProjectLib.GetCurrentXMLPortName(67027);
                    IBPO9Buffer.Insert();
                end;
            }

            tableelement(SIV; "UTT SalesBuffer")
            {
                XmlName = 'o9SalesActual';
                textelement(Material)
                {
                    trigger OnBeforePassVariable()
                    begin
                        Material := siv."Artikelnr.";
                        IBPO9Buffer."Field 1" := Material;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(MaterialDescription)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        MaterialDescription := ItemRec.Description;
                        IBPO9Buffer."Field 2" := MaterialDescription;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(Quality)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        Quality := 'Standard';
                        IBPO9Buffer."Field 3" := Quality;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(FromLocationCode)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        if CompanyInfo."Country/Region Code" = 'DE' then
                            FromLocationCode := 'IVMK';
                        if CompanyInfo."Country/Region Code" = 'MX' then
                            FromLocationCode := 'IVMP';
                        IBPO9Buffer."Field 4" := FromLocationCode;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(ShiptoID)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        ShiptoID := siv.Debitor;
                        IBPO9Buffer."Field 5" := ShiptoID;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(SoldtoID)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        SoldtoID := siv.Debitor;
                        IBPO9Buffer."Field 6" := SoldtoID;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(TransmodeCode)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                        Customer: Record Customer;
                    begin
                        Customer.get(siv.Debitor);
                        if CompanyInfo."Country/Region Code" = 'DE' then
                            if Customer."Gen. Bus. Posting Group" in ['INLAND', 'EU'] then
                                TransmodeCode := 'Truck'
                            else
                                TransmodeCode := 'Ship';
                        if CompanyInfo."Country/Region Code" = 'MX' then
                            if Customer."No." = '10025' then
                                TransmodeCode := 'Ship'
                            else
                                TransmodeCode := 'Truck';
                        IBPO9Buffer."Field 7" := TransmodeCode;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(TransmodeDescription)
                {
                    trigger OnBeforePassVariable()
                    begin
                        TransmodeDescription := TransmodeCode;
                        IBPO9Buffer."Field 8" := TransmodeDescription;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(LeadTime)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        if siv.Incoterm in ['AAA', 'CAC', 'EXW', 'EXWA', 'EXWE', 'EXWK', 'FCA', 'FCA TTOP'] then
                            LeadTime := '1'
                        else
                            LeadTime := '5';
                        IBPO9Buffer."Field 9" := LeadTime;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(Incoterm)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        Incoterm := siv.incoterm;
                        IBPO9Buffer."Field 10" := Incoterm;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(InvoiceDatedefinition)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        if siv.Incoterm in ['AAA', 'CAC', 'EXW', 'EXWA', 'EXWE', 'EXWK', 'FCA', 'FCA TTOP'] then
                            if siv.Debitor in ['17031', '17237', '18064', '10002', '10013'] then
                                InvoiceDatedefinition := 'Consumption date'
                            else
                                InvoiceDatedefinition := 'Goods Issue date';
                        IBPO9Buffer."Field 11" := InvoiceDatedefinition;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(InventoryStorageType)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        if siv.Debitor in ['17031', '17237', '18064', '10002', '10013'] then
                            InventoryStorageType := 'Consignment'
                        else
                            InventoryStorageType := 'Regular';
                        IBPO9Buffer."Field 12" := InventoryStorageType;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(IncotermsPlace)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        IncotermsPlace := siv.City;
                        IBPO9Buffer."Field 13" := IncotermsPlace;
                        IBPO9Buffer.Modify();
                    end;
                }

                trigger OnPreXmlItem()
                var
                    myInt: Integer;
                begin
                    CompanyInfo.get();
                end;

                trigger OnAfterGetRecord()
                var
    EntryNo: Integer;
                    myInt: Integer;
                begin
                    ItemRec.get(SIV."Artikelnr.");

                     EntryNo:= IBPO9Buffer.getNextEntry();
                    IBPO9Buffer.Init(); 
                    IBPO9Buffer."Entry No.":= EntryNo;
                    IBPO9Buffer."Export Date" := CurrentDateTime();
                    IBPO9Buffer."Export Batch ID" := O9ProjectLib.GetCurrentXMLPortName(67027);
                    IBPO9Buffer.Insert();
                end;
            }
        }
    }

    procedure SetDataItem(PSIV: Record "UTT SalesBuffer")
    begin
        SIV := PSIV;
    end;

    var
        CompanyInfo: Record "Company Information";
        ItemRec: Record Item;
        IBPO9Buffer: Record "UTT IBPO9 Buffer";
        O9ProjectLib: Codeunit "UTT O9 Project Lib";
}
