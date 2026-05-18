xmlport 67008 "UTT O9Inventory-KPI"
{
    Caption = 'UTT O9 Inventory KPI';
    Format = VariableText;
    Direction = Export;
    TextEncoding = UTF8;
    UseRequestPage = false;
    FileName = 'IVMK_Inventory-KPI.dsv';
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
                textelement(MatNumberLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        MatNumberLbl := 'Mat Number';
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
                        CurrSnapShotDateLbl := 'Current Snapshot Date';
                    end;
                }

                textelement(Unr_InventoryLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        Unr_InventoryLbl := 'Unrestricted Inventory';
                    end;
                }
                textelement(UOM_UnreInvLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        UOM_UnreInvLbl := 'UOM of Unrestricted Inventory';
                    end;
                }
                textelement(res_InventoryLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        res_InventoryLbl := 'Restricted Inventory';
                    end;
                }
                textelement(UOM_ResInvLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        UOM_ResInvLbl := 'UOM of Restricted Inventory';
                    end;
                }

            }
            tableelement(ItemLedgEntry; "Item Ledger Entry")
            {
                XmlName = 'ItemLedgEntry';
                // SourceTableView = sorting("No.") WHERE("KVSTEX Item Type" = filter("Finished Product" | "yarn"));
                RequestFilterFields = "Item No.";

                textelement(Matl_Number)

                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        Matl_Number :=ItemLedgEntry."Item No."

                    end;
                }

                fieldelement(Location; ItemLedgEntry."Location Code")
                {
                }
                textelement(CurrSnapShotDate)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        CurrSnapShotDate := format(WorkDate(), 0, '<year4>/<month,2>/<day,2>')

                    end;

                }
                textelement(Unr_Inventory)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        clear(Unr_Inventory);
                        if not QtyisRestruct then
                            Unr_Inventory := format(ItemLedgEntry."Remaining Quantity")
                        else
                            Unr_Inventory := Format('0');


                    end;

                }
                fieldelement(UOM_UnreInv; ItemLedgEntry."Unit of Measure Code")
                {
                }
                textelement(res_Inventory)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        clear(res_Inventory);
                        if QtyisRestruct then
                            res_Inventory := format(ItemLedgEntry."Remaining Quantity")
                        else
                            res_Inventory := Format('0');


                    end;

                }
                fieldelement(UOM_ResInv; ItemLedgEntry."Unit of Measure Code")
                {
                }



                trigger OnPreXmlItem()
                var
                    myInt: Integer;
                begin

                    ItemLedgEntry.Setfilter("KVSTEX Item Type", '%1|%2', ItemLedgEntry."KVSTEX Item Type"::"Finished Product", ItemLedgEntry."KVSTEX Item Type"::"KVS Cutset");
                    ItemLedgEntry.Setfilter("Remaining Quantity", '>%1', 0);
                    //ItemLedgEntry.SetRange("Item No.", '36107');
                    //ItemLedgEntry.SetRange("Location Code",'39');
                    //ItemLedgEntry.SetRange("Location Code", 'FERTIGWARE');
                end;

                trigger OnAfterGetRecord()
                var
                    ItemLoc: Record Item;
                begin
                    Clear(Plant);
                    CompanyInfo.get();
                    case CompanyInfo."Country/Region Code" of
                        'DE':
                            Plant := 'IVMK';
                        'MX':
                            Plant := 'IVMP';

                    end;



                    itemLoc.get(ItemLedgEntry."Item No.");
                    if itemloc."KVSTEX Item Status" <> itemloc."KVSTEX Item Status"::Certified then
                        currXMLport.Break();

                    ItemLedgEntry.CalcFields("KVSTEX Bin Code");
                    if (ItemLedgEntry."KVSTEX Bin Code" <> 'STANDARD') then
                        QtyisRestruct := true
                    else
                        QtyisRestruct := false;
                end;

            }

        }


    }
    var
        QtyisRestruct: Boolean;
        CompanyInfo: Record "Company Information";
        Plant: text;

}
