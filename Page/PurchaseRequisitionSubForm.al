page 70102 "Purchase Requistion SubForm"
{
    AutoSplitKey = true;
    Caption = 'Lines';
    DelayedInsert = true;
    LinksAllowed = false;
    MultipleNewLines = true;
    PageType = ListPart;
    SourceTable = "Purchase Requistion Line";


    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                /*
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Caption = 'Line No';
                    Editable = false;
                }
                */
                field("Line No."; Rec."Line No.")
                {
                    Caption = 'Line No';
                    ApplicationArea = Suite;
                    Editable = false;

                }
                field("Item Type"; Rec."Item Type")
                {
                    Caption = 'Item Type';
                    ApplicationArea = Suite;
                }
                field("Item No"; Rec."Item No")
                {
                    Caption = 'Item No';
                    ApplicationArea = Suite;

                    trigger OnValidate()
                    var


                        ItemRec: Record Item;
                        varVendor: Record Vendor;
                        varLineRecord: Record "Purchase Requistion Line";
                        varHeaderRecord: Record "Purchase Requisition Header";
                        ItemRecSet: Record Item;
                        varPRNo: Text;
                        varVendorNo: Text;
                        varEmployeeInfo: Record Employee;
                        varDimension: Record "Default Dimension";
                        varCurrentUser1: Record User;

                    begin

                        varLineRecord.Reset();
                        varLineRecord.SetFilter("PR No.", CurrentHeaderNo);
                        if (CurrentHeaderNo <> '') then
                            if varLineRecord.FindFirst() then begin
                                ItemRec.Reset();
                                ItemRec.SetFilter("No.", varLineRecord."Item No");
                                if ItemRec.FindFirst() then begin
                                    ItemRecSet.Reset();
                                    ItemRecSet.SetFilter(ItemRecSet.Type, Format(ItemRec.Type));
                                    If ItemRecSet.FindSet() then begin
                                        ItemRecSet.SetFilter("No.", Rec."Item No");

                                        If ItemRecSet.FindFirst() then begin

                                            //If Page.RunModal(Page::"Item List", ItemRecSet) = Action::LookupOK then begin
                                            Rec."Item No" := ItemRecSet."No.";
                                            Rec.Quantity := 1;
                                            Rec.Description := ItemRecSet.Description;
                                            Rec.UOM := ItemRecSet."Base Unit of Measure";
                                            Rec.Amount := ItemRecSet."Unit Price";
                                            Rec."Net Amount" := Rec.Amount * 1;
                                            varVendorNo := ItemRecSet."Vendor No.";

                                            //for vendor
                                            varVendor.Reset();
                                            varVendor.SETFILTER("No.", varVendorNo);
                                            if (varVendorNo <> '') then
                                                if varVendor.FindFirst() then begin
                                                    Rec."Vendor Name" := varVendor.Name;
                                                    Rec."Location Code" := varVendor."Location Code";

                                                end;

                                            //end;
                                            //defaulting department code
                                            varCurrentUser1.SETFILTER("User Name", UserId());
                                            If varCurrentUser1.FindSet() then begin
                                                varEmployeeInfo.SetFilter("User Id", varCurrentUser1."User Name");
                                                if varEmployeeInfo.FindSet() then begin
                                                    varDimension.SetFilter(ParentId, varEmployeeInfo.SystemId);
                                                    if varDimension.FindSet() then begin
                                                        //Message('your department code is ' + varDimension."Dimension Value Code");
                                                        Rec."Department Code" := varDimension."Dimension Value Code";

                                                    end;

                                                end;
                                            end //defaulting department code end here

                                        end



                                        else
                                            Error('Item does not exist is the list. Try again.');

                                    end;

                                end;

                            end //
                            else
                                //if line does not exist in table
                                ItemRecSet.Reset();
                        ItemRecSet.SetFilter(ItemRecSet."No.", Rec."Item No");
                        If ItemRecSet.FindSet() then begin
                            ItemRecSet.SetFilter("No.", Rec."Item No");
                            If ItemRecSet.FindFirst() then begin

                                //If Page.RunModal(Page::"Item List", ItemRecSet) = Action::LookupOK then begin
                                Rec."Item No" := ItemRecSet."No.";
                                Rec.Description := ItemRecSet.Description;
                                Rec.Quantity := 1;
                                Rec.UOM := ItemRecSet."Base Unit of Measure";
                                Rec.Amount := ItemRecSet."Unit Price";
                                Rec."Net Amount" := Rec.Amount * 1;
                                Rec."Vendor No" := ItemRecSet."Vendor No.";
                                varVendorNo := ItemRecSet."Vendor No.";

                                //for vendor
                                varVendor.Reset();
                                varVendor.SETFILTER("No.", varVendorNo);
                                if (varVendorNo <> '') then begin
                                    if varVendor.FindFirst() then begin
                                        Rec."Vendor Name" := varVendor.Name;
                                        Rec."Location Code" := varVendor."Location Code";

                                    end;

                                end;
                                //defaulting department code

                                varCurrentUser1.SETFILTER("User Name", UserId());
                                If varCurrentUser1.FindSet() then begin
                                    varEmployeeInfo.SetFilter("User Id", varCurrentUser1."User Name");
                                    if varEmployeeInfo.FindSet() then begin
                                        varDimension.SetFilter(ParentId, varEmployeeInfo.SystemId);
                                        if varDimension.FindSet() then begin
                                            //Message('your department code is ' + varDimension."Dimension Value Code");
                                            Rec."Department Code" := varDimension."Dimension Value Code";

                                        end;

                                    end;
                                end //defaulting department code end here
                                //reset fields for vendor if no vendor exist
                                else
                                    if (Rec."Vendor Name" <> '') or (Rec."Location Code" <> '') then begin
                                        Rec."Vendor Name" := '';
                                        Rec."Location Code" := '';

                                    end;


                                // end;


                            end
                            else
                                Error('Item does not exist is the list. Try again.');

                        end
                        else
                            Error('Item does not exist is the list. Try again.');
                    end;




                    trigger OnLookup(var Text: Text): Boolean
                    var
                        ItemRec: Record Item;
                        varVendor: Record Vendor;
                        varLineRecord: Record "Purchase Requistion Line";
                        varHeaderRecord: Record "Purchase Requisition Header";
                        ItemRecSet: Record Item;
                        varPRNo: Text;
                        varVendorNo: Text;
                        varEmployeeInfo: Record Employee;
                        varDimension: Record "Default Dimension";
                        varCurrentUser1: Record User;
                    begin

                        varLineRecord.Reset();
                        varLineRecord.SetFilter("PR No.", CurrentHeaderNo);
                        if (CurrentHeaderNo <> '') then
                            if varLineRecord.FindFirst() then begin  //
                                ItemRec.Reset();
                                ItemRec.SetFilter("No.", varLineRecord."Item No");
                                if ItemRec.FindFirst() then begin
                                    ItemRecSet.Reset();
                                    ItemRecSet.SetFilter(ItemRecSet.Type, Format(ItemRec.Type));
                                    If ItemRecSet.FindSet() then begin
                                        If Page.RunModal(Page::"Item List", ItemRecSet) = Action::LookupOK then begin
                                            Rec."Item No" := ItemRecSet."No.";
                                            Rec.Quantity := 1;
                                            Rec.Description := ItemRecSet.Description;
                                            Rec.UOM := ItemRecSet."Base Unit of Measure";
                                            Rec.Amount := ItemRecSet."Unit Price";
                                            Rec."Net Amount" := Rec.Amount * 1;
                                            varVendorNo := ItemRecSet."Vendor No.";

                                            //for vendor
                                            varVendor.Reset();
                                            varVendor.SETFILTER("No.", varVendorNo);
                                            if (varVendorNo <> '') then
                                                if varVendor.FindFirst() then begin
                                                    Rec."Vendor Name" := varVendor.Name;
                                                    Rec."Location Code" := varVendor."Location Code";

                                                end;


                                            //defaulting department code

                                            varCurrentUser1.SETFILTER("User Name", UserId());
                                            If varCurrentUser1.FindSet() then begin
                                                varEmployeeInfo.SetFilter("User Id", varCurrentUser1."User Name");
                                                if varEmployeeInfo.FindSet() then begin
                                                    varDimension.SetFilter(ParentId, varEmployeeInfo.SystemId);
                                                    if varDimension.FindSet() then begin
                                                        //Message('your department code is ' + varDimension."Dimension Value Code");
                                                        Rec."Department Code" := varDimension."Dimension Value Code";

                                                    end;

                                                end;
                                            end //defaulting department code end here

                                        end;


                                    end

                                end;

                            end //
                            else
                                //if line does not exist in table
                                ItemRecSet.Reset();
                        ItemRecSet.SetFilter(ItemRecSet."No.", Rec."Item No");
                        If ItemRecSet.FindSet() then begin

                            If Page.RunModal(Page::"Item List", ItemRecSet) = Action::LookupOK then begin
                                Rec."Item No" := ItemRecSet."No.";
                                Rec.Description := ItemRecSet.Description;
                                Rec.Quantity := 1;
                                Rec.UOM := ItemRecSet."Base Unit of Measure";
                                Rec.Amount := ItemRecSet."Unit Price";
                                Rec."Net Amount" := Rec.Amount * 1;
                                Rec."Vendor No" := ItemRecSet."Vendor No.";
                                varVendorNo := ItemRecSet."Vendor No.";

                                //for vendor
                                varVendor.Reset();
                                varVendor.SETFILTER("No.", varVendorNo);
                                if (varVendorNo <> '') then begin
                                    if varVendor.FindFirst() then begin
                                        Rec."Vendor Name" := varVendor.Name;
                                        Rec."Location Code" := varVendor."Location Code";

                                    end;

                                end;

                                //defaulting department code

                                varCurrentUser1.SETFILTER("User Name", UserId());
                                If varCurrentUser1.FindSet() then begin
                                    varEmployeeInfo.SetFilter("User Id", varCurrentUser1."User Name");
                                    if varEmployeeInfo.FindSet() then begin
                                        varDimension.SetFilter(ParentId, varEmployeeInfo.SystemId);
                                        if varDimension.FindSet() then begin
                                            //Message('your department code is ' + varDimension."Dimension Value Code");
                                            Rec."Department Code" := varDimension."Dimension Value Code";

                                        end;

                                    end;
                                end

                                else
                                    if (Rec."Vendor Name" <> '') or (Rec."Location Code" <> '') then begin
                                        Rec."Vendor Name" := '';
                                        Rec."Location Code" := '';

                                    end;

                            end;
                        end;
                    end;
                }
                field("Description"; Rec."Description")
                {
                    Caption = 'Description';
                    ApplicationArea = Suite;
                    Editable = false;
                }
                field("Quantity"; Rec."Quantity")
                {
                    Caption = 'Quantity';
                    ApplicationArea = Suite;
                }
                field("Location Code"; Rec."Location Code")
                {
                    Caption = 'Location Code';
                    ApplicationArea = Suite;
                    Editable = false;
                }
                field("UOM"; Rec."UOM")
                {
                    Caption = 'UOM';
                    ApplicationArea = Suite;
                    Editable = false;
                }

                field("Department Code"; Rec."Department Code")
                {
                    Caption = 'Department Code';
                    ApplicationArea = Suite;
                }

                field("Vendor No"; Rec."Vendor No")
                {
                    Caption = 'Vendor No';
                    ApplicationArea = Suite;
                    Editable = false;
                }
                field("Vendor Name"; Rec."Vendor Name")
                {
                    Caption = 'Vendor Name';
                    ApplicationArea = Suite;
                    Editable = false;
                }
                field("Amount"; Rec."Amount")
                {
                    Caption = 'Amount';
                    ApplicationArea = Suite;
                }
                field("Net Amount"; Rec."Net Amount")
                {
                    Caption = 'Net Amount';
                    ApplicationArea = Suite;
                    Editable = false;
                }

                field("PO No."; Rec."PO No.")
                {
                    ApplicationArea = All;
                    Caption = 'PO No.';
                    Enabled = false;

                }

            }

        }
    }

    actions
    {
        /*
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction()
                begin

                end;
            }
        }
        */
    }

    var
        CurrentHeaderNo: code[20];


    Procedure globalHeader1(CurrentHeaderNo1: Code[20])

    begin
        CurrentHeaderNo := CurrentHeaderNo1
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean

    var
    begin
        CurrentHeaderNo := Rec."PR No.";
    end;



}