xmlport 67007 "UTT O9 Purchase Export"
{
    Caption = 'UTT O9 Purchase Export';
    Format = VariableText;
    Direction = Export;
    TextEncoding = UTF8;
    UseRequestPage = false;
    FileName = 'IVMK_PO_KPI_dsv';
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
                    end;
                }
                textelement(PO_CreationDateLbl)
                {
                    trigger OnBeforePassVariable()

                    begin
                        PO_CreationDateLbl := 'POCreationDate';

                    end;
                }
                textelement(SupplierLbl)
                {
                    trigger OnBeforePassVariable()

                    begin
                        SupplierLbl := 'Supplier';

                    end;
                }

                textelement(Matl_NumberLbl)
                {
                    trigger OnBeforePassVariable()

                    begin
                        Matl_NumberLbl := 'MatlNumber';

                    end;
                }
                textelement(locationLbl)
                {
                    trigger OnBeforePassVariable()

                    begin
                        locationLbl := 'Location';

                    end;
                }
                textelement(TransModeLbl)
                {
                    trigger OnBeforePassVariable()

                    begin
                        TransModeLbl := 'TransMode';

                    end;
                }
                textelement(POCommitQuantityLbl)
                {
                    trigger OnBeforePassVariable()

                    begin
                        POCommitQuantityLbl := 'POCommitQuantity';

                    end;
                }
                textelement(UOM_POCommitQuantityLbl)
                {
                    trigger OnBeforePassVariable()

                    begin
                        UOm_POCommitQuantityLbl := 'UOMofPOCommitQuantity';

                    end;
                }
                textelement(POCommittedDeliveryDateLbl)
                {
                    trigger OnBeforePassVariable()

                    begin
                        POCommittedDeliveryDateLbl := 'POCommittedDeliveryDate';

                    end;
                }
                textelement(statusLbl)
                {
                    trigger OnBeforePassVariable()

                    begin
                        statusLbl := 'Status';

                    end;
                }
                textelement(PO_Goods_Receipt_DateLbl)
                {
                    trigger OnBeforePassVariable()

                    begin
                        PO_Goods_Receipt_DateLbl := 'POGoodsReceiptDate';

                    end;
                }
                textelement(PO_Goods_Receipt_QuantityLbl)
                {
                    trigger OnBeforePassVariable()

                    begin
                        PO_Goods_Receipt_QuantityLbl := 'POGoodsReceiptQuantity';

                    end;
                }
                textelement(UOM_Receipt_QuantityLbl)
                {
                    trigger OnBeforePassVariable()

                    begin
                        UOM_Receipt_QuantityLbl := 'UOMofPOGoodsReceiptQuantity';

                    end;
                }
                textelement(PO_releaseStatusLbl)
                {
                    trigger OnBeforePassVariable()

                    begin
                        PO_releaseStatusLbl := 'POreleaseStatus';

                    end;
                }
                textelement(POOpenQuantityLbl)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        POOpenQuantityLbl := 'POOpenQuantity';
                    end;
                }
                textelement(UoMPOOpenQuantityLbl)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        UoMPOOpenQuantityLbl := 'UoMPOOpenQuantity';

                    end;
                }
                textelement(POTypeLbl)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        POTypeLbl := 'POType';

                    end;
                }
                textelement(SalesOrderLineIDLbl)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        SalesOrderLineIDLbl := 'SalesOrderLineID';

                    end;
                }
                textelement(MaterialDescriptionLbl)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        MaterialDescriptionLbl := 'MaterialDescription';

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
            }
            // tableelement(PurchLine; "Purchase Line")
            // {
            //     XmlName = 'UOM';
            //     RequestFilterFields = "Document No.";
            //     SourceTableView = WHERE("document type" = CONST(Order), type = const(item));


            //     textelement(POHeaderID_LineID)
            //     {
            //         trigger OnBeforePassVariable()
            //         begin
            //             if not PurchHeader.get(PurchLine."Document Type", PurchLine."Document No.") then
            //                 currXMLport.Break();
            //             POHeaderID_LineID := StrSubstNo('%1-%2', PurchLine."Document No.", PurchLine."Line No.")


            //         end;
            //     }
            //     textelement(PO_CreationDate)
            //     {
            //         trigger OnBeforePassVariable()
            //         var
            //             myInt: Integer;
            //         begin
            //             clear(PO_CreationDate);
            //             PO_CreationDate := format(PurchHeader."Order Date", 0, '<year4>/<month,2>/<day,2>');
            //             if PO_CreationDate = '' then
            //                 PO_CreationDate := format(PurchLine."Promised Receipt Date", 0, '<year4>/<month,2>/<day,2>');


            //         end;

            //     }
            //     fieldelement(Supplier; PurchLine."Buy-from Vendor No.") { }
            //     fieldelement(Matl_Number; PurchLine."No.") { }
            //     textelement(location)
            //     {
            //         trigger OnBeforePassVariable()
            //         var
            //             myInt: Integer;
            //         begin
            //             clear(location);
            //             location := PLANT_CD;
            //             //location := PurchLine."Location Code";
            //         end;

            //     }
            //     textelement(TransMode)
            //     {
            //         trigger OnBeforePassVariable()
            //         var
            //             myInt: Integer;
            //         begin
            //             TransMode := 'N/A';

            //         end;
            //     }
            //     textelement(POCommitQuantity)
            //     {
            //         trigger OnBeforePassVariable()
            //         var
            //             myInt: Integer;
            //         begin
            //             clear(POCommitQuantity);
            //             POCommitQuantity := format(PurchLine."KVSTEX Order Quantity", 0, 9)

            //         end;
            //     }
            //     fieldelement(UOm_POCommitQuantity; PurchLine."Unit of Measure Code") { }
            //     textelement(POCommittedDeliveryDate)
            //     {
            //         trigger OnBeforePassVariable()
            //         var
            //             myInt: Integer;
            //         begin
            //             POCommittedDeliveryDate := format(PurchLine."Promised Receipt Date", 0, '<year4>/<month,2>/<day,2>');
            //             if POCommittedDeliveryDate = '' then
            //                 POCommittedDeliveryDate := format(PurchLine."planned Receipt Date", 0, '<year4>/<month,2>/<day,2>')

            //         end;
            //     }
            //     textelement(status)
            //     {
            //         trigger OnBeforePassVariable()
            //         var
            //             PurchHeader: Record "Purchase Header";
            //         begin
            //             status := 'Open';

            //             //     PurchHeader.get(PurchLine."Document Type", PurchLine."Document No.");

            //             //     if PurchHeader.Status = PurchHeader.Status::Released then begin
            //             //         status := 'released';
            //             //     end
            //             //     else
            //             //         status := 'Open';
            //         end;
            //     }
            //     textelement(PO_Goods_Receipt_Date)
            //     {
            //         trigger OnBeforePassVariable()
            //         var
            //             myInt: Integer;
            //             PurchRcptLineLoc: record "Purch. Rcpt. Line";
            //         begin

            //             clear(PO_Goods_Receipt_Date);
            //             // PurchRcptLineLoc.SetRange("Order No.", PurchLine."Document No.");
            //             // PurchRcptLineLoc.setrange("Order Line No.", PurchLine."Line No.");
            //             // if PurchRcptLineLoc.findlast then
            //             //     PO_Goods_Receipt_Date := format(PurchRcptLineLoc."Posting Date", 0, '<year4>/<month,2>/<day,2>')

            //         end;
            //     }
            //     textelement(PO_Goods_Receipt_Quantity)
            //     {
            //         trigger OnBeforePassVariable()
            //         var
            //             myInt: Integer;
            //         begin
            //             Clear(PO_Goods_Receipt_Quantity);
            //             // PO_Goods_Receipt_Quantity := format(PurchLine."Quantity Received", 0, 9)
            //         end;

            //     }
            //     fieldelement(UOM_Receipt_Quantity; PurchLine."Unit of Measure Code") { }
            //     textelement(PO_releaseStatus)
            //     {
            //         trigger OnBeforePassVariable()
            //         var
            //             myInt: Integer;
            //         begin
            //             PO_releaseStatus := 'N/A';

            //         end;
            //     }

            //     trigger OnPreXmlItem()
            //     var

            //     begin
            //         CompanyInfo.get();
            //         case CompanyInfo."Country/Region Code" of
            //             'DE':
            //                 PLANT_CD := 'IVMK';
            //             'MX':
            //                 PLANT_CD := 'IVMP';
            //         end;

            //         PurchLine.setrange(SystemCreatedAt, CreateDateTime(StartDate, 0T), CreateDateTime(EndDate, 0T));
            //         PurchLine.setfilter("Outstanding Quantity", '<>%1', 0);
            //         if PLANT_CD = 'IVMK' then
            //             PurchLine.SetFilter("Location Code", '%1|%2|%3', 'KETTBAUM', 'KOMBILINE', 'GARNLAGER');
            //         if PLANT_CD = 'IVMP' then
            //             PurchLine.SetFilter("Location Code", '%1|%2|%3', 'ALMHILO', 'ALMPROACA');


            //     end;



            // }
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
                        POHeaderID_LineIDRcpt := StrSubstNo('%1-%2', PurchLineRcpt."Document No.", PurchLineRcpt."Line No.")


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
                            PO_CreationDateRcpt := format(PurchLineRcpt."Planned Receipt Date", 0, '<year4>/<month,2>/<day,2>')


                    end;

                }
                textelement(SupplierRcpt)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        SupplierRcpt := PurchLineRcpt."Buy-from Vendor No."

                    end;
                }
                textelement(Matl_NumberRcpt)

                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        Matl_NumberRcpt := PurchLineRcpt."No."

                    end;
                }
                textelement(locationRcpt)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        locationRcpt := PLANT_CD;
                        //locationRcpt := PurchLineRcpt."Location Code";
                    end;
                }
                textelement(TransModeRcpt)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        TransModeRcpt := 'N/A';

                    end;
                }
                textelement(POCommitQuantityRcpt)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        POCommitQuantityRcpt := format(PurchLineRcpt.Quantity, 0, 9)

                    end;
                }
                textelement(UOm_POCommitQuantityRcpt)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        UOm_POCommitQuantityRcpt := format(PurchLineRcpt."Unit of Measure code")

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
                            POCommittedDeliveryDateRcpt := format(PurchLineRcpt."Planned Receipt Date", 0, '<year4>/<month,2>/<day,2>')

                    end;
                }
                textelement(statusRcpt)
                {
                    trigger OnBeforePassVariable()

                    begin
                        statusRcpt := 'Closed';
                    end;
                }
                textelement(PO_Goods_Receipt_DateRcpt)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        PO_Goods_Receipt_DateRcpt := format(PurchLineRcpt."Posting Date", 0, '<year4>/<month,2>/<day,2>')

                    end;
                }
                textelement(PO_Goods_Receipt_QuantityRcpt)
                {

                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        PO_Goods_Receipt_QuantityRcpt := format(PurchLineRcpt."Quantity", 0, 9)


                    end;
                }
                textelement(UOM_Receipt_QuantityRcpt) 
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        UOM_Receipt_QuantityRcpt := format(PurchLineRcpt."Unit of Measure code")

                    end;

                 }
                textelement(PO_releaseStatusRcpt)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        PO_releaseStatusRcpt := 'N/A';

                    end;
                }


                textelement(POOpenQuantity)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        POOpenQuantity := '0';
                    end;
                }
                textelement(UoMPOOpenQuantity)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        UoMPOOpenQuantity := PurchLineRcpt."Unit of Measure Code";

                    end;
                }
                textelement(POType)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        POType := 'Standard';

                    end;
                }
                textelement(SalesOrderLineID)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        SalesOrderLineID := '';

                    end;
                }
                textelement(MaterialDescription)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        MaterialDescription := PurchLineRcpt.Description;

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

                    PurchLineRcpt.setrange("Posting Date", StartDate,EndDate);
                    PurchLineRcpt.Setfilter(Quantity, '>%1', 0);
                    if PLANT_CD = 'IVMK' then
                        PurchLineRcpt.SetFilter("Location Code", '%1|%2|%3', 'KETTBAUM', 'KOMBILINE', 'GARNLAGER');
                    if PLANT_CD = 'IVMP' then
                        PurchLineRcpt.SetFilter("Location Code", '%1|%2|%3', 'ALMHILO', 'ALMPROACA');

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

}
