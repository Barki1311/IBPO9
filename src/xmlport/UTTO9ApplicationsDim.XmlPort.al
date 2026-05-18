xmlport 67010 "UTT O9ApplicationsDim"
{
    Caption = 'UTT O9AppliCationDim';
    Format = VariableText;
    Direction = Export;
    TextEncoding = UTF8;
    UseRequestPage = false;
    FileName = 'IVMK_ApplicationDim.dsv';
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
                textelement(ApplicationLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        ApplicationLbl := 'Application';
                    end;
                }
               
                textelement(ApplicationDescLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        ApplicationDescLbl := 'Application Description';
                    end;
                }
                textelement(MarketSegmentLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        MarketSegmentLbl := 'Market Segment';
                    end;
                }
                textelement(MarketsegmentDescLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        MarketsegmentDescLbl := 'Market segment Description';
                    end;
                }


                 textelement(SegmentLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        SegmentLbl := 'Segment';
                    end;
                }
                textelement(SegmentDescLabel)
                {
                    trigger OnBeforePassVariable()
                    begin
                        SegmentDescLabel := 'Segment Description';

                    end;
                }


            }
            tableelement(Line1; Integer)
            {
                XmlName = 'Line1';
                SourceTableView = SORTING(Number) WHERE(Number = CONST(1));
                textelement(Application)
                {
                    trigger OnBeforePassVariable()
                    begin
                        Application := 'Airbag';
                    end;
                }
                textelement(ApplicationDesc)
                {
                    trigger OnBeforePassVariable()
                    begin
                        ApplicationDesc := 'Airbag';
                    end;
                }
                textelement(MarketSegment)
                {
                    trigger OnBeforePassVariable()
                    begin
                        MarketSegment := 'Automotive & Specialties';
                    end;
                }
                textelement(MarketSegmentDesc)
                {
                    trigger OnBeforePassVariable()
                    begin
                        MarketSegmentDesc := 'Automotive & Specialties';
                    end;
                }
               
                textelement(Segment)
                {
                    trigger OnBeforePassVariable()
                    begin
                        Segment := 'Fibers';
                    end;
                }
                textelement(SegmentDesc)
                {
                    trigger OnBeforePassVariable()
                    begin
                        SegmentDesc := 'Fibers';

                    end;
                }


            }
            tableelement(Line2; Integer)
            {
                XmlName = 'line2';
                SourceTableView = SORTING(Number) WHERE(Number = CONST(1));
                textelement(Application2)
                {
                    trigger OnBeforePassVariable()
                    begin
                        Application2 := 'Specialties';
                    end;
                }
                textelement(ApplicationDesc2)
                {
                    trigger OnBeforePassVariable()
                    begin
                        ApplicationDesc2 := 'Specialties';
                    end;
                }
                textelement(MarketSegment2)
                {
                    trigger OnBeforePassVariable()
                    begin
                        MarketSegment2 := 'Automotive & Specialties';
                    end;
                }
              
                textelement(MarketSegmentDesc2)
                {
                    trigger OnBeforePassVariable()
                    begin
                        MarketSegmentDesc2 := 'Automotive & Specialties';
                    end;
                }
                textelement(Segment2)
                {
                    trigger OnBeforePassVariable()
                    begin
                        Segment2 := 'Fibers';
                    end;
                }
                textelement(SegmentDesc2)
                {
                    trigger OnBeforePassVariable()
                    begin
                        SegmentDesc2 := 'Fibers';

                    end;
                }


            }



        }



    }
}


