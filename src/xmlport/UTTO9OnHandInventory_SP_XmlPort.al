xmlport 67030 "UTT O9OnHandInventory_SP"
{
    Caption = 'UTT O9OnHandInventory_SP';
    Format = VariableText;
    Direction = Export;
    TextEncoding = UTF8;
    UseRequestPage = false;
    FileName = 'IVMK_O9OnHandInventory_SP.dsv';
    TableSeparator = '<NewLine>';
    FieldSeparator = '|';

    schema
    {
        textelement(Root)
        {
            tableelement(Header; Integer)
            {
                XmlName = 'Header';
                SourceTableView = SORTING(Number) WHERE(Number = CONST(1));
                textelement(MatNumberLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        MatNumberLbl := 'MatlNumber';
                        IBPO9Buffer."Field 1" := MatNumberLbl;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(LocationLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        LocationLbl := 'LocationCode';
                        IBPO9Buffer."Field 2" := LocationLbl;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(CurrSnapShotDateLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        CurrSnapShotDateLbl := 'CurrentSnapShotDate';
                        IBPO9Buffer."Field 3" := CurrSnapShotDateLbl;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(QualityLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        QualityLbl := 'Quality';
                        IBPO9Buffer."Field 4" := QualityLbl;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(LotIDLbl)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        LotIDLbl := 'LotID';
                        IBPO9Buffer."Field 5" := LotIDLbl;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(MatDescLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        MatDescLbl := 'MaterialDescription';
                        IBPO9Buffer."Field 6" := MatDescLbl;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(Unr_InventoryLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        Unr_InventoryLbl := 'UnrestrictedInventory';
                        IBPO9Buffer."Field 7" := Unr_InventoryLbl;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(UOMUnr_InventoryLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        UOMUnr_InventoryLbl := 'UoMUnrestrictedInventory';
                        IBPO9Buffer."Field 8" := UOMUnr_InventoryLbl;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(QAQuantityLbl)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        QAQuantityLbl := 'QAQuantity';
                        IBPO9Buffer."Field 9" := QAQuantityLbl;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(UOMQAQuantityLbl)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        UOMQAQuantityLbl := 'UoMQAQuantity';
                        IBPO9Buffer."Field 10" := UOMQAQuantityLbl;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(BlockedQuantityLbl)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        BlockedQuantityLbl := 'BlockedQuantity';
                        IBPO9Buffer."Field 11" := BlockedQuantityLbl;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(UOMBlockedQuantityLbl)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        UOMBlockedQuantityLbl := 'UoMBlockedQuantity';
                        IBPO9Buffer."Field 12" := UOMBlockedQuantityLbl;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(SalesOrdeLineIDLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        SalesOrdeLineIDLbl := 'SalesOrdeLineID';
                        IBPO9Buffer."Field 13" := SalesOrdeLineIDLbl;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(QAExpectedDeliveryDateLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        QAExpectedDeliveryDateLbl := 'QAExpectedDeliveryDate';
                        IBPO9Buffer."Field 14" := QAExpectedDeliveryDateLbl;
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
                    IBPO9Buffer."Export Batch ID" := 'ONHANDINV_SP';
                    IBPO9Buffer.Insert();
                end;
            }

            tableelement(TempItemLedgEntry; "Item Ledger Entry")
            {
                UseTemporary = true;

                textelement(Matl_Number)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        Matl_Number := TempItemLedgEntry."Item No.";
                        IBPO9Buffer."Field 1" := Matl_Number;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(Location)
                {
                    trigger OnBeforePassVariable()
                    begin
                        clear(Location);
                        case CompanyInfo."Country/Region Code" of
                            'DE':
                                Location := 'IVMK';
                            'MX':
                                Location := 'IVMP';
                        end;
                        IBPO9Buffer."Field 2" := Location;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(CurrentSnapshotDate)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        CurrentSnapshotDate := format(WorkDate(), 0, '<year4>/<month,2>/<day,2>');
                        IBPO9Buffer."Field 3" := CurrentSnapshotDate;
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
                        IBPO9Buffer."Field 4" := Quality;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(LotID)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        LotID := TempItemLedgEntry."Lot No.";
                        IBPO9Buffer."Field 5" := LotID;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(MatDesc)
                {
                    trigger OnBeforePassVariable()
                    var
                        ItemLoc: Record Item;
                    begin
                        itemloc.get(TempItemLedgEntry."Item No.");
                        MatDesc := ItemLoc.Description;
                        IBPO9Buffer."Field 6" := MatDesc;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(TotalUnResInventory_)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        clear(TotalUnResInventory_);
                        TotalUnResInventory_ := format(TempItemLedgEntry."Remaining Quantity", 0, 9);
                        IBPO9Buffer."Field 7" := TotalUnResInventory_;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(UOMTotalUnResInventory_)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        clear(UOMTotalUnResInventory_);
                        UOMTotalUnResInventory_ := TempItemLedgEntry."Unit of Measure Code";
                        IBPO9Buffer."Field 8" := UOMTotalUnResInventory_;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(QAQuantity)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        QAQuantity := format(0, 0, 9);
                        IBPO9Buffer."Field 9" := QAQuantity;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(UoMQAQuantity)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        UoMQAQuantity := TempItemLedgEntry."Unit of Measure Code";
                        IBPO9Buffer."Field 10" := UoMQAQuantity;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(BlockedQuantity)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        Clear(BlockedQuantity);
                        BlockedQuantity := format(TempItemLedgEntry."Invoiced Quantity", 0, 9);
                        IBPO9Buffer."Field 11" := BlockedQuantity;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(UoMBlockedQuantity)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        Clear(UoMBlockedQuantity);
                        UoMBlockedQuantity := TempItemLedgEntry."Unit of Measure Code";
                        IBPO9Buffer."Field 12" := UoMBlockedQuantity;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(SalesOrdeLineID)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        SalesOrdeLineID := '';
                        IBPO9Buffer."Field 13" := SalesOrdeLineID;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(QAExpectedDate)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        QAExpectedDate := 'N/A';
                        IBPO9Buffer."Field 14" := QAExpectedDate;
                        IBPO9Buffer.Modify();
                    end;
                }

                trigger OnPreXmlItem()
                var
                    myInt: Integer;
                begin
                end;

                trigger OnAfterGetRecord()
                var
    EntryNo: Integer;
                    myInt: Integer;
                begin
                    Clear(Plant);
                    CompanyInfo.get();
                    case CompanyInfo."Country/Region Code" of
                        'DE':
                            Plant := 'IVMK';
                        'MX':
                            Plant := 'IVMP';
                    end;

                     EntryNo:= IBPO9Buffer.getNextEntry();
                    IBPO9Buffer.Init(); 
                    IBPO9Buffer."Entry No.":= EntryNo;
                    IBPO9Buffer."Export Date" := CurrentDateTime();
                    IBPO9Buffer."Export Batch ID" := 'ONHANDINV_SP';
                    IBPO9Buffer.Insert();
                end;
            }
        }
    }

    var
        ItemLedgEntry: Record "Item Ledger Entry";
        CurrentItemNo: Code[20];
        CurrentLocation: Code[10];
        TotalUnrInventory: Decimal;
        TotalResInventory: Decimal;
        UnrestrictedUOM: Text[10];
        RestrictedUOM: Text[10];
        isRestricted: Boolean;
        IBPO9Buffer: Record "UTT IBPO9 Buffer";

    trigger OnPreXmlPort()
    begin
        GroupAndCalculateInventory();
        companyInfo.get();
    end;

    local procedure GroupAndCalculateInventory()
    var
    begin
        TempItemLedgEntry.DeleteAll();

        // Load data into temporary storage grouped by Item No.
        ItemLedgEntry.Reset();
        ItemLedgEntry.SetCurrentKey("Entry No.");
        ItemLedgEntry.SetFilter("Location Code", '<>%1&<>%2&<>%3&<>%4&<>%5', 'ERSATZTEIL', 'REFACCIONE', 'REVISTA', 'MAGAZIN', 'PRODUCION');
        ItemLedgEntry.SetFilter("Remaining Quantity", '>%1', 0);
        if ItemLedgEntry.FindSet() then
            repeat
                Clear(ItemLedgEntry."KVS Assigned Quantity");

                // Find or create grouped item in temporary table
                TempItemLedgEntry.Reset();
                TempItemLedgEntry.SetRange("Item No.", ItemLedgEntry."Item No.");
                TempItemLedgEntry.SetRange("Lot No.", ItemLedgEntry."Lot No.");
                // ItemLedgEntry.SetFilter("KVS Gen. Prod. Posting Group", '<>%1&<>%2&<>%3&<>%4&<>%5&<>%6', 'OPW LAMFOL', 'SILIKON', 'SON BETRST', 'YARN', 'EKA', 'HILO');
                if not TempItemLedgEntry.FindFirst() then begin
                    Clear(TempItemLedgEntry);
                    TempItemLedgEntry.Init();
                    TempItemLedgEntry := ItemLedgEntry;
                    TempItemLedgEntry."KVS Assigned Quantity" := 0;
                    TempItemLedgEntry."Remaining Quantity" := 0;
                    TempItemLedgEntry."Invoiced Quantity" := 0;
                    if not excludeItems(ItemLedgEntry."Item No.") then
                        TempItemLedgEntry.Insert();
                end;
                ItemLedgEntry.CalcFields("KVSTEX Bin Code");
                case ItemLedgEntry."KVSTEX Bin Code" of
                    'STANDARD', '':
                        TempItemLedgEntry."Remaining Quantity" += Round(ItemLedgEntry."Remaining Quantity", 0.0001); // Unrestricted Qty
                    else
                        TempItemLedgEntry."Invoiced Quantity" += Round(ItemLedgEntry."Remaining Quantity", 0.0001); // blocked Restricted  Qty
                                                                                                                    // else
                                                                                                                    //     TempItemLedgEntry."KVS Assigned Quantity" += Round(ItemLedgEntry."Remaining Quantity", 0.0001); // QS Restricted  Qty
                end;
                if TempItemLedgEntry.Modify() then;;
            until ItemLedgEntry.Next() = 0;
    end;

    local procedure excludeItems(ItemNo: Code[20]): Boolean
    var
        Item: Record Item;
        PolymerNA: Boolean;
    begin
        if item.get(ItemNo) then begin
            if (item."KVSTEX Item Type" = item."KVSTEX Item Type"::Standard) then
                if item."KVSTEX Composition Key Total" = '' then
                    if item."Gen. Prod. Posting Group" in ['OPW LAMFOL', 'SILIKON', 'SON BETRST', 'YARN', 'EKA', 'HILO'] then
                        exit(false)
                    else
                        exit(true);
        end;
    end;

    var
        companyInfo: Record "Company Information";
        Plant: text;
}
