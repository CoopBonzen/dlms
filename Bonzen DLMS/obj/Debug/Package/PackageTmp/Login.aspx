<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Login.aspx.vb" Inherits="Bonzen_DLMS.Login" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body bgcolor="#0a98d9">
    <form id="form1" runat="server">
    <center>
        <div id="div_bg" runat="server" style="background-image: url(Images/login.jpg);
            height: 600px; width: 1024px;">
            <h1 style="font-family: 'Angsana New'; font-size: 70px; text-align: center; color: #FFFFFF;">
                &nbsp;</h1>
            
                <div style=" border: 5px solid #4747FF; border-radius: 20px; background-color:White; 
                    padding :10px 10px 10px 10px; width:310px; box-shadow: 10px 10px 30px #888888;"> 
                    <asp:Login ID="Login" runat="server" UserNameLabelText="ชื่อผู้ใช้ :  " PasswordLabelText="รหัสผ่าน :  "
                        BackColor="White" BorderColor="#000099" BorderPadding="30" BorderStyle="Solid"
                        BorderWidth="0px" Font-Names="Tahoma" Font-Size="Medium" ForeColor="#333333" 
                        DisplayRememberMe="False" EnableTheming="True" Font-Bold="False" Height="120px"
                        LoginButtonText="เข้าสู่ระบบ" TitleText="" Width="250px">
                        <InstructionTextStyle Font-Italic="True" ForeColor="Black" />
                        <LoginButtonStyle BackColor="#FFFBFF" BorderColor="#CCCCCC" BorderStyle="Solid" BorderWidth="2px"
                            Font-Names="Verdana" Font-Size="0.8em" ForeColor="#284775" />
                        <TextBoxStyle Font-Size="0.8em" Width="170px" />
                        <TitleTextStyle BackColor="#5D7B9D" Font-Bold="True" Font-Size="0.9em" ForeColor="White" />
                    </asp:Login>
                </div>
           
        </div>
    </center>
    </form>
</body>
</html>
