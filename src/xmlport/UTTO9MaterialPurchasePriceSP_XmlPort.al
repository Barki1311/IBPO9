xmlport 67032 "UTT O9MaterialPurchasePrice_SP"
{
    Caption = 'UTT O9MaterialPurchasePrice_SP';
    Format = VariableText;
    Direction = Export;
    TextEncoding = UTF8;
    UseRequestPage = false;
    FileName = 'O9MaterialPurchasePrice_SP.dsv';
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
                textelement(MatDescLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        MatDescLbl := 'MaterialDescription';
                        IBPO9Buffer."Field 2" := MatDescLbl;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(QualityLbl)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        QualityLbl := 'Quality';
                        IBPO9Buffer."Field 3" := QualityLbl;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(BaseUOMLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        BaseUOMLbl := 'BaseUOM';
                        IBPO9Buffer."Field 4" := BaseUOMLbl;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(LocationCodeLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        LocationCodeLbl := 'LocationCode';
                        IBPO9Buffer."Field 5" := LocationCodeLbl;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(MaterialPurchasePriceLbl)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        MaterialPurchasePriceLbl := 'MaterialPurchasePrice';
                        IBPO9Buffer."Field 6" := MaterialPurchasePriceLbl;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(CurrencyMaterialPurchasePriceLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        CurrencyMaterialPurchasePriceLbl := 'CurrencyMaterialPurchasePrice';
                        IBPO9Buffer."Field 7" := CurrencyMaterialPurchasePriceLbl;
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
                    IBPO9Buffer."Export Batch ID" := o9ProjectLib.GetCurrentXMLPortName(67032);
                    IBPO9Buffer.Insert();
                end;
            }

            tableelement(Item; Item)
            {
                XmlName = 'ItemDim';
                RequestFilterFields = "No.";
                textelement(Material) 
                {
                    trigger OnBeforePassVariable()
                    begin
                        Material := item."No.";
                        IBPO9Buffer."Field 1" := Material;
                        IBPO9Buffer.Modify();
                    end;
                 }
                textelement(Material_Description)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        Material_Description := DelChr(item.Description, '=', '"');
                        IBPO9Buffer."Field 2" := Material_Description;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(Quality)
                {
                    trigger OnBeforePassVariable()
                    begin
                        Quality := 'Standard';
                        IBPO9Buffer."Field 3" := Quality;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(UOM) 
                {
                    trigger OnBeforePassVariable()
                    begin
                        UOM := item."Base Unit of Measure";
                        IBPO9Buffer."Field 4" := UOM;
                        IBPO9Buffer.Modify();
                    end;
                 }
                textelement(LocationCode)
                {
                    trigger OnBeforePassVariable()
                    var
                        CompanyInfo: Record "Company Information";
                    begin
                        CompanyInfo.get();
                        case CompanyInfo."Country/Region Code" of
                            'DE':
                                LocationCode := 'IVMK';
                            'MX':
                                LocationCode := 'IVMP';
                        end;
                        IBPO9Buffer."Field 5" := LocationCode;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(MaterialPurchasePrice)
                {
                    trigger OnBeforePassVariable()
                    begin
                        MaterialPurchasePrice := getPurchasePrice(Item."No.", PurchPrice, PurchUOM, PurchCurrency);
                        IBPO9Buffer."Field 6" := MaterialPurchasePrice;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(CurrencyMaterialPurchasePrice)
                {
                    trigger OnBeforePassVariable()
                    begin
                        CurrencyMaterialPurchasePrice := PurchCurrency;
                        IBPO9Buffer."Field 7" := CurrencyMaterialPurchasePrice;
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
                    IBPO9Buffer."Export Batch ID" := o9ProjectLib.GetCurrentXMLPortName(67032);
                    IBPO9Buffer.Insert();
                end;

                trigger OnPreXmlItem()
                var
                    myInt: Integer;
                begin
                    item.SetFilter("KVS Default Location Code", '<>%1&<>%2&<>%3&<>%4&<>%5', 'ERSATZTEIL', 'REFACCIONE', 'REVISTA', 'MAGAZIN', 'PRODUCION');
                    item.Setfilter("Unit Cost", '<>%1', 0);
                end;
            }
        }
    }

    local procedure getPurchasePrice(ItemNo: Code[20]; var PurchPrice: Decimal; var PurchUOM: Code[20]; var PurchCurrency: Code[20]): Variant
    var
        PurchasePrice: Record "Purchase Price";
    begin
        PurchasePrice.RESET;
        PurchasePrice.SETCURRENTKEY("Item No.", "Vendor No.", "Starting Date", "Currency Code", "Variant Code",
                                    "Unit of Measure Code", "Minimum Quantity");
        PurchasePrice.SETFILTER("Item No.", ItemNo);
        PurchasePrice.SETFILTER("Starting Date", '<=%1|%2', WORKDATE, 0D);
        PurchasePrice.SETFILTER("Ending Date", '>=%1|%2', WORKDATE, 0D);
        if PurchasePrice.FINDlast then begin
            PurchPrice := PurchasePrice."Direct Unit Cost";
            PurchUOM := PurchasePrice."Unit of Measure Code";
            PurchCurrency := PurchasePrice."Currency Code";
        end;
    end;

    var
        PurchPrice: Decimal;
        PurchUOM: Code[20];
        purchCurrency: code[20];
        IBPO9Buffer: Record "UTT IBPO9 Buffer";
        o9ProjectLib: Codeunit "UTT O9 Project Lib";
}
