xmlport 67026 "UTT O9 Pro"
{
    Caption = 'UTT O9 Pro';
    Format = VariableText;
    Direction = Export;
    TextEncoding = UTF8;
    UseRequestPage = false;
    FileName = 'IVMK_P_o9Pro.dsv';
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
                    begin
                        MaterialDescLbl := 'MaterialDescription';
                        IBPO9Buffer."Field 2" := MaterialDescLbl;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(LocationCodeLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        LocationCodeLbl := 'LocationCode';
                        IBPO9Buffer."Field 3" := LocationCodeLbl;
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
                textelement(OrderIDLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        OrderIDLbl := 'OrderID';
                        IBPO9Buffer."Field 5" := OrderIDLbl;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(OrderLineIdLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        OrderLineIdLbl := 'OrderLineId';
                        IBPO9Buffer."Field 6" := OrderLineIdLbl;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(BOMIDLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        BOMIDLbl := 'BOMID';
                        IBPO9Buffer."Field 7" := BOMIDLbl;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(BOMVerLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        BOMVerLbl := 'BOMVersion';
                        IBPO9Buffer."Field 8" := BOMVerLbl;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(RoutingIDLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        RoutingIDLbl := 'RoutingID';
                        IBPO9Buffer."Field 9" := RoutingIDLbl;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(PrODetailQuantityLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        PrODetailQuantityLbl := 'PrODetailQuantity';
                        IBPO9Buffer."Field 10" := PrODetailQuantityLbl;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(UoMPrODetailQuantityLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        UoMPrODetailQuantityLbl := 'UoMPrODetailQuantity';
                        IBPO9Buffer."Field 11" := UoMPrODetailQuantityLbl;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(PrODetailDeliveredQuantityLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        PrODetailDeliveredQuantityLbl := 'PrODetailDeliveredQuantity';
                        IBPO9Buffer."Field 12" := PrODetailDeliveredQuantityLbl;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(UoMPrODetailDeliveredQuantityLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        UoMPrODetailDeliveredQuantityLbl := 'UoMPrODetailDeliveredQuantity';
                        IBPO9Buffer."Field 13" := UoMPrODetailDeliveredQuantityLbl;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(PrOWIPOperationQuantityLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        PrOWIPOperationQuantityLbl := 'PrOWIPOperationQuantity';
                        IBPO9Buffer."Field 14" := PrOWIPOperationQuantityLbl;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(UoMPrOWIPOperationQuantityLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        UoMPrOWIPOperationQuantityLbl := 'UoMPrOWIPOperationQuantity';
                        IBPO9Buffer."Field 15" := UoMPrOWIPOperationQuantityLbl;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(PrODetailOpenQuantityLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        PrODetailOpenQuantityLbl := 'PrODetailOpenQuantity';
                        IBPO9Buffer."Field 16" := PrODetailOpenQuantityLbl;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(UoMPrODetailOpenQuantityLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        UoMPrODetailOpenQuantityLbl := 'UoMPrODetailOpenQuantity';
                        IBPO9Buffer."Field 17" := UoMPrODetailOpenQuantityLbl;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(PrOWIPDeliveryDateLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        PrOWIPDeliveryDateLbl := 'PrOWIPDeliveryDate';
                        IBPO9Buffer."Field 18" := PrOWIPDeliveryDateLbl;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(PrODetailFinishDateLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        PrODetailFinishDateLbl := 'PrODetailFinishDate';
                        IBPO9Buffer."Field 19" := PrODetailFinishDateLbl;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(PrODetailActualFinishDateLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        PrODetailActualFinishDateLbl := 'PrODetailActualFinishDate';
                        IBPO9Buffer."Field 20" := PrODetailActualFinishDateLbl;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(PrODetailStatusLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        PrODetailStatusLbl := 'PrODetailStatus';
                        IBPO9Buffer."Field 21" := PrODetailStatusLbl;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(SalesOrderLineIDLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        SalesOrderLineIDLbl := 'SalesOrderLineID';
                        IBPO9Buffer."Field 22" := SalesOrderLineIDLbl;
                        IBPO9Buffer.Modify();
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    IBPO9Buffer.Init();
                    if not IBPO9Buffer.FindLast() then
                        IBPO9Buffer."Entry No." := 1
                    else
                        IBPO9Buffer."Entry No." := IBPO9Buffer."Entry No." + 1;
                    IBPO9Buffer."Export Date" := CurrentDateTime();
                    IBPO9Buffer."Export Batch ID" := 'PRO';
                    IBPO9Buffer.Insert();
                end;
            }

            tableelement(ProdOrderLine; "Prod. Order Line")
            {
                XmlName = 'Data';
                RequestFilterFields = "Item No.";

                textelement(Material)
                {
                    trigger OnBeforePassVariable()
                    begin
                        Material := ProdOrderLine."Item No.";
                        IBPO9Buffer."Field 1" := Material;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(MaterialDesc)
                {
                    trigger OnBeforePassVariable()
                    var
                        ItemRec: Record Item;
                    begin
                        ItemRec.get(ProdOrderLine."Item No.");
                        MaterialDesc := ItemRec.Description;
                        IBPO9Buffer."Field 2" := MaterialDesc;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(LocationCode)
                {
                    trigger OnBeforePassVariable()
                    begin
                        if companyInfo."Country/Region Code" = 'DE' then
                            LocationCode := 'IVMK';
                        if companyInfo."Country/Region Code" = 'MX' then
                            locationCode := 'IVMP';
                        IBPO9Buffer."Field 3" := LocationCode;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(Quality)
                {
                    trigger OnBeforePassVariable()
                    begin
                        Quality := 'Standard';
                        IBPO9Buffer."Field 4" := Quality;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(OrderID)
                {
                    trigger OnBeforePassVariable()
                    begin
                        OrderID := ProdOrderLine."Prod. Order No.";
                        IBPO9Buffer."Field 5" := OrderID;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(OrderLineId)
                {
                    trigger OnBeforePassVariable()
                    begin
                        OrderLineId := format(prodorderline."Line No.", 0, 9);
                        IBPO9Buffer."Field 6" := OrderLineId;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(BOMID)
                {
                    trigger OnBeforePassVariable()
                    begin
                        BOMID := ProdOrderLine."Production BOM No.";
                        IBPO9Buffer."Field 7" := BOMID;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(BOMVersion)
                {
                    trigger OnBeforePassVariable()
                    begin
                        BOMVersion := ProdOrderLine."Production BOM Version Code";
                        if BomVersion = '' then
                            BomVersion := '1';
                        IBPO9Buffer."Field 8" := BOMVersion;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(RoutingID)
                {
                    trigger OnBeforePassVariable()
                    begin
                        RoutingID := ProdOrderLine."Routing No.";
                        IBPO9Buffer."Field 9" := RoutingID;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(PrODetailQuantity)
                {
                    trigger OnBeforePassVariable()
                    begin
                        PrODetailQuantity := format(ProdOrderLine.quantity, 0, 9);
                        IBPO9Buffer."Field 10" := PrODetailQuantity;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(UoMPrODetailQuantity)
                {
                    trigger OnBeforePassVariable()
                    begin
                        UoMPrODetailQuantity := ProdOrderLine."Unit of Measure Code";
                        IBPO9Buffer."Field 11" := UoMPrODetailQuantity;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(PrODetailDeliveredQuantity)
                {
                    trigger OnBeforePassVariable()
                    begin
                        PrODetailDeliveredQuantity := format(prodorderline."Finished Quantity", 0, 9);
                        IBPO9Buffer."Field 12" := PrODetailDeliveredQuantity;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(UoMPrODetailDeliveredQuantity)
                {
                    trigger OnBeforePassVariable()
                    begin
                        UoMPrODetailDeliveredQuantity := ProdOrderLine."Unit of Measure Code";
                        IBPO9Buffer."Field 13" := UoMPrODetailDeliveredQuantity;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(PrOWIPOperationQuantity)
                {
                    trigger OnBeforePassVariable()
                    begin
                        PrOWIPOperationQuantity := Format(StrSubstNo('%1', PrOWIPOperationQuantity), 0, 9);
                        IBPO9Buffer."Field 14" := PrOWIPOperationQuantity;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(UoMPrOWIPOperationQuantity)
                {
                    trigger OnBeforePassVariable()
                    begin
                        UoMPrOWIPOperationQuantity := ProdOrderLine."Unit of Measure Code";
                        IBPO9Buffer."Field 15" := UoMPrOWIPOperationQuantity;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(PrODetailOpenQuantity)
                {
                    trigger OnBeforePassVariable()
                    begin
                        PrODetailOpenQuantity := format(ProdOrderLine."Remaining Quantity", 0, 9);
                        IBPO9Buffer."Field 16" := PrODetailOpenQuantity;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(UoMPrODetailOpenQuantity)
                {
                    trigger OnBeforePassVariable()
                    begin
                        UoMPrODetailOpenQuantity := ProdOrderLine."Unit of Measure Code";
                        IBPO9Buffer."Field 17" := UoMPrODetailOpenQuantity;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(PrOWIPDeliveryDate)
                {
                    trigger OnBeforePassVariable()
                    begin
                        PrOWIPDeliveryDate := 'N/A';
                        IBPO9Buffer."Field 18" := PrOWIPDeliveryDate;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(PrODetailFinishDate)
                {
                    trigger OnBeforePassVariable()
                    begin
                        if ProdOrder."Due Date" <= Today then
                            ProdOrder."Due Date" := CalcDate('<+30D>', Today);
                        PrODetailFinishDate := format(ProdOrder."Due Date", 0, '<year4>/<month,2>/<day,2>');
                        IBPO9Buffer."Field 19" := PrODetailFinishDate;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(PrODetailActualFinishDate)
                {
                    trigger OnBeforePassVariable()
                    begin
                        PrODetailActualFinishDate := format(ItemLEdgerEntry."Posting Date", 0, '<year4>/<month,2>/<day,2>');
                        IBPO9Buffer."Field 20" := PrODetailActualFinishDate;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(PrODetailStatus)
                {
                    trigger OnBeforePassVariable()
                    begin
                        PrODetailStatus := PrODetailStatus;
                        IBPO9Buffer."Field 21" := PrODetailStatus;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(SalesOrderLineID)
                {
                    trigger OnBeforePassVariable()
                    begin
                        SalesOrderLineID := 'N/A';
                        IBPO9Buffer."Field 22" := SalesOrderLineID;
                        IBPO9Buffer.Modify();
                    end;
                }

                trigger OnPreXmlItem()
                var
                    myInt: Integer;
                begin
                    companyInfo.get();
                    ProdOrderLine.setrange(Status, ProdOrderLine.Status::Released);
                    ProdOrderLine.SetFilter("Production BOM No.", '<>%1', '');
                    ProdOrderLine.SetFilter("Routing No.", '<>%1', '');
                    ProdOrderLine.setrange(SystemCreatedAt, CreateDateTime(StartDate, 0T), CreateDateTime(EndDate, 0T));
                    ProdOrderLine.SetFilter(Quantity, '>%1', 0);
                end;

                trigger OnAfterGetRecord()
                var
                    ProdOrderComp: Record "Prod. Order Component";
                begin
                    if CalcProdVolume(ProdOrderLine) < 95 then
                        PrODetailStatus := 'open'
                    else
                        currXMLport.Skip();

                    Clear(PrOWIPOperationQuantity);
                    Clear(UoMPrOWIPOperationQuantity);
                    if not prodOrder.get(ProdOrderLine.Status, ProdOrderLine."Prod. Order No.") then
                        ProdOrder.init;

                    ItemLEdgerEntry.reset();
                    ItemLedgerEntry.SetCurrentKey("Lot No.");
                    ItemLedgerEntry.SetRange("Document No.", ProdOrderLine."Prod. Order No.");
                    ItemLedgerEntry.SetRange("Entry Type", ItemLedgerEntry."Entry Type"::Output);
                    if not ItemLEdgerEntry.FindLast() then
                        ItemLEdgerEntry.init;

                    ProdOrderComp.reset();
                    ProdOrderComp.SetRange("Prod. Order No.", ProdOrderLine."Prod. Order No.");
                    ProdOrderComp.SetRange("Prod. Order Line No.", ProdOrderLine."Line No.");
                    ProdOrderComp.SetFilter("Reserved Quantity", '>%1', 0);
                    if ProdOrderComp.FindFirst() then
                        ProdOrderComp.CalcFields("Reserved Quantity");

                    IBPO9Buffer.Init();
                    if not IBPO9Buffer.FindLast() then
                        IBPO9Buffer."Entry No." := 1
                    else
                        IBPO9Buffer."Entry No." := IBPO9Buffer."Entry No." + 1;
                    IBPO9Buffer."Export Date" := CurrentDateTime();
                    IBPO9Buffer."Export Batch ID" := 'PRO';
                    IBPO9Buffer.Insert();
                end;
            }
        }
    }

    procedure SetDataFilter(PStartDate: Date; PEndDate: Date)
    var
        myInt: Integer;
    begin
        StartDate := PStartDate;
        EndDate := PEndDate;
    end;

    local procedure CalcProdVolume(ProdOrderLine_: Record "Prod. Order Line"): Decimal
    begin
        exit((ProdOrderLine_."Finished Quantity" * 100) / ProdOrderLine_.Quantity);
    end;

    var
        companyInfo: Record "Company Information";
        ItemLEdgerEntry: record "Item Ledger Entry";
        ProdOrder: record "Production Order";
        StartDate: date;
        EndDate: Date;
        IBPO9Buffer: Record "UTT IBPO9 Buffer";
}
