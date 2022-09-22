<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="UniformsPaymentReceipt.aspx.vb" Inherits="WebApplication2.UniformsPaymentReceipt" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <script language="javascript" type="text/javascript">
            function CallPrint(strid) {
                var prtContent = document.getElementById(strid);
                var WinPrint = window.open('', '', 'letf=0,top=0,width=400,height=500,toolbar=0,scrollbars=0,status=0');
                WinPrint.document.write(prtContent.innerHTML);
                WinPrint.document.close();
                WinPrint.focus();
                WinPrint.print();

                //WinPrint.print.
                WinPrint.close();
                prtContent.innerHTML = strOldOne;
            }
        </script>

        <div id="bill">
            <%-- the content will be printed --%>
            <table class="watermark">
                <tr><td colspan="2">&nbsp</td></tr>
                <tr><td colspan="2" class="receiptHeader" style="text-align:center;font-weight:bolder">HERENTALS COLLEGE</td></tr>
                <tr><td colspan="2" class="receiptHeader" style="text-align:center;font-weight:bolder">Uniforms Payment Receipt</td></tr>
                <tr><td><asp:Label ID="lblReceiptNumber" runat="server" Text="Receipt Number"></asp:Label></td><td><asp:Label ID="txtReceiptNumber" runat="server"></asp:Label></td></tr>
                <tr><td colspan="2"><hr /></td></tr>
                <tr><td><asp:Label ID="lblDate" runat="server" Text="Date"></asp:Label></td><td><asp:Label ID="txtdate" runat="server"></asp:Label></td></tr>
                <tr><td><asp:Label ID="lblStudentId" runat="server" Text="Student ID"></asp:Label></td><td><asp:Label ID="txtStudentId" runat="server"></asp:Label></td></tr>
                <tr><td><asp:Label ID="lblStudent" runat="server" Text="Student Name"></asp:Label></td><td><asp:Label ID="txtStudent" runat="server"></asp:Label></td></tr>
                <%--
                <tr><td><asp:Label ID="lblStream" runat="server" Text="Stream"></asp:Label></td><td><asp:Label ID="txtStream" runat="server"></asp:Label></td></tr> --%>
                <tr><td><asp:Label ID="lblSchoolClass" runat="server" Text="Class"></asp:Label></td><td><asp:Label ID="txtSchoolClass" runat="server"></asp:Label></td></tr>
                <tr><td><asp:Label ID="lblStrMonth" runat="server" Text="Month/Year"></asp:Label></td><td><asp:Label ID="txtStrMonth" runat="server"></asp:Label>&nbsp;&nbsp;&nbsp<asp:Label ID="txtIntYear" runat="server"></asp:Label></td></tr>
                <%--
                <tr><td><asp:Label ID="lblMonthNumber" runat="server" Text="Month Number"></asp:Label></td><td><asp:Label ID="txtMonthNumber" runat="server"></asp:Label></td></tr>--%>
                <tr><td><asp:Label ID="lblExpectedAmt" runat="server" Text="Expected Amount"></asp:Label></td><td><asp:Label ID="txtExpectedAmt" runat="server"></asp:Label></td></tr>
                <tr><td><asp:Label ID="lblAmountPaid" runat="server" Text="Amount Paid"></asp:Label></td><td><asp:Label ID="txtAmountPaid" runat="server"></asp:Label></td></tr>
                <tr><td><asp:Label ID="lblBalance" runat="server" Text="Balance"></asp:Label></td><td><asp:Label ID="txtBalance" runat="server"></asp:Label></td></tr>
                <tr><td><asp:Label ID="lblPenalty" runat="server" Text="Penalty"></asp:Label></td><td><asp:Label ID="txtPenalty" runat="server"></asp:Label></td></tr>
                <tr><td><asp:Label ID="lblCashier" runat="server" Text="Cashier"></asp:Label></td><td><asp:Label ID="txtCashier" runat="server"></asp:Label></td></tr>
            </table>
        </div>
        <asp:button id="BtnPrint" runat="server" text="Print Receipt" onclientclick="javascript:CallPrint('bill')"> </asp:button>
    </form>
</body>
</html>
