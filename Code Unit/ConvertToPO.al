codeunit 70105 ConvertToPO
{


    trigger OnRun();

    begin

    end;




    procedure CreateRecord(var getHeaderNo: Record "Purchase Requisition Header")
    var
        HeaderNo: Text;
        LineNo: Integer;
        VendorName: Text;
        VendorNo: Text;
        PONumber: Text;
        LineInc: Integer;
        Lines: Record "Purchase Requistion Line";
        LineDetails: Record "Purchase Requistion Line";
        Header: Record "Purchase Requisition Header";
        POOrder: Record "Purchase Header";
        POLines: Record "Purchase Line";
        NoSeriesMgt1: Codeunit NoSeriesManagement;
    begin

        HeaderNo := getHeaderNo."PR No.";
        LineDetails.SETFILTER("PR No.", HeaderNo);
        //LineDetails.SetAscending("Vendor No", true);

        LineDetails.SETCURRENTKEY("Vendor No");
        LineDetails.ASCENDING;
        LineInc := 1000;
        if LineDetails.FindSet() then begin

            repeat

                if (VendorNo <> LineDetails."Vendor No") then begin



                    POOrder.Reset;
                    POOrder.Init;

                    //POOrder.Validate("No.");
                    POOrder.Validate("Document Type", "Purchase Document Type"::Order);
                    POOrder.Validate("Buy-from Vendor No.", LineDetails."Vendor No");
                    POOrder.Validate("Buy-from Vendor Name", LineDetails."Vendor Name");
                    POOrder.Validate("Purchase Requisition", HeaderNo);

                    POOrder.Insert(true);
                    VendorNo := LineDetails."Vendor No";

                    //line code starts here
                    Lines.SETFILTER("Vendor No", LineDetails."Vendor No");
                    Lines.SETFILTER("PR No.", HeaderNo);
                    if Lines.FindSet() then begin

                        repeat
                            //adding a PO no in po lines
                            POLines.Init();

                            POLines.Validate("Document Type", "Purchase Document Type"::Order);

                            POLines.Validate("Document No.", POOrder."No.");

                            POLines.Validate("Buy-from Vendor No.", VendorNo);

                            POLines.Validate("Type", POLines.Type::Item);

                            POLines.Validate("No.", Lines."Item No");

                            POLines.Validate("Shortcut Dimension 1 Code", Lines."Department Code");//department code

                            POLines.Validate("Line No.", POLines."Line No." + LineInc);

                            POLines.Validate(Quantity, Lines.Quantity);

                            POLines.Validate("Unit Cost", Lines.Amount);


                            POLines.INSERT(true);

                        until Lines.Next() = 0;
                    end;//line code ends here


                end;

            until LineDetails.Next() = 0;
        end;

    end;


}