xmlport 67016 "UTT O9RountingMaster"
{
    Caption = 'UTT O9 Routing Master';
    Format = VariableText;
    Direction = Export;
    TextEncoding = UTF8;
    UseRequestPage = false;
    FileName = 'IVMK_P_RoutingMaster.dsv';
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
                textelement(MaterialcodeLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        MaterialcodeLbl := 'Material';
                        IBPO9Buffer."Field 1" := MaterialcodeLbl;
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
                textelement(QualityLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        QualityLbl := 'Quality';
                        IBPO9Buffer."Field 3" := QualityLbl;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(LocationCodeLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        LocationCodeLbl := 'LocationCode';
                        IBPO9Buffer."Field 4" := LocationCodeLbl;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(ResourceCodeLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        ResourceCodeLbl := 'ResourceCode';
                        IBPO9Buffer."Field 5" := ResourceCodeLbl;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(RoutingIDLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        RoutingIDLbl := 'RoutingID';
                        IBPO9Buffer."Field 6" := RoutingIDLbl;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(BOMVersionLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        BOMVersionLbl := 'BOMVersion';
                        IBPO9Buffer."Field 7" := BOMVersionLbl;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(BOMIDLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        BOMIDLbl := 'BOMID';
                        IBPO9Buffer."Field 8" := BOMIDLbl;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(ProdRateperDayLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        ProdRateperDayLbl := 'ProductionRateperday';
                        IBPO9Buffer."Field 9" := ProdRateperDayLbl;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(PriorityLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        PriorityLbl := 'Priority';
                        IBPO9Buffer."Field 10" := PriorityLbl;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(MinOrderQtyLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        MinOrderQtyLbl := 'MinimumOrderQuantity';
                        IBPO9Buffer."Field 11" := MinOrderQtyLbl;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(UOMMinOrderQtyLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        UOMMinOrderQtyLbl := 'UoMMinimumOrderQuantity';
                        IBPO9Buffer."Field 12" := UOMMinOrderQtyLbl;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(LotSizeLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        LotSizeLbl := 'LotSize';
                        IBPO9Buffer."Field 13" := LotSizeLbl;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(StartDateLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        StartDateLbl := 'StartDate';
                        IBPO9Buffer."Field 14" := StartDateLbl;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(EndDateLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        EndDateLbl := 'EndDate';
                        IBPO9Buffer."Field 15" := EndDateLbl;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(OEELbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        OEELbl := 'OEE';
                        IBPO9Buffer."Field 16" := OEELbl;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(OperationSequenceLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        OperationSequenceLbl := 'OperationSequence';
                        IBPO9Buffer."Field 17" := OperationSequenceLbl;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(NumberOfActiveResourcesLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        NumberOfActiveResourcesLbl := 'NumberOfActiveResources';
                        IBPO9Buffer."Field 18" := NumberOfActiveResourcesLbl;
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
                    IBPO9Buffer."Export Batch ID" := 'ROUTINGMASTER';
                    IBPO9Buffer.Insert();
                end;
            }

            tableelement(Item; Item)
            {
                XmlName = 'ItemDim';
                RequestFilterFields = "No.";

                tableelement(RtgLine; "Routing Line")
                {
                    textelement(Material)
                    {
                        trigger OnBeforePassVariable()
                        begin
                            Material := item."No.";
                            IBPO9Buffer."Field 1" := Material;
                            IBPO9Buffer.Modify();
                        end;
                    }
                    textelement(MaterialDesc)
                    {
                        trigger OnBeforePassVariable()
                        begin
                            MaterialDesc := item.Description;
                            IBPO9Buffer."Field 2" := MaterialDesc;
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
                    textelement(LocationCode)
                    {
                        trigger OnBeforePassVariable()
                        var
                            myInt: Integer;
                        begin
                            companyInfo.get();
                            case CompanyInfo."Country/Region Code" of
                                'DE':
                                    LocationCode := 'IVMK';
                                'MX':
                                    LocationCode := 'IVMP';
                            end;
                            IBPO9Buffer."Field 4" := LocationCode;
                            IBPO9Buffer.Modify();
                        end;
                    }
                    textelement(ResourceCode)
                    {
                        trigger OnBeforePassVariable()
                        var
                            myInt: Integer;
                        begin
                            ResourceCode := RtgLine."No.";
                            IBPO9Buffer."Field 5" := ResourceCode;
                            IBPO9Buffer.Modify();
                        end;
                    }
                    textelement(RoutingID)
                    {
                        trigger OnBeforePassVariable()
                        var
                            myInt: Integer;
                        begin
                            RoutingID := RtgLine."Routing No.";
                            IBPO9Buffer."Field 6" := RoutingID;
                            IBPO9Buffer.Modify();
                        end;
                    }
                    textelement(BomVersion)
                    {
                        trigger OnBeforePassVariable()
                        var
                            myInt: Integer;
                        begin
                            BomVersion := BomActiveVersionCode;
                            if BomVersion = '' then
                                BomVersion := '99';
                            IBPO9Buffer."Field 7" := BomVersion;
                            IBPO9Buffer.Modify();
                        end;
                    }
                    textelement(BoMID)
                    {
                        trigger OnBeforePassVariable()
                        var
                            myInt: Integer;
                        begin
                            BoMID := ProdBOMHeader."No.";
                            IBPO9Buffer."Field 8" := BoMID;
                            IBPO9Buffer.Modify();
                        end;
                    }
                    textelement(ProdRateperDay)
                    {
                        trigger OnBeforePassVariable()
                        var
                            myInt: Integer;
                        begin
                            ProdRateperDay := 'N/A';
                            IBPO9Buffer."Field 9" := ProdRateperDay;
                            IBPO9Buffer.Modify();
                        end;
                    }
                    textelement(Priority)
                    {
                        trigger OnBeforePassVariable()
                        var
                            myInt: Integer;
                        begin
                            Priority := '1';
                            IBPO9Buffer."Field 10" := Priority;
                            IBPO9Buffer.Modify();
                        end;
                    }
                    textelement(MinOrderQty)
                    {
                        trigger OnBeforePassVariable()
                        var
                            myInt: Integer;
                        begin
                            MinOrderQty := 'N/A';
                            IBPO9Buffer."Field 11" := MinOrderQty;
                            IBPO9Buffer.Modify();
                        end;
                    }
                    textelement(UOMMinOrderQty)
                    {
                        trigger OnBeforePassVariable()
                        begin
                            UOMMinOrderQty := 'N/A';
                            IBPO9Buffer."Field 12" := UOMMinOrderQty;
                            IBPO9Buffer.Modify();
                        end;
                    }
                    textelement(LotSize)
                    {
                        trigger OnBeforePassVariable()
                        var
                            myInt: Integer;
                        begin
                            LotSize := format(RtgLine."Lot Size");
                            IBPO9Buffer."Field 13" := LotSize;
                            IBPO9Buffer.Modify();
                        end;
                    }
                    textelement(StartDate)
                    {
                        trigger OnBeforePassVariable()
                        var
                            myInt: Integer;
                        begin
                            StartDate := format(Today, 0, '<year4>/<month,2>/<day,2>');
                            IBPO9Buffer."Field 14" := StartDate;
                            IBPO9Buffer.Modify();
                        end;
                    }
                    textelement(EndDate)
                    {
                        trigger OnBeforePassVariable()
                        var
                            myInt: Integer;
                        begin
                            EndDate := format(DMY2DATE(31, 12, 9999), 0, '<year4>/<month,2>/<day,2>');
                            IBPO9Buffer."Field 15" := EndDate;
                            IBPO9Buffer.Modify();
                        end;
                    }
                    textelement(OEE)
                    {
                        trigger OnBeforePassVariable()
                        var
                            myInt: Integer;
                        begin
                            OEE := 'N/A';
                            IBPO9Buffer."Field 16" := OEE;
                            IBPO9Buffer.Modify();
                        end;
                    }
                    textelement(OperationSequence)
                    {
                        trigger OnBeforePassVariable()
                        var
                            myInt: Integer;
                        begin
                            OperationSequence := RtgLine."Operation No.";
                            IBPO9Buffer."Field 17" := OperationSequence;
                            IBPO9Buffer.Modify();
                        end;
                    }
                    textelement(NumberOfActiveResources)
                    {
                        trigger OnBeforePassVariable()
                        begin
                            NumberOfActiveResources := '';
                            IBPO9Buffer."Field 18" := NumberOfActiveResources;
                            IBPO9Buffer.Modify();
                        end;
                    }

                    trigger OnPreXmlItem()
                    begin
                        RtgLine.SetRange("Routing No.", RtgHeader."No.");
                        RtgLine.SETRANGE("Version Code", RtgActiveVersionCode);
                    end;

                    trigger OnAfterGetRecord()
                    begin
                        IBPO9Buffer.Init();
                        if not IBPO9Buffer.FindLast() then
                            IBPO9Buffer."Entry No." := 1
                        else
                            IBPO9Buffer."Entry No." := IBPO9Buffer."Entry No." + 1;
                        IBPO9Buffer."Export Date" := CurrentDateTime();
                        IBPO9Buffer."Export Batch ID" := 'ROUTINGMASTER';
                        IBPO9Buffer.Insert();
                    end;
                }

                trigger OnAfterGetRecord()
                var
                    ItemledEntry: Record "Item Ledger Entry";
                begin
                    if item.Description = '' then
                        currXMLport.skip();
                    if not RtgHeader.GET(item."Routing No.") then
                        currXMLport.skip();
                    ProdBOMHeader.Init();
                    if not ProdBOMHeader.GET(item."Production BOM No.") then
                        currXMLport.skip();
                    clear(BomActiveVersionCode);
                    BomActiveVersionCode := VersionMgt.GetBOMVersion(ProdBOMHeader."No.", WORKDATE, true);
                    if not RtgHeader.GET(item."Routing No.") then
                        currXMLport.skip();
                    if not ProdBOMHeader.GET(item."Production BOM No.") then
                        currXMLport.skip();
                    RtgActiveVersionCode := VersionMgt.GetRtngVersion(RtgHeader."No.", WORKDATE, true);
                    companyInfo.get();
                end;

                trigger OnPreXmlItem()
                var
                begin
                    item.Setfilter("KVSTEX Item Status", '%1|%2|%3', item."KVSTEX Item Status"::Certified, item."KVSTEX Item Status"::"Under Development", item."KVSTEX Item Status"::Closed);
                    item.setfilter("Production BOM No.", '<>%1', '');
                    item.setfilter("Routing No.", '<>%1', '');
                    item.SetFilter(Description, '<>%1', '');
                end;
            }
        }
    }

    var
        companyInfo: Record "Company Information";
        RtgActiveVersionCode: Text;
        BomActiveVersionCode: Text;
        RtgHeader: Record "Routing Header";
        VersionMgt: Codeunit VersionManagement;
        ProdBOMHeader: Record "Production BOM Header";
        IBPO9Buffer: Record "UTT IBPO9 Buffer";
}
