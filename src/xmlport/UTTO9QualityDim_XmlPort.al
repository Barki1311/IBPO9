xmlport 67011 "UTT O9QualityDim"
{
    Caption = 'UTT O9QualityDim';
    Format = VariableText;
    Direction = Export;
    TextEncoding = UTF8;
    UseRequestPage = false;
    FileName = 'IVMK_O9QualityDim.dsv';
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
                textelement(QualityLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        QualityLbl := 'Quality';
                        IBPO9Buffer."Field 1" := QualityLbl;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(QualityDescLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        QualityDescLbl := 'QualityDescription';
                        IBPO9Buffer."Field 2" := QualityDescLbl;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(QualityGrpLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        QualityGrpLbl := 'QualityGroup';
                        IBPO9Buffer."Field 3" := QualityGrpLbl;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(QualityGrpDescLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        QualityGrpDescLbl := 'QualityGroupDescription';
                        IBPO9Buffer."Field 4" := QualityGrpDescLbl;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(SegmentLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        SegmentLbl := 'Segment';
                        IBPO9Buffer."Field 5" := SegmentLbl;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(SegmentDescLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        SegmentDescLbl := 'SegmentDescription';
                        IBPO9Buffer."Field 6" := SegmentDescLbl;
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
                    IBPO9Buffer."Export Batch ID" := 'QUALITYDIM';
                    IBPO9Buffer.Insert();
                end;
            }

            tableelement(Data; Integer)
            {
                XmlName = 'Data';
                SourceTableView = SORTING(Number) WHERE(Number = CONST(1));
                textelement(Quality)
                {
                    trigger OnBeforePassVariable()
                    begin
                        Quality := 'STANDARD';
                        IBPO9Buffer."Field 1" := Quality;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(QualityDesc)
                {
                    trigger OnBeforePassVariable()
                    begin
                        QualityDesc := 'STANDARD';
                        IBPO9Buffer."Field 2" := QualityDesc;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(QualityGrp)
                {
                    trigger OnBeforePassVariable()
                    begin
                        QualityGrp := 'First Grade';
                        IBPO9Buffer."Field 3" := QualityGrp;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(QualityGrpDesc)
                {
                    trigger OnBeforePassVariable()
                    begin
                        QualityGrpDesc := 'First Grade';
                        IBPO9Buffer."Field 4" := QualityGrpDesc;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(Segment)
                {
                    trigger OnBeforePassVariable()
                    begin
                        Segment := 'Fibers';
                        IBPO9Buffer."Field 5" := Segment;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(SegmentDesc)
                {
                    trigger OnBeforePassVariable()
                    begin
                        SegmentDesc := 'Fibers';
                        IBPO9Buffer."Field 6" := SegmentDesc;
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
                    IBPO9Buffer."Export Batch ID" := 'QUALITYDIM';
                    IBPO9Buffer.Insert();
                end;
            }
        }
    }

    var
        IBPO9Buffer: Record "UTT IBPO9 Buffer";
}
