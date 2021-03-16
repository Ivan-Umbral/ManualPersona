<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PersonaPrincipal.aspx.cs" Inherits="UTTT.Ejemplo.Persona.PersonaPrincipal"  debug=false%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-BmbxuPwQa2lc/FVzBcNJ7UAyJxM6wuqIj61tLrc4wSX0szH/Ev+nYRRuWlolflfl" crossorigin="anonymous" />
</head>

<body class="table-responsive">
    <form id="form1" runat="server">
    <div class="bg-secondary" align="center" style="color: #000000; font-size: 150%; font-family: Arial; font-weight: bold">Persona</div>
    
     <%--   <div>--%>
        
        
        
        <asp:ScriptManager runat="server"></asp:ScriptManager>

                <asp:UpdatePanel ID="paneltxtName" runat="server">
                    <ContentTemplate>
                        <asp:Button style="display:none;" runat="server" OnClick="Unnamed_Click" ID="BtnBus"/>
        <%--<asp:TextBox ID="txtNombre" runat="server" Width="174px" 
            ViewStateMode="Disabled" OnTextChanged="txtNombre_TextChanged" AutoPostBack="true"></asp:TextBox>--%>
                         </ContentTemplate>
                </asp:UpdatePanel>
        <div  align="center" style="color: #000000; font-size: 100%; font-family: Arial; font-weight: bold">
            &nbsp; 
            <br />
            Nombre :&nbsp; 
            <asp:TextBox ID="txtNombre" runat="server" Width="174px" 
            ViewStateMode="Disabled" AutoPostBack="false"></asp:TextBox>&nbsp;&nbsp;&nbsp;
            <asp:Button ID="btnBuscar" class="btn btn-secondary" runat="server" Text="Buscar" 
            onclick="btnBuscar_Click" ViewStateMode="Disabled" /> &nbsp;&nbsp;&nbsp;
            <asp:Button ID="btnAgregar" class="btn btn-dark" runat="server" Text="Agregar" 
            onclick="btnAgregar_Click" ViewStateMode="Disabled" />
            <br />
            <br />
        </div>
        
        <div  align="center" style="color: #000000; font-size: 100%; font-family: Arial; font-weight: bold">Sexo :&nbsp; 
            <asp:DropDownList ID="ddlSexo" runat="server" Height="32px" Width="177px">
        </asp:DropDownList>
          &nbsp  
            <asp:Label ID="Label1" runat="server" Text="Estado Civil :"></asp:Label>&nbsp
        <asp:DropDownList ID="IdEstadosCiviles" runat="server">
        </asp:DropDownList>    
            <br />
        </div>
        <div  align="center" style="color: #000000; font-size: 100%; font-family: Arial; font-weight: bold"> 
            
            
        </div>

        
    
    <%--</div>--%>
    
    <div style="font-weight: bold" class="mt-3">
        <h4 class="text-center">Detalle</h4>
    </div>
       
        <div class="table-responsive">
        
            <asp:UpdatePanel runat="server" ID="panelGrid">
                    <ContentTemplate>

             <asp:GridView ID="dgvPersonas" runat="server" 
                AllowPaging="True" AutoGenerateColumns="False" DataSourceID="DataSourcePersona" 
                Width="1365px" Height="400" CellPadding="4" GridLines="None" 
                onrowcommand="dgvPersonas_RowCommand" BackColor="White" 
                BorderColor="#E7E7FF" BorderStyle="None" BorderWidth="1px" 
                ViewStateMode="Disabled">
                <AlternatingRowStyle BackColor="#F7F7F7" />
                <Columns>
                    <asp:BoundField DataField="strClaveUnica" HeaderText="Clave Unica" 
                        ReadOnly="True" SortExpression="strClaveUnica" />
                    <asp:BoundField DataField="strNombre" HeaderText="Nombre" ReadOnly="True" 
                        SortExpression="strNombre" />
                    <asp:BoundField DataField="strAPaterno" HeaderText="APaterno" ReadOnly="True" 
                        SortExpression="strAPaterno" />
                    <asp:BoundField DataField="strAMaterno" HeaderText="AMaterno" ReadOnly="True" 
                        SortExpression="strAMaterno" />
                    <asp:BoundField DataField="CatSexo" HeaderText="Sexo" 
                        SortExpression="CatSexo" />
                    <asp:TemplateField HeaderText="Editar">
                        <ItemTemplate>
                                    <asp:ImageButton runat="server" ID="imgEditar" CommandName="Editar" CommandArgument='<%#Bind("id") %>' ImageUrl="~/Images/editrecord_16x16.png" />
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Center" />
                                <ItemStyle HorizontalAlign="Center" Width="50px" />
                    
                    </asp:TemplateField>
                     <asp:TemplateField HeaderText="Eliminar" Visible="True">
                            <ItemTemplate>
                                <asp:ImageButton runat="server" ID="imgEliminar" CommandName="Eliminar" CommandArgument='<%#Bind("id") %>' ImageUrl="~/Images/delrecord_16x16.png" OnClientClick="javascript:return confirm('¿Está seguro de querer eliminar el registro seleccionado?', 'Mensaje de sistema')"/>
                            </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Center" />
                                <ItemStyle HorizontalAlign="Center" Width="50px" />
                            </asp:TemplateField>

                      <asp:TemplateField HeaderText="Direccion">
                        <ItemTemplate>
                                    <asp:ImageButton runat="server" ID="imgDireccion" CommandName="Direccion" CommandArgument='<%#Bind("id") %>' ImageUrl="~/Images/editrecord_16x16.png" />
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Center" />
                                <ItemStyle HorizontalAlign="Center" Width="50px" />
                    
                    </asp:TemplateField>
                </Columns>
                <FooterStyle BackColor="#B5C7DE" ForeColor="#34495E" />
                <HeaderStyle BackColor="#34495E" Font-Bold="True" ForeColor="#F7F7F7" />
                <PagerStyle BackColor="#E7E7FF" ForeColor="#34495E" HorizontalAlign="Right" />
                <RowStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" />
                <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="#F7F7F7" />
                <SortedAscendingCellStyle BackColor="#F4F4FD" />
                <SortedAscendingHeaderStyle BackColor="#5A4C9D" />
                <SortedDescendingCellStyle BackColor="#D8D8F0" />
                <SortedDescendingHeaderStyle BackColor="#3E3277" />
            </asp:GridView>
                        </ContentTemplate>
                    </asp:UpdatePanel>
        
        </div>
    <asp:LinqDataSource ID="DataSourcePersona" runat="server" 
        ContextTypeName="UTTT.Ejemplo.Linq.Data.Entity.DcGeneralDataContext" 
        onselecting="DataSourcePersona_Selecting" 
        Select="new (strNombre, strAPaterno, strAMaterno, CatSexo, strClaveUnica,id)" 
        TableName="Persona" EntityTypeName="">
    </asp:LinqDataSource>
        
    </form>
    <script type="text/javascript">
        document.querySelector("#txtNombre").addEventListener("keyup",() => {
            document.querySelector("#BtnBus").click();
        });
    </script>
</body>
</html>
