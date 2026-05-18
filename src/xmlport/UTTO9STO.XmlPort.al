xmlport 67025 "UTT O9 STO"
{
    Caption = 'UTT O9 STO';
    Format = VariableText;
    Direction = Export;
    TextEncoding = UTF8;
    UseRequestPage = false;
    FileName = 'IVMK_P_o9STO.dsv';
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
                    end;
                }
                textelement(ShippingLocationCodeLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        ShippingLocationCodeLbl := 'ShippingLocationCode';
                    end;
                }
                textelement(DestinationLocationCodeLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        DestinationLocationCodeLbl := 'DestinationLocationCode(Customer)';
                    end;
                }
                textelement(STOPONumberLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        STOPONumberLbl := 'STOPONumber';
                    end;
                }
                textelement(STOPOLineNumberLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        STOPOLineNumberLbl := 'STOPOLineNumber';
                    end;
                }
                textelement(TransmodeLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        TransmodeLbl := 'Transmode';
                    end;
                }

                textelement(STOLineDetailQuantityLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        STOLineDetailQuantityLbl := 'STOLineDetailQuantity';
                    end;
                }
                textelement(UOMSTOLineDetailQuantityLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        UOMSTOLineDetailQuantityLbl := 'UOMSTOLineDetailQuantity';
                    end;
                }
                textelement(STOLineDetailDeliveredQuantityLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        STOLineDetailDeliveredQuantityLbl := 'STOLineDetailDeliveredQuantity';
                    end;
                }
                textelement(UOMSTOLineDetailDeliveredQuantityLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        UOMSTOLineDetailDeliveredQuantityLbl := 'UOMSTOLineDetailDeliveredQuantity';
                    end;
                }
                textelement(STOLineDetailIssuedQuantityLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        STOLineDetailIssuedQuantityLbl := 'STOLineDetailIssuedQuantity';
                    end;
                }
                textelement(UOMSTOLineDetailIssuedQuantityLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        UOMSTOLineDetailIssuedQuantityLbl := 'UOMSTOLineDetailIssuedQuantity';
                    end;
                }
                textelement(STOLineShippedQuantityLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        STOLineShippedQuantityLbl := 'STOLineShippedQuantity';
                    end;
                }
                textelement(UOMSTOLineShippedQuantityLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        UOMSTOLineShippedQuantityLbl := 'UOMSTOLineShippedQuantity';
                    end;
                }
                textelement(STOLineIntransitQuantityLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        STOLineIntransitQuantityLbl := 'STOLineIntransitQuantity';
                    end;
                }
                textelement(UOMSTOLineIntransitQuantityLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        UOMSTOLineIntransitQuantityLbl := 'UOMSTOLineIntransitQuantity';
                    end;
                }
                textelement(STOLineOpenQuantityLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        STOLineOpenQuantityLbl := 'STOLineOpenQuantity';
                    end;
                }
                textelement(UOMSTOLineOpenQuantityLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        UOMSTOLineOpenQuantityLbl := 'UOMSTOLineOpenQuantity';
                    end;
                }
                textelement(STOLineDeliveryDateLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        STOLineDeliveryDateLbl := 'STOLineDeliveryDate';
                    end;
                }
                textelement(STOLineActualDeliveryDateLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        STOLineActualDeliveryDateLbl := 'STOLineActualDeliveryDate';
                    end;
                }
                textelement(STOLineDetailStatusLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        STOLineDetailStatusLbl := 'STOLineDetailStatus';
                    end;
                }
                textelement(SalesOrderLineIDLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        SalesOrderLineIDLbl := 'SalesOrderLineID';
                    end;
                }












            }
            // tableelement(TransferLine; "Transfer Line")
            // {
            //     XmlName = 'Data';
            //     // SourceTableView = sorting("No.") WHERE("KVSTEX Item Type" = filter("Finished Product" | "yarn"));
            //     RequestFilterFields = "Transfer-to Code";

            //     textelement(Material)
            //     {
            //         trigger OnBeforePassVariable()
            //         begin
            //             Material := TransferLine."Item No.";
            //         end;
            //     }
            //     textelement(ShippingLocationCode)
            //     {
            //         trigger OnBeforePassVariable()
            //         begin
            //             case companyInfo."Country/Region Code" of
            //                 'DE':
            //                     ShippingLocationCode := 'IVMK';
            //                 'MX':
            //                     ShippingLocationCode := 'IVMP';
            //             end;

            //         end;


            //     }
            //     textelement(DestinationLocationCode)
            //     {
            //         trigger OnBeforePassVariable()
            //         begin
            //             DestinationLocationCode := transferline."Transfer-to Code";
            //         end;
            //     }
            //     textelement(STOPONumber)
            //     {
            //         trigger OnBeforePassVariable()
            //         begin
            //             STOPONumber := transferline."Document No.";
            //         end;
            //     }
            //     textelement(STOPOLineNumber)
            //     {
            //         trigger OnBeforePassVariable()
            //         begin
            //             STOPOLineNumber := format(TransferLine."Line No.");
            //         end;
            //     }
            //     textelement(Transmode)
            //     {
            //         trigger OnBeforePassVariable()
            //         begin
            //             Transmode := 'Truck';
            //         end;
            //     }

            //     textelement(STOLineDetailQuantity)
            //     {
            //         trigger OnBeforePassVariable()
            //         begin
            //             STOLineDetailQuantity := format(transferline.Quantity, 0, 9);
            //         end;
            //     }
            //     textelement(UOMSTOLineDetailQuantity)
            //     {
            //         trigger OnBeforePassVariable()
            //         begin
            //             UOMSTOLineDetailQuantity := TransferLine."Unit of Measure Code";
            //         end;
            //     }
            //     textelement(STOLineDetailDeliveredQuantity)
            //     {
            //         trigger OnBeforePassVariable()
            //         begin
            //             STOLineDetailDeliveredQuantity := format(transferline."Quantity Shipped", 0, 9);
            //         end;
            //     }
            //     textelement(UOMSTOLineDetailDeliveredQuantity)
            //     {
            //         trigger OnBeforePassVariable()
            //         begin
            //             UOMSTOLineDetailDeliveredQuantity := transferline."Unit of Measure Code";
            //         end;
            //     }
            //     textelement(STOLineDetailIssuedQuantity)
            //     {
            //         trigger OnBeforePassVariable()
            //         begin
            //             STOLineDetailIssuedQuantity := format(0, 0, 9);
            //         end;
            //     }
            //     textelement(UOMSTOLineDetailIssuedQuantity)
            //     {
            //         trigger OnBeforePassVariable()
            //         begin
            //             UOMSTOLineDetailIssuedQuantity := transferline."Unit of Measure Code";
            //         end;
            //     }
            //     textelement(STOLineShippedQuantity)
            //     {
            //         trigger OnBeforePassVariable()
            //         begin
            //             STOLineShippedQuantity := format(0, 0, 9);
            //         end;
            //     }
            //     textelement(UOMSTOLineShippedQuantity)
            //     {
            //         trigger OnBeforePassVariable()
            //         begin
            //             UOMSTOLineShippedQuantity := transferline."Unit of Measure Code";
            //         end;
            //     }
            //     textelement(STOLineIntransitQuantity)
            //     {
            //         trigger OnBeforePassVariable()
            //         begin
            //             STOLineIntransitQuantity := format(TransferLine."Qty. in Transit", 0, 9);
            //         end;
            //     }
            //     textelement(UOMSTOLineIntransitQuantity)
            //     {
            //         trigger OnBeforePassVariable()
            //         begin
            //             UOMSTOLineIntransitQuantity := transferline."Unit of Measure Code";
            //         end;
            //     }
            //     textelement(STOLineOpenQuantity)
            //     {
            //         trigger OnBeforePassVariable()
            //         begin
            //             STOLineOpenQuantity := format(transferline."Qty. to Ship", 0, 9);
            //         end;
            //     }
            //     textelement(UOMSTOLineOpenQuantity)
            //     {
            //         trigger OnBeforePassVariable()
            //         begin
            //             UOMSTOLineOpenQuantity := transferline."Unit of Measure Code";
            //         end;
            //     }
            //     textelement(STOLineDeliveryDate)
            //     {
            //         trigger OnBeforePassVariable()
            //         begin
            //             STOLineDeliveryDate := format(TransferLine."Shipment Date", 0, '<year4>/<month,2>/<day,2>');
            //         end;
            //     }
            //     textelement(STOLineActualDeliveryDate)
            //     {
            //         trigger OnBeforePassVariable()
            //         begin
            //             STOLineActualDeliveryDate := format(TransferLine."Shipment Date", 0, '<year4>/<month,2>/<day,2>');
            //         end;
            //     }
            //     textelement(STOLineDetailStatus)
            //     {
            //         trigger OnBeforePassVariable()
            //         begin
            //             STOLineDetailStatus := 'Open' ;
            //         end;
            //     }
            //     textelement(SalesOrderLineID)
            //     {
            //         trigger OnBeforePassVariable()
            //         begin
            //             SalesOrderLineID := transferline.KVSFCYDeliveryScheduleNo;
            //         end;
            //     }



            //     trigger OnPreXmlItem()
            //     var
            //         myInt: Integer;
            //     begin

            //         // MachineCenter.Setfilter("KVSTEX Item Type", '%1|%2|%3', item."KVSTEX Item Type"::"Finished Product", item."KVSTEX Item Type"::Yarn, item."KVSTEX Item Type"::"KVS Cutset", item."KVSTEX Item Type"::"KVS Colour Ribbon");
            //         // item.SetRange("KVSTEX Item Status", item."KVSTEX Item Status"::Certified);

            //         companyInfo.get();
            //         if companyInfo."Country/Region Code" = 'DE' then
            //             TransferLine.setrange("Transfer-to Code", '49');
            //         TransferLine.setrange(Status, TransferLine.Status::Released);
            //         TransferLine.SetFilter("Qty. to Ship",'<>%1',0);
            //     end;

            // }
            // tableelement(PostedTransferLine; "Transfer Shipment Line")
            // {
            //     XmlName = 'Data';
            //     // SourceTableView = sorting("No.") WHERE("KVSTEX Item Type" = filter("Finished Product" | "yarn"));
            //     RequestFilterFields = "Transfer-to Code";

            //     textelement(P_Material)
            //     {
            //         trigger OnBeforePassVariable()
            //         begin
            //             P_Material := PostedTransferLine."Item No.";
            //         end;
            //     }
            //     textelement(P_ShippingLocationCode)
            //     {
            //         trigger OnBeforePassVariable()
            //         begin
            //             case companyInfo."Country/Region Code" of
            //                 'DE':
            //                    P_ShippingLocationCode := 'IVMK';
            //                 'MX':
            //                     P_ShippingLocationCode := 'IVMP';
            //             end;

            //         end;


            //     }
            //     textelement(P_DestinationLocationCode)
            //     {
            //         trigger OnBeforePassVariable()
            //         begin
            //             P_DestinationLocationCode := PostedTransferLine."Transfer-to Code";
            //         end;
            //     }
            //     textelement(P_STOPONumber)
            //     {
            //         trigger OnBeforePassVariable()
            //         begin
            //             P_STOPONumber := PostedTransferLine."Document No.";
            //         end;
            //     }
            //     textelement(P_STOPOLineNumber)
            //     {
            //         trigger OnBeforePassVariable()
            //         begin
            //             P_STOPOLineNumber := format(PostedTransferLine."Line No.");
            //         end;
            //     }
            //     textelement(P_Transmode)
            //     {
            //         trigger OnBeforePassVariable()
            //         begin
            //             P_Transmode := 'Truck';
            //         end;
            //     }

            //     textelement(P_STOLineDetailQuantity)
            //     {
            //         trigger OnBeforePassVariable()
            //         begin
            //             P_STOLineDetailQuantity := format(PostedTransferLine.Quantity, 0, 9);
            //         end;
            //     }
            //     textelement(P_UOMSTOLineDetailQuantity)
            //     {
            //         trigger OnBeforePassVariable()
            //         begin
            //             P_UOMSTOLineDetailQuantity := PostedTransferLine."Unit of Measure Code";
            //         end;
            //     }
            //     textelement(P_STOLineDetailDeliveredQuantity)
            //     {
            //         trigger OnBeforePassVariable()
            //         begin
            //             P_STOLineDetailDeliveredQuantity := format(PostedTransferLine.Quantity, 0, 9);
            //         end;
            //     }
            //     textelement(P_UOMSTOLineDetailDeliveredQuantity)
            //     {
            //         trigger OnBeforePassVariable()
            //         begin
            //             P_UOMSTOLineDetailDeliveredQuantity := PostedTransferLine."Unit of Measure Code";
            //         end;
            //     }
            //     textelement(P_STOLineDetailIssuedQuantity)
            //     {
            //         trigger OnBeforePassVariable()
            //         begin
            //             P_STOLineDetailIssuedQuantity := format(PostedTransferLine.Quantity, 0, 9);
            //         end;
            //     }
            //     textelement(P_UOMSTOLineDetailIssuedQuantity)
            //     {
            //         trigger OnBeforePassVariable()
            //         begin
            //             P_UOMSTOLineDetailIssuedQuantity := PostedTransferLine."Unit of Measure Code";
            //         end;
            //     }
            //     textelement(P_STOLineShippedQuantity)
            //     {
            //         trigger OnBeforePassVariable()
            //         begin
            //             P_STOLineShippedQuantity := format(0, 0, 9);
            //         end;
            //     }
            //     textelement(P_UOMSTOLineShippedQuantity)
            //     {
            //         trigger OnBeforePassVariable()
            //         begin
            //             P_UOMSTOLineShippedQuantity := PostedTransferLine."Unit of Measure Code";
            //         end;
            //     }
            //     textelement(P_STOLineIntransitQuantity)
            //     {
            //         trigger OnBeforePassVariable()
            //         begin
            //             P_STOLineIntransitQuantity := format(0, 0, 9);
            //         end;
            //     }
            //     textelement(P_UOMSTOLineIntransitQuantity)
            //     {
            //         trigger OnBeforePassVariable()
            //         begin
            //             P_UOMSTOLineIntransitQuantity := PostedTransferLine."Unit of Measure Code";
            //         end;
            //     }
            //     textelement(P_STOLineOpenQuantity)
            //     {
            //         trigger OnBeforePassVariable()
            //         begin
            //             P_STOLineOpenQuantity := format(0, 0, 9);
            //         end;
            //     }
            //     textelement(P_UOMSTOLineOpenQuantity)
            //     {
            //         trigger OnBeforePassVariable()
            //         begin
            //             P_UOMSTOLineOpenQuantity := PostedTransferLine."Unit of Measure Code";
            //         end;
            //     }
            //     textelement(P_STOLineDeliveryDate)
            //     {
            //         trigger OnBeforePassVariable()
            //         begin
            //             P_STOLineDeliveryDate := format(PostedTransferLine."Shipment Date", 0, '<year4>/<month,2>/<day,2>');
            //         end;
            //     }
            //     textelement(P_STOLineActualDeliveryDate)
            //     {
            //         trigger OnBeforePassVariable()
            //         begin
            //             P_STOLineActualDeliveryDate := format(PostedTransferLine."Shipment Date", 0, '<year4>/<month,2>/<day,2>');
            //         end;
            //     }
            //     textelement(P_STOLineDetailStatus)
            //     {
            //         trigger OnBeforePassVariable()
            //         begin
            //             P_STOLineDetailStatus := 'closed' ;
            //         end;
            //     }
            //     textelement(P_SalesOrderLineID)
            //     {
            //         trigger OnBeforePassVariable()
            //         begin
            //             P_SalesOrderLineID := PostedTransferLine.KVSFCYDeliveryScheduleNo;
            //         end;
            //     }



            //     trigger OnPreXmlItem()
            //     var
            //         myInt: Integer;
            //     begin

            //         // MachineCenter.Setfilter("KVSTEX Item Type", '%1|%2|%3', item."KVSTEX Item Type"::"Finished Product", item."KVSTEX Item Type"::Yarn, item."KVSTEX Item Type"::"KVS Cutset", item."KVSTEX Item Type"::"KVS Colour Ribbon");
            //         // item.SetRange("KVSTEX Item Status", item."KVSTEX Item Status"::Certified);

            //         companyInfo.get();
            //         if companyInfo."Country/Region Code" = 'DE' then
            //             PostedTransferLine.setrange("Transfer-to Code", '49');

            //     end;

            // }
            tableelement(Purchline; "Purchase Line")
            {
                XmlName = 'Data';
                // SourceTableView = sorting("No.") WHERE("KVSTEX Item Type" = filter("Finished Product" | "yarn"));
                RequestFilterFields = "Buy-from Vendor No.";

                textelement(Material)
                {
                    trigger OnBeforePassVariable()
                    begin
                        Material := Purchline."No.";
                    end;
                }
                textelement(ShippingLocationCode)
                {
                    trigger OnBeforePassVariable()
                    begin
                        ShippingLocationCode := Purchline."Buy-from Vendor No.";
                        ;
                    end;
                }
                textelement(DestinationLocationCode)
                {
                    trigger OnBeforePassVariable()
                    begin
                        DestinationLocationCode := Purchline."Buy-from Vendor No.";
                        case companyInfo."Country/Region Code" of
                            'DE':
                                DestinationLocationCode := 'IVMK';
                            'MX':
                                DestinationLocationCode := 'IVMP';
                        end;
                    end;
                }
                textelement(STOPONumber)
                {
                    trigger OnBeforePassVariable()
                    begin
                        STOPONumber := Purchline."Document No.";
                    end;
                }
                textelement(STOPOLineNumber)
                {
                    trigger OnBeforePassVariable()
                    begin
                        STOPOLineNumber := format(Purchline."Line No.");
                    end;
                }
                textelement(Transmode)
                {
                    trigger OnBeforePassVariable()
                    begin
                        Transmode := 'Truck';
                    end;
                }

                textelement(STOLineDetailQuantity)
                {
                    trigger OnBeforePassVariable()
                    begin
                        STOLineDetailQuantity := format(Purchline.Quantity, 0, 9);
                    end;
                }
                textelement(UOMSTOLineDetailQuantity)
                {
                    trigger OnBeforePassVariable()
                    begin
                        UOMSTOLineDetailQuantity := Purchline."Unit of Measure Code";
                    end;
                }
                textelement(STOLineDetailDeliveredQuantity)
                {
                    trigger OnBeforePassVariable()
                    begin
                        STOLineDetailDeliveredQuantity := format(Purchline."Quantity Received", 0, 9);
                    end;
                }
                textelement(UOMSTOLineDetailDeliveredQuantity)
                {
                    trigger OnBeforePassVariable()
                    begin
                        UOMSTOLineDetailDeliveredQuantity := Purchline."Unit of Measure Code";
                    end;
                }
                textelement(STOLineDetailIssuedQuantity)
                {
                    trigger OnBeforePassVariable()
                    begin
                        STOLineDetailIssuedQuantity := format(0, 0, 9);
                    end;
                }
                textelement(UOMSTOLineDetailIssuedQuantity)
                {
                    trigger OnBeforePassVariable()
                    begin
                        UOMSTOLineDetailIssuedQuantity := Purchline."Unit of Measure Code";
                    end;
                }
                textelement(STOLineShippedQuantity)
                {
                    trigger OnBeforePassVariable()
                    begin
                        STOLineShippedQuantity := format(Purchline."Quantity Received", 0, 9);
                    end;
                }
                textelement(UOMSTOLineShippedQuantity)
                {
                    trigger OnBeforePassVariable()
                    begin
                        UOMSTOLineShippedQuantity := Purchline."Unit of Measure Code";
                    end;
                }
                textelement(STOLineIntransitQuantity)
                {
                    trigger OnBeforePassVariable()
                    begin
                        STOLineIntransitQuantity := '0';
                    end;
                }
                textelement(UOMSTOLineIntransitQuantity)
                {
                    trigger OnBeforePassVariable()
                    begin
                        UOMSTOLineIntransitQuantity := Purchline."Unit of Measure Code";
                    end;
                }
                textelement(STOLineOpenQuantity)
                {
                    trigger OnBeforePassVariable()
                    begin
                        STOLineOpenQuantity := format(Purchline."Outstanding Qty. (Base)", 0, 9);
                    end;
                }
                textelement(UOMSTOLineOpenQuantity)
                {
                    trigger OnBeforePassVariable()
                    begin
                        UOMSTOLineOpenQuantity := Purchline."Unit of Measure Code";
                    end;
                }
                textelement(STOLineDeliveryDate)
                {
                    trigger OnBeforePassVariable()
                    var

                    begin
                        STOLineDeliveryDate := format(Purchline."Expected Receipt Date", 0, '<year4>/<month,2>/<day,2>');
                    end;
                }
                textelement(STOLineActualDeliveryDate)
                {
                    trigger OnBeforePassVariable()
                    begin
                        STOLineActualDeliveryDate := format(PurchRcptLine."Posting Date", 0, '<year4>/<month,2>/<day,2>');
                    end;
                }
                textelement(STOLineDetailStatus)
                {
                    trigger OnBeforePassVariable()
                    begin
                        if Purchline."Outstanding Qty. (Base)" <> 0 then
                            STOLineDetailStatus := 'Open'
                        else
                            STOLineDetailStatus := 'closed'

                    end;
                }
                textelement(SalesOrderLineID)
                {
                    trigger OnBeforePassVariable()
                    begin
                        SalesOrderLineID := 'N/A'
                    end;
                }



                trigger OnPreXmlItem()
                var
                    myInt: Integer;
                begin

                    // MachineCenter.Setfilter("KVSTEX Item Type", '%1|%2|%3', item."KVSTEX Item Type"::"Finished Product", item."KVSTEX Item Type"::Yarn, item."KVSTEX Item Type"::"KVS Cutset", item."KVSTEX Item Type"::"KVS Colour Ribbon");
                    // item.SetRange("KVSTEX Item Status", item."KVSTEX Item Status"::Certified);

                    companyInfo.get();
                    //if companyInfo."Country/Region Code" = 'DE' then
                    //Purchline.SetFilter(Purchline."Buy-from Vendor No.",'%1|%2','70005',73093,);
                    Purchline.SetRange("Document Type", Purchline."Document Type"::Order);
                    Purchline.setfilter("Gen. Bus. Posting Group", '%1|%2', 'IVL', 'MEXICO IC');
                    // Purchline.SetFilter("Qty. to Receive",'<>%1',0);
                end;

                trigger OnAfterGetRecord()
                var
                    myInt: Integer;
                begin
                    clear(PurchRcptLine);
                    PurchRcptLine.reset();
                    PurchRcptLine.SetRange("Order No.", Purchline."Document No.");
                    PurchRcptLine.setrange("Order Line No.", Purchline."Line No.");
                    PurchRcptLine.setfilter(Quantity, '>%1', 0);
                    if PurchRcptLine.FindLast() then;

                end;



            }

        }

    }
    var
        companyInfo: Record "Company Information";
        PurchRcptLine: Record "Purch. Rcpt. Line";

}
