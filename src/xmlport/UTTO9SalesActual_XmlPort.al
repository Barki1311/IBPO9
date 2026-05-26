xmlport 67005 "UTT O9SalesActual"
{
    Caption = 'UTT O9SalesActual';
    Format = VariableText;
    Direction = Export;
    TextEncoding = UTF8;
    UseRequestPage = false;
    FileName = 'IVMK_SalesActual.csv';
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

                textelement(SALES_ORDER_HDR_IDLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        SALES_ORDER_HDR_IDLbl := 'SalesOrderHeaderID';
                        IBPO9Buffer."Field 1" := SALES_ORDER_HDR_IDLbl;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(SALES_ORDER_LINE_IDLbl)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        SALES_ORDER_LINE_IDLbl := 'SalesOrderLineID';
                        IBPO9Buffer."Field 2" := SALES_ORDER_LINE_IDLbl;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(MATL_NUMLbl)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        MATL_NUMLbl := 'MatlNumber';
                        IBPO9Buffer."Field 3" := MATL_NUMLbl;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(PLANT_CDLbl)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        PLANT_CDLbl := 'Location';
                        IBPO9Buffer."Field 4" := PLANT_CDLbl;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(ACCOUNTLbl)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        ACCOUNTLbl := 'ShipTo';
                        IBPO9Buffer."Field 5" := ACCOUNTLbl;
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
                textelement(Invoice_DateLbl)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        Invoice_DateLbl := 'InvoiceDate';
                        IBPO9Buffer."Field 7" := Invoice_DateLbl;
                        IBPO9Buffer.Modify();
                    end;
                }

                textelement(ApplicationLbl)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        ApplicationLbl := 'ProductApplication';
                        IBPO9Buffer."Field 8" := ApplicationLbl;
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
                        IBPO9Buffer."Field 9" := QualityLbl;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(FINAL_COMMIT_DTLbl)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        FINAL_COMMIT_DTLbl := 'FinalCommitDate';
                        IBPO9Buffer."Field 10" := FINAL_COMMIT_DTLbl;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(OrderTypeLbl)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        OrderTypeLbl := 'OrderType';
                        IBPO9Buffer."Field 11" := OrderTypeLbl;
                        IBPO9Buffer.Modify();
                    end;
                }

                textelement(ORDER_CREATION_DTLbl)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        ORDER_CREATION_DTLbl := 'OrderCreationDate';
                        IBPO9Buffer."Field 12" := ORDER_CREATION_DTLbl;
                        IBPO9Buffer.Modify();
                    end;
                }

                textelement(ORDER_LAST_CHNGE_DTLbl)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        ORDER_LAST_CHNGE_DTLbl := 'OrderLastChangedDate';
                        IBPO9Buffer."Field 13" := ORDER_LAST_CHNGE_DTLbl;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(ORDER_COMMIT_QTYLbl)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        ORDER_COMMIT_QTYLbl := 'OrderCommitQuantity';
                        IBPO9Buffer."Field 14" := ORDER_COMMIT_QTYLbl;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(UOM_CommitQtyLbl)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        UOM_CommitQtyLbl := 'UOMofCommitQuantity';
                        IBPO9Buffer."Field 15" := UOM_CommitQtyLbl;
                        IBPO9Buffer.Modify();
                    end;
                }


                textelement(COMMOM_DTLbl)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        COMMOM_DTLbl := 'OrderCommitDate';
                        IBPO9Buffer."Field 16" := COMMOM_DTLbl;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(FINAL_COMMIT_QTYLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        FINAL_COMMIT_QTYLbl := 'FinalCommitQuantity';
                        IBPO9Buffer."Field 17" := FINAL_COMMIT_QTYLbl;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(ACTUAL_DLVRY_DTLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        ACTUAL_DLVRY_DTLbl := 'ActualDeliveryDate';
                        IBPO9Buffer."Field 18" := ACTUAL_DLVRY_DTLbl;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(ACTUAL_SHP_DTLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        ACTUAL_SHP_DTLbl := 'ActualShipDate';
                        IBPO9Buffer."Field 19" := ACTUAL_SHP_DTLbl;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(DELIVERED_QTLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        DELIVERED_QTLbl := 'DeliveredQuantity';
                        IBPO9Buffer."Field 20" := DELIVERED_QTLbl;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(UOM_DelivQtyLbl)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        UOM_DelivQtyLbl := 'UOMofDeliveredQuantity';
                        IBPO9Buffer."Field 21" := UOM_DelivQtyLbl;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(OPEN_COMMIT_QTYLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        OPEN_COMMIT_QTYLbl := 'OpenCommitQuantity';
                        IBPO9Buffer."Field 22" := OPEN_COMMIT_QTYLbl;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(ORDER_STATUSLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        ORDER_STATUSLbl := 'OrderStatus';
                        IBPO9Buffer."Field 23" := ORDER_STATUSLbl;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(ORDER_RQST_QTLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        ORDER_RQST_QTLbl := 'OrderRequestQuantity';
                        IBPO9Buffer."Field 24" := ORDER_RQST_QTLbl;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(UOM_OrderRequestedQtyLbl)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        UOM_OrderRequestedQtyLbl := 'UOMofRequestedQuantity';
                        IBPO9Buffer."Field 25" := UOM_OrderRequestedQtyLbl;
                        IBPO9Buffer.Modify();
                    end;
                }

                textelement(ORDER_RQST_DTLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        ORDER_RQST_DTLbl := 'OrderRequestDate';
                        IBPO9Buffer."Field 26" := ORDER_RQST_DTLbl;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(OPEN_REQUEST_QTYLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        OPEN_REQUEST_QTYLbl := 'OpenRequestQuantity';
                        IBPO9Buffer."Field 27" := OPEN_REQUEST_QTYLbl;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(ORDER_NET_VALUELbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        ORDER_NET_VALUELbl := 'OrderNetValue';
                        IBPO9Buffer."Field 28" := ORDER_NET_VALUELbl;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(Currency_OrderNetValueLbl)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        Currency_OrderNetValueLbl := 'CurrencyofOrderNetValue';
                        IBPO9Buffer."Field 29" := Currency_OrderNetValueLbl;
                        IBPO9Buffer.Modify();
                    end;

                }
                textelement(SELLING_PRICE_UNLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        SELLING_PRICE_UNLbl := 'Sellingpriceperunit';
                        IBPO9Buffer."Field 30" := SELLING_PRICE_UNLbl;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(Invoice_ValLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        Invoice_ValLbl := 'InvoiceValue';
                        IBPO9Buffer."Field 31" := Invoice_ValLbl;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(Currency_InvoiceValueLbl)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        Currency_InvoiceValueLbl := 'CurrencyofInvoiceValue';
                        IBPO9Buffer."Field 32" := Currency_InvoiceValueLbl;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(PaymentTermsLbl)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        PaymentTermsLbl := 'PaymentTerms';
                        IBPO9Buffer."Field 33" := PaymentTermsLbl;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(MaterialDescriptionLbl)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        MaterialDescriptionLbl := 'MaterialDescription';
                        IBPO9Buffer."Field 34" := MaterialDescriptionLbl;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(IncotermsLbl)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        IncotermsLbl := 'Incoterms';
                        IBPO9Buffer."Field 35" := IncotermsLbl;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(IncotermsPlaceLbl)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        IncotermsPlaceLbl := 'IncotermsPlace';
                        IBPO9Buffer."Field 36" := IncotermsPlaceLbl;
                        IBPO9Buffer.Modify();
                    end;
                }

                trigger OnAfterGetRecord()
                var
                    EntryNo: Integer;   
                begin
                    EntryNo := IBPO9Buffer.getNextEntry();
                    IBPO9Buffer.Init();
                    IBPO9Buffer."Entry No." := EntryNo;
                    IBPO9Buffer."Export Date" := CurrentDateTime();
                    IBPO9Buffer."Export Batch ID" := 'SALESACTUAL_SP';
                    IBPO9Buffer.Insert();
                end;

            }

            tableelement(SIV; "UTT SalesBuffer")
            {
                XmlName = 'o9SalesActual';
                textelement(SALES_ORDER_HDR_ID)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        SALES_ORDER_HDR_ID := siv."document No.";
                        IBPO9Buffer."Field 1" := SALES_ORDER_HDR_ID;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(SALES_ORDER_LINE_ID)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        SALES_ORDER_LINE_ID := siv."DocLineNo.";
                        IBPO9Buffer."Field 2" := SALES_ORDER_LINE_ID;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(MATL_NUM)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        MATL_NUM := siv."Artikelnr.";
                        CreateIVLMatdim(siv."Artikelnr.");
                        IBPO9Buffer."Field 3" := MATL_NUM;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(PLANT_CD)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        PLANT_CD := Plant;
                        IBPO9Buffer."Field 4" := PLANT_CD;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(Account_ShipTo)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        Account_ShipTo := siv.Debitor;
                        IBPO9Buffer."Field 5" := Account_ShipTo;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(SoldTo)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        SoldTo := siv.Debitor;
                        IBPO9Buffer."Field 6" := SoldTo;
                        IBPO9Buffer.Modify();
                    end;
                }

                textelement(Invoice_Date)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        Clear(Invoice_Date);

                        if (siv.QtyShipped <> 0) and (siv.OrderType in ['Posted Sales Shipment']) then
                            Invoice_Date := format(siv.postingDate, 0, '<year4>/<month,2>/<day,2>');
                        IBPO9Buffer."Field 7" := Invoice_Date;
                        IBPO9Buffer.Modify();
                    end;

                }
                textelement(Application)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                        customer: Record Customer;
                    begin
                        customer.get(siv.Debitor);

                        case customer."KVS Customer Group" of
                            '100':
                                Application := 'Airbag';
                            '501':
                                Application := 'Airbag';
                            else
                                Application := 'Specialties';
                        end;
                        IBPO9Buffer."Field 8" := Application;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(Quality)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                        RecyItem: Record item;
                    begin
                        clear(Quality);

                        Quality := 'Standard';
                        // recyItem.get(siv."Artikelnr.");
                        // if (RecyItem."Gen. Prod. Posting Group" = 'RECYCL') then
                        //     Quality := 'C';
                        IBPO9Buffer."Field 9" := Quality;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(FINAL_COMMIT_DT)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        clear(FINAL_COMMIT_DT);
                        FINAL_COMMIT_DT := Format(Siv.PromdisedDeliveryDate, 0, '<year4>/<month,2>/<day,2>');
                        IBPO9Buffer."Field 10" := FINAL_COMMIT_DT;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(OrderType)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        // case siv.OrderType of
                        //     'Order':
                        //         OrderType := 'Order';
                        //     'BlanketOrder':
                        //         OrderType := 'BlanketOrder';
                        //     'Shipment':
                        //         OrderType := 'Shipment';
                        //     'DeliverySchedule':
                        //         OrderType := 'DeliverySchedule';
                        //     'Transfer':
                        //         OrderType := 'Trnsfer';
                        clear(OrderType);
                        OrderType := siv.OrderType;
                        IBPO9Buffer."Field 11" := OrderType;
                        IBPO9Buffer.Modify();
                    end;


                }
                textelement(ORDER_CREATION_DT)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        Clear(ORDER_CREATION_DT);
                        ORDER_CREATION_DT := format(siv.OrderCreationDate, 0, '<year4>/<month,2>/<day,2>');
                        IBPO9Buffer."Field 12" := ORDER_CREATION_DT;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(ORDER_LAST_CHNGE)
                {

                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        Clear(ORDER_LAST_CHNGE);
                        ORDER_LAST_CHNGE := format(Siv.modifiedAt, 0, '<year4>/<month,2>/<day,2>');
                        IBPO9Buffer."Field 13" := ORDER_LAST_CHNGE;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(ORDER_COMMIT_QTY)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        ORDER_COMMIT_QTY := format(Siv."Forecast Qty", 0, 9);
                        IBPO9Buffer."Field 14" := ORDER_COMMIT_QTY;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(UOM_CommitQty)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        UOM_CommitQty := siv.Einheit;
                        IBPO9Buffer."Field 15" := UOM_CommitQty;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(Order_COMMIT_DT)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        Clear(Order_COMMIT_DT);
                        Order_COMMIT_DT := Format(Siv.PromdisedDeliveryDate, 0, '<year4>/<month,2>/<day,2>');
                        IBPO9Buffer."Field 16" := Order_COMMIT_DT;
                        IBPO9Buffer.Modify();
                    end;

                }
                textelement(FINAL_COMMIT_QTY)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        FINAL_COMMIT_QTY := format(Siv."Forecast Qty", 0, 9);
                        IBPO9Buffer."Field 17" := FINAL_COMMIT_QTY;
                        IBPO9Buffer.Modify();
                    end;

                }
                textelement(ACTUAL_DLVRY_DT)

                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        clear(ACTUAL_DLVRY_DT);
                        ACTUAL_DLVRY_DT := format(siv.PlanedDeliveryDate, 0, '<year4>/<month,2>/<day,2>');

                        if (siv.status = 'OPEN') then
                            ACTUAL_DLVRY_DT := '';
                        IBPO9Buffer."Field 18" := ACTUAL_DLVRY_DT;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(ACTUAL_SHP_DT)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        clear(ACTUAL_SHP_DT);

                        if (siv.status = 'OPEN') then
                            ACTUAL_SHP_DT := ''

                        else
                            ACTUAL_SHP_DT := ACTUAL_DLVRY_DT;
                        IBPO9Buffer."Field 19" := ACTUAL_SHP_DT;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(DELIVERED_QT)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        DELIVERED_QT := Format(siv.QtyShipped, 0, 9);
                        IBPO9Buffer."Field 20" := DELIVERED_QT;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(UOM_DelivQty)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        UOM_DelivQty := siv.Einheit;
                        IBPO9Buffer."Field 21" := UOM_DelivQty;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(OPEN_COMMIT_QTY)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        OPEN_COMMIT_QTY := Format(siv.OustandingQty, 0, 9);
                        IBPO9Buffer."Field 22" := OPEN_COMMIT_QTY;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(ORDER_STATUS)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        clear(ORDER_STATUS);
                        if siv.Status = 'OPEN' then
                            ORDER_STATUS := 'Open';
                        if siv.Status = 'CLOSED' then
                            ORDER_STATUS := 'Closed';
                        IBPO9Buffer."Field 23" := ORDER_STATUS;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(ORDER_RQST_QTY)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        ORDER_RQST_QTY := format(siv.OrderQty, 0, 9);
                        IBPO9Buffer."Field 24" := ORDER_RQST_QTY;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(UOM_OrderRequestedQty)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        UOM_OrderRequestedQty := siv.Einheit;
                        IBPO9Buffer."Field 25" := UOM_OrderRequestedQty;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(ORDER_RQST_DT)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        clear(ORDER_RQST_DT);
                        ORDER_RQST_DT := format(siv.OrderRequestedDate, 0, '<year4>/<month,2>/<day,2>');
                        IBPO9Buffer."Field 26" := ORDER_RQST_DT;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(OPEN_REQUEST_QTY)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        OPEN_REQUEST_QTY := Format(siv.OustandingQty, 0, 9);
                        IBPO9Buffer."Field 27" := OPEN_REQUEST_QTY;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(ORDER_NET_VALUE)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        ORDER_NET_VALUE := Format(Siv."unit Price" * siv.OrderQty, 0, 9);
                        IBPO9Buffer."Field 28" := ORDER_NET_VALUE;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(Currency_OrderNetValue)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        Currency_OrderNetValue := siv.Currency;
                        IBPO9Buffer."Field 29" := Currency_OrderNetValue;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(SELLING_PRICE_UN)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        SELLING_PRICE_UN := Format(siv."unit Price", 0, 9);
                        IBPO9Buffer."Field 30" := SELLING_PRICE_UN;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(Invoice_Value)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        clear(Invoice_Value);
                        if (siv.QtyShipped <> 0) and (siv.OrderType in ['Posted Sales Shipment']) then
                            Invoice_Value := Format(siv.Invoice_Value, 0, 9);
                        IBPO9Buffer."Field 31" := Invoice_Value;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(Currency_InvoiceValue)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        Currency_InvoiceValue := siv.Currency;
                        IBPO9Buffer."Field 32" := Currency_InvoiceValue;
                        IBPO9Buffer.Modify();
                    end;
                }

                textelement(PaymentTerms)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        PaymentTerms := siv.PaymentTherm;
                        IBPO9Buffer."Field 33" := PaymentTerms;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(MaterialDescription)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        MaterialDescription := siv.Beschreibung;
                        IBPO9Buffer."Field 34" := MaterialDescription;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(Incoterms)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        Incoterms := siv.Incoterm;
                        IBPO9Buffer."Field 35" := Incoterms;
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
                        IBPO9Buffer."Field 36" := IncotermsPlace;
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
                    myInt: Integer;
                    EntryNo: Integer;
                begin
                    Clear(Plant);
                    CompanyInfo.get();
                    case CompanyInfo."Country/Region Code" of
                        'DE':
                            Plant := 'IVMK';
                        'MX':
                            Plant := 'IVMP';
                    end;

                    EntryNo := IBPO9Buffer.getNextEntry();
                    IBPO9Buffer.Init();
                    IBPO9Buffer."Entry No." := EntryNo;
                    IBPO9Buffer."Export Date" := CurrentDateTime();
                    IBPO9Buffer."Export Batch ID" := 'SALESACTUAL_SP';
                    IBPO9Buffer.Insert();
                end;
            }


        }

    }
    procedure SetDataItem(PSIV: Record "UTT SalesBuffer")

    begin
        SIV := PSIV;

    end;

    local procedure CreateIVLMatdim(ItemNo: Code[20])
    var
        CompanyInfo: Record "Company Information";
        ItemRec: Record item;
        IVLTrans: Record "KVS IVL Translation Table";

    begin
        CompanyInfo.get();
        if (CompanyInfo."Country/Region Code") = 'MX' then begin
            IVLTrans.Reset();
            IVLTrans.SetRange("Object ID", 27);
            IVLTrans.SetRange("Object Type", IVLTrans."Object Type"::Table);
            IVLTrans.SetRange(ID, '09_MAT_TYP');
            IVLTrans.SetRange("Field Value", ItemNo);
            if IVLTrans.IsEmpty then begin
                IVLTrans.Reset();
                IVLTrans.Init();
                IVLTrans."Entry No." := IVLTrans.GetNextEntryNo();
                IVLTrans."Object ID" := 27;
                IVLTrans."Field No." := 1;
                IVLTrans."Object Type" := IVLTrans."Object Type"::table;
                IVLTrans.ID := '09_MAT_TYP';
                IVLTrans.Translation := 'finished goods';
                IVLTrans."Field Value" := ItemNo;
                IVLTrans.Insert(true);

            end;


        end;

    end;

    var

        CompanyInfo: Record "Company Information";
        Plant: text;
        IBPO9Buffer: Record "UTT IBPO9 Buffer";

}
