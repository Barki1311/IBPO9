xmlport 67015 "UTT O9BOMMaster"
{
    Caption = 'UTT O9 Bom Master';
    Format = VariableText;
    Direction = Export;
    TextEncoding = UTF8;
    UseRequestPage = false;
    FileName = 'IVMK_P_BOMMaster.dsv';
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
                textelement(ConsumedMaterialLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        ConsumedMaterialLbl := 'ConsumedMaterialCode';
                        IBPO9Buffer."Field 5" := ConsumedMaterialLbl;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(ComponentDescLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        ComponentDescLbl := 'ComponentDescription';
                        IBPO9Buffer."Field 6" := ComponentDescLbl;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(BOMIDLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        BOMIDLbl := 'BoMID';
                        IBPO9Buffer."Field 7" := BOMIDLbl;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(BOMVersionLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        BOMVersionLbl := 'BOMVersion';
                        IBPO9Buffer."Field 8" := BOMVersionLbl;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(ConsumedQtyLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        ConsumedQtyLbl := 'ConsumedQuantity';
                        IBPO9Buffer."Field 9" := ConsumedQtyLbl;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(UOMConsumedQtyLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        UOMConsumedQtyLbl := 'UOMofConsumedQty';
                        IBPO9Buffer."Field 10" := UOMConsumedQtyLbl;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(ProducedQtyLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        ProducedQtyLbl := 'ProducedQuantity';
                        IBPO9Buffer."Field 11" := ProducedQtyLbl;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(UOMProducedQtyLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        UOMProducedQtyLbl := 'UOMofProducedQty';
                        IBPO9Buffer."Field 12" := UOMProducedQtyLbl;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(StartDateLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        StartDateLbl := 'StartDate';
                        IBPO9Buffer."Field 13" := StartDateLbl;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(EndDateLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        EndDateLbl := 'EndDate';
                        IBPO9Buffer."Field 14" := EndDateLbl;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(QualityOfConsumedMaterialLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        QualityOfConsumedMaterialLbl := 'QualityOfConsumedMaterial';
                        IBPO9Buffer."Field 15" := QualityOfConsumedMaterialLbl;
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
                    IBPO9Buffer."Export Batch ID" := 'BOMMASTER';
                    IBPO9Buffer.Insert();
                end;
            }

            tableelement(Item; Item)
            {
                XmlName = 'ItemDim';
                MinOccurs = Zero;

                tableelement(ProdBOMLine; "Production BOM Line")
                {
                    MinOccurs = Zero;

                    textelement(Material)
                    {
                        trigger OnBeforePassVariable()
                        begin
                            Material := item."No.";
                            if Material = '' then
                                currXMLport.skip();
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
                    textelement(ConsumedMaterialCode)
                    {
                        trigger OnBeforePassVariable()
                        var
                            myInt: Integer;
                        begin
                            ConsumedMaterialCode := ProdBOMLine."No.";
                            IBPO9Buffer."Field 5" := ConsumedMaterialCode;
                            IBPO9Buffer.Modify();
                        end;
                    }
                    textelement(ComponentDesc)
                    {
                        trigger OnBeforePassVariable()
                        var
                            myInt: Integer;
                            ItemLoc: Record Item;
                        begin
                            if ItemLoc.get(ProdBOMLine."No.") then
                                ComponentDesc := ItemLoc.Description;
                            IBPO9Buffer."Field 6" := ComponentDesc;
                            IBPO9Buffer.Modify();
                        end;
                    }
                    textelement(BoMID)
                    {
                        trigger OnBeforePassVariable()
                        var
                            myInt: Integer;
                        begin
                            BoMID := ProdBOMLine."Production BOM No.";
                            IBPO9Buffer."Field 7" := BoMID;
                            IBPO9Buffer.Modify();
                        end;
                    }
                    textelement(BomVersion_)
                    {
                        trigger OnBeforePassVariable()
                        var
                            myInt: Integer;
                        begin
                            BomVersion_ := ProdBOMLine."Version Code";
                            if BomVersion_ = '' then
                                BomVersion_ := '99';
                            IBPO9Buffer."Field 8" := BomVersion_;
                            IBPO9Buffer.Modify();
                        end;
                    }
                    textelement(ConsumedQuantity)
                    {
                        trigger OnBeforePassVariable()
                        var
                            myInt: Integer;
                        begin
                            ConsumedQuantity := format(ProdBOMLine.Quantity, 0, 9);
                            IBPO9Buffer."Field 9" := ConsumedQuantity;
                            IBPO9Buffer.Modify();
                        end;
                    }
                    textelement(UOMConsumedQuantity)
                    {
                        trigger OnBeforePassVariable()
                        var
                            myInt: Integer;
                        begin
                            UOMConsumedQuantity := ProdBOMLine."Unit of Measure Code";
                            IBPO9Buffer."Field 10" := UOMConsumedQuantity;
                            IBPO9Buffer.Modify();
                        end;
                    }
                    textelement(ProducedQuantity)
                    {
                        trigger OnBeforePassVariable()
                        var
                            myInt: Integer;
                        begin
                            ProducedQuantity := format(1);
                            IBPO9Buffer."Field 11" := ProducedQuantity;
                            IBPO9Buffer.Modify();
                        end;
                    }
                    textelement(UOMProducedQuantity)
                    {
                        trigger OnBeforePassVariable()
                        var
                            myInt: Integer;
                        begin
                            UOMProducedQuantity := format(ProdBOMHeader."Unit of Measure Code");
                            IBPO9Buffer."Field 12" := UOMProducedQuantity;
                            IBPO9Buffer.Modify();
                        end;
                    }
                    textelement(StartDate)
                    {
                        trigger OnBeforePassVariable()
                        var
                            myInt: Integer;
                        begin
                            StartDate := Format(calcdate('<-12M>', WorkDate()), 0, '<year4>/<month,2>/<day,2>');
                            IBPO9Buffer."Field 13" := StartDate;
                            IBPO9Buffer.Modify();
                        end;
                    }
                    textelement(EndDate)
                    {
                        trigger OnBeforePassVariable()
                        var
                            myInt: Integer;
                        begin
                            if ActiveVersionCode <> '' then begin
                                if ProdBOMHeaderVersion."KVS OpenManufacture" then
                                    EndDate := Format(calcdate('<12M>', WorkDate()), 0, '<year4>/<month,2>/<day,2>')
                                else
                                    EndDate := Format(calcdate('<-12M>', WorkDate()), 0, '<year4>/<month,2>/<day,2>')
                            end else
                                EndDate := Format(calcdate('<12M>', WorkDate()), 0, '<year4>/<month,2>/<day,2>');
                            IBPO9Buffer."Field 14" := EndDate;
                            IBPO9Buffer.Modify();
                        end;
                    }
                    textelement(QualityOfConsumedMaterial)
                    {
                        trigger OnBeforePassVariable()
                        var
                            myInt: Integer;
                        begin
                            QualityOfConsumedMaterial := 'Standard';
                            IBPO9Buffer."Field 15" := QualityOfConsumedMaterial;
                            IBPO9Buffer.Modify();
                        end;
                    }

                    trigger OnAfterGetRecord()
                    var
    EntryNo: Integer;
                        myInt: Integer;
                    begin
                       EntryNo:= IBPO9Buffer.getNextEntry();
                    IBPO9Buffer.Init(); 
                    IBPO9Buffer."Entry No.":= EntryNo;
                    IBPO9Buffer."Export Date" := CurrentDateTime();
                        IBPO9Buffer."Export Batch ID" := 'BOMMASTER';
                        IBPO9Buffer.Insert();
                    end;

                    trigger OnPreXmlItem()
                    begin
                        ProdBOMLine.SetRange("Production BOM No.", ProdBOMHeader."No.");
                        ProdBOMLine.SetFilter(Description, '<>%1', '');
                    end;
                }

                trigger OnAfterGetRecord()
                var
                    myInt: Integer;
                    ItemledEntry: Record "Item Ledger Entry";
                begin
                    if item.Description = '' then
                        currXMLport.skip();
                    if not RtgHeader.GET(item."Routing No.") then
                        currXMLport.skip();
                    if not ProdBOMHeader.GET(item."Production BOM No.") then
                        currXMLport.skip();

                    clear(ProdBOMHeaderVersion);
                    Clear(ActiveVersionCode);
                    ActiveVersionCode := VersionMgt.GetBOMVersion(ProdBOMHeader."No.", WORKDATE, true);
                    if ActiveVersionCode <> '' then
                        ProdBOMHeaderVersion.get(ProdBOMHeader."No.", ActiveVersionCode);

                    companyInfo.get();
                end;

                trigger OnPreXmlItem()
                var
                begin
                    item.SetFilter("KVS Default Location Code", '<>%1&<>%2&<>%3&<>%4&<>%5', 'ERSATZTEIL', 'REFACCIONE', 'REVISTA', 'MAGAZIN', 'PRODUCION');
                    Clear(ActiveVersionCode);
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
        ActiveVersionCode: Text;
        ProdBOMHeader: Record "Production BOM Header";
        ProdBOMHeaderVersion: Record "Production BOM Version";
        VersionMgt: Codeunit VersionManagement;
        RtgHeader: Record "Routing Header";
        IBPO9Buffer: Record "UTT IBPO9 Buffer";
        EntryNo: Integer;
}
