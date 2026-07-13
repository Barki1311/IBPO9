xmlport 67003 "UTT O9MaterialDim"

{
    Caption = 'UTT O9 MAterialDim';
    Format = VariableText;
    Direction = Export;
    TextEncoding = UTF8;
    UseRequestPage = false;
    FileName = 'IVMK_MaterialDim.dsv';
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
                textelement(PlanningMaterialLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        PlanningMaterialLbl := 'PlanningMaterial';
                        IBPO9Buffer."Field 2" := PlanningMaterialLbl;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(MatDescLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        MatDescLbl := 'MaterialDescription';
                        IBPO9Buffer."Field 3" := MatDescLbl;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(Mat_TypeLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        Mat_TypeLbl := 'MaterialType';
                        IBPO9Buffer."Field 4" := Mat_TypeLbl;
                        IBPO9Buffer.Modify();
                    end;
                }

                textelement(Mat_GrpCodeLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        Mat_GrpCodeLbl := 'MaterialGroupCode';
                        IBPO9Buffer."Field 5" := Mat_GrpCodeLbl;
                        IBPO9Buffer.Modify();
                    end;
                }

                textelement(MatGrpDescLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        MatGrpDescLbl := 'MaterialGroupDescription';

                        IBPO9Buffer."Field 6" := MatGrpDescLbl;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(ProdTypeCodeLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        ProdTypeCodeLbl := 'ProductTypeCode';
                        IBPO9Buffer."Field 7" := ProdTypeCodeLbl;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(ProdTypeDescLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        ProdTypeDescLbl := 'ProductTypeDescription';
                        IBPO9Buffer."Field 8" := ProdTypeDescLbl;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(SegmentLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        SegmentLbl := 'SegmentCode';
                        IBPO9Buffer."Field 9" := SegmentLbl;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(SegmentDescLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        SegmentDescLbl := 'SegmentDescription';
                        IBPO9Buffer."Field 10" := SegmentDescLbl;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(FrontEndGrpLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        FrontEndGrpLbl := 'Front_endGroup';
                        IBPO9Buffer."Field 11" := FrontEndGrpLbl;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(FrontEndGrpDescLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        FrontEndGrpDescLbl := 'Front_endGroupDescription';
                        IBPO9Buffer."Field 12" := FrontEndGrpDescLbl;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(PolymerLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        PolymerLbl := 'PolymerType';
                        IBPO9Buffer."Field 13" := PolymerLbl;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(DtexLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        DtexLbl := 'Dtex_Or_Denier';
                        IBPO9Buffer."Field 14" := DtexLbl;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(ConstructionLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        ConstructionLbl := 'Construction';
                        IBPO9Buffer."Field 15" := ConstructionLbl;
                        IBPO9Buffer.Modify();
                    end;
                }
                // textelement(DistributionLbl)
                // {
                //     trigger OnBeforePassVariable()
                //     begin
                //         DistributionLbl := 'Distribution Channel';
                //     end;
                // }
                textelement(TwistLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        TwistLbl := 'TwistLevel';
                        IBPO9Buffer."Field 16" := TwistLbl;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(FilamentLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        FilamentLbl := 'FilamentCount';
                        IBPO9Buffer."Field 17" := FilamentLbl;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(DensityLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        DensityLbl := 'DensityThickness';
                        IBPO9Buffer."Field 18" := DensityLbl;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(StyleLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        StyleLbl := 'Style_Or_Grade_Or_Type_Or_Merge';
                        IBPO9Buffer."Field 19" := StyleLbl;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(WeightLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        WeightLbl := 'Weight';
                        IBPO9Buffer."Field 20" := WeightLbl;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(packagingLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        packagingLbl := 'Packaging';
                        IBPO9Buffer."Field 21" := packagingLbl;
                        IBPO9Buffer.Modify();

                    end;
                }
                textelement(CanvasLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        CanvasLbl := 'CanvasType_And_Strength';
                        IBPO9Buffer."Field 22" := CanvasLbl;
                        IBPO9Buffer.Modify();
                    end;
                }

                textelement(UOMLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        UOMLbl := 'BaseUOM';
                        IBPO9Buffer."Field 23" := UOMLbl;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(HVACommodityLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        HVACommodityLbl := 'HVA_Or_Commodity';
                        IBPO9Buffer."Field 24" := HVACommodityLbl;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(BrandTypeLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        BrandTypeLbl := 'Brand_Or_Type';
                        IBPO9Buffer."Field 25" := BrandTypeLbl;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(IsmaterialActiveLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        IsmaterialActiveLbl := 'IsMaterialActive';
                        IBPO9Buffer."Field 26" := IsmaterialActiveLbl;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(LocationCodeLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        LocationCodeLbl := 'LocationCode';
                        IBPO9Buffer."Field 27" := LocationCodeLbl;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(QualityLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        QualityLbl := 'Quality';
                        IBPO9Buffer."Field 28" := QualityLbl;
                        IBPO9Buffer.Modify();
                    end;
                }
                // textelement(PlanningMaterialLbl)
                // {
                //     trigger OnBeforePassVariable()
                //     begin
                //         PlanningMaterialLbl := 'PlanningMaterial'
                //     end;
                // }
                trigger OnPreXmlItem()
                var
                    myInt: Integer;
                begin


                end;

                trigger OnAfterGetRecord()
                // var
                //     IBPO9Buffer: Record "UTT IBPO9 Buffer Table";
                begin
                    IBPO9Buffer.Init();

                    //IBPO9Buffer."Field 1" := MaterialLbl;
                    if not IBPO9Buffer.FindLast() then begin
                        IBPO9Buffer."Entry No." := 1;
                    end else begin
                        IBPO9Buffer."Entry No." := IBPO9Buffer."Entry No." + 1;
                    end;
                    IBPO9Buffer."Export Date" := CurrentDateTime();
                    IBPO9Buffer."Export Batch ID" := o9ProjectLib.GetCurrentXMLPortName(67003);


                    IBPO9Buffer.Insert();









                end;


            }
            tableelement(Item; Item)
            {
                XmlName = 'ItemDim';
                // SourceTableView = sorting("No.") WHERE("KVSTEX Item Type" = filter("Finished Product" | "yarn"));
                RequestFilterFields = "No.";
                textelement(Material)
                {
                    trigger OnBeforePassVariable()
                    begin
                        Material := item."No.";
                        IBPO9Buffer."Field 1" := Material;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(PlanningMaterial)
                {
                    trigger OnBeforePassVariable()
                    begin
                        PlanningMaterial := item."No.";
                        IBPO9Buffer."Field 2" := PlanningMaterial;
                        IBPO9Buffer.Modify();
                    end;
                }

                textelement(Material_Description)

                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        Material_Description := DelChr(item.Description, '=', '"');
                        IBPO9Buffer."Field 3" := Material_Description;
                        IBPO9Buffer.Modify();

                    end;
                }
                textelement(Mat_Type)
                // Item."KVSTEX Item Type")
                {
                    trigger OnBeforePassVariable()
                    var
                        IVLTrans: Record "KVS IVL Translation Table";
                        ProdBOMHeader: Record "Production BOM Header";
                    begin
                        case Item."KVSTEX Item Type" of

                            Item."KVSTEX Item Type"::"Finished Product":
                                Mat_Type := 'finished goods';
                            Item."KVSTEX Item Type"::"KVS Cutset":
                                Mat_Type := 'finished goods';
                            item."KVSTEX Item Type"::"KVS Colour Ribbon":
                                Mat_Type := 'finished goods';

                            else begin
                                ProdBOMHeader.Init();
                                if ProdBOMHeader.GET(item."Production BOM No.") then
                                    Mat_Type := 'Semi Finished Goods'
                                else
                                    Mat_Type := 'Raw Material'


                            end;

                                // IVLTrans.SetRange("Object ID", 94)
                                IVLTrans.Reset();
                                IVLTrans.SetRange("Object ID", 27);
                                IVLTrans.SetRange("Object Type", IVLTrans."Object Type"::Table);
                                IVLTrans.SetRange(ID, '09_MAT_TYP');
                                IVLTrans.SetRange("Field Value", Item."No.");
                                IVLTrans.SetFilter(Translation, '<>%1', '');
                                if IVLTrans.FindFirst() then
                                    Mat_Type := IVLTrans.Translation;

                        end;
                        IBPO9Buffer."Field 4" := Mat_Type;
                        IBPO9Buffer.Modify();

                    end;

                }

                textelement(Mat_GrpCode)
                {
                    trigger OnBeforePassVariable()
                    begin
                        Mat_GrpCode := item."No.";
                        IBPO9Buffer."Field 5" := Mat_GrpCode;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(MatGrpDesc)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        MatGrpDesc := Material_Description;
                        IBPO9Buffer."Field 6" := MatGrpDesc;
                        IBPO9Buffer.Modify();

                    end;
                }
                textelement(ProdTypeCode)
                {
                    trigger OnBeforePassVariable()
                    var
                        IVLTrans: Record "KVS IVL Translation Table";
                    begin
                        ProdTypeCode := 'Flat Fabric';

                        // IVLTrans.SetRange("Object ID", 94)
                        IVLTrans.SetRange("Object ID", 5722);
                        IVLTrans.SetRange("Object Type", IVLTrans."Object Type"::Table);
                        IVLTrans.SetRange(ID, '09_MATDIM_PROD_TYP1');
                        // IVLTrans.SetRange("Field Value", Item."Inventory Posting Group");
                        IVLTrans.SetRange("Field Value", Item."Item Category Code");
                        if IVLTrans.FindFirst() then
                            ProdTypeCode := IVLTrans.Translation;

                        if ProdTypeCode = '' then
                            ProdTypeCode := 'Flat Fabric';
                        IBPO9Buffer."Field 7" := ProdTypeCode;
                        IBPO9Buffer.Modify();
                    end;


                }
                textelement(ProdTypeCodeDesc)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        ProdTypeCodeDesc := ProdTypeCode;
                        IBPO9Buffer."Field 8" := ProdTypeCodeDesc;
                        IBPO9Buffer.Modify();

                    end;
                }



                textelement(SegmentCode)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        SegmentCode := 'Fibers';
                        IBPO9Buffer."Field 9" := SegmentCode;
                        IBPO9Buffer.Modify();

                    end;
                }
                textelement(SegmentDesc)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        SegmentDesc := 'Fibers';
                        IBPO9Buffer."Field 10" := SegmentDesc;
                        IBPO9Buffer.Modify();

                    end;
                }

                textelement(FrontEndGrp)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        FrontEndGrp := 'mobility';
                        IBPO9Buffer."Field 11" := FrontEndGrp;
                        IBPO9Buffer.Modify();

                    end;
                }
                textelement(FrontEndGrpDesc)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        FrontEndGrpDesc := 'mobility';
                        IBPO9Buffer."Field 12" := FrontEndGrpDesc;
                        IBPO9Buffer.Modify();

                    end;
                }


                textelement(PolymerType)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;

                        IVLTrans: Record "KVS IVL Translation Table";
                        CompositionKey: Record "KVSTEX Composition Key";
                        DefaultTissue: Record item;
                    begin
                        CompositionKey.Reset();
                        CompositionKey.SetRange(Code, item."KVSTEX Composition Key Total");
                        if CompositionKey.FindFirst() then
                            PolymerType := CompositionKey."Material 1";
                        if PolymerType = '' then begin
                            PolymerType := 'N/A';
                            if DefaultTissue.get(item."KVS Default Tissue") then begin
                                CompositionKey.Reset();
                                CompositionKey.SetRange(Code, DefaultTissue."KVSTEX Composition Key Total");
                                if CompositionKey.FindFirst() then
                                    PolymerType := CompositionKey."Material 1";

                            end;
                        end;
                        IBPO9Buffer."Field 13" := PolymerType;
                        IBPO9Buffer.Modify();








                        // IVLTrans.SetRange("Object ID", 65100);
                        // IVLTrans.SetRange("Object Type", IVLTrans."Object Type"::page);
                        // IVLTrans.SetRange(ID, 'PRODUCT CODE');
                        // IVLTrans.SetRange("Field Value", item."KVSTEX Composition Key Total");
                        // if IVLTrans.FindFirst() then
                        //     PolymerType := IVLTrans.Translation
                        // else
                        //     PolymerType := 'N/A';




                    end;



                }

                textelement(Dtex)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        Dtex := 'N/A';
                        IBPO9Buffer."Field 14" := Dtex;
                        IBPO9Buffer.Modify();

                    end;
                }
                textelement(Construction)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        Construction := 'N/A';
                        IBPO9Buffer."Field 15" := Construction;
                        IBPO9Buffer.Modify();

                    end;
                }
                //  textelement(Distribution)
                // {
                //     trigger OnBeforePassVariable()
                //     var
                //         myInt: Integer;
                //     begin
                //         Distribution := 'N/A';

                //     end;
                // }
                textelement(Twist)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        Twist := 'N/A';
                        IBPO9Buffer."Field 16" := Twist;
                        IBPO9Buffer.Modify();

                    end;
                }
                textelement(Filament)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        Filament := 'N/A';
                        IBPO9Buffer."Field 17" := Filament;
                        IBPO9Buffer.Modify();

                    end;
                }
                textelement(Density)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        Density := 'N/A';
                        IBPO9Buffer."Field 18" := Density;
                        IBPO9Buffer.Modify();

                    end;
                }
                textelement(Style)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        Clear(Style);
                        Style := item."Item Category Code";
                        if Style = '' then
                            Style := 'N/A';
                        IBPO9Buffer."Field 19" := Style;
                        IBPO9Buffer.Modify();

                    end;
                }



                textelement(Weight)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        Weight := Format(item."Net Weight");
                        IBPO9Buffer."Field 20" := Weight;
                        IBPO9Buffer.Modify();

                    end;
                }
                textelement(packaging)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        packaging := 'N/A';
                        IBPO9Buffer."Field 21" := packaging;
                        IBPO9Buffer.Modify();

                    end;
                }
                textelement(Canvas)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        Canvas := 'N/A';
                        IBPO9Buffer."Field 22" := Canvas;
                        IBPO9Buffer.Modify();

                    end;
                }

                textelement(UOM)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        UOM := item."Base Unit of Measure";
                        IBPO9Buffer."Field 23" := UOM;
                        IBPO9Buffer.Modify();

                    end;
                }
                textelement(HVACommodity)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        HVACommodity := 'HVA';
                        IBPO9Buffer."Field 24" := HVACommodity;
                        IBPO9Buffer.Modify();

                    end;
                }
                textelement(BrandType)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        BrandType := 'N/A';
                        IBPO9Buffer."Field 25" := BrandType;
                        IBPO9Buffer.Modify();

                    end;
                }

                textelement(IsmaterialActive)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                       if item."KVSTEX Item Status" in [Item."KVSTEX Item Status"::Certified,Item."KVSTEX Item Status"::"Under Development"] then
                            IsmaterialActive := 'Yes'
                        else
                            IsmaterialActive := 'No';
                        IBPO9Buffer."Field 26" := IsmaterialActive;
                        IBPO9Buffer.Modify();

                    end;
                }
                textelement(LocationCode)
                {
                    trigger OnBeforePassVariable()
                    var
                        CompanyInfo: Record "Company Information";
                    begin
                        CompanyInfo.get();
                        case CompanyInfo."Country/Region Code" of
                            'DE':
                                LocationCode := 'IVMK';
                            'MX':
                                LocationCode := 'IVMP';

                        end;
                        IBPO9Buffer."Field 27" := LocationCode;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(Quality)
                {
                    trigger OnBeforePassVariable()
                    begin
                        Quality := 'Standard';
                        IBPO9Buffer."Field 28" := Quality;
                        IBPO9Buffer.Modify();
                    end;
                }
                // textelement(PlanningMaterial)
                // {
                //     trigger OnBeforePassVariable()
                //     begin
                //         PlanningMaterial := item."No.";
                //     end;
                // }



                trigger OnAfterGetRecord()
                var
    EntryNo: Integer;
                    myInt: Integer;
                    ItemledEntry: Record "Item Ledger Entry";
                    PolymerNA: Boolean;

                begin

                    if (item."KVSTEX Item Type" = item."KVSTEX Item Type"::Standard) then
                        if item."KVSTEX Composition Key Total" = '' then
                            if item."Gen. Prod. Posting Group" in ['OPW LAMFOL', 'SILIKON', 'SON BETRST', 'YARN', 'EKA', 'HILO'] then
                                PolymerNA := true
                            else
                                currXMLport.skip;

                    //item.CalcFields(Inventory);
                    // if item.Inventory = 0 then begin
                    //     itemledEntry.SetCurrentKey("Item No.");
                    //     itemledEntry.SetRange("Item No.", item."No.");
                    //     ItemledEntry.SetRange("Posting Date", CalcDate('<-5Y>', WorkDate), WorkDate);
                    //     if itemledEntry.IsEmpty then begin
                    //         if not IsInBOMSalesExist(Item."No.") then
                    //             currXMLport.skip;
                    //     end;

                    // end;

                    //IBPO9Buffer."Field 1" := MaterialLbl;
                    EntryNo:= IBPO9Buffer.getNextEntry();
                    IBPO9Buffer.Init(); 
                    IBPO9Buffer."Entry No.":= EntryNo;
                    IBPO9Buffer."Export Date" := CurrentDateTime();
                    IBPO9Buffer."Export Batch ID" := o9ProjectLib.GetCurrentXMLPortName(67003);


                    IBPO9Buffer.Insert();
                end;

                trigger OnPreXmlItem()
                var
                    myInt: Integer;
                begin

                    //Item.Setfilter("KVSTEX Item Type", '%1|%2|%3|%4|%5|%6', item."KVSTEX Item Type"::"Finished Product", item."KVSTEX Item Type"::Yarn, item."KVSTEX Item Type"::"KVS Cutset", item."KVSTEX Item Type"::"KVS Colour Ribbon", item."KVSTEX Item Type"::Standard, item."KVSTEX Item Type"::Warp);
                    //item.SetRange("KVSTEX Item Status", item."KVSTEX Item Status"::Certified);
                    item.SetFilter("KVS Default Location Code", '<>%1&<>%2&<>%3&<>%4&<>%5', 'ERSATZTEIL', 'REFACCIONE', 'REVISTA', 'MAGAZIN', 'PRODUCION');
                    item.SetFilter(Description, '<>%1', '');

                end;

            }

        }

    }





    local procedure IsInBOMSalesExist(No: Code[20]): Boolean
    var

        BOMLine: Record "Production BOM Line";
        IsExist: Boolean;
        SalesLine: Record "Sales Line";
    begin
        BOMLine.SetRange("No.", No);
        if BOMLine.FindFirst then
            IsExist := true;

        SalesLine.SetRange("No.", No);
        if SalesLine.FindFirst then
            IsExist := true;
        exit(IsExist)

    end;

    var
        IBPO9Buffer: Record "UTT IBPO9 Buffer";
        o9ProjectLib: Codeunit "UTT O9 Project Lib";


}

