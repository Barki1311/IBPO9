xmlport 67009 "UTT O9ItemInventory-KPI"
{
    Caption = 'UTT O9 Inventory KPI per Item';
    Format = VariableText;
    Direction = Export;
    TextEncoding = UTF8;
    UseRequestPage = false;
    FileName = 'IVMK_Inventory-KPI2.dsv';
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
                    end;
                }
                textelement(LocationLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        LocationLbl := 'Location';
                    end;
                }

                textelement(CurrSnapShotDateLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        CurrSnapShotDateLbl := 'CurrentSnapshotDate';
                    end;
                }
                textelement(QualityLbl)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        QualityLbl := 'Quality';

                    end;
                }
                textelement(LotIDLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        LotIDLbl := 'LotID';
                    end;
                }
                textelement(MaterialDescriptionLbl)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        MaterialDescriptionLbl:='MaterialDescription';
                        
                    end;
                }

                textelement(Unr_InventoryLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        Unr_InventoryLbl := 'UnrestrictedInventory';
                    end;
                }
                textelement(UOM_UnreInvLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        UOM_UnreInvLbl := 'UOMofUnrestrictedInventory';
                    end;
                }
               textelement(QAQuantityLbl)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        QAQuantityLbl := 'QAQuantity';

                    end;
                }
                 textelement(UOMQAQuantityLbl)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        UOMQAQuantityLbl := 'UoMQAQuantity';

                    end;
                }
                textelement(BlockedQuantityLbl)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        BlockedQuantityLbl := 'BlockedQuantity';

                    end;
                }
                 textelement(UOMBlockedQuantityLbl)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        UOMBlockedQuantityLbl := 'UoMBlockedQuantity';

                    end;
                }
                textelement(SalesOrdeLineIDLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        SalesOrdeLineIDLbl := 'SalesOrdeLineID';
                    end;
                }
                textelement(QAExpectedDeliveryDateLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        QAExpectedDeliveryDateLbl := 'QAExpectedDeliveryDate';
                    end;
                }


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
                    end;

                }

                textelement(CurrentSnapshotDate)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        CurrentSnapshotDate := format(WorkDate(), 0, '<year4>/<month,2>/<day,2>')

                    end;


                }
                textelement(Quality)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        Quality := 'Standard';

                    end;
                }
                  textelement(LotID)
                {
                    trigger OnBeforePassVariable()
                    begin
                        LotID := TempItemLedgEntry."Lot No.";
                    end;
                }
                textelement(MaterialDescription)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        MaterialDescription:=TempItemLedgEntry.Description
                        
                    end;
                }
                textelement(TotalUnResInventory_)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        clear(TotalUnResInventory_);
                        // if not isRestricted then
                        //     TotalUnResInventory_ := format(TempItemLedgEntry."Remaining Quantity")
                        // else
                        //     TotalResInventory_ := format(0);
                        TotalUnResInventory_ := format(TempItemLedgEntry."Remaining Quantity", 0, 9);

                    end;

                }
                textelement(UOM_Unrestricted_Inventory)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        // Clear(UOM_Unrestricted_Inventory);
                        // if not isRestricted then
                        //     UOM_Unrestricted_Inventory := format(TempItemLedgEntry."Unit of Measure Code")
                        // else
                        //     UOM_Unrestricted_Inventory := '';
                        UOM_Unrestricted_Inventory := TempItemLedgEntry."Unit of Measure Code";



                    end;

                }
                  textelement(QAQuantity)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        QAQuantity := format(0, 0, 9);

                    end;
                }
                  textelement(UoMQAQuantity)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        UoMQAQuantity := TempItemLedgEntry."Unit of Measure Code";

                    end;
                }


                textelement(BlockedQuantity)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        Clear(BlockedQuantity);
                        // if not isRestricted then
                        //     UOM_Unrestricted_Inventory := format(TempItemLedgEntry."Unit of Measure Code")
                        // els
                        //     UOM_Unrestricted_Inventory := '';
                        BlockedQuantity := format(TempItemLedgEntry."Invoiced Quantity", 0, 9);

                    end;

                }
                 textelement(UoMBlockedQuantity)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        Clear(UoMBlockedQuantity);
                        // if not isRestricted then
                        //     UOM_Unrestricted_Inventory := format(TempItemLedgEntry."Unit of Measure Code")
                        // els
                        //     UOM_Unrestricted_Inventory := '';
                        UoMBlockedQuantity := TempItemLedgEntry."Unit of Measure Code";

                    end;

                }
                textelement(SalesOrdeLineID)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin

                        SalesOrdeLineID := ''


                    end;
                }
                textelement(QAExpectedDate)

                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        // clear(UOM_Restricted_Inventory);
                        // if isRestricted then
                        //     UOM_Restricted_Inventory := format(TempItemLedgEntry."Unit of Measure Code")
                        // else
                        //     UOM_Restricted_Inventory := '';
                        QAExpectedDate := Format(calcdate('<2D>',WorkDate()), 0, '<year4>/<month,2>/<day,2>');
                        
                    end;
                }


                trigger OnPreXmlItem()
                var
                    myInt: Integer;
                begin
                    //integer.setrange(Number, 1, (TempItemLedgEntry.Count))

                end;

                trigger OnAfterGetRecord()
                var
                    myInt: Integer;
                begin
                    // if integer.Number = 1 then
                    //     TempItemLedgEntry.FINDFIRST
                    // else
                    //     TempItemLedgEntry.NEXT;

                    // TempItemLedgEntry.CalcFields("KVSTEX Bin Code");
                    // if TempItemLedgEntry."KVSTEX Bin Code" <> 'STANDARD' then
                    //     isRestricted := true
                    // else
                    //     isRestricted := false;

                    Clear(Plant);
                    CompanyInfo.get();
                    case CompanyInfo."Country/Region Code" of
                        'DE':
                            Plant := 'IVMK';
                        'MX':
                            Plant := 'IVMP';

                    end;





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
        //TempItemLedgEntry: Record "Item Ledger Entry" temporary;
        isRestricted: Boolean;

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
        ItemLedgEntry.SetFilter("KVSTEX Item Type", '%1|%2|%3',
            ItemLedgEntry."KVSTEX Item Type"::"Finished Product",
            ItemLedgEntry."KVSTEX Item Type"::"KVS Cutset",
            ItemLedgEntry."KVSTEX Item Type"::"KVS Colour Ribbon");

        ItemLedgEntry.SetFilter("Remaining Quantity", '>%1', 0);
        //ItemLedgEntry.SetRange("Item No.", '38581');

        if ItemLedgEntry.FindSet() then
            repeat
                Clear(ItemLedgEntry."KVS Assigned Quantity");

                // Find or create grouped item in temporary table
                TempItemLedgEntry.Reset();
                TempItemLedgEntry.SetRange("Item No.", ItemLedgEntry."Item No.");
                TempItemLedgEntry.SetRange("Lot No.", ItemLedgEntry."Lot No.");
                if not TempItemLedgEntry.FindFirst() then begin
                    Clear(TempItemLedgEntry);
                    TempItemLedgEntry.Init();
                    TempItemLedgEntry := ItemLedgEntry;
                    TempItemLedgEntry."KVS Assigned Quantity" := 0;
                    TempItemLedgEntry."Remaining Quantity" := 0;
                    TempItemLedgEntry."Invoiced Quantity" := 0;

                    TempItemLedgEntry.Insert();
                end;

                // Calculate Bin Code and update quantities
                ItemLedgEntry.CalcFields("KVSTEX Bin Code");
                case ItemLedgEntry."KVSTEX Bin Code" of
                    'STANDARD':
                        TempItemLedgEntry."Remaining Quantity" += Round(ItemLedgEntry."Remaining Quantity", 0.0001); // Unrestricted Qty
                    else
                        TempItemLedgEntry."Invoiced Quantity" += Round(ItemLedgEntry."Remaining Quantity", 0.0001); // blocked Restricted  Qty
                    // else
                    //     TempItemLedgEntry."KVS Assigned Quantity" += Round(ItemLedgEntry."Remaining Quantity", 0.0001); // QS Restricted  Qty
                end;
                TempItemLedgEntry.Modify();
            until ItemLedgEntry.Next() = 0;
    end;

    var
        companyInfo: Record "Company Information";
        Plant: text;
}
