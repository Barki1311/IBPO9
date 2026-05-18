xmlport 67029 "UTT O9 Purchase Export_SP"
{
    Caption = 'UTT O9 Purchase Export_SP';
    Format = VariableText;
    Direction = Export;
    TextEncoding = UTF8;
    UseRequestPage = false;
    FileName = 'IVMK_PO_KPI_SP_dsv';
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

                textelement(POHeaderID_LineIDLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        POHeaderID_LineIDLbl := 'POHeaderID_LineID';
                        IBPO9Buffer."Field 1" := POHeaderID_LineIDLbl;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(PO_CreationDateLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        PO_CreationDateLbl := 'POCreationDate';
                        IBPO9Buffer."Field 2" := PO_CreationDateLbl;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(SupplierLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        SupplierLbl := 'Supplier';
                        IBPO9Buffer."Field 3" := SupplierLbl;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(Matl_NumberLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        Matl_NumberLbl := 'MatlNumber';
                        IBPO9Buffer."Field 4" := Matl_NumberLbl;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(locationLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        locationLbl := 'Location';
                        IBPO9Buffer."Field 5" := locationLbl;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(TransModeLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        TransModeLbl := 'TransMode';
                        IBPO9Buffer."Field 6" := TransModeLbl;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(POCommitQuantityLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        POCommitQuantityLbl := 'POCommitQuantity';
                        IBPO9Buffer."Field 7" := POCommitQuantityLbl;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(UOM_POCommitQuantityLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        UOm_POCommitQuantityLbl := 'UOMofPOCommitQuantity';
                        IBPO9Buffer."Field 8" := UOm_POCommitQuantityLbl;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(POCommittedDeliveryDateLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        POCommittedDeliveryDateLbl := 'POCommittedDeliveryDate';
                        IBPO9Buffer."Field 9" := POCommittedDeliveryDateLbl;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(statusLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        statusLbl := 'Status';
                        IBPO9Buffer."Field 10" := statusLbl;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(PO_Goods_Receipt_DateLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        PO_Goods_Receipt_DateLbl := 'POGoodsReceiptDate';
                        IBPO9Buffer."Field 11" := PO_Goods_Receipt_DateLbl;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(PO_Goods_Receipt_QuantityLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        PO_Goods_Receipt_QuantityLbl := 'POGoodsReceiptQuantity';
                        IBPO9Buffer."Field 12" := PO_Goods_Receipt_QuantityLbl;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(UOM_Receipt_QuantityLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        UOM_Receipt_QuantityLbl := 'UOMofPOGoodsReceiptQuantity';
                        IBPO9Buffer."Field 13" := UOM_Receipt_QuantityLbl;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(PO_releaseStatusLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        PO_releaseStatusLbl := 'POreleaseStatus';
                        IBPO9Buffer."Field 14" := PO_releaseStatusLbl;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(POOpenQuantityLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        POOpenQuantityLbl := 'POOpenQuantity';
                        IBPO9Buffer."Field 15" := POOpenQuantityLbl;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(UoMPOOpenQuantityLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        UoMPOOpenQuantityLbl := 'UoMPOOpenQuantity';
                        IBPO9Buffer."Field 16" := UoMPOOpenQuantityLbl;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(POTypeLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        POTypeLbl := 'POType';
                        IBPO9Buffer."Field 17" := POTypeLbl;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(SalesOrderLineIDLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        SalesOrderLineIDLbl := 'SalesOrderLineID';
                        IBPO9Buffer."Field 18" := SalesOrderLineIDLbl;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(MaterialDescriptionLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        MaterialDescriptionLbl := 'MaterialDescription';
                        IBPO9Buffer."Field 19" := MaterialDescriptionLbl;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(QualityLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        QualityLbl := 'Quality';
                        IBPO9Buffer."Field 20" := QualityLbl;
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
                    IBPO9Buffer."Export Batch ID" := 'POKPI_SP';
                    IBPO9Buffer.Insert();
                end;
            }

            tableelement(PurchLine; "Purchase Line")
            {
                XmlName = 'UOM';
                RequestFilterFields = "Document No.";
                SourceTableView = WHERE(type = const(item));

                textelement(POHeaderID_LineID)
                {
                    trigger OnBeforePassVariable()
                    begin
                        clear(POHeaderID_LineID);
                        if not PurchHeader.get(PurchLine."Document Type", PurchLine."Document No.") then
                            currXMLport.Break();
                        POHeaderID_LineID := StrSubstNo('%1-%2', PurchLine."Document No.", PurchLine."Line No.");
                        IBPO9Buffer."Field 1" := POHeaderID_LineID;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(PO_CreationDate)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        PO_CreationDate := format(PurchHeader."Order Date", 0, '<year4>/<month,2>/<day,2>');
                        if PO_CreationDate = '' then
                            PO_CreationDate := format(PurchLine."Planned Receipt Date", 0, '<year4>/<month,2>/<day,2>');
                        IBPO9Buffer."Field 2" := PO_CreationDate;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(Supplier)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        Supplier := PurchLine."Buy-from Vendor No.";
                        IBPO9Buffer."Field 3" := Supplier;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(Matl_Number)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        Matl_Number := PurchLine."No.";
                        IBPO9Buffer."Field 4" := Matl_Number;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(location)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        location := PLANT_CD;
                        IBPO9Buffer."Field 5" := location;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(TransMode)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                        Vendor: record Vendor;
                    begin
                        Vendor.get(PurchLine."Buy-from Vendor No.");
                        case CompanyInfo."Country/Region Code" of
                            'DE':
                                begin
                                    if Vendor."Gen. Bus. Posting Group" in ['INLAND', 'EU'] then
                                        Transmode := 'Truck'
                                    else
                                        Transmode := 'Ship'
                                end;
                            'MX':
                                begin
                                    if Vendor."No." = '10006' then
                                        TransMode := 'Ship'
                                    else
                                        TransMode := 'Truck';
                                end;
                        end;
                        IBPO9Buffer."Field 6" := TransMode;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(POCommitQuantity)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        POCommitQuantity := format(PurchLine.Quantity, 0, 9);
                        IBPO9Buffer."Field 7" := POCommitQuantity;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(UOm_POCommitQuantity)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        UOm_POCommitQuantity := format(PurchLine."Unit of Measure code");
                        IBPO9Buffer."Field 8" := UOm_POCommitQuantity;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(POCommittedDeliveryDate)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        POCommittedDeliveryDate := format(PurchLine."Promised Receipt Date", 0, '<year4>/<month,2>/<day,2>');
                        if POCommittedDeliveryDate = '' then
                            POCommittedDeliveryDate := format(PurchLine."Planned Receipt Date", 0, '<year4>/<month,2>/<day,2>');
                        IBPO9Buffer."Field 9" := POCommittedDeliveryDate;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(status)
                {
                    trigger OnBeforePassVariable()
                    begin
                        status := 'Open';
                        IBPO9Buffer."Field 10" := status;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(PO_Goods_Receipt_Date)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        PO_Goods_Receipt_Date := '';
                        IBPO9Buffer."Field 11" := PO_Goods_Receipt_Date;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(PO_Goods_Receipt_Quantity)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        PO_Goods_Receipt_Quantity := format(0, 0, 9);
                        IBPO9Buffer."Field 12" := PO_Goods_Receipt_Quantity;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(UOM_Receipt_Quantity) 
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        UOM_Receipt_Quantity := PurchLine."Unit of Measure Code";
                        IBPO9Buffer."Field 13" := UOM_Receipt_Quantity;
                        IBPO9Buffer.Modify();
                    end;
                 }
                textelement(PO_releaseStatus)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        PO_releaseStatus := 'N/A';
                        IBPO9Buffer."Field 14" := PO_releaseStatus;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(POOpenQuantity)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        POOpenQuantity := format(PurchLine."Outstanding Quantity", 0, 9);
                        IBPO9Buffer."Field 15" := POOpenQuantity;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(UoMPOOpenQuantity)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        UoMPOOpenQuantity := PurchLine."Unit of Measure Code";
                        IBPO9Buffer."Field 16" := UoMPOOpenQuantity;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(POType)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        if PurchLine."Document Type" = PurchLine."Document Type"::Order then
                            POType := 'Standard'
                        else
                            POType := 'Blanket';
                        IBPO9Buffer."Field 17" := POType;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(SalesOrderLineID)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        SalesOrderLineIDLbl := '';
                        IBPO9Buffer."Field 18" := SalesOrderLineIDLbl;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(MaterialDescription)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                        Item: record Item;
                    begin
                        Item.get(PurchLine."No.");
                        MaterialDescription := Item.Description;
                        IBPO9Buffer."Field 19" := MaterialDescription;
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
                        IBPO9Buffer."Field 20" := Quality;
                        IBPO9Buffer.Modify();
                    end;
                }

                trigger OnPreXmlItem()
                var
                begin
                    CompanyInfo.get();
                    case CompanyInfo."Country/Region Code" of
                        'DE':
                            PLANT_CD := 'IVMK';
                        'MX':
                            PLANT_CD := 'IVMP';
                    end;
                    PurchLine.SetFilter("Document Type", '%1|%2', PurchLine."Document Type"::Order, PurchLine."Document Type"::"Blanket Order");
                    PurchLine.SetRange(Type, PurchLine.Type::Item);
                    PurchLine.setrange("Planned Receipt Date", StartDate, EndDate);
                    PurchLine.Setfilter("Outstanding Quantity", '>%1', 0);
                    if PLANT_CD = 'IVMK' then
                        PurchLine.SetFilter("Location Code", '%1|%2|%3', 'KETTBAUM', 'KOMBILINE', 'GARNLAGER');
                    if PLANT_CD = 'IVMP' then
                        PurchLine.SetFilter("Location Code", '%1|%2|%3', 'ALMHILO', 'ALMPROACA', 'ALMLAM');
                end;

                trigger OnAfterGetRecord()
                var
                    Vendor: record Vendor;
                begin
                    IBPO9Buffer.Init();
                    if not IBPO9Buffer.FindLast() then
                        IBPO9Buffer."Entry No." := 1
                    else
                        IBPO9Buffer."Entry No." := IBPO9Buffer."Entry No." + 1;
                    IBPO9Buffer."Export Date" := CurrentDateTime();
                    IBPO9Buffer."Export Batch ID" := 'POKPI_SP';
                    IBPO9Buffer.Insert();
                end;
            }

            tableelement(PurchLineRcpt; "Purch. Rcpt. Line")
            {
                XmlName = 'UOM';
                RequestFilterFields = "Document No.";
                SourceTableView = WHERE(type = const(item));

                textelement(POHeaderID_LineIDRcpt)
                {
                    trigger OnBeforePassVariable()
                    begin
                        clear(POHeaderID_LineIDRcpt);
                        if not PurchHeaderRcpt.get(PurchLineRcpt."Document No.") then
                            currXMLport.Break();
                        POHeaderID_LineIDRcpt := StrSubstNo('%1-%2', PurchLineRcpt."Document No.", PurchLineRcpt."Line No.");
                        IBPO9Buffer."Field 1" := POHeaderID_LineIDRcpt;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(PO_CreationDateRcpt)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        PO_CreationDateRcpt := format(PurchHeaderRcpt."Order Date", 0, '<year4>/<month,2>/<day,2>');
                        if PO_CreationDateRcpt = '' then
                            PO_CreationDateRcpt := format(PurchLineRcpt."Planned Receipt Date", 0, '<year4>/<month,2>/<day,2>');
                        IBPO9Buffer."Field 2" := PO_CreationDateRcpt;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(SupplierRcpt)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        SupplierRcpt := PurchLineRcpt."Buy-from Vendor No.";
                        IBPO9Buffer."Field 3" := SupplierRcpt;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(Matl_NumberRcpt)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        Matl_NumberRcpt := PurchLineRcpt."No.";
                        IBPO9Buffer."Field 4" := Matl_NumberRcpt;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(locationRcpt)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        locationRcpt := PLANT_CD;
                        IBPO9Buffer."Field 5" := locationRcpt;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(TransModeRcpt)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                        Vendor: record Vendor;
                    begin
                        Vendor.get(PurchLineRcpt."Buy-from Vendor No.");
                        case CompanyInfo."Country/Region Code" of
                            'DE':
                                begin
                                    if Vendor."Gen. Bus. Posting Group" in ['INLAND', 'EU'] then
                                        TransModeRcpt := 'Truck'
                                    else
                                        TransModeRcpt := 'Ship'
                                end;
                            'MX':
                                begin
                                    TransModeRcpt := 'Truck';
                                    if Vendor."No." = '10006' then
                                        TransModeRcpt := 'Ship';
                                end;
                        end;
                        IBPO9Buffer."Field 6" := TransModeRcpt;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(POCommitQuantityRcpt)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        POCommitQuantityRcpt := format(PurchLineRcpt.Quantity, 0, 9);
                        IBPO9Buffer."Field 7" := POCommitQuantityRcpt;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(UOm_POCommitQuantityRcpt)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        UOm_POCommitQuantityRcpt := format(PurchLineRcpt."Unit of Measure code");
                        IBPO9Buffer."Field 8" := UOm_POCommitQuantityRcpt;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(POCommittedDeliveryDateRcpt)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        POCommittedDeliveryDateRcpt := format(PurchLineRcpt."Promised Receipt Date", 0, '<year4>/<month,2>/<day,2>');
                        if POCommittedDeliveryDateRcpt = '' then
                            POCommittedDeliveryDateRcpt := format(PurchLineRcpt."Planned Receipt Date", 0, '<year4>/<month,2>/<day,2>');
                        IBPO9Buffer."Field 9" := POCommittedDeliveryDateRcpt;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(statusRcpt)
                {
                    trigger OnBeforePassVariable()
                    begin
                        statusRcpt := 'Closed';
                        IBPO9Buffer."Field 10" := statusRcpt;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(PO_Goods_Receipt_DateRcpt)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        PO_Goods_Receipt_DateRcpt := format(PurchLineRcpt."Posting Date", 0, '<year4>/<month,2>/<day,2>');
                        IBPO9Buffer."Field 11" := PO_Goods_Receipt_DateRcpt;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(PO_Goods_Receipt_QuantityRcpt)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        PO_Goods_Receipt_QuantityRcpt := format(PurchLineRcpt."Quantity", 0, 9);
                        IBPO9Buffer."Field 12" := PO_Goods_Receipt_QuantityRcpt;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(UOM_Receipt_QuantityRcpt) 
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        UOM_Receipt_QuantityRcpt := PurchLineRcpt."Unit of Measure Code";
                        IBPO9Buffer."Field 13" := UOM_Receipt_QuantityRcpt;
                        IBPO9Buffer.Modify();
                    end;
                 }
                textelement(PO_releaseStatusRcpt)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        PO_releaseStatusRcpt := 'N/A';
                        IBPO9Buffer."Field 14" := PO_releaseStatusRcpt;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(POOpenQuantityRcpt)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        POOpenQuantityRcpt := '0';
                        IBPO9Buffer."Field 15" := POOpenQuantityRcpt;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(UoMPOOpenQuantityRcpt)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        UoMPOOpenQuantityrcpt := PurchLineRcpt."Unit of Measure Code";
                        IBPO9Buffer."Field 16" := UoMPOOpenQuantityrcpt;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(POTypeRcpt)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        POTypeRcpt := 'Standard';
                        IBPO9Buffer."Field 17" := POTypeRcpt;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(SalesOrderLineIDRcpt)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        SalesOrderLineIDRcpt := '';
                        IBPO9Buffer."Field 18" := SalesOrderLineIDRcpt;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(MaterialDescriptionRcpt)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                        Item: record Item;
                    begin
                        Item.get(PurchLineRcpt."No.");
                        MaterialDescriptionRcpt := Item.Description;
                        IBPO9Buffer."Field 19" := MaterialDescriptionRcpt;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(QualityRcpt)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        QualityRcpt := 'Standard';
                        IBPO9Buffer."Field 20" := QualityRcpt;
                        IBPO9Buffer.Modify();
                    end;
                }

                trigger OnPreXmlItem()
                var
                begin
                    CompanyInfo.get();
                    case CompanyInfo."Country/Region Code" of
                        'DE':
                            PLANT_CD := 'IVMK';
                        'MX':
                            PLANT_CD := 'IVMP';
                    end;
                    PurchLineRcpt.setrange("Posting Date", StartDate, EndDate);
                    PurchLineRcpt.Setfilter(Quantity, '>%1', 0);
                    if PLANT_CD = 'IVMK' then
                        PurchLineRcpt.SetFilter("Location Code", '%1|%2|%3', 'KETTBAUM', 'KOMBILINE', 'GARNLAGER');
                    if PLANT_CD = 'IVMP' then
                        PurchLineRcpt.SetFilter("Location Code", '%1|%2|%3', 'ALMHILO', 'ALMPROACA', 'ALMLAM');
                end;

                trigger OnAfterGetRecord()
                var
                    Vendor: record Vendor;
                begin
                    Vendor.get(PurchLineRcpt."Buy-from Vendor No.");

                    IBPO9Buffer.Init();
                    if not IBPO9Buffer.FindLast() then
                        IBPO9Buffer."Entry No." := 1
                    else
                        IBPO9Buffer."Entry No." := IBPO9Buffer."Entry No." + 1;
                    IBPO9Buffer."Export Date" := CurrentDateTime();
                    IBPO9Buffer."Export Batch ID" := 'POKPI_SP';
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

    var
        PurchHeader: Record "Purchase Header";
        PurchHeaderRcpt: Record "Purch. Rcpt. Header";
        CompanyInfo: Record "Company Information";
        StartDate: date;
        EndDate: date;
        PLANT_CD: Text;
        IBPO9Buffer: Record "UTT IBPO9 Buffer";
}
