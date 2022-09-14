codeunit 70106 DeleteEvent

{
    trigger OnRun()
    var
        myInt: Integer;
    begin

    end;
    //check before delete header
    [EventSubscriber(ObjectType::Table, Database::"Purchase Requisition Header", 'OnBeforeDeleteEvent', '', false, false)]

    local procedure OnBeforeDeleteEventForheader(var Rec: Record "Purchase Requisition Header");

    begin

        if (Rec.Status = 'Approved') or (Rec.Status = 'Submitted') then
            Error('You cannot delete this requisition ' + Rec."PR No.");

    end;

    //check before delete line
    [EventSubscriber(ObjectType::Table, Database::"Purchase Requistion Line", 'OnBeforeDeleteEvent', '', false, false)]

    local procedure OnBeforeDeleteEventForLine(var Rec: Record "Purchase Requistion Line");
    var
        varHeaderCheck: Record "Purchase Requisition Header";
        varLineCheck: Record "Purchase Requistion Line";

    begin
        varHeaderCheck.SetFilter("PR No.", Rec."PR No.");
        If varHeaderCheck.FindSet() then begin
            varLineCheck.SetFilter("PR No.", Rec."PR No.");
            if varLineCheck.FindSet() then begin
                if (varHeaderCheck.Status = 'Approved') or (varHeaderCheck.Status = 'Submitted') then
                    Error('You cannot delete this line no ' + Format(varLineCheck."Line No."));

            end;

        end;



    end;

}

