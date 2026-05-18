report 67034 "UTT actualSales"
{
    // version Richter

    // utt
    // ..............................
    // 
    // 01   12.07.2019  bb   utt     neu erstellt
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'UTT Actual Sales', Comment = 'DEU=offene verlaufszahlen';
    Permissions = TableData "UTT SalesBuffer" = rimd,
                  TableData "KVS Target-Perf. Power BI" = rimd,
                  TableData "KVSExp.-Act. COS Entry" = rimd,
                  TableData "KVSCOSTurnoverEntry" = rimd;


    dataset
    {

        dataitem("Sales Line"; "Sales Line")
        {
            //DataItemLink = "Bill-to Customer No." = FIELD("No."), "Shortcut Dimension 1 Code" = FIELD("Global Dimension 1 Filter"), "Shortcut Dimension 2 Code" = FIELD("Global Dimension 2 Filter");
            DataItemTableView = SORTING("Document Type", "Bill-to Customer No.", "Currency Code") WHERE("Document Type" = FILTER(Order | "Blanket Order"), "Outstanding Quantity" = FILTER(<> 0), KVSFCYDeliveryScheduleNo = FILTER(= ''));
            RequestFilterFields = "Document No.", Type, "No.";

            trigger OnAfterGetRecord();
            var
                ItemLoc: Record Item;
                ItemSourceLoc: Code[20];
                HasBomLoc: Boolean;
                LSalesHeader: Record "Sales Header";
                LForcastAmount: Decimal;
                LCurrencyDate: Date;
                EntryNo: integer;
                CustomerLoc: record Customer;
                GeneralLedgerSetup: Record "General Ledger Setup";
            begin
                if ExcludeSalesLines then
                    CurrReport.BREAK;
                //startUTTRoe20070918
                SalesLineRahmenAuftrag.RESET;
                SalesLineRahmenAuftrag.SETRANGE("Blanket Order No.", "Document No.");
                SalesLineRahmenAuftrag.SETRANGE("Blanket Order Line No.", "Line No.");
                if SalesLineRahmenAuftrag.FIND('-') then
                    CurrReport.SKIP;
                //stopUTTRoe20070918

                LSalesHeader.GET("Sales Line"."Document Type", "Sales Line"."Document No.");
                CLEAR(LForcastAmount);
                LForcastAmount := "Outstanding Amount (LCY)" / (1 + "VAT %" / 100);
                if (LSalesHeader."Document Type" in [LSalesHeader."Document Type"::"Blanket Order"]) and
                   (LSalesHeader."Posting Date" = 0D)
                then
                    LCurrencyDate := WORKDATE
                else
                    LCurrencyDate := LSalesHeader."Posting Date";

                ExchangeLCYTFCR(36, "Document No.", LForcastAmount, LSalesHeader."Currency Code", NewCurrency,
                 LCurrencyDate);



                ItemLoc.GET("No.");
                // if itemloc."KVSTEX Item Status" <> itemloc."KVSTEX Item Status"::Certified then
                //     CurrReport.skip;

                EntryNo := SIVGetNextEntryNo();
                siv.reset();
                siv.INIT;
                siv.EntryNo := EntryNo;
                siv.User := USERID;
                siv."Artikelnr." := "No.";
                siv.Debitor := "Sell-to Customer No.";
                CustomerLoc.get("Sell-to Customer No.");
                siv."customer name" := customerloc."name";
                siv.Artikelkategorie := ItemLoc."Item Category Code";
                siv.Kostenträger := "Shortcut Dimension 2 Code";
                siv.Debitorengruppe := DefDim."Dimension Value Code";
                siv.Warenart := ItemLoc."KVSTEX Item Type";
                siv.Produktgruppe := ItemLoc."Item Category Code";
                siv.Produktbuchungsgruppe := ItemLoc."Gen. Prod. Posting Group";
                siv.Lagerbuchungsgruppe := ItemLoc."Inventory Posting Group";
                siv.Land := CustomerLoc."Country/Region Code";
                siv.Verkäufercode := CustomerLoc."Salesperson Code";
                siv.Beschreibung := ItemLoc.Description;
                siv.Einheit := ItemLoc."Base Unit of Measure";
                siv."Composition Key Total" := ItemLoc."KVSTEX Composition Key Total";
                siv."Forecast Amount" := LForcastAmount;
                siv.PaymentTherm := CustomerLoc."Payment Terms Code";
                siv.Incoterm := LSalesHeader."Shipment Method Code";
                if siv.Incoterm = '' then
                    siv.Incoterm := CustomerLoc."Shipment Method Code";
                siv.City := LSalesHeader."Ship-to City";
                if siv.City = '' then
                    siv.City := CustomerLoc."City";

                siv."Forecast Qty" := "Outstanding Quantity";
                siv."unit Price" := "Sales Line"."Unit Price";
                case ItemLoc."Base Unit of Measure" of
                    'M':
                        begin
                            siv."Forecast Meter" := Conversion(ItemLoc."No.", siv."Forecast Qty", ItemSourceLoc);
                            siv."Forecast Gesamt meter" := siv."Forecast Meter";
                        end;
                    'STK':
                        begin
                            siv."Forecast STK" := siv."Forecast Qty";
                            siv."Forecast STK-M" := Conversion(ItemLoc."No.", siv."Forecast Qty", ItemSourceLoc);
                            siv."Forecast Gesamt meter" := siv."Forecast STK-M";
                        end;
                    'QM':
                        begin
                            siv."Forecast QM" := siv."Forecast Qty";
                            siv."Forecast QM-M" := Conversion(ItemLoc."No.", siv."Forecast Qty", ItemSourceLoc);
                            siv."Forecast Gesamt meter" := siv."Forecast QM-M";
                        end;
                end;
                if ItemLoc."Base Unit of Measure" = 'KG' then
                    siv."Forecast KG" := siv."Forecast Qty"
                else
                    siv."Forecast KG" := siv."Forecast Qty" * ItemLoc."Net Weight";
                CalcYarnforcast(siv);
                siv."Entry Date" := "Sales Line"."Shipment Date";

                siv."document No." := "Sales Line"."Document No.";
                siv."DocLineNo." := format("Sales Line"."Line No.");
                if "Sales Line"."Location Code" <> '' then
                    siv."location Code" := "Sales Line"."Location Code"
                else
                    siv."location Code" := ItemLoc."KVS Default Location Code";
                siv.postingDate := LSalesHeader."Posting Date";
                if siv.postingDate = 0D then
                    siv.postingDate := "Sales Line"."Shipment Date";
                siv.OrderCreationDate := DT2Date("Sales Line".SystemCreatedAt);
                siv.OrderDate := LSalesHeader."Order Date";
                if siv.OrderDate = 0D then
                    siv.OrderDate := DT2Date(LSalesHeader.SystemCreatedAt);
                siv.modifiedAt := DT2Date(LSalesHeader.SystemModifiedAt);
                if siv.modifiedAt = 0D then
                    siv.modifiedAt := siv.OrderDate;
                siv.PromdisedDeliveryDate := "Sales Line"."Promised Delivery Date";
                if siv.PromdisedDeliveryDate = 0D then
                    siv.PromdisedDeliveryDate := "Sales Line"."Shipment Date";
                // siv.PlanedDeliveryDate := "Sales Line"."Planned Delivery Date";
                // if siv.PlanedDeliveryDate = 0D then
                siv.PlanedDeliveryDate := 0D;
                siv.OrderRequestedDate := LSalesHeader."Order Date";
                if siv.OrderRequestedDate = 0D then
                    siv.OrderRequestedDate := "Sales line"."Shipment Date";
                siv.ShipmentDate := "Sales Line"."Shipment Date";
                siv.QtyShipped := "Sales Line"."Quantity Shipped";
                siv.OustandingQty := "Sales Line"."Outstanding Quantity";
                siv.status := 'OPEN';
                // case LSalesHeader.Status of
                //     LSalesHeader.Status::Released:
                //         begin
                //             siv.status := 'Open';
                //         end
                //     else
                //         siv.status := 'Open';
                // end;
                //siv.OrderQty := "Sales Line"."KVSTEX Order Quantity";
                //if siv.OrderQty = 0 then
                siv.OrderQty := "Sales Line".Quantity;
                //siv.Invoice_Value := "Unit Price" * siv.QtyShipped;
                siv.Invoice_Value := siv.QtyShipped * siv."unit Price";
                siv.Currency := LSalesHeader."Currency Code";
                if siv.Currency = '' then begin
                    GeneralLedgerSetup.get();
                    siv.Currency := GeneralLedgerSetup."LCY Code";
                end;

                case LSalesHeader."Document Type" of
                    lsalesHeader."Document Type"::order:
                        siv.OrderType := 'SalesOrder';
                    lsalesHeader."Document Type"::"Blanket Order":
                        begin
                            siv.OrderType := 'Blanket Order';
                            clear(siv.postingDate);
                            clear(siv.Invoice_Value);

                        end;

                end;

                siv.INSERT;

                //end;

                //70000 Stückliste entfalten
                ItemLoc.GET("No.");
                if ItemLoc."Item Category Code" = 'SET' then begin
                    UnfoldCutsetLines("Sales Line", HasBomLoc);
                    if HasBomLoc then
                        siv.DELETE;
                end;
            end;

            trigger OnPreDataItem();
            var
                CompanyInfo: Record "Company Information";
                OrderCreationDate: date;
            begin
                SETFILTER("Document Type", '%1|%2', "Document Type"::Order, "Document Type"::"Blanket Order");
                SETRANGE(Type, Type::Item);
                SETFILTER("Outstanding Quantity", '>%1', 0);
                SetFilter("Unit Price", '>%1', 0);
                SETRANGE(KVSFCYDeliveryScheduleNo, '');
                //SETRANGE("Blanket Order No.",'');
                SETRANGE("Shipment Date", StartDate, EndDate);
                //SETRANGE("SystemCreatedAt", DT2Datetime(StartDate), DT2Datetime(EndDate));
                CompanyInfo.get();
                case CompanyInfo."Country/Region Code" of
                    'DE':
                        Setfilter("KVSTEX Item Type", '%1|%2|%3|%4', "KVSTEX Item Type"::"Finished Product", "KVSTEX Item Type"::Yarn, "KVSTEX Item Type"::"KVS Cutset", "KVStex Item Type"::"KVS Colour Ribbon");
                    'MX':
                        Setfilter("KVSTEX Item Type", '%1|%2|%3|%4|%5', "KVSTEX Item Type"::"Finished Product", "KVSTEX Item Type"::Yarn, "KVSTEX Item Type"::"KVS Cutset", "KVStex Item Type"::"KVS Colour Ribbon", "KVStex Item Type"::"Raw Commodity");
                end;

            end;
        }
        dataitem("Delivery Schedule Header"; "KVSFCYDeliverySchedHeader")
        {
            //DataItemLink = "Sell-to Customer No." = FIELD("No."), "Shortcut Dimension 1 Code" = FIELD("Global Dimension 1 Code"), "Shortcut Dimension 2 Code" = FIELD("Global Dimension 2 Code");
            DataItemTableView = SORTING("Document Type", "Sell-to Customer No.", "Ship-to Code", "Item No.", "Usage Code") WHERE(Status = CONST(Released));
            RequestFilterFields = "Sell-to Customer No.", "Item No.";
            RequestFilterHeading = 'Delivery Schedule Header', Comment = 'ENU = Delivery Schedule Header,ESM = Delivery Schedule Header,DEA = Lieferplan';

            trigger OnAfterGetRecord();
            var
                DeliveryScheduleLineBuffer: Record "KVSFCYDelScheduleLineBuffer" temporary;
                DelScheduleBufferEngine: Codeunit "KVSFCYDelScheduleBufferLib";
                VATPostingSetup: Record "VAT Posting Setup";
                ItemLoc: Record Item;
                LineNo: Integer;
                LocSalesOrderAmount: Decimal;
                VATValue: Decimal;
                ItemSourceLoc: Code[20];
                DelSchedHeader: Record "KVSFCYDeliverySchedHeader";
                LDeliveryPlanAmount: Decimal;
                EntryNo: integer;
                CustomerLoc: record customer;
                GeneralLedgerSetup: Record "General Ledger Setup";
                SalesPriceList: Record "Price List Line";

            begin
                if ExcludeDeliverySchedule then
                    CurrReport.BREAK;
                ;

                DelScheduleBufferEngine.FillBufferStandard(
                  DeliveryScheduleLineBuffer,
                  "No.",
                  false);

                DeliveryScheduleLineBuffer.RESET;
                DeliveryScheduleLineBuffer.SETFILTER("Outstanding Quantity", '>0');
                DeliveryScheduleLineBuffer.SETRANGE("Shipment Date", StartDate, EndDate);
                //DeliveryScheduleLineBuffer.SetRange(SystemCreatedAt, DT2Datetime(StartDate), DT2Datetime(EndDate));
                if DeliveryScheduleLineBuffer.FINDFIRST then
                    repeat
                        DelSchedHeader.GET(DelSchedHeader."Document Type"::"Delivery Schedule",
                            DeliveryScheduleLineBuffer."Delivery Schedule No.");

                        ItemLoc.GET(DelSchedHeader."Item No.");
                        // if itemloc."KVSTEX Item Status" <> itemloc."KVSTEX Item Status"::Certified then
                        //     CurrReport.skip;
                        EntryNo := SIVGetNextEntryNo();
                        siv.reset();
                        siv.INIT;
                        siv.EntryNo := EntryNo;
                        siv.User := USERID;
                        siv."Artikelnr." := DelSchedHeader."Item No.";
                        siv.Debitor := DelSchedHeader."Sell-to Customer No.";

                        siv.Artikelkategorie := ItemLoc."Item Category Code";
                        CustomerLoc.get(DelSchedHeader."Sell-to Customer No.");
                        siv.PaymentTherm := CustomerLoc."Payment Method Code";
                        siv."Customer name" := CustomerLoc.name;
                        siv.Kostenträger := DelSchedHeader."Shortcut Dimension 2 Code";
                        siv.Debitorengruppe := DefDim."Dimension Value Code";
                        siv.PaymentTherm := CustomerLoc."Payment Terms Code";
                        siv.Incoterm := CustomerLoc."Shipment Method Code";
                        if siv.Incoterm = '' then
                            siv.Incoterm := CustomerLoc."Shipment Method Code";
                        siv.City := DelSchedHeader."Ship-to City";
                        if siv.City = '' then
                            siv.City := CustomerLoc."City";
                        siv.Warenart := ItemLoc."KVSTEX Item Type";
                        siv.Produktgruppe := ItemLoc."Item Category Code";
                        siv.Produktbuchungsgruppe := ItemLoc."Gen. Prod. Posting Group";
                        siv.Lagerbuchungsgruppe := ItemLoc."Inventory Posting Group";
                        siv.Land := CustomerLoc."Country/Region Code";
                        siv.Verkäufercode := CustomerLoc."Salesperson Code";
                        siv.Beschreibung := ItemLoc.Description;
                        siv.Einheit := ItemLoc."Base Unit of Measure";
                        siv."Composition Key Total" := ItemLoc."KVSTEX Composition Key Total";
                        if VATPostingSetup.GET(CustomerLoc."VAT Bus. Posting Group", ItemLoc."VAT Prod. Posting Group") then
                            VATValue := VATPostingSetup."VAT %";
                        CLEAR(LDeliveryPlanAmount);
                        siv."unit Price" := DelSchedHeader."Unit Price (Last Release)";
                        if siv."unit Price" = 0 then begin
                            SalesPriceList.Reset();
                            SalesPriceList.setrange("Source No.", siv.Debitor);
                            SalesPriceList.SetRange("Asset No.", siv."Artikelnr.");
                            SalesPriceList.setfilter("Starting Date", '>=%1', siv.ShipmentDate);
                            SalesPriceList.setfilter("Ending Date", '<=%1', siv.ShipmentDate);
                            if SalesPriceList.FindLast() then
                                siv."Unit Price" := SalesPriceList."Unit Price"
                            else begin
                                SalesPriceList.SetRange("Starting Date");
                                SalesPriceList.SetRange("Ending Date");
                                if SalesPriceList.FindLast() then
                                    siv."Unit Price" := SalesPriceList."Unit Price"
                            end;
                        end;


                        LDeliveryPlanAmount := DeliveryScheduleLineBuffer."Outstanding Quantity" * siv."Unit Price";

                        ExchangeLCYTFCR(5030054, DeliveryScheduleLineBuffer."Delivery Schedule No.",
                          LDeliveryPlanAmount,
                          DelSchedHeader."Currency Code (Last Release)",
                          NewCurrency,
                          WORKDATE);
                        siv."Forecast Amount" := LDeliveryPlanAmount;

                        //siv."Forecast Amount"  += siv."Forecast Amount"  +
                        //          (DeliveryScheduleLineBuffer."Outstanding Quantity" * "Unit Price (Last Release)") ;
                        //   //(1 + (VATValue/100) );
                        siv."Forecast Qty" := DeliveryScheduleLineBuffer."Outstanding Quantity";
                        CalcYarnforcast(siv);
                        case ItemLoc."Base Unit of Measure" of
                            'M':
                                begin
                                    siv."Forecast Meter" := Conversion(ItemLoc."No.", siv."Forecast Qty", ItemSourceLoc);
                                    siv."Forecast Gesamt meter" := siv."Forecast Meter";
                                end;
                            'STK':
                                begin
                                    siv."Forecast STK" := siv."Forecast Qty";
                                    siv."Forecast STK-M" := Conversion(ItemLoc."No.", siv."Forecast Qty", ItemSourceLoc);
                                    siv."Forecast Gesamt meter" := siv."Forecast STK-M";
                                end;
                            'QM':
                                begin
                                    siv."Forecast QM" := siv."Forecast Qty";
                                    siv."Forecast QM-M" := Conversion(ItemLoc."No.", siv."Forecast Qty", ItemSourceLoc);
                                    siv."Forecast Gesamt meter" := siv."Forecast QM-M";
                                end;
                        end;
                        if ItemLoc."Base Unit of Measure" = 'KG' then
                            siv."Forecast KG" := siv."Forecast Qty"
                        else
                            siv."Forecast KG" := siv."Forecast Qty" * ItemLoc."Net Weight";
                        siv."Entry Date" := DeliveryScheduleLineBuffer."Shipment Date";

                        siv."document No." := DeliveryScheduleLineBuffer."Delivery Schedule No.";
                        siv."DocLineNo." := format(DeliveryScheduleLineBuffer."Delivery Schedule Entry No.");
                        if DelSchedHeader."Location Code" <> '' then
                            siv."location Code" := DelSchedHeader."Location Code"
                        else
                            siv."location Code" := ItemLoc."KVS Default Location Code";

                        //siv.postingDate := DeliveryScheduleLineBuffer."Shipment Date";
                        siv.OrderCreationDate := DelSchedHeader."KVS Release Order Date";

                        siv.OrderDate := DelSchedHeader."KVS Release Order Date";

                        siv.modifiedAt := DT2Date(DelSchedHeader.SystemModifiedAt);
                        if siv.modifiedAt = 0D then
                            siv.modifiedAt := siv.OrderDate;
                        // siv.PlanedDeliveryDate := DeliveryScheduleLineBuffer."Planned Shipment Date";
                        // if siv.PlanedDeliveryDate = 0D then
                        siv.PlanedDeliveryDate := 0D;
                        siv.ShipmentDate := DeliveryScheduleLineBuffer."Shipment Date";
                        //siv.OrderRequestedDate := DelSchedHeader."KVS Release Order Date";
                        //if siv.OrderRequestedDate = 0D then
                        siv.OrderRequestedDate := DeliveryScheduleLineBuffer."Shipment Date";
                        siv.QtyShipped := DeliveryScheduleLineBuffer."Quantity Shipped";
                        siv.OustandingQty := DeliveryScheduleLineBuffer."Outstanding Quantity";
                        if siv.PromdisedDeliveryDate = 0D then
                            siv.PromdisedDeliveryDate := DeliveryScheduleLineBuffer."Shipment Date";
                        siv.status := 'OPEN';

                        // case DelSchedHeader.Status of
                        //     DelSchedHeader.Status::Released:
                        //         begin
                        //             siv.status := 'C';
                        //         end
                        //     else
                        //         siv.status := 'O';
                        // end;
                        siv.OrderQty := DeliveryScheduleLineBuffer.Quantity;

                        //siv.Invoice_Value := DelSchedHeader."Unit Price (Last Release)" * siv.QtyShipped;




                        //siv.Invoice_Value := siv.QtyShipped * siv."unit Price";
                        siv.Currency := DelSchedHeader."Currency Code (Last Release)";
                        if siv.Currency = '' then begin
                            GeneralLedgerSetup.get();
                            siv.Currency := GeneralLedgerSetup."LCY Code";
                        end;
                        siv.OrderType := 'DeliverySchedule';



                        siv.INSERT;

                    until DeliveryScheduleLineBuffer.NEXT = 0;
            end;

            trigger OnPreDataItem()
            var
                myInt: Integer;
                CompanyInfo: Record "Company Information";
            begin
                CompanyInfo.get();
                case CompanyInfo."Country/Region Code" of
                    'DE':
                        Setfilter("KVS Item Type", '%1|%2|%3|%4', "KVSTEX Item Type"::"Finished Product", "KVSTEX Item Type"::Yarn, "KVSTEX Item Type"::"KVS Cutset", "KVSTEX Item Type"::"KVS Colour Ribbon");
                    //setrange("Order No.",'DA24-10624');
                    'MX':
                        Setfilter("KVS Item Type", '%1|%2|%3|%4|%5', "KVSTEX Item Type"::"Finished Product", "KVSTEX Item Type"::Yarn, "KVSTEX Item Type"::"KVS Cutset", "KVSTEX Item Type"::"KVS Colour Ribbon", "KVSTEX Item Type"::"Raw Commodity");
                //setrange("Order No.",'DA24-10624');
                end;

            end;

        }


        //######bb 2025
        dataitem("SalesShptLine"; "Sales Shipment Line")
        {
            //DataItemLink = "Bill-to Customer No." = FIELD("No."), "Shortcut Dimension 1 Code" = FIELD("Global Dimension 1 Filter"), "Shortcut Dimension 2 Code" = FIELD("Global Dimension 2 Filter");
            DataItemTableView = SORTING("Bill-to Customer No.", "Currency Code");
            RequestFilterFields = "Document No.", Type, "No.";

            trigger OnAfterGetRecord();
            var
                ItemLoc: Record Item;
                ItemSourceLoc: Code[20];
                HasBomLoc: Boolean;
                LSalesShptHeader: Record "Sales shipment Header";
                LForcastAmount: Decimal;
                LCurrencyDate: Date;
                EntryNo: integer;
                CustomerLoc: record Customer;
                GeneralLedgerSetup: Record "General Ledger Setup";
                SalesOrderLine: Record "Sales line";
                SalesOrderLineArch: Record "Sales Line Archive";
            begin

                LSalesShptHeader.get(SalesShptLine."Document No.");





                ItemLoc.GET("No.");
                // if itemloc."KVSTEX Item Status" <> itemloc."KVSTEX Item Status"::Certified then
                //     CurrReport.skip;
                EntryNo := SIVGetNextEntryNo();
                siv.reset();
                siv.INIT;
                siv.EntryNo := EntryNo;
                siv.User := USERID;
                siv."Artikelnr." := "No.";
                siv.Debitor := "Sell-to Customer No.";
                CustomerLoc.get("Sell-to Customer No.");
                siv."customer name" := CopyStr(CustomerLoc."name", 1, StrLen(siv."Customer Name"));
                siv.PaymentTherm := LSalesShptHeader."Payment Method Code";
                siv.Incoterm := LSalesShptHeader."Shipment Method Code";
                if siv.Incoterm = '' then
                    siv.Incoterm := CustomerLoc."Shipment Method Code";
                siv.City := LSalesShptHeader."Ship-to City";
                if siv.City = '' then
                    siv.City := CustomerLoc."City";
                siv.Artikelkategorie := ItemLoc."Item Category Code";
                siv.Kostenträger := "Shortcut Dimension 2 Code";
                siv.Debitorengruppe := DefDim."Dimension Value Code";
                siv.Warenart := ItemLoc."KVSTEX Item Type";
                siv.Produktgruppe := ItemLoc."Item Category Code";
                siv.Produktbuchungsgruppe := ItemLoc."Gen. Prod. Posting Group";
                siv.Lagerbuchungsgruppe := ItemLoc."Inventory Posting Group";
                siv.Land := CustomerLoc."Country/Region Code";
                siv.Verkäufercode := CustomerLoc."Salesperson Code";
                siv.Beschreibung := ItemLoc.Description;
                siv.Einheit := ItemLoc."Base Unit of Measure";
                siv."Composition Key Total" := ItemLoc."KVSTEX Composition Key Total";
                CLEAR(LForcastAmount);
                LForcastAmount := SalesShptLine."Unit Price" * SalesShptLine.Quantity;
                siv."Forecast Amount" := LForcastAmount;

                siv."Forecast Qty" := "Quantity";
                siv."unit Price" := "SalesShptLine"."Unit Price";

                case ItemLoc."Base Unit of Measure" of
                    'M':
                        begin
                            siv."Forecast Meter" := Conversion(ItemLoc."No.", siv."Forecast Qty", ItemSourceLoc);
                            siv."Forecast Gesamt meter" := siv."Forecast Meter";
                        end;
                    'STK':
                        begin
                            siv."Forecast STK" := siv."Forecast Qty";
                            siv."Forecast STK-M" := Conversion(ItemLoc."No.", siv."Forecast Qty", ItemSourceLoc);
                            siv."Forecast Gesamt meter" := siv."Forecast STK-M";
                        end;
                    'QM':
                        begin
                            siv."Forecast QM" := siv."Forecast Qty";
                            siv."Forecast QM-M" := Conversion(ItemLoc."No.", siv."Forecast Qty", ItemSourceLoc);
                            siv."Forecast Gesamt meter" := siv."Forecast QM-M";
                        end;
                end;
                if ItemLoc."Base Unit of Measure" = 'KG' then
                    siv."Forecast KG" := siv."Forecast Qty"
                else
                    siv."Forecast KG" := siv."Forecast Qty" * ItemLoc."Net Weight";
                CalcYarnforcast(siv);
                siv."Entry Date" := "SalesShptLine"."Shipment Date";


                if SalesShptLine."Order No." <> '' then
                    siv."document No." := SalesShptLine."Order No."
                else
                    siv."document No." := SalesShptLine."Document No.";

                siv."DocLineNo." := StrSubstNo('%1-%2', "Document No.", "Line No.");
                siv.PaymentTherm := LSalesShptHeader."Payment Terms Code";
                siv.Incoterm := LSalesShptHeader."Shipment Method Code";
                if siv.Incoterm = '' then
                    siv.Incoterm := CustomerLoc."Shipment Method Code";
                siv.City := LSalesShptHeader."Ship-to City";
                if siv.City = '' then
                    siv.City := CustomerLoc."City";
                siv."location Code" := "SalesShptLine"."Location Code";
                siv.postingDate := LSalesShptHeader."Posting Date";
                siv.OrderCreationDate := DT2Date(LSalesShptHeader.SystemCreatedAt);
                siv.OrderDate := LSalesShptHeader."Order Date";
                if SalesOrderLine.get(SalesOrderLine."Document Type"::Order, SalesShptLine."Order No.", SalesShptLine."Order Line No.") then begin
                    siv.modifiedAt := DT2Date(SalesOrderLine.SystemCreatedAt);
                    if siv.modifiedAt = 0D then
                        siv.modifiedAt := SalesOrderLine."Posting Date";
                    siv.PromdisedDeliveryDate := "SalesOrderLine"."Promised Delivery Date";
                    if siv.PromdisedDeliveryDate = 0D then
                        siv.PromdisedDeliveryDate := SalesOrderLine."Shipment Date";
                    // siv.PlanedDeliveryDate := "SalesOrderLine"."Promised Delivery Date";
                    // if siv.PlanedDeliveryDate = 0D then
                    siv.PlanedDeliveryDate := SalesOrderLine."Posting Date";
                    //siv.OrderRequestedDate := LSalesShptHeader."Order Date";
                    //if siv.OrderRequestedDate = 0D then
                    siv.OrderRequestedDate := SalesOrderLine."Planned Shipment Date";
                end else begin
                    SalesOrderLineArch.SetRange("Document Type", SalesOrderLineArch."Document Type"::Order);
                    SalesOrderLineArch.SetRange("Document No.", SalesShptLine."Order No.");
                    SalesOrderLineArch.SetRange("Line No.", SalesShptLine."Order Line No.");
                    if SalesOrderLineArch.FindLast() then begin
                        siv.modifiedAt := DT2Date(SalesOrderLineArch.SystemCreatedAt);
                        if siv.modifiedAt = 0D then
                            siv.modifiedAt := LSalesShptHeader."Posting Date";
                        siv.PromdisedDeliveryDate := "SalesOrderLineArch"."Promised Delivery Date";
                        if siv.PromdisedDeliveryDate = 0D then
                            siv.PromdisedDeliveryDate := SalesOrderLineArch."Shipment Date";
                        //siv.PlanedDeliveryDate := "SalesOrderLineArch"."Promised Delivery Date";
                        //if siv.PlanedDeliveryDate = 0D then
                        siv.PlanedDeliveryDate := SalesOrderLine."Posting Date";
                        siv.OrderRequestedDate := LSalesShptHeader."Order Date";
                        if siv.OrderRequestedDate = 0D then
                            siv.OrderRequestedDate := SalesOrderLineArch."Planned Shipment Date";
                    end;


                end;



                // siv.modifiedAt := DT2Date(LSalesShptHeader.SystemModifiedAt);
                // if siv.modifiedAt = 0D then
                //     siv.modifiedAt := siv.OrderDate;
                // siv.PromdisedDeliveryDate := "SalesShptLine"."Promised Delivery Date";
                // if siv.PromdisedDeliveryDate = 0D then
                //     siv.PromdisedDeliveryDate := SalesShptLine."Shipment Date";
                // siv.PlanedDeliveryDate := "SalesShptLine"."Planned Delivery Date";
                // if siv.PlanedDeliveryDate = 0D then
                //     siv.PlanedDeliveryDate := SalesShptLine."Shipment Date";
                // siv.OrderRequestedDate := "SalesShptLine"."Requested Delivery Date";
                // if siv.OrderRequestedDate = 0D then
                //     siv.OrderRequestedDate := SalesShptLine."Shipment Date";
                siv.ShipmentDate := "SalesShptLine"."Shipment Date";
                siv.QtyShipped := "SalesShptLine"."Quantity";
                siv.OustandingQty := 0;

                siv.status := 'CLOSED';


                //siv.OrderQty := "SalesShptLine"."KVSTEX Order Quantity";
                //if siv.OrderQty = 0 then
                siv.OrderQty := "SalesShptLine".Quantity;
                //siv.Invoice_Value := "Unit Price" * siv.QtyShipped;
                siv.Invoice_Value := siv.QtyShipped * siv."unit Price";
                siv.Currency := LSalesShptHeader."Currency Code";
                if siv.Currency = '' then begin
                    GeneralLedgerSetup.get();
                    siv.Currency := GeneralLedgerSetup."LCY Code";
                end;
                siv.OrderType := 'Posted Sales Shipment';

                siv.INSERT;



            end;

            trigger OnPreDataItem();
            var
                CompanyInfo: Record "Company Information";
            begin
                if OnlyOpenSales then
                    CurrReport.Break();

                CompanyInfo.get();
                //SETFILTER("Document Type", '%1|%2', "Document Type"::Order, "Document Type"::"Blanket Order");
                SETRANGE(Type, Type::Item);
                SETFILTER("Quantity", '>%1', 0);
                SetFilter("Unit Price", '>%1', 0);
                //SETRANGE(KVSFCYDeliveryScheduleNo, '');
                //SETRANGE("Blanket Order No.",'');
                SETRANGE("Shipment Date", StartDate, EndDate);
                CompanyInfo.get;
                case CompanyInfo."Country/Region Code" of
                    'DE':
                        Setfilter("KVSTEX Item Type", '%1|%2|%3|%4', "KVSTEX Item Type"::"Finished Product", "KVSTEX Item Type"::Yarn, "KVSTEX Item Type"::"KVS Cutset", "KVSTEX Item Type"::"KVS Colour Ribbon");
                    //setrange("Order No.",'DA24-10624');
                    'MX':
                        Setfilter("KVSTEX Item Type", '%1|%2|%3|%4|%5', "KVSTEX Item Type"::"Finished Product", "KVSTEX Item Type"::Yarn, "KVSTEX Item Type"::"KVS Cutset", "KVSTEX Item Type"::"KVS Colour Ribbon", "KVSTEX Item Type"::"Raw Commodity");
                //setrange("Order No.",'DA24-10624');
                end;

                //Setfilter("KVSTEX Item Type", '%1|%2|%3', "KVSTEX Item Type"::"Finished Product", "KVSTEX Item Type"::Yarn, "KVSTEX Item Type"::"KVS Cutset", "KVSTEX Item Type"::"KVS Colour Ribbon");
                //setrange("Order No.",'DA24-10624');
                // SETRANGE("Sell-to Customer No.", Customer."No.");
            end;
        }


        // dataitem("KFSFCYCumQtyEntry"; "KVSFCYCumQuantityEntry")
        // {

        //     trigger OnAfterGetRecord();
        //     var
        //         ItemLoc: Record Item;
        //         ItemSourceLoc: Code[20];
        //         HasBomLoc: Boolean;
        //         //LTransShptHeader: Record "Transfer Shipment Header";
        //         LForcastAmount: Decimal;
        //         LCurrencyDate: Date;
        //         EntryNo: integer;
        //         CustomerLoc: record Customer;
        //         GeneralLedgerSetup: Record "General Ledger Setup";
        //         DelSchedHeader: Record "KVSFCYDeliverySchedHeader";
        //         location: Record Location;
        //         KVSFCYInbReleaseOrderHeader: record KVSFCYInbReleaseOrderHeader;
        //         transferShiptHeader: Record "Transfer Shipment Header";
        //         TransferShipLine: Record "Transfer Shipment Line";
        //         KVSFCYNonActiveDelSchedEntry: record KVSFCYNonActiveDelSchedEntry;
        //         SalesPriceList:Record "Price List Line";
        //     //DeliveryScheduleLineBuffer: Record "KVSFCYDelScheduleLineBuffer" temporary;
        //     //DelScheduleBufferEngine: Codeunit "KVSFCYDelScheduleBufferLib";
        //     begin

        //         DelSchedHeader.GET(DelSchedHeader."Document Type"::"Delivery Schedule",
        //                    KFSFCYCumQtyEntry."Delivery Schedule No.");


        //         // DelScheduleBufferEngine.FillBufferStandard(
        //         //                  DeliveryScheduleLineBuffer,
        //         //                  DelSchedHeader."No.",
        //         //                  false);

        //         // DeliveryScheduleLineBuffer.RESET;
        //         // DeliveryScheduleLineBuffer.setrange("Document Type",DelSchedHeader."Document Type");
        //         // DeliveryScheduleLineBuffer.SETRANGE("Delivery Schedule No.", DelSchedHeader."No.");
        //         // DeliveryScheduleLineBuffer.SETRANGE("Delivery Schedule Entry No.", TransShptLine.KVSFCYDeliveryScheduleEntryNo);
        //         // DeliveryScheduleLineBuffer.FindFirst();
        //         //DeliveryScheduleLineBuffer.Init();

        //         //LTransShptHeader.get(TransShptLine."Document No.");

        //         ItemLoc.GET(KFSFCYCumQtyEntry."Item No.");

        //         if itemloc."KVSTEX Item Status" <> itemloc."KVSTEX Item Status"::Certified then
        //             CurrReport.skip;






        //         EntryNo := SIVGetNextEntryNo();
        //         siv.reset();
        //         siv.INIT;
        //         siv.EntryNo := EntryNo;
        //         siv.User := USERID;
        //         siv."Artikelnr." := KFSFCYCumQtyEntry."Item No.";
        //         siv.Debitor := KFSFCYCumQtyEntry."Customer No.";
        //         CustomerLoc.get(KFSFCYCumQtyEntry."Customer No.");
        //         siv."customer name" := CopyStr(CustomerLoc."name", 1, StrLen(siv."Customer Name"));
        //         siv.Artikelkategorie := ItemLoc."Item Category Code";
        //         //siv.Kostenträger := "Shortcut Dimension 2 Code";
        //         //siv.Debitorengruppe := DefDim."Dimension Value Code";
        //         siv.Warenart := ItemLoc."KVSTEX Item Type";
        //         siv.Produktgruppe := ItemLoc."Item Category Code";
        //         siv.Produktbuchungsgruppe := ItemLoc."Gen. Prod. Posting Group";
        //         siv.Lagerbuchungsgruppe := ItemLoc."Inventory Posting Group";
        //         siv.Land := CustomerLoc."Country/Region Code";
        //         siv.Verkäufercode := CustomerLoc."Salesperson Code";
        //         siv.Beschreibung := '';
        //         siv.Einheit := ItemLoc."Base Unit of Measure";
        //         siv."Composition Key Total" := ItemLoc."KVSTEX Composition Key Total";
        //         CLEAR(LForcastAmount);
        //         LForcastAmount := DelSchedHeader."Unit Price (Last Release)" * KFSFCYCumQtyEntry."Quantity (Base)";
        //         siv."Forecast Amount" := LForcastAmount;

        //         siv."Forecast Qty" := KFSFCYCumQtyEntry."Quantity (Base)";
        //         siv."unit Price" := DelSchedHeader."Unit Price (Last Release)";
        //           if siv."unit Price" = 0 then begin
        //                     SalesPriceList.Reset();
        //                     SalesPriceList.setrange("Source No.", siv.Debitor);
        //                     SalesPriceList.SetRange("Asset No.", siv."Artikelnr.");
        //                     SalesPriceList.setfilter("Starting Date", '>=%1', siv.ShipmentDate);
        //                     SalesPriceList.setfilter("Ending Date", '<=%1', siv.ShipmentDate);
        //                     if SalesPriceList.FindLast() then
        //                         siv."Unit Price" := SalesPriceList."Unit Price"
        //                     else begin
        //                         SalesPriceList.SetRange("Starting Date");
        //                         SalesPriceList.SetRange("Ending Date");
        //                         if SalesPriceList.FindLast() then
        //                             siv."Unit Price" := SalesPriceList."Unit Price"
        //                     end;
        //                 end;


        //         case ItemLoc."Base Unit of Measure" of
        //             'M':
        //                 begin
        //                     siv."Forecast Meter" := Conversion(ItemLoc."No.", siv."Forecast Qty", ItemSourceLoc);
        //                     siv."Forecast Gesamt meter" := siv."Forecast Meter";
        //                 end;
        //             'STK':
        //                 begin
        //                     siv."Forecast STK" := siv."Forecast Qty";
        //                     siv."Forecast STK-M" := Conversion(ItemLoc."No.", siv."Forecast Qty", ItemSourceLoc);
        //                     siv."Forecast Gesamt meter" := siv."Forecast STK-M";
        //                 end;
        //             'QM':
        //                 begin
        //                     siv."Forecast QM" := siv."Forecast Qty";
        //                     siv."Forecast QM-M" := Conversion(ItemLoc."No.", siv."Forecast Qty", ItemSourceLoc);
        //                     siv."Forecast Gesamt meter" := siv."Forecast QM-M";
        //                 end;
        //         end;
        //         if ItemLoc."Base Unit of Measure" = 'KG' then
        //             siv."Forecast KG" := siv."Forecast Qty"
        //         else
        //             siv."Forecast KG" := siv."Forecast Qty" * ItemLoc."Net Weight";
        //         CalcYarnforcast(siv);
        //         siv."Entry Date" := "KFSFCYCumQtyEntry"."Reference Date";

        //         case "Document Type" of
        //             "Document Type"::"Transfer Shipment":
        //                 begin
        //                     TransferShipLine.init;
        //                     if TransferShipLine.get("Document No.", "Document Line No.") then begin
        //                         KVSFCYNonActiveDelSchedEntry.Reset();
        //                         KVSFCYNonActiveDelSchedEntry.SetRange("Delivery Schedule No.", TransferShipLine.KVSFCYDeliveryScheduleNo);
        //                         KVSFCYNonActiveDelSchedEntry.SetRange(Version, TransferShipLine.KVSFCYDeliveryScheduleVersion);
        //                         if KVSFCYNonActiveDelSchedEntry.FindFirst() then
        //                             siv.OrderRequestedDate := KVSFCYNonActiveDelSchedEntry."Release Order Date New";
        //                         siv.OrderDate := KVSFCYNonActiveDelSchedEntry."Release Order Date New";

        //                     end;
        //                 end;
        //         end;

        //         if siv.OrderDate = 0D then
        //             siv.OrderDate := "KFSFCYCumQtyEntry"."Reference Date";
        //         IF siv.OrderRequestedDate = 0D then
        //             siv.OrderRequestedDate := "KFSFCYCumQtyEntry"."Reference Date";
        //         // siv."document No." := TransShptLine."Document No." + '_' + KVSFCYDeliveryScheduleNo;
        //         siv."document No." := KFSFCYCumQtyEntry."Delivery Schedule No.";
        //         siv."DocLineNo." := format(KFSFCYCumQtyEntry."Entry No.");
        //         Location.reset();
        //         location.SetRange("KVSTEX Customer No.", CustomerLoc."No.");
        //         if not location.FindFirst() then
        //             location.init();
        //         siv."location Code" := location.Name;
        //         siv.postingDate := KFSFCYCumQtyEntry."Reference Date";



        //         siv.modifiedAt := KFSFCYCumQtyEntry."Reference Date";
        //         if siv.modifiedAt = 0D then
        //             siv.modifiedAt := siv.OrderDate;
        //         siv.PromdisedDeliveryDate := KFSFCYCumQtyEntry."Reference Date";
        //         if siv.PromdisedDeliveryDate = 0D then
        //             siv.PromdisedDeliveryDate := KFSFCYCumQtyEntry."Reference Date";
        //         siv.PlanedDeliveryDate := KFSFCYCumQtyEntry."Reference Date";
        //         if siv.PlanedDeliveryDate = 0D then
        //             siv.PlanedDeliveryDate := KFSFCYCumQtyEntry."Reference Date";
        //         //siv.OrderRequestedDate := CalcDate('<-2W>', KFSFCYCumQtyEntry."Reference Date");
        //         if siv.OrderRequestedDate = 0D then
        //             siv.OrderRequestedDate := KFSFCYCumQtyEntry."Reference Date";
        //         siv.ShipmentDate := KFSFCYCumQtyEntry."Reference Date";
        //         siv.QtyShipped := KFSFCYCumQtyEntry."Quantity (Base)";
        //         siv.OustandingQty := 0;

        //         siv.status := 'CLOSED';


        //         //siv.OrderQty := "TransShptLine"."KVSTEX Order Quantity";
        //         //if siv.OrderQty = 0 then
        //         siv.OrderQty := "KFSFCYCumQtyEntry"."Quantity (Base)";
        //         //siv.Invoice_Value := "Unit Price" * siv.QtyShipped;
        //         siv.Invoice_Value := siv.QtyShipped * siv."unit Price";
        //         siv.Currency := DelSchedHeader."Currency Code (Last Release)";
        //         if siv.Currency = '' then begin
        //             GeneralLedgerSetup.get();
        //             siv.Currency := GeneralLedgerSetup."LCY Code";
        //         end;
        //         siv.OrderType := 'DeliverySchedule';

        //         siv.INSERT;



        //     end;

        //     trigger OnPreDataItem();
        //     begin
        //         //SETFILTER("Document Type", '%1|%2', "Document Type"::Order, "Document Type"::"Blanket Order");
        //         //SETRANGE(typ, Type::Item);
        //         //SETFILTER("Quantity", '>%1', 0);
        //         //SETRANGE(KVSFCYDeliveryScheduleNo, '');
        //         //SETRANGE("Blanket Order No.",'');
        //         SETRANGE("Reference Date", StartDate, EndDate);
        //         //Setfilter("KVSTEX Item Type", '%1|%2|%3', "KVSTEX Item Type"::"Finished Product", "KVSTEX Item Type"::Yarn, "KVSTEX Item Type"::"KVS Cutset","KVSTEX Item Type"::"KVS Colour Ribbon");
        //         // SETRANGE("Sell-to Customer No.", Customer."No.");
        //         //setfilter("Delivery Schedule No.", '%1', 'LP16-10008');
        //         SetRange(Type, Type::Own);
        //     end;
        // }
        //end 022025
        dataitem(TempSalesLinesBuffer; "Integer")
        {
            DataItemTableView = SORTING(Number);

            trigger OnAfterGetRecord();
            begin
                if Number = 1 then
                    TempSalesLine.FINDFIRST
                else
                    TempSalesLine.NEXT;

                CreateSIVfromTempSalesLine(TempSalesLine);
            end;

            trigger OnPreDataItem();
            begin
                SETRANGE(Number, 1, TempSalesLine.COUNTAPPROX)
            end;
        }
        dataitem("Soll-Ist-Vergleich-Temp"; Integer)
        {
            //DataItemTableView = SORTING(Debitorengruppe, Debitor, "Artikelnr.");

            trigger OnPreDataItem();
            var
                ItemLoc: Record Item;
            begin
                siv.Reset();
                siv.SETRANGE(User, USERID);
                SetRange(number, 1, siv.count());
                i := COUNTAPPROX;
                if GUIALLOWED then begin
                    Window.OPEN(
                      '#1################################\\' +
                      'Posten werden Exportiert\\' +
                      '@2@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@');
                    if i > 0 then
                        Factor := 9999 / i;
                end;

                if PrintToExcel then
                    MakeExcelInfo;

            end;

            trigger OnAfterGetRecord();
            var
                ItemLoc: Record Item;
            begin
                if Number = 1 then
                    siv.FindFirst()
                else
                    siv.Next();

                ItemLoc.GET(siv."Artikelnr.");

                siv."IST Menge KG" := siv."Ist Menge" * ItemLoc."Net Weight";
                siv."Soll Menge KG" := siv."Soll Menge" * ItemLoc."Net Weight";

                case ItemLoc."Base Unit of Measure" of
                    'STK':
                        begin
                            siv."Ist Menge Stück" := siv."Ist Menge";
                            siv."IST STK Meter" := Conversion(ItemLoc."No.", siv."Ist Menge", siv."Cutset FW");
                            siv.Gesamtmeter := siv."IST STK Meter";

                            siv."Soll Menge Stück" := siv."Soll Menge";
                            siv."Soll Cutset Lfm" := Conversion(ItemLoc."No.", siv."Soll Menge", siv."Cutset FW");
                            siv."Soll Gesamtmeter" := siv."Soll Cutset Lfm";

                        end;
                    'M':
                        begin
                            siv."Ist Menge Meter" := Conversion(ItemLoc."No.", siv."Ist Menge", siv."Cutset FW");
                            siv.Gesamtmeter := siv."Ist Menge Meter";

                            siv."Soll Menge Meter" := Conversion(ItemLoc."No.", siv."Soll Menge", siv."Cutset FW");
                            ;
                            siv."Soll Gesamtmeter" := siv."Soll Menge Meter";
                        end;
                    'QM':
                        begin
                            siv."Ist Menge QM" := siv."Ist Menge";
                            siv."Menge QM - M" := Conversion(ItemLoc."No.", siv."Ist Menge", siv."Cutset FW");
                            siv.Gesamtmeter := siv."Menge QM - M";

                            siv."Soll Menge QM" := siv."Soll Menge";
                            siv."Soll Menge QM - M" := Conversion(ItemLoc."No.", siv."Soll Menge", siv."Cutset FW");
                            siv."Soll Gesamtmeter" := siv."Soll Menge QM - M";
                        end;
                end;

                //CalcForCast("Soll-Ist-Vergleich-Temp");

                CalcDiff(siv);

                if not ItemInfo.GET(siv."Cutset FW") then
                    ItemInfo.INIT;

                siv.Kettgarn := GetYarn(siv."Artikelnr.");
                GetYarnInfo(siv);
                siv.MODIFY;

                // if PrintToExcel then
                //     MakeExcelDataBody(Output::Data);
            end;

            trigger OnPostDataItem();
            var
                VarOutstream: OutStream;
                VarInStream: InStream;
                DataExport: Text;
                TempBlob: Codeunit "Temp Blob";
            begin
                // if PrintToExcel then
                //     CreateExcelBook;
                // // if CreateCSV then begin
                // //     Clear(TempBlob);
                // //     TempBlob.CreateInStream(VarInStream);
                // //     TempBlob.CreateOutStream(VarOutstream);
                // //     Clear(O9SalesActualXML);
                // //     //O9SalesActualXML.SetDataItem(SIV);
                // //     //O9SalesActualXML.Run();
                // //     //O9SalesActualXML.Export();
                // //     //VarInStream.ReadText(DataExport);
                // //     //IF StrLen(DataExport) = 0 then
                //     //    Error('There is no data export');
                //     Xmlport.Export(xmlport::"UTT O9SalesActual", VarOutstream);
                //     //VarInStream.ReadText(DataExport);
                //     // IF StrLen(DataExport) = 0 then
                //     //     Error('There is no data export');




                // end;

                if GUIALLOWED then begin
                    Window.CLOSE;
                end;
            end;
        }

    }
    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(StartDate; StartDate)
                    {
                        ApplicationArea = All;
                        Caption = 'Start Date';
                        ToolTip = 'Specifies the value of the Start Date field';
                    }
                    field(EndDate; EndDate)
                    {
                        ApplicationArea = All;
                        Caption = 'End Date';
                        ToolTip = 'Specifies the value of the End Date field';
                    }
                    // field(NewCurrency; NewCurrency)
                    // {
                    //     ApplicationArea = All;
                    //     Caption = 'Sales Conversion Currency';
                    //     ToolTip = 'Specifies the value of the Sales Conversion Currency field';
                    // }
                    // field(CurrencyDate; CurrencyDate)
                    // {
                    //     ApplicationArea = All;
                    //     Caption = 'Cost of goods Exchange rate Date';
                    //     ToolTip = 'Specifies the value of the Cost of goods Exchange rate Date field';
                    // }
                    // field(ExcludeDeliverySchedule; ExcludeDeliverySchedule)
                    // {
                    //     ApplicationArea = All;
                    //     Caption = 'Without Delivery Schedules';
                    //     ToolTip = 'Specifies the value of the Without Delivery Schedules field';
                    // }
                    // field(ExcludeSalesLines; ExcludeSalesLines)
                    // {
                    //     ApplicationArea = All;
                    //     Caption = 'Exclude SalesShptLines';
                    //     ToolTip = 'Specifies the value of the Exclude SalesShptLines field';
                    // }
                    // field(CalcGarneinsatz; CalcGarneinsatz)
                    // {
                    //     ApplicationArea = All;
                    //     Caption = 'Calculate cost of goods';
                    //     ToolTip = 'Specifies the value of the Calculate cost of goods field';
                    // }
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPostReport();
    begin
        SOLLISTCOstEntry.CleanSalesPlanLedgEntry()
    end;

    trigger OnPreReport();
    begin

        if CalcGarneinsatz then
            COSPlanEntryBuff.DELETEALL;
    end;

    procedure SetDataFilter(PStartDate: Date; PEndDate: Date; CSV: Boolean)
    var
        myInt: Integer;
    begin
        StartDate := PStartDate;
        EndDate := PEndDate;
        CreateCSV := CSV;

    end;

    procedure RetrieveOnlyOpenSales(OnlyOpenSales_: Boolean)

    begin
        OnlyOpenSales := OnlyOpenSales_;

    end;

    procedure getOutstream(var POutstream: OutStream): OutStream;
    begin
        OutS := POutstream

    end;

    var
        Text000: Label 'Period: %1', Comment = 'ENU = Period: %1, DEA = Periode: %1';
        Item: Record Item;
        ValueEntryBuffer: Record "Value Entry" temporary;
        CustFilter: Text[250];
        ItemLedgEntryFilter: Text[250];
        PeriodText: Text[30];
        NextEntryNo: Integer;
        PrintOnlyOnePerPage: Boolean;
        Profit: Decimal;
        ProfitPct: Decimal;
        _kuma16: Integer;
        siv: Record "UTT SalesBuffer";
        Item1: Record Item;
        AbwMenge: Decimal;
        AbwVerkauf: Decimal;
        AbwEinstand: Decimal;
        PlanFilter: Text[250];
        Customer1: Record Customer;
        ArtKat: Record "Item Category";
        ArtikelAusblenden: Boolean;
        DebitorenAusblenden: Boolean;
        DiffMenge: Decimal;
        DiffVerkauf: Decimal;
        DiffEinstand: Decimal;
        ShowDif: Option Betrag,Prozent;
        SalesSetup: Record "Sales & Receivables Setup";
        DefDim: Record "Default Dimension";
        "_KUMA.ea": Boolean;
        ItemLedgerEntry: Record "Item Ledger Entry";
        ITEM3: Record Item;
        ProdBOMHeader: Record "Production BOM Header";
        ProdBOMLine: Record "Production BOM Line";
        ActiveVersionCode: Code[10];
        VersionMgt: Codeunit VersionManagement;
        _UTT__: Integer;
        ExcelBuf: Record "Excel Buffer" temporary;
        PrintToExcel: Boolean;
        i: Integer;
        iz: Integer;
        Factor: Decimal;
        Window: Dialog;
        TxtReportName: Label 'Soll-Ist-Vergleich Excel', Comment = 'ENU = Soll-Ist-Vergleich Excel, ESM = Soll-Ist-Vergleich Excel, DEA = Soll-Ist-Vergleich Excel';
        TxtDate: Label 'Datum', Comment = 'DEU = Datum, ENU = Date, ESM = Fecha, DEA = Datum';
        TxtUser: Label 'User', Comment = 'DEU = Benutzer, ENU = User, ESM = Usuario, DEA = Benutzer';
        Output: Option Cust,CustGroup,Data,Footer,Total,CustGrp,Diff,TotalCustGrp;
        CurrCustomer: Code[50];
        idx: Integer;
        CustomerCounter: Integer;
        "uttP99--": Integer;
        UserSetup: Record "User Setup";
        CustSetup: Record "Sales & Receivables Setup";
        CustRec: Record Customer;

        Pos: Integer;
        x: Integer;
        StatisticGrp: Text[120];
        ItemCrossRef: Record "Item Reference";
        vRefNo: Code[20];
        C_KVS013: Label 'Reference No.:', Comment = 'DEU = Referenznr.:, ENU = Reference No.:, DEA = Referenznr.:';
        HelpCustTab: Record Customer;
        "Sales Line Buffer": Record "Sales Line" temporary;
        StartDate: Date;
        EndDate: Date;
        TxtError1: Label 'please set as filter the  sales plan name!! ', Comment = 'DEU = bitte Umsatzplanname eingeben!!, ENU = please set as filter the  sales plan name!! , DEA = bitte Umsatzplanname eingeben!!';
        txtError2: Label 'plase set the start and end date !!', Comment = 'DEU = bitte Start- und Enddatum eingeben !!, ENU = plase set the start and end date !!, DEA = bitte Start- und Enddatum eingeben !!';
        ExcludeDeliverySchedule: Boolean;
        ExcludeSalesLines: Boolean;
        SalesLineRahmenAuftrag: Record "Sales Line";
        TempSalesLine: Record "Sales Line" temporary;
        NextLineNo: Integer;
        ItemInfo: Record Item;
        PrintAmountsInLCY: Boolean;
        SalesInvHeader: Record "Sales Invoice Header";
        CurrExchRate: Record "Currency Exchange Rate";
        SalescreditHeader: Record "Sales Cr.Memo Header";
        CurrenyCode: Code[20];
        NewCurrency: Code[20];
        COSPlanEntryBuff: Record "KVSExp.-Act. COS Entry";
        COSPlanEntry: Record "KVSCOSTurnoverEntry";
        SalesPlanLedgerEntry: Record "KVSTurnoverPlanLedgerEntry";
        SalesPlanName: Record "KVSTurnoverPlanName";
        SOLLISTCOstEntry: Record "KVSExp.-Act. COS Entry";
        CalcGarneinsatz: Boolean;
        Marked: Boolean;
        CurrencyDate: Date;
        Found: Boolean;
        RwItem: Code[20];
        CreateCSV: Boolean;
        O9SalesActualXML: XmlPort "UTT O9SalesActual";
        OutS: OutStream;
        PLANT_CD: text;
        OnlyOpenSales: Boolean;












    local procedure CalcProfitPct();
    begin
        with ValueEntryBuffer do begin
            if "Sales Amount (Actual)" <> 0 then
                ProfitPct := ROUND(100 * Profit / "Sales Amount (Actual)", 0.1)
            else
                ProfitPct := 0;
        end;
    end;

    local procedure SIVGetNextEntryNo(): Integer
    begin
        if SIV.FindLast() then
            exit(SIV.EntryNo + 1)
        else
            exit(1);
    end;

    local procedure DT2Datetime(Date_: Date): DateTime
    begin
        exit(CreateDateTime(Date_, 000000T)); // Converts date to datetime at midnight
    end;

    procedure UTT___();
    begin
    end;

    procedure MakeExcelInfo();
    begin
        ExcelBuf.SetUseInfoSheet;
        ExcelBuf.AddInfoColumn(FORMAT('Company Name'), FALSE, TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(FORMAT(COMPANYNAME), FALSE, FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;

        ExcelBuf.AddInfoColumn(FORMAT('Report Name'), FALSE, TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(FORMAT(TxtReportName), FALSE, FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;

        ExcelBuf.AddInfoColumn(FORMAT(TxtDate), FALSE, TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(FORMAT(PeriodText), FALSE, FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;

        ExcelBuf.AddInfoColumn(FORMAT(TxtUser), FALSE, TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(FORMAT(USERID), FALSE, FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;

        ExcelBuf.ClearNewRow();
        MakeExcelDataHeader;
    end;

    procedure MakeExcelDataHeader();
    begin
        ExcelBuf.NewRow;
        ExcelBuf.AddColumn(FORMAT('LfdNr.'), FALSE, '', TRUE, FALSE, FALSE, '@', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(FORMAT('Datum'), FALSE, '', TRUE, FALSE, FALSE, '@', ExcelBuf."Cell Type"::Text);

        ExcelBuf.AddColumn(FORMAT('Artikelnr.'), FALSE, '', TRUE, FALSE, FALSE, '@', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(FORMAT('Rohstoffschlüssel'), FALSE, '', TRUE, FALSE, FALSE, '@', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(ItemInfo.FIELDCAPTION("KVSTEX Finish"), FALSE, '', TRUE, FALSE, FALSE, '@', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(FORMAT('Ursprungsartikel'), FALSE, '', TRUE, FALSE, FALSE, '@', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(FORMAT(C_KVS013), FALSE, '', TRUE, FALSE, FALSE, '@', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(FORMAT('Land'), FALSE, '', TRUE, FALSE, FALSE, '@', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(FORMAT('Soll Menge'), FALSE, '', TRUE, FALSE, FALSE, '@', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(FORMAT('Soll Meter'), FALSE, '', TRUE, FALSE, FALSE, '@', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(FORMAT('soll STK'), FALSE, '', TRUE, FALSE, FALSE, '@', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(FORMAT('soll M²'), FALSE, '', TRUE, FALSE, FALSE, '@', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(FORMAT('Soll KG'), FALSE, '', TRUE, FALSE, FALSE, '@', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(FORMAT('Soll Verkaufs- betrag'), FALSE, '', TRUE, FALSE, FALSE, '@', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(FORMAT('Soll Einstands- betrag'), FALSE, '', TRUE, FALSE, FALSE, '@', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(FORMAT('SOLL STK-M'), FALSE, '', TRUE, FALSE, FALSE, '@', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(FORMAT('SOLL M²-M'), FALSE, '', TRUE, FALSE, FALSE, '@', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(FORMAT('Soll Gesamtmeter'), FALSE, '', TRUE, FALSE, FALSE, '@', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(FORMAT('IST Menge'), FALSE, '', TRUE, FALSE, FALSE, '@', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(FORMAT('IST Meter'), FALSE, '', TRUE, FALSE, FALSE, '@', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(FORMAT('IST STK'), FALSE, '', TRUE, FALSE, FALSE, '@', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(FORMAT('IST M²'), FALSE, '', TRUE, FALSE, FALSE, '@', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(FORMAT('IST KG'), FALSE, '', TRUE, FALSE, FALSE, '@', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(FORMAT('IST Verkaufs- betrag'), FALSE, '', TRUE, FALSE, FALSE, '@', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(FORMAT('IST Einstands- betrag'), FALSE, '', TRUE, FALSE, FALSE, '@', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(FORMAT('IST STK-M'), FALSE, '', TRUE, FALSE, FALSE, '@', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(FORMAT('IST M²-M'), FALSE, '', TRUE, FALSE, FALSE, '@', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(FORMAT('IST Gesamtmeter'), FALSE, '', TRUE, FALSE, FALSE, '@', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(FORMAT('Forecast Menge'), FALSE, '', TRUE, FALSE, FALSE, '@', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(FORMAT('Forecast STK'), FALSE, '', TRUE, FALSE, FALSE, '@', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(FORMAT('Forecast STK-M'), FALSE, '', TRUE, FALSE, FALSE, '@', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(FORMAT('Forecast Meter'), FALSE, '', TRUE, FALSE, FALSE, '@', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(FORMAT('Forecast QM'), FALSE, '', TRUE, FALSE, FALSE, '@', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(FORMAT('Forecast QM-M'), FALSE, '', TRUE, FALSE, FALSE, '@', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(FORMAT('Forecast Gesamtmeter'), FALSE, '', TRUE, FALSE, FALSE, '@', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(FORMAT('Forecast KG'), FALSE, '', TRUE, FALSE, FALSE, '@', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(FORMAT('Forecast Betrag'), FALSE, '', TRUE, FALSE, FALSE, '@', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(FORMAT('Kunde'), FALSE, '', TRUE, FALSE, FALSE, '@', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(FORMAT('Kundename'), FALSE, '', TRUE, FALSE, FALSE, '@', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(FORMAT('Artikelkategorie'), FALSE, '', TRUE, FALSE, FALSE, '@', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(FORMAT('Kostenträger'), FALSE, '', TRUE, FALSE, FALSE, '@', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(FORMAT('Debitorengruppe'), FALSE, '', TRUE, FALSE, FALSE, '@', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(FORMAT('Warenart'), FALSE, '', TRUE, FALSE, FALSE, '@', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(FORMAT('Produktgruppe'), FALSE, '', TRUE, FALSE, FALSE, '@', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(FORMAT('Produktbuchungsgruppe'), FALSE, '', TRUE, FALSE, FALSE, '@', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(FORMAT('Lagerbuchungsgruppe'), FALSE, '', TRUE, FALSE, FALSE, '@', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(FORMAT('Verkäufer'), FALSE, '', TRUE, FALSE, FALSE, '@', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(FORMAT('Abw. Verkauf%'), FALSE, '', TRUE, FALSE, FALSE, '@', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(FORMAT('Abw. Einstandsbetrag%'), FALSE, '', TRUE, FALSE, FALSE, '@', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(FORMAT('Abw. Menge%'), FALSE, '', TRUE, FALSE, FALSE, '@', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(FORMAT('Währung'), FALSE, '', TRUE, FALSE, FALSE, '@', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(FORMAT('GarnEinsatz KG IST'), FALSE, '', TRUE, FALSE, FALSE, '@', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(FORMAT('Garneinsatz Kosten IST'), FALSE, '', TRUE, FALSE, FALSE, '@', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(FORMAT('Garneinsatz KG SOLL'), FALSE, '', TRUE, FALSE, FALSE, '@', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(FORMAT('Garneinsatz Kosten SOLL'), FALSE, '', TRUE, FALSE, FALSE, '@', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(FORMAT('Garneinsatz KG Forecast'), FALSE, '', TRUE, FALSE, FALSE, '@', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(FORMAT('Garneinsatz Kosten Forecast'), FALSE, '', TRUE, FALSE, FALSE, '@', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(FORMAT('Kettgarnartikel'), FALSE, '', TRUE, FALSE, FALSE, '@', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(FORMAT('Kettgarn Kreditor'), FALSE, '', TRUE, FALSE, FALSE, '@', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(FORMAT('Kettgarn DtexNominal'), FALSE, '', TRUE, FALSE, FALSE, '@', ExcelBuf."Cell Type"::Text);
    end;

    procedure MakeExcelDataBody(P_Output: Option Cust,CustGroup,Data,Footer,Total,CustGrp,Diff,TotalCustGrp);
    var
        ItemLoc: Record Item;
    begin
        //SALES_ORDER_HDR_ID	
        //SALES_ORDER_LINE_ID	
        //MATL_NUM	
        //PLANT_CD	
        //ACCOUNT	
        //Invoice_Date	
        //Application	
        //Quality	
        //FINAL_COMMIT_DT	
        //ORDER_CREATION_DT	
        //ORDER_LAST_CHNGE_DT	
        //ORDER_COMMIT_QTY	
        //COMMOM_DT	
        //FINAL_COMMIT_QTY	
        //ACTUAL_DLVRY_DT	
        //ACTUAL_SHP_DT	
        //DELIVERED_QTY	
        //OPEN_COMMIT_QTY	
        //ORDER_STATUS	
        //ORDER_RQST_QTY	
        //ORDER_RQST_DT	
        //OPEN_REQUEST_QTY	
        //ORDER_NET_VALUE	
        //SELLING_PRICE_UNIT	
        //Invoice Value
        CASE P_Output OF
            P_Output::Data:
                BEGIN
                    ExcelBuf.NewRow;
                    ExcelBuf.AddColumn(siv.EntryNo, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                    ExcelBuf.AddColumn(siv."Entry Date", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Date);
                    ExcelBuf.AddColumn(siv."Artikelnr.", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn(siv."Composition Key Total", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn(ItemInfo."KVSTEX Finish", FALSE, '', FALSE, FALSE, FALSE, '@', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn(siv."Cutset FW", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn(siv.Beschreibung, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn(siv.Land, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn(ROUND(siv."Soll Menge", 0.01), FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                    ExcelBuf.AddColumn(ROUND(siv."Soll Menge Meter", 0.01), FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                    ExcelBuf.AddColumn(ROUND(siv."Soll Menge Stück", 0.01), FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                    ExcelBuf.AddColumn(ROUND(siv."Soll Menge QM", 0.01), FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                    ExcelBuf.AddColumn(ROUND(siv."Soll Menge KG", 0.01), FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                    ExcelBuf.AddColumn(ROUND(siv."Soll Verkaufsbetrag", 0.01), FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                    ExcelBuf.AddColumn(ROUND(siv."Soll Einstandsbetrag", 0.01), FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                    ExcelBuf.AddColumn(ROUND(siv."Soll Cutset Lfm", 0.01), FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                    ExcelBuf.AddColumn(ROUND(siv."Soll Menge QM - M", 0.01), FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                    ExcelBuf.AddColumn(ROUND(siv."Soll Gesamtmeter", 0.01), FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                    ExcelBuf.AddColumn(ROUND(siv."Ist Menge", 0.01), FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                    ExcelBuf.AddColumn(ROUND(siv."Ist Menge Meter", 0.01), FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                    ExcelBuf.AddColumn(ROUND(siv."Ist Menge Stück", 0.01), FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                    ExcelBuf.AddColumn(ROUND(siv."Ist Menge QM", 0.01), FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                    ExcelBuf.AddColumn(ROUND(siv."IST Menge KG", 0.01), FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                    ExcelBuf.AddColumn(ROUND(siv."Ist Verkaufsbetrag", 0.01), FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                    ExcelBuf.AddColumn(ROUND(siv."Ist Einstandsbetrag", 0.01), FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                    ExcelBuf.AddColumn(ROUND(siv."IST STK Meter", 0.01), FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                    ExcelBuf.AddColumn(ROUND(siv."Menge QM - M", 0.01), FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                    ExcelBuf.AddColumn(ROUND(siv.Gesamtmeter, 0.01), FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                    ExcelBuf.AddColumn(ROUND(siv."Forecast Qty", 0.01), FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                    ExcelBuf.AddColumn(ROUND(siv."Forecast STK", 0.01), FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                    ExcelBuf.AddColumn(ROUND(siv."Forecast STK-M", 0.01), FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                    ExcelBuf.AddColumn(ROUND(siv."Forecast Meter", 0.01), FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                    ExcelBuf.AddColumn(ROUND(siv."Forecast QM", 0.01), FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                    ExcelBuf.AddColumn(ROUND(siv."Forecast QM-M", 0.01), FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                    ExcelBuf.AddColumn(ROUND(siv."Forecast Gesamt meter", 0.01), FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                    ExcelBuf.AddColumn(ROUND(siv."Forecast KG", 0.01), FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                    ExcelBuf.AddColumn(ROUND(siv."Forecast Amount", 0.01), FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                    ExcelBuf.AddColumn(siv.Debitor, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn(siv."customer name", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn(siv.Artikelkategorie, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn(siv.Kostenträger, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn(siv.Debitorengruppe, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn(FORMAT(siv.Warenart), FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn(siv.Produktgruppe, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn(siv.Produktbuchungsgruppe, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn(siv.Lagerbuchungsgruppe, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn(siv.Verkäufercode, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn(AbwVerkauf, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn(AbwEinstand, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn(AbwMenge, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                    ExcelBuf.AddColumn(NewCurrency, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn(siv."Garneinsatz KG IST", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn(siv."Garneinsatz Kosten IST", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn(siv."Garneinsatz KG SOLL", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn(siv."Garneinsatz Kosten SOLL", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn(siv."Garneinsatz KG Forcast", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn(siv."Garneinsatz Kosten Forcast", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn(siv.Kettgarn, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn(siv."Kettgarn Kredior", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn(siv."Kettgarn Detex", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                END;
        END;
    end;

    procedure CreateExcelBook();
    begin
        ExcelBuf.CreateBookAndOpenExcel('', FORMAT(TxtReportName), 'Report Name', COMPANYNAME, USERID);
    end;

    procedure CreateBookAndOpenExcel(SheetName: Text[250]; ReportHeader: Text[250]; CompanyName: Text[250]; UserID1: Text[250]);
    begin

    end;

    procedure EntryCount(P_CurrCust: Code[50]): Integer;
    begin
    end;

    procedure Conversion(ItemNo: Code[20]; Qty: Decimal; var FWItem: Code[20]): Decimal;
    var
        itemLoc: Record Item;
        ProdBOMLine: Record "Production BOM Line";
        ActiveVersionCode: Code[10];
        VersionMgt: Codeunit VersionManagement;
        ProdBOMHeader: Record "Production BOM Header";
    begin
        if itemLoc.GET(ItemNo) then begin
            if (itemLoc."Base Unit of Measure" = 'QM') and (itemLoc."KVSTEX Item Type" <> itemLoc."KVSTEX Item Type"::"KVS Colour Ribbon") then begin
                if not ProdBOMHeader.GET(itemLoc."Production BOM No.") then
                    exit;

                ActiveVersionCode := VersionMgt.GetBOMVersion(ProdBOMHeader."No.", WORKDATE, true);
                ProdBOMLine.RESET;
                ProdBOMLine.SETRANGE("No.", ItemNo);
                ProdBOMLine.SETRANGE("Version Code", ActiveVersionCode);
                if ProdBOMLine.FIND('-') then
                    exit(Qty * ProdBOMLine."Quantity per");
            end;


            if (itemLoc."Base Unit of Measure" = 'M') then begin
                if not ProdBOMHeader.GET(itemLoc."Production BOM No.") then
                    exit;

                ActiveVersionCode := VersionMgt.GetBOMVersion(ProdBOMHeader."No.", WORKDATE, true);
                ProdBOMLine.RESET;
                ProdBOMLine.SETRANGE("Production BOM No.", ProdBOMHeader."No.");
                ProdBOMLine.SETRANGE("Version Code", ActiveVersionCode);
                if ProdBOMLine.FIND('-') then begin
                    Qty := Qty * ProdBOMLine."Quantity per";
                    if itemLoc."KVSTEX Item Type" <> itemLoc."KVSTEX Item Type"::"Finished Product" then
                        FWItem := ProdBOMLine."No."
                    else
                        FWItem := itemLoc."No."

                end;
            end;



            if (itemLoc."Base Unit of Measure" = 'STK') or (itemLoc."Base Unit of Measure" = 'Stück') then begin

                while itemLoc."KVSTEX Item Type" <> itemLoc."KVSTEX Item Type"::"Finished Product" do begin
                    if not ProdBOMHeader.GET(itemLoc."Production BOM No.") then
                        exit;

                    ActiveVersionCode := VersionMgt.GetBOMVersion(ProdBOMHeader."No.", WORKDATE, true);
                    ProdBOMLine.RESET;
                    ProdBOMLine.SETRANGE("Production BOM No.", ProdBOMHeader."No.");
                    ProdBOMLine.SETRANGE("Version Code", ActiveVersionCode);
                    if ProdBOMLine.FIND('-') then begin
                        itemLoc.GET(ProdBOMLine."No.");
                        Qty := Qty * ProdBOMLine."Quantity per";
                        FWItem := ProdBOMLine."No.";
                    end;
                end;
            end;
            if (itemLoc."Base Unit of Measure" = 'QM') and (itemLoc."KVSTEX Item Type" = itemLoc."KVSTEX Item Type"::"KVS Colour Ribbon") then begin
                if not ProdBOMHeader.GET(itemLoc."Production BOM No.") then
                    exit;

                ActiveVersionCode := VersionMgt.GetBOMVersion(ProdBOMHeader."No.", WORKDATE, true);
                ProdBOMLine.RESET;
                ProdBOMLine.SETRANGE("Production BOM No.", ProdBOMHeader."No.");
                ProdBOMLine.SETRANGE("Version Code", ActiveVersionCode);
                ProdBOMLine.SETRANGE("KVS Used for Sales Plan", true);
                if ProdBOMLine.FIND('-') then begin
                    Qty := Qty * ProdBOMLine."Quantity per";
                    FWItem := ProdBOMLine."No.";
                end;
            end;
        end;
        exit(Qty);
    end;

    procedure ConversionBom(P_ItemNo: Code[20]; var SLBestand: Record "UTT SalesBuffer"): Decimal;
    var
        itemLoc: Record Item;
        itemBom: Record Item;
        ProdBOMLine: Record "Production BOM Line";
        ActiveVersionCode: Code[10];
        VersionMgt: Codeunit VersionManagement;
        ProdBOMHeader: Record "Production BOM Header";
        MaxLevel: Integer;
    begin
        if itemLoc.GET(P_ItemNo) then begin
            if (itemLoc."KVSTEX Item Type" = itemLoc."KVSTEX Item Type"::"KVS Cutset") then begin
                if not ProdBOMHeader.GET(itemLoc."Production BOM No.") then
                    exit;

                ActiveVersionCode := VersionMgt.GetBOMVersion(ProdBOMHeader."No.", WORKDATE, true);
                ProdBOMLine.RESET;
                ProdBOMLine.SETRANGE("Production BOM No.", ProdBOMHeader."No.");
                ProdBOMLine.SETRANGE("Version Code", ActiveVersionCode);

                if ProdBOMLine.FIND('-') then begin

                    if ProdBOMLine."Quantity per" <> 0 then begin
                        SLBestand."Soll Cutset FW" := ProdBOMLine."No.";

                        exit(SLBestand."Soll Menge" * ProdBOMLine."Quantity per")

                    end;
                end;
            end;

        end;
    end;

    procedure CalcForCast(var P_SIV: Record "UTT SalesBuffer");
    begin
    end;

    procedure CalcDiff(var P_SollIST: Record "UTT SalesBuffer");
    begin
        with P_SollIST do begin
            DiffMenge := Gesamtmeter - "Soll Gesamtmeter";
            DiffVerkauf := "Ist Verkaufsbetrag" - "Soll Verkaufsbetrag";
            DiffEinstand := "Ist Einstandsbetrag" - "Soll Einstandsbetrag";

            AbwMenge := DiffMenge;
            AbwVerkauf := DiffVerkauf;
            AbwEinstand := DiffEinstand;

            //IF ShowDif = ShowDif::Prozent THEN
            //BEGIN
            if "Soll Verkaufsbetrag" <> 0 then
                AbwVerkauf := ROUND(DiffVerkauf * 100 / "Soll Verkaufsbetrag", 0.01)
            else
                AbwVerkauf := 0;
            if "Soll Einstandsbetrag" <> 0 then
                AbwEinstand := ROUND(DiffEinstand * 100 / "Soll Einstandsbetrag", 0.01)
            else
                AbwEinstand := 0;
            if "Soll Gesamtmeter" <> 0 then
                AbwMenge := ROUND(DiffMenge * 100 / "Soll Gesamtmeter", 0.01)
            else
                AbwMenge := 0;
        end;
    end;

    procedure CreateSIVfromTempSalesLine(var P_SalesLines: Record "Sales Line");
    var
        itemLoc: Record Item;
        ProdBOMLine: Record "Production BOM Line";
        ActiveVersionCode: Code[10];
        VersionMgt: Codeunit VersionManagement;
        ProdBOMHeader: Record "Production BOM Header";
        ItemSourceLoc: Code[20];
        Referenz: Record "Item Reference";
        "Referenznr.": Code[20];
        CustomerLoc: Record Customer;
    begin
        itemLoc.GET(P_SalesLines."No.");

        siv.INIT;
        siv.User := USERID;
        siv.Kostenträger := P_SalesLines."Shortcut Dimension 2 Code";
        siv."Artikelnr." := itemLoc."No.";
        siv.Beschreibung := itemLoc.Description;
        siv.Artikelkategorie := itemLoc."Item Category Code";
        siv.Warenart := itemLoc."KVSTEX Item Type";
        siv.Produktgruppe := itemLoc."Item Category Code";
        siv.Produktbuchungsgruppe := itemLoc."Gen. Prod. Posting Group";
        siv.Lagerbuchungsgruppe := itemLoc."Inventory Posting Group";
        siv.Einheit := itemLoc."Base Unit of Measure";
        siv."unit Price" := P_SalesLines."Unit Price";
        siv."Forecast Amount" := P_SalesLines."Outstanding Amount" / (1 + P_SalesLines."VAT %" / 100);
        ;
        siv."Forecast Qty" := P_SalesLines."Outstanding Quantity";

        CalcYarnforcast(siv);

        //siv.Parent :=P_SalesLines."Origin Cutset No.";
        siv.Debitor := P_SalesLines."Sell-to Customer No.";
        siv."Composition Key Total" := itemLoc."KVSTEX Composition Key Total";
        SalesSetup.GET;
        DefDim.RESET;
        DefDim.SETRANGE("Table ID", 18);
        DefDim.SETRANGE("No.", P_SalesLines."Sell-to Customer No.");
        DefDim.SETRANGE("Dimension Code", SalesSetup."Customer Group Dimension Code");
        if not DefDim.FIND('-') then
            DefDim.INIT;
        siv.Debitorengruppe := DefDim."Dimension Value Code";

        CustomerLoc.GET(P_SalesLines."Sell-to Customer No.");
        siv."Customer Name" := Customerloc.name;
        siv.Land := CustomerLoc."Country/Region Code";
        siv.Verkäufercode := CustomerLoc."Salesperson Code";


        case itemLoc."Base Unit of Measure" of
            'M':
                begin
                    siv."Forecast Meter" := Conversion(itemLoc."No.", siv."Forecast Qty", ItemSourceLoc);
                    siv."Forecast Gesamt meter" := siv."Forecast Meter";
                end;
            'STK':
                begin
                    siv."Forecast STK" := siv."Forecast Qty";
                    siv."Forecast STK-M" := Conversion(itemLoc."No.", siv."Forecast Qty", ItemSourceLoc);
                    siv."Forecast Gesamt meter" := siv."Forecast STK-M";
                end;
            'QM':
                begin
                    siv."Forecast QM" := siv."Forecast Qty";
                    siv."Forecast QM-M" := Conversion(itemLoc."No.", siv."Forecast Qty", ItemSourceLoc);
                    siv."Forecast Gesamt meter" := siv."Forecast QM-M";
                end;
        end;
        if itemLoc."Base Unit of Measure" = 'KG' then
            siv."Forecast KG" := siv."Forecast Qty"
        else
            siv."Forecast KG" := siv."Forecast Qty" * itemLoc."Net Weight";
        siv."Entry Date" := P_SalesLines."Shipment Date";
        siv.INSERT;

        // end;
    end;

    procedure CreateTempSalesLines(P_SalesLine: Record "Sales Line"; P_ItemNo: Code[20]; P_QtyPer: Decimal; CalledByFieldNoPar: Integer);
    var
        TempSalesHeaderLoc: Record "Sales Header" temporary;
        CustLoc: Record Customer;
        // SalesPriceMgtLoc: Codeunit "Sales Price Calc. Mgt.";
        SalesHeader: Record "Sales Header";
        ItemLoc: Record Item;
        PriceCalculation: Interface "Price Calculation";
        PriceType: Enum "Price Type";
    begin
        // Start KVS002.MK

        SalesHeader.GET(P_SalesLine."Document Type", P_SalesLine."Document No.");

        TempSalesHeaderLoc.INIT;
        TempSalesHeaderLoc := SalesHeader;

        /*
        TempSalesLine.RESET;
        IF TempSalesLine.FINDLAST THEN
          NextLineNo:=TempSalesLine."Line No."+1
        ELSE
          NextLineNo:=100000;
        */

        NextLineNo := NextLineNo + 1;
        ItemLoc.GET(P_ItemNo);
        TempSalesLine.INIT;
        TempSalesLine := P_SalesLine;
        TempSalesLine."Line No." := NextLineNo;
        TempSalesLine."No." := P_ItemNo;
        TempSalesLine."KVSOrigin Cutset No." := P_SalesLine."No.";
        TempSalesLine.Quantity := P_SalesLine.Quantity * P_QtyPer;
        TempSalesLine."Outstanding Quantity" := P_SalesLine."Outstanding Quantity" * P_QtyPer;

        ItemCrossRef.RESET;
        ItemCrossRef.SETFILTER("Item No.", TempSalesLine."No.");
        ItemCrossRef.SETFILTER("Unit of Measure", ItemLoc."Sales Unit of Measure");
        ItemCrossRef.SETRANGE("KVS Active Item No.", true);
        ItemCrossRef.SETRANGE("Reference Type", ItemCrossRef."Reference Type"::Customer);
        ItemCrossRef.SETRANGE("Reference Type No.", P_SalesLine."Sell-to Customer No.");
        if ItemCrossRef.FINDFIRST() then
            TempSalesLine."IC Item Reference No." := ItemCrossRef."Reference No.";
        TempSalesLine.INSERT;
        TempSalesLine.GetPriceCalculationHandler(PriceType::Sale, SalesHeader, PriceCalculation);
        TempSalesLine.ApplyDiscount(PriceCalculation);
        TempSalesLine.ApplyPrice(TempSalesLine.FieldNo(Quantity), PriceCalculation);

        // SalesPriceMgtLoc.FindSalesLineLineDisc(TempSalesHeaderLoc, TempSalesLine);
        // SalesPriceMgtLoc.FindSalesLinePrice(TempSalesHeaderLoc, TempSalesLine, CalledByFieldNoPar);
        TempSalesLine."Outstanding Amount" := TempSalesLine."Outstanding Quantity" * TempSalesLine."Unit Price";
        TempSalesLine.MODIFY;

    end;

    procedure UnfoldCutsetLines(var P_SalesLine: Record "Sales Line"; var P_HasBom: Boolean);
    var
        itemLoc: Record Item;
        ProdBOMLine: Record "Production BOM Line";
        ActiveVersionCode: Code[10];
        VersionMgt: Codeunit VersionManagement;
        ProdBOMHeader: Record "Production BOM Header";
        ItemSourceLoc: Code[20];
        Referenz: Record "Item Reference";
        "Referenznr.": Code[20];
        QtyPer: Decimal;
    begin
        itemLoc.GET(P_SalesLine."No.");
        ProdBOMHeader.GET(itemLoc."Production BOM No.");

        ActiveVersionCode := VersionMgt.GetBOMVersion(ProdBOMHeader."No.", WORKDATE, true);
        ProdBOMLine.RESET;
        ProdBOMLine.SETRANGE("Production BOM No.", ProdBOMHeader."No.");
        ProdBOMLine.SETRANGE("Version Code", ActiveVersionCode);
        ProdBOMLine.SETFILTER("No.", '<>%1', '');
        if ProdBOMLine.FIND('-') then
            repeat
                CreateTempSalesLines(P_SalesLine, ProdBOMLine."No.", ProdBOMLine."Quantity per", 6);
                P_HasBom := true;
            until (ProdBOMLine.NEXT = 0)
    end;

    procedure ExchangeLCYTFCR(P_TableID: Integer; P_DocNo: Code[20]; var P_Amount: Decimal; P_OrigCurrency: Code[20]; ToCurrencyCode: Code[20]; P_PostingDate: Date);
    var
        LSalesInvHeader: Record "Sales Invoice Header";
        LSalesHeader: Record "Sales Header";
        LSalesInvLines: Record "Sales Invoice Line";
        LCreditInvHeader: Record "Sales Cr.Memo Header";
        LCreditInvLines: Record "Sales Cr.Memo Line";
        AmountLCY: Decimal;
        LrecExchangeRate: Record "Currency Exchange Rate";
        GeneralLedger: Record "General Ledger Setup";
        LSalesPlanLine: Record "KVSTurnoverPlanLine";
        LEntryNo: Integer;
        LDelSchedHeader: Record "KVSFCYDeliverySchedHeader";
    begin
        GeneralLedger.GET;
        if (ToCurrencyCode = '') and (P_TableID in [5802, 36, 80153, 5030054]) then begin
            P_Amount := P_Amount;
            exit;
        end;

        if (P_OrigCurrency = '') and (ToCurrencyCode = GeneralLedger."LCY Code") then begin
            P_Amount := P_Amount;
            exit;
        end;

        if (P_OrigCurrency = '') and (ToCurrencyCode = '') then begin
            P_Amount := P_Amount;
            exit;
        end;

        //IF (P_OrigCurrency <>'') AND (ToCurrencyCode='') AND (P_TableID=5030054)  THEN
        //  ToCurrencyCode :=P_OrigCurrency;


        if (ToCurrencyCode <> GeneralLedger."LCY Code") then begin
            LrecExchangeRate.RESET;
            LrecExchangeRate.SETRANGE("Currency Code", ToCurrencyCode);
            LrecExchangeRate.SETFILTER("Starting Date", '..%1', P_PostingDate);
            if LrecExchangeRate.FINDLAST then begin
                if GeneralLedger."KVS G/L Mexico" then
                    P_Amount := ROUND((P_Amount / (LrecExchangeRate."Relational Exch. Rate Amount" / LrecExchangeRate."Exchange Rate Amount"))
                              , 0.01, '=')
                else
                    P_Amount := ROUND((P_Amount * (LrecExchangeRate."Exchange Rate Amount" / LrecExchangeRate."Relational Exch. Rate Amount"))
                              , 0.01, '=');
            end else
                ERROR(STRSUBSTNO('TbaleID:%1#Document No. %2#PAmount: %3#Orig currency:%4# new Currency:%5#Date:%6'),
                FORMAT(P_TableID),
                P_DocNo,
                FORMAT(P_Amount),
                P_OrigCurrency,
                ToCurrencyCode,
                FORMAT(P_PostingDate));

        end;
    end;

    procedure CreateWareneinsatztposten(P_ValueEntry: Record "Value Entry"; P_delete: Boolean; P_checkdouble: Boolean; P_CurrencyDate: Date);
    var
        SalesPlanHeader: Record "KVSTurnoverPlanHeader";
        SalesPlanLine: Record "KVSTurnoverPlanLine";
        SalesPlanLine2: Record "KVSTurnoverPlanLine";
        LineNo: Integer;
        SalesPlanLedgerEntry: Record "KVSTurnoverPlanLedgerEntry";
        CreateCOSPlanEntries: Report "KVSCreateCOSPlanEntries";
        COSPlanEntry: Record "KVSCOSTurnoverEntry";
        LSollISTCOSEntry: Record "KVSExp.-Act. COS Entry";
    begin
        if not CalcGarneinsatz then
            exit;
        LSollISTCOSEntry.CreateNewEntryFromSalesPlan(P_ValueEntry, P_delete, P_checkdouble, P_CurrencyDate);
    end;

    procedure TotalGarnEinsatzIST(var P_SIV: Record "UTT SalesBuffer"; P_salesPlanName: Code[20]; P_ItemNo: Code[20]);
    var
        LSollISTCosEntry: Record "KVSExp.-Act. COS Entry";
        LResult: Decimal;
    begin
        if not CalcGarneinsatz then
            exit;

        LSollISTCosEntry.RESET;
        LSollISTCosEntry.SETCURRENTKEY("Turnover Plan Name", "Item No.", "Customer No.", Date, "Line No.", Type, "Warp Type", "Item Type");
        LSollISTCosEntry.SETRANGE("Turnover Plan Name", P_salesPlanName);
        LSollISTCosEntry.SETRANGE("Item No.", P_ItemNo);
        LSollISTCosEntry.SETRANGE("Customer No.", P_SIV.Debitor);
        LSollISTCosEntry.SETRANGE(Date, StartDate, EndDate);
        LSollISTCosEntry.SETFILTER("Line No.", '<>%1', 0);
        LSollISTCosEntry.SETRANGE(Type, LSollISTCosEntry.Type::Item);
        LSollISTCosEntry.SETFILTER("Warp Type", '%1|%2', 0, 7);
        LSollISTCosEntry.SETRANGE("Item Type", LSollISTCosEntry."Item Type"::Yarn);
        //LSollISTCosEntry.FINDSET;
        LSollISTCosEntry.CALCSUMS(Quantity, LSollISTCosEntry."Unit Amount");
        P_SIV."Garneinsatz KG IST" := ABS(LSollISTCosEntry.Quantity);
        P_SIV."Garneinsatz Kosten IST" := ABS(LSollISTCosEntry."Unit Amount");
    end;

    procedure TotalGarnEinsatzSOLL(P_SIV: Record "UTT SalesBuffer"; P_salesPlanLedgerEntry: Record "KVSTurnoverPlanLedgerEntry"; var P_GarnQty: Decimal; var P_GarnKosten: Decimal);
    var
        LSalesCostPlanEntry: Record "KVSCOSTurnoverEntry";
        LResult: Decimal;
        LItemRec: Record Item;
    begin
        if not CalcGarneinsatz then
            exit;

        LSalesCostPlanEntry.RESET;
        LSalesCostPlanEntry.SETCURRENTKEY(Type, "Line No.", "Entry No. Sa. Plan Led. Entry", "Version No.", "Turnover Plan Name", Date, "Warp Type");
        LSalesCostPlanEntry.SETRANGE(Type, LSalesCostPlanEntry.Type::Item);
        LSalesCostPlanEntry.SETRANGE("Line No.", P_salesPlanLedgerEntry."Line No.");
        LSalesCostPlanEntry.SETRANGE("Entry No. Sa. Plan Led. Entry", P_salesPlanLedgerEntry."Entry No.");
        LSalesCostPlanEntry.SETRANGE("Version No.", P_salesPlanLedgerEntry."Version No.");
        LSalesCostPlanEntry.SETRANGE("Turnover Plan Name", P_salesPlanLedgerEntry."Turnover Plan Name");
        LSalesCostPlanEntry.SETRANGE(Date, StartDate, EndDate);
        LSalesCostPlanEntry.SETFILTER("Warp Type", '%1|%2', 0, 7);
        if LSalesCostPlanEntry.FINDFIRST then
            repeat
                LItemRec.GET(LSalesCostPlanEntry."No.");
                if LItemRec."KVSTEX Item Type" = LItemRec."KVSTEX Item Type"::Yarn then begin
                    P_GarnQty := P_GarnQty + LSalesCostPlanEntry.Quantity;
                    P_GarnKosten := P_GarnKosten + LSalesCostPlanEntry."Unit Amount";
                end;
            until LSalesCostPlanEntry.NEXT = 0;
    end;

    procedure CalcYarnforcast(var P_siv: Record "UTT SalesBuffer");
    var
        ValueBufferTemp: Record "Value Entry" temporary;
        LSalesPlanLedgEntry: Record "KVSTurnoverPlanLedgerEntry";
        LastNo: Integer;
        LCOSEntry: Record "KVSExp.-Act. COS Entry";
        lastno1: Integer;
        lastno2: Integer;
    begin
        if not CalcGarneinsatz then
            exit;

        LSalesPlanLedgEntry.RESET;
        LSalesPlanLedgEntry.FINDLAST;
        LastNo := LSalesPlanLedgEntry."Entry No." + 10000;


        ValueBufferTemp.INIT;
        ValueBufferTemp."Entry No." := LastNo;
        ValueBufferTemp."Item No." := P_siv."Artikelnr.";
        ValueBufferTemp."Source No." := P_siv.Debitor;
        ValueBufferTemp."Invoiced Quantity" := P_siv."Forecast Qty";
        CreateWareneinsatztposten(ValueBufferTemp, true, false, CurrencyDate);

        LCOSEntry.RESET;
        LCOSEntry.SETCURRENTKEY("Record marked", "Entry No. Sa. Plan Led. Entry", Type, "Warp Type", "Item Type");
        LCOSEntry.SETRANGE("Record marked", true);
        LCOSEntry.SETRANGE("Entry No. Sa. Plan Led. Entry", LastNo);
        LCOSEntry.SETRANGE(Type, LCOSEntry.Type::Item);
        LCOSEntry.SETFILTER("Warp Type", '%1|%2', 0, 7);
        LCOSEntry.SETRANGE("Item Type", LCOSEntry."Item Type"::Yarn);
        LCOSEntry.CALCSUMS(Quantity, "Unit Amount");

        P_siv."Garneinsatz KG Forcast" := LCOSEntry.Quantity;
        P_siv."Garneinsatz Kosten Forcast" := LCOSEntry."Unit Amount";

        LCOSEntry.RESET;
        LCOSEntry.SETRANGE(LCOSEntry."Entry No. Sa. Plan Led. Entry", ValueBufferTemp."Entry No.");
        LCOSEntry.SETRANGE("Record marked", true);
        //LCOSEntry.MODIFYALL("Record marked",FALSE);
        LCOSEntry.DELETEALL;
    end;

    procedure GetYarn(ItemNo: Code[20]): Code[20];
    var
        itemLoc: Record Item;
        ProdBOMLineLoc: Record "Production BOM Line";
        ActiveVersionCode: Code[10];
        VersionMgt: Codeunit VersionManagement;
        ProdBOMHeaderLoc: Record "Production BOM Header";
        ItemBom: Record Item;
        Foundloc: Boolean;
    begin
        Found := false;
        CLEAR(RwItem);
        itemLoc.GET(ItemNo);
        if not ProdBOMHeaderLoc.GET(itemLoc."Production BOM No.") then
            exit;
        ActiveVersionCode := VersionMgt.GetBOMVersion(ProdBOMHeaderLoc."No.", WORKDATE, true);
        ProdBOMLineLoc.RESET;
        ProdBOMLineLoc.SETRANGE("Production BOM No.", ProdBOMHeaderLoc."No.");
        ProdBOMLineLoc.SETRANGE("Version Code", ActiveVersionCode);
        ProdBOMLineLoc.SETRANGE(Type, ProdBOMLineLoc.Type::Item);
        if ProdBOMLineLoc.FINDFIRST then
            repeat
                ItemBom.GET(ProdBOMLineLoc."No.");
                if (itemLoc."KVSTEX Warp Type" = itemLoc."KVSTEX Warp Type"::Normal) and
                  (ItemBom."KVSTEX Item Type" = ItemBom."KVSTEX Item Type"::Yarn) then begin
                    Found := true;
                    RwItem := ItemBom."No.";
                end else
                    GetYarn(ProdBOMLineLoc."No.");
            until (ProdBOMLineLoc.NEXT = 0) or Found;
        exit(RwItem);
    end;

    procedure GetYarnInfo(var P_SIV: Record "UTT SalesBuffer");
    var
        ItemLoc: Record Item;
        VendorLoc: Record Vendor;
    begin
        if not ItemLoc.GET(P_SIV.Kettgarn) then
            ItemLoc.INIT;

        if VendorLoc.GET(ItemLoc."Vendor No.") then
            P_SIV."Kettgarn Kredior" := VendorLoc."No." + '   ' + VendorLoc.Name;

        P_SIV."Kettgarn Detex" := FORMAT(ItemLoc."KVSTEX Titer Nominal");
    end;

    procedure ExchangeFCR2LCY(P_TableID: Integer; P_DocNo: Code[20]; var P_Amount: Decimal; P_OrigCurrency: Code[20]; ToCurrencyCode: Code[20]; P_PostingDate: Date);
    var
        LSalesInvHeader: Record "Sales Invoice Header";
        LSalesHeader: Record "Sales Header";
        LSalesInvLines: Record "Sales Invoice Line";
        LCreditInvHeader: Record "Sales Cr.Memo Header";
        LCreditInvLines: Record "Sales Cr.Memo Line";
        AmountLCY: Decimal;
        LrecExchangeRate: Record "Currency Exchange Rate";
        GeneralLedger: Record "General Ledger Setup";
        LSalesPlanLine: Record "KVSTurnoverPlanLine";
        LEntryNo: Integer;
        LDelSchedHeader: Record "KVSFCYDeliverySchedHeader";
    begin
        if P_OrigCurrency = '' then
            exit;

        GeneralLedger.GET;
        LrecExchangeRate.RESET;
        LrecExchangeRate.SETRANGE("Currency Code", P_OrigCurrency);
        LrecExchangeRate.SETFILTER("Starting Date", '..%1', P_PostingDate);
        if LrecExchangeRate.FINDLAST then begin
            if GeneralLedger."KVS G/L Mexico" then
                P_Amount := ROUND((P_Amount / (LrecExchangeRate."Exchange Rate Amount" / LrecExchangeRate."Relational Exch. Rate Amount"))
                          , 0.01, '=')
            else
                P_Amount := ROUND((P_Amount * (LrecExchangeRate."Exchange Rate Amount" / LrecExchangeRate."Relational Exch. Rate Amount"))
                          , 0.01, '=');

        end else
            ERROR(STRSUBSTNO('TbaleID:%1#Document No. %2#PAmount: %3#Orig currency:%4# new Currency:%5#Date:%6'),
            FORMAT(P_TableID),
            P_DocNo,
            FORMAT(P_Amount),
            P_OrigCurrency,
            ToCurrencyCode,
            FORMAT(P_PostingDate));
    end;

}

