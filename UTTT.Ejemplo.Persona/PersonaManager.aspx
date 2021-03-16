<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PersonaManager.aspx.cs" Inherits="UTTT.Ejemplo.Persona.PersonaManager" debug=false%>

<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="ajaxToolkit" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <!-- CSS only -->

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-giJF6kkoqNQ00vy+HMDP7azOuL0xtbfIcaT9wjKHr8RbDVddVHyTfAAsrekwKmP1" crossorigin="anonymous"/>
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.14.0/css/all.css" integrity="sha384-HzLeBuhoNPvSl5KYnjx0BT+WB0QEEqLprO+NBkkk5gbc67FTaL7XIGa2w1L0Xbgc" crossorigin="anonymous">

</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
       
    <%--<div style="font-family: Arial; font-size: medium; font-weight: bold">--%>
    
    <div class="bg-secondary" align="center" style="color: #000000; font-size: 150%; font-family: Arial; font-weight: bold">Persona</div>
          <div>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<asp:Label ID="lblAccion"  align="center" style="font-weight: bold" Cssclass="h4" runat="server" Text="Accion" Font-Bold="True"></asp:Label>
        </div>
        
        <%--<div>--%>
        <%--<div class="navbar navbar-inverse">--%>
        <div class="row justify-content-md-center mt-3">
            <div class="col-md-6">
                <%-- Sexo --%>
                <div class="mb-3">
                    <label class="form-label" style="color: #000000; font-size: 100%; font-family: Arial; font-weight: bold">Sexo :</label>
            <asp:DropDownList ID="ddlSexo" runat="server" 
                CssClass="form-check-inline"  
                onselectedindexchanged="ddlSexo_SelectedIndexChanged">
            </asp:DropDownList>
                    
                    <asp:CustomValidator ID="CustomValidator1" align="center" runat="server" ControlToValidate="ddlSexo" EnableClientScript="False" ErrorMessage="Este campo es requerido" OnServerValidate="CustomValidator1_ServerValidate"></asp:CustomValidator>
                </div>
                <%-- Clave --%>
                <div class="mb-3">
                    <label class="form-label" style="color: #000000; font-size: 100%; font-family: Arial; font-weight: bold">Clave Única :</label>
                    <asp:TextBox ID="txtClaveUnica" runat="server" 
                     ViewStateMode="Disabled" MaxLength="3" CssClass="form-check-inline"  onkeyup="this.value=Numeros(this.value)"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtClaveUnica" EnableClientScript="False" ErrorMessage="Este campo es requerido"></asp:RequiredFieldValidator>
                </div>
                <%-- Nombre --%>
                <div class="mb-3">
                    <label class="form-label" style="color: #000000; font-size: 100%; font-family: Arial; font-weight: bold"">Nombre :</label>
                    <asp:TextBox ID="txtNombre" runat="server" ViewStateMode="Disabled" onkeypress="return soloLetras(event)" required="" MaxLength="20" CssClass="form-check-inline"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtNombre" EnableClientScript="False" ErrorMessage="Este campo es requerido"></asp:RequiredFieldValidator>
                    <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ControlToValidate="txtNombre" EnableClientScript="False" ErrorMessage="Este campo es requerido" ValidationGroup="validForm"></asp:RequiredFieldValidator>--%>
                    <%--<asp:CustomValidator ID="CustomValidator4" runat="server" ControlToValidate="txtNombre" EnableClientScript="False" ErrorMessage="Este campo contiene demasiados espacios" OnServerValidate="CustomValidator3_ServerValidate" ValidationGroup="validForm"></asp:CustomValidator>--%>
                </div>
                <%-- Apellido Paterno --%>
                <div class="mb-3">
                    <label class="form-label" style="color: #000000; font-size: 100%; font-family: Arial; font-weight: bold">Apellido Paterno :</label>
                    <asp:TextBox ID="txtAPaterno" runat="server" ViewStateMode="Disabled" onkeypress="return soloLetras(event)" required="" MaxLength="10" CssClass="form-check-inline"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtAPaterno" EnableClientScript="False" ErrorMessage="Este campo es requerido"></asp:RequiredFieldValidator>
                </div>
                <%-- Apellido Materno --%>
                <div class="mb-3">
                    <label class="form-label" style="color: #000000; font-size: 100%; font-family: Arial; font-weight: bold">Apellido Materno :</label>
                    <asp:TextBox ID="txtAMaterno" runat="server" ViewStateMode="Disabled" onkeypress="return soloLetras(event)" required="" MaxLength="10" CssClass="form-check-inline"></asp:TextBox>
                    <%--<asp:CustomValidator ID="CustomValidator5" runat="server" ControlToValidate="txtAMaterno" EnableClientScript="False" ErrorMessage="Este campo contiene demasiados espacios" OnServerValidate="CustomValidator5_ServerValidate" ValidationGroup="validForm"></asp:CustomValidator>--%>
                </div>
                <%-- Fecha Nacimiento --%>
                <div class="mb-3">
                    <label class="form-label" style="color: #000000; font-size: 100%; font-family: Arial; font-weight: bold"">Fecha de Nacimiento :</label>&nbsp;
                    <%--<asp:ImageButton ID="BtnFecha" ImageUrl="~/Images/Calendar.png"  AlternateText="No Image available" runat="server" Height="16px" />--%>
                    <asp:Button ID="BtnFecha" runat="server" Text="Seleccionar" />
                    &nbsp;<asp:TextBox ID="IdFecha" runat="server" CssClass="form-check-inline" MaxLength="10"></asp:TextBox> 
                    
                    <ajaxToolkit:CalendarExtender ID="IdFecha_CalendarExtender" runat="server" Format="dd/MM/yyyy" TargetControlID="IdFecha" PopupButtonID="BtnFecha"/>
                <asp:Label ID="IdErrorCal" runat="server"></asp:Label>
                </div>

                <%-- Estado Civil--%>
                <div class="mb-3">
                    <label class="form-label" style="color: #000000; font-size: 100%; font-family: Arial; font-weight: bold">Estado Civil :</label>
                    <asp:DropDownList ID="IdEstadoCivil" CssClass="form-check-inline" runat="server"></asp:DropDownList>
                    <asp:CustomValidator ID="CustomValidator3" runat="server" ControlToValidate="IdEstadoCivil" EnableClientScript="False" ErrorMessage="Campo requerido" OnServerValidate="CustomValidator3_ServerValidate1"></asp:CustomValidator>
                </div>

                <%-- Numero de Hermanos --%>
                <div class="mb-3">
                    <label class="form-label" style="color: #000000; font-size: 100%; font-family: Arial; font-weight: bold">Número de hermanos :</label>
                    <asp:TextBox ID="txtNumeroHermanos" runat="server" required="" onkeyup="this.value=Numeros(this.value)" MaxLength="2" CssClass="form-check-inline"></asp:TextBox>
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtNumeroHermanos" EnableClientScript="False" ErrorMessage="Este campo requiere solo numeros" ValidationExpression="^\d+$" ValidationGroup="validForm"></asp:RegularExpressionValidator>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="txtNumeroHermanos" EnableClientScript="False" ErrorMessage="Campo requerido"></asp:RequiredFieldValidator>
                </div>

                <%-- Correo --%>
                <div class="mb-3">
                    <label class="form-label" style="color: #000000; font-size: 100%; font-family: Arial; font-weight: bold">Correo electrónico :</label>
                    <asp:TextBox ID="txtCorreo" runat="server" required="" onkeypress="this.value=vEmail(this.value);" MaxLength="25" CssClass="form-check-inline"></asp:TextBox>
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="txtCorreo" EnableClientScript="False" ErrorMessage="Format not valid" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ValidationGroup="validForm"></asp:RegularExpressionValidator>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="txtCorreo" EnableClientScript="False" ErrorMessage="Campo requerido"></asp:RequiredFieldValidator>
                </div>

                <%-- Codigo Postal --%>     
                <div class="mb-3">
                    <label class="form-label" style="color: #000000; font-size: 100%; font-family: Arial; font-weight: bold">Código Postal :</label>
                    <asp:TextBox ID="txtCodigoPostal" runat="server" MaxLength="5" required="" onkeyup="this.value=Numeros(this.value)" CssClass="form-check-inline"></asp:TextBox>
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" ControlToValidate="txtCodigoPostal" EnableClientScript="False" ErrorMessage="Format not valid" ValidationExpression="^[0-5][1-9]{3}[0-9]$" ValidationGroup="validForm"></asp:RegularExpressionValidator>
                    <asp:CustomValidator ID="CustomValidator2" runat="server" ControlToValidate="txtCodigoPostal" EnableClientScript="False" ErrorMessage="Longitud de 5 caracteres" OnServerValidate="CustomValidator2_ServerValidate" ValidationGroup="validForm"></asp:CustomValidator>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="txtCodigoPostal" EnableClientScript="False" ErrorMessage="Campo requerido"></asp:RequiredFieldValidator>
                </div>

                <%--<%-- Rfc --%>
                <div class="mb-3">
                    <label class="form-label" style="color: #000000; font-size: 100%; font-family: Arial; font-weight: bold">RFC :</label>
                    <asp:TextBox ID="txtRfc" runat="server" MaxLength="13" CssClass="form-check-inline"></asp:TextBox>
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator4" runat="server" ControlToValidate="txtRfc" EnableClientScript="False" ErrorMessage="Format not valid" ValidationExpression="^([A-ZÑ\x26]{3,4}([0-9]{2})(0[1-9]|1[0-2])(0[1-9]|1[0-9]|2[0-9]|3[0-1]))([A-Z\d]{3})?$" ValidationGroup="validForm"></asp:RegularExpressionValidator>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ControlToValidate="txtRfc" EnableClientScript="False" ErrorMessage="Campo requerido"></asp:RequiredFieldValidator>
                    <%--<asp:RegularExpressionValidator ID="RegularExpressionValidator5" runat="server" ControlToValidate="txtRFC" EnableClientScript="False" ErrorMessage="El RFC no coincide con el formato oficial" ValidationExpression="^([aA-zZñÑ\x26]{3,4}([0-9]{2})(0[1-9]|1[0-2])(0[1-9]|1[0-9]|2[0-9]|3[0-1]))([aA-zZ\d]{3})?$" ValidationGroup="validForm"></asp:RegularExpressionValidator>--%>
                </div>

                <asp:Label ID="txtMensage" runat="server" Text="Label" Visible="False"></asp:Label>

                <div>
     
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
     
        <asp:Button ID="btnAceptar" class="btn btn-dark" runat="server" Text="Aceptar" 
            onclick="btnAceptar_Click" ViewStateMode="Disabled" />
        &nbsp;&nbsp;&nbsp;
        <asp:Button ID="btnCancelar" class="btn btn-secondary" runat="server" Text="Cancelar" 
            onclick="btnCancelar_Click" ViewStateMode="Disabled" />
    
    </div>
                </div>
            </div>

            

        <%--</div>--%>
        
        <%--<div id="txtMensage">--%>
    
            <asp:Calendar ID="IdCalendar" runat="server" Visible="False"></asp:Calendar>

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
           <%-- <asp:Label ID="Label3" runat="server" Text="Codigo Postal:"></asp:Label>
            <asp:TextBox ID="txtCodigoPostal" runat="server" style="margin-left: 56px" required="" onkeyup="this.value=Numeros(this.value)" MaxLength="5"></asp:TextBox>
            <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" ControlToValidate="txtCodigoPostal" EnableClientScript="False" ErrorMessage="Este campo requiere solo numeros" ValidationExpression="^\d+$"></asp:RegularExpressionValidator>
            <asp:CustomValidator ID="CustomValidator2" runat="server" ControlToValidate="txtCodigoPostal" EnableClientScript="False" ErrorMessage="Longitud de 5 caracteres" OnServerValidate="CustomValidator2_ServerValidate"></asp:CustomValidator>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="txtCodigoPostal" EnableClientScript="False" ErrorMessage="Campo requerido"></asp:RequiredFieldValidator>
            <asp:RegularExpressionValidator ID="RegularExpressionValidator5" runat="server" ControlToValidate="txtCodigoPostal" EnableClientScript="False" ErrorMessage="Format not valid" ValidationExpression="^[0-5][1-9]{3}[0-9]$"></asp:RegularExpressionValidator>
            <br />--%>
            <br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <%--<asp:Label ID="Label4" runat="server" Text="Rfc:"></asp:Label>
            <asp:TextBox ID="txtRfc" runat="server" style="margin-left: 120px" MaxLength="13" required=""></asp:TextBox>
            <asp:RegularExpressionValidator ID="RegularExpressionValidator4" runat="server" ControlToValidate="txtRfc" EnableClientScript="False" ErrorMessage="Format not valid" ValidationExpression="^([A-ZÑ\x26]{3,4}([0-9]{2})(0[1-9]|1[0-2])(0[1-9]|1[0-9]|2[0-9]|3[0-1]))([A-Z\d]{3})?$"></asp:RegularExpressionValidator>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ControlToValidate="txtRfc" EnableClientScript="False" ErrorMessage="Campo requerido"></asp:RequiredFieldValidator>
            <br />--%>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            
        <%--</div>--%>
    <div> 
    
        <asp:Label ID="txtMensageJS" runat="server"></asp:Label>
            <br />
    
    </div>
    
            <%--</div>--%>
    </form>
    <script src="javaScripFile.js" type="text/javascript"></script>
</body>
</html>
