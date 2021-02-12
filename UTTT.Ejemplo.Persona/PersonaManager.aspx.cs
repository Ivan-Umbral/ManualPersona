#region Using

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using UTTT.Ejemplo.Linq.Data.Entity;
using System.Data.Linq;
using System.Linq.Expressions;
using System.Collections;
using UTTT.Ejemplo.Persona.Control;
using UTTT.Ejemplo.Persona.Control.Ctrl;
using System.Text.RegularExpressions;

#endregion

namespace UTTT.Ejemplo.Persona
{
    public partial class PersonaManager : System.Web.UI.Page
    {
        #region Variables

        private SessionManager session = new SessionManager();
        private int idPersona = 0;
        private UTTT.Ejemplo.Linq.Data.Entity.Persona baseEntity;
        private DataContext dcGlobal = new DcGeneralDataContext();
        private int tipoAccion = 0;
        private readonly Regex numeros=new Regex(@"^\d+$");
        private readonly Regex gmail = new Regex(@"\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*");
        private readonly Regex rfcc = new Regex(@"^([aA-zZñÑ\x26]{3,4}([0-9]{2})(0[1-9]|1[0-2])(0[1-9]|1[0-9]|2[0-9]|3[0-1]))([aA-zZ\d]{3})?$");
        private readonly Regex SoloLetras = new Regex(@"^[a-zA-ZÀ-ÿ\s\u00f1\u00d1]+$");

        #endregion

        #region Eventos

        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                this.Response.Buffer = true;
                this.session = (SessionManager)this.Session["SessionManager"];
                this.idPersona = this.session.Parametros["idPersona"] != null ?
                    int.Parse(this.session.Parametros["idPersona"].ToString()) : 0;
                if (this.idPersona == 0)
                {
                    this.baseEntity = new Linq.Data.Entity.Persona();
                    this.tipoAccion = 1;
                }
                else
                {
                    this.baseEntity = dcGlobal.GetTable<Linq.Data.Entity.Persona>().First(c => c.id == this.idPersona);
                    this.tipoAccion = 2;
                }

                if (!this.IsPostBack)
                {
                    if (this.session.Parametros["baseEntity"] == null)
                    {
                        this.session.Parametros.Add("baseEntity", this.baseEntity);
                    }
                    List<CatSexo> lista = dcGlobal.GetTable<CatSexo>().ToList();
                    CatSexo catTemp = new CatSexo();
                    //catTemp.id = -1;
                    //catTemp.strValor = "Seleccionar";
                    //lista.Insert(0, catTemp);
                    //this.ddlSexo.DataTextField = "strValor";
                    //this.ddlSexo.DataValueField = "id";
                    //this.ddlSexo.DataSource = lista;
                    //this.ddlSexo.DataBind();

                    this.ddlSexo.SelectedIndexChanged += new EventHandler(ddlSexo_SelectedIndexChanged);
                    this.ddlSexo.AutoPostBack = true;
                    if (this.idPersona == 0)
                    {
                        catTemp.id = -1;
                        catTemp.strValor = "Seleccionar";
                        lista.Insert(0, catTemp);
                        this.ddlSexo.DataTextField = "strValor";
                        this.ddlSexo.DataValueField = "id";
                        this.ddlSexo.DataSource = lista;
                        this.ddlSexo.DataBind();

                        //this.lblAccion.Text = "Agregar";

                        this.lblAccion.Text = "Agregar";
                        DateTime date = new DateTime(2000, 7, 8);
                        this.IdCalendar.TodaysDate = date;

                        //DateTime date = new DateTime(2000, 1, 1);
                        //this.IdCalendar.TodaysDate = date;
                        //this.IdCalendar.SelectedDate = date;

                    }
                    else
                    {
                        catTemp.id = baseEntity.CatSexo.strValor == "Masculino" ? 1 : 2;
                        catTemp.strValor = baseEntity.CatSexo.strValor;
                        lista.Insert(0, catTemp);
                        this.ddlSexo.DataTextField = "strValor";
                        this.ddlSexo.DataValueField = "id";
                        lista.RemoveAt(0);
                        this.ddlSexo.DataSource = lista;
                        this.ddlSexo.DataBind();

                        this.lblAccion.Text = "Editar";
                        this.txtNombre.Text = this.baseEntity.strNombre;
                        this.txtAPaterno.Text = this.baseEntity.strAPaterno;
                        this.txtAMaterno.Text = this.baseEntity.strAMaterno;
                        this.txtClaveUnica.Text = this.baseEntity.strClaveUnica;
                        this.setItem(ref this.ddlSexo, baseEntity.CatSexo.strValor);

                        this.txtNumeroHermanos.Text = this.baseEntity.Num_Hermanos.ToString();
                        this.txtCorreo.Text = this.baseEntity.Correo;
                        this.txtCodigoPostal.Text = this.baseEntity.Codigo_Postal;
                        this.txtRfc.Text = this.baseEntity.Rfc;
                        DateTime? fechaNa = this.baseEntity.Fecha_Naci;

                        if (fechaNa != null)
                        {
                            //this.IdCalendar.TodaysDate = (DateTime)fechaNa;
                            this.IdCalendar.TodaysDate = (DateTime)fechaNa;
                            this.IdCalendar.SelectedDate = (DateTime)fechaNa;

                        }
                        
                        this.setItem(ref this.ddlSexo, baseEntity.CatSexo.strValor);
                    }                
                }

            }
            catch (Exception _e)
            {
                this.showMessage("Ha ocurrido un problema al cargar la página");
                this.Response.Redirect("~/PersonaPrincipal.aspx", false);
            }

        }

        protected void btnAceptar_Click(object sender, EventArgs e)
        {
            try
            {
                if (!IsValid)
                {
                    return;
                }
                DataContext dcGuardar = new DcGeneralDataContext();
                UTTT.Ejemplo.Linq.Data.Entity.Persona persona = new Linq.Data.Entity.Persona();
                int i = 0;
                if (this.idPersona == 0)
                {
                    persona.Fecha_Naci = this.IdCalendar.SelectedDate.Date;
                    //ControlGmail ctrgmail = new ControlGmail();
                    //ctrgmail.sendEmail("Edel");
                    persona.strClaveUnica = this.txtClaveUnica.Text.Trim();
                    persona.strNombre = this.txtNombre.Text.Trim();
                    persona.strAMaterno = this.txtAMaterno.Text.Trim();
                    persona.strAPaterno = this.txtAPaterno.Text.Trim();
                    persona.idCatSexo = int.Parse(this.ddlSexo.Text);
                   
                    //persona.Num_Hermanos = int.Parse(this.txtNumeroHermanos.Text);
                    persona.Num_Hermanos = this.txtNumeroHermanos.Text.Trim().Length > 0 ? (int.TryParse(this.txtNumeroHermanos.Text.Trim(), out i) ? int.Parse(this.txtNumeroHermanos.Text.Trim()) : 0) : 0;
                    persona.Correo = this.txtCorreo.Text;
                    persona.Codigo_Postal = this.txtCodigoPostal.Text;
                    persona.Rfc = this.txtRfc.Text;
                    String mensage = String.Empty;
                    if (!this.validacion(persona, ref mensage))
                    {
                        this.txtMensage.Text = mensage;
                        this.txtMensage.Visible = true;
                        return;
                    }
                    if (!this.ValidacionSql(ref mensage))
                    {
                        this.txtMensage.Text = mensage;
                        this.txtMensage.Visible = true;
                        return;
                    }
                    if (!this.ValidacionHtml(ref mensage))
                    {
                        this.txtMensage.Text = mensage;
                        this.txtMensage.Visible = true;
                        return;
                    }

                    dcGuardar.GetTable<UTTT.Ejemplo.Linq.Data.Entity.Persona>().InsertOnSubmit(persona);
                    dcGuardar.SubmitChanges();
                    this.showMessage("El registro se agrego correctamente.");
                    this.Response.Redirect("~/PersonaPrincipal.aspx", false);
                    
                }
                if (this.idPersona > 0)
                {
                    persona = dcGuardar.GetTable<UTTT.Ejemplo.Linq.Data.Entity.Persona>().First(c => c.id == idPersona);
                    persona.Fecha_Naci = this.IdCalendar.SelectedDate.Date;
                    persona.strClaveUnica = this.txtClaveUnica.Text.Trim();
                    persona.strNombre = this.txtNombre.Text.Trim();
                    persona.strAMaterno = this.txtAMaterno.Text.Trim();
                    persona.strAPaterno = this.txtAPaterno.Text.Trim();
                    persona.idCatSexo = int.Parse(this.ddlSexo.Text);
                    //persona.Num_Hermanos = int.Parse(this.txtNumeroHermanos.Text);
                    persona.Num_Hermanos = this.txtNumeroHermanos.Text.Trim().Length > 0 ? (int.TryParse(this.txtNumeroHermanos.Text.Trim(), out i) ? int.Parse(this.txtNumeroHermanos.Text.Trim()) : 0) : 0;
                    persona.Correo = this.txtCorreo.Text;
                    persona.Codigo_Postal = this.txtCodigoPostal.Text;
                    persona.Rfc = this.txtRfc.Text;
                    String mensage = String.Empty;
                    if (!this.validacion(persona, ref mensage))
                    {
                        this.txtMensage.Text = mensage;
                        this.txtMensage.Visible = true;
                        return;
                    }
                    if (!this.ValidacionSql(ref mensage))
                    {
                        this.txtMensage.Text = mensage;
                        this.txtMensage.Visible = true;
                        return;
                    }
                    if (!this.ValidacionHtml(ref mensage))
                    {
                        this.txtMensage.Text = mensage;
                        this.txtMensage.Visible = true;
                        return;
                    }
                    dcGuardar.SubmitChanges();
                    this.showMessage("El registro se edito correctamente.");
                    this.Response.Redirect("~/PersonaPrincipal.aspx", false);
                }
            }
            catch (Exception _e)
            {
                //this.showMessageException(_e.Message);
                ControlGmail ctrlmail = new ControlGmail();
                ctrlmail.sendEmail(_e.Message);
                this.Response.Redirect("~/Error/Error.html", false);
            }
        }

        protected void btnCancelar_Click(object sender, EventArgs e)
        {
            try
            {              
                this.Response.Redirect("~/PersonaPrincipal.aspx", false);
            }
            catch (Exception _e)
            {
                this.showMessage("Ha ocurrido un error inesperado");
            }
        }

        protected void ddlSexo_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
                int idSexo = int.Parse(this.ddlSexo.Text);
                Expression<Func<CatSexo, bool>> predicateSexo = c => c.id == idSexo;
                predicateSexo.Compile();
                List<CatSexo> lista = dcGlobal.GetTable<CatSexo>().Where(predicateSexo).ToList();
                CatSexo catTemp = new CatSexo();            
                this.ddlSexo.DataTextField = "strValor";
                this.ddlSexo.DataValueField = "id";
                this.ddlSexo.DataSource = lista;
                this.ddlSexo.DataBind();
            }
            catch (Exception)
            {
                this.showMessage("Ha ocurrido un error inesperado");
            }
        }

        #endregion

        #region Metodos

        public void setItem(ref DropDownList _control, String _value)
        {
            foreach (ListItem item in _control.Items)
            {
                if (item.Value == _value)
                {
                    item.Selected = true;
                    break;
                }
            }
            _control.Items.FindByText(_value).Selected = true;
        }

        #endregion


        #region MetodosValidaciones
        /// <summary>
        /// Validación datos
        /// </summary>
        /// <param name="_persona"></param>
        /// <param name="_mensaje"></param>
        /// <returns></returns>

        public bool validacion(UTTT.Ejemplo.Linq.Data.Entity.Persona _persona, ref String _mensaje) {
            int i;
            if (_persona.idCatSexo<0)
            {
                _mensaje = "El campo de sexo es requerido";
                return false;
            }
            //
            //Clave unica
            if (_persona.strClaveUnica.Equals(String.Empty))
            {
                _mensaje = "El campo clave única es requerido";
                return false;
            }

            if (!int.TryParse(_persona.strClaveUnica, out i))
            {
                _mensaje = "La clave única debe ser un número";
                return false;
            }
            //if (int.Parse(_persona.strClaveUnica) < 100 || int.Parse(_persona.strClaveUnica) > 999)
            //{
            //    _mensaje = "La clave unica no contiene rango necesario";
            //    return false;
            //}
            if (_persona.strClaveUnica.Length > 3 || _persona.strClaveUnica.Length < 3)
            {
                _mensaje = "La clave unica debe tener 3 caracteres de longitud";
                return false;
            }
            //Nombre
            if (_persona.strNombre.Equals(String.Empty))
            {
                _mensaje = "El campo de nombre es requerido";
                return false;
            }
            
            if (_persona.strNombre.Length < 3 || _persona.strNombre.Length > 50)
            {
                _mensaje = "Rango de nombre no es valido";
                return false;
            }
            if (!this.SoloLetras.IsMatch(_persona.strNombre))
            {
                _mensaje = "El campo Nombre debe contener solo letras.";
                return false;
            }
            //Paterno
            if (_persona.strAPaterno.Equals(String.Empty))
            {
                _mensaje = "El campo de apellido paterno es requerido";
                return false;
            }
            if (_persona.strAPaterno.Length < 3 || _persona.strAPaterno.Length > 50)
            {
                _mensaje = "Rango de Apellido Paterno no es valido";
                return false;
            }
            if (!this.SoloLetras.IsMatch(_persona.strAPaterno))
            {
                _mensaje = "El campo Apellido Paterno debe contener solo letras.";
                return false;
            }
            //////Materno
            if (_persona.strAMaterno.Equals(String.Empty))
            {
                _mensaje = "El campo de apellido Materno es requerido";
                return false;
            }
            if (_persona.strAMaterno.Length < 3 || _persona.strAMaterno.Length > 50)
            {
                _mensaje = "Rango de Apellido Materno no es valido";
                return false;
            }
            if (!this.SoloLetras.IsMatch(_persona.strAMaterno))
            {
                _mensaje = "El campo Apellido Materno debe contener solo letras.";
                return false;
            }


            //Fecha Nacimiento
            if (_persona.Fecha_Naci.ToString().Equals("01/01/0001 12:00:00 a. m.") || _persona.Fecha_Naci.ToString().Equals("1/1/0001 12:00:00 AM"))
            {
                _mensaje = "El campo fecha de nacimiento es requerido";
                return false;
            }
            var time = DateTime.Now - _persona.Fecha_Naci.Value.Date;
            if (time.Days < 6570)
            {
                _mensaje = "Debes ser mayor de 18 años";
                return false;
            }
            if (_persona.Num_Hermanos.ToString().Equals(String.Empty))
            {
                _mensaje = "El campo de numero de hermanos es requerido";
                return false;
            }

            if (!this.numeros.IsMatch(_persona.Num_Hermanos.ToString()))
            {
                _mensaje = "Numero de hermanos debe ser entero";
                return false;
            }
            if (_persona.Num_Hermanos.ToString().Length > 2)
            {
                _mensaje = "Rango de hermanos no valido";
                return false;
            }
            
            if (_persona.Correo.Equals(String.Empty))
            {
                _mensaje = "El campo de correo es requerido";
                return false;
            }
            if (!this.gmail.IsMatch(_persona.Correo.ToString()))
            {
                _mensaje = "Correo invalido";
                return false;
            }
            if (_persona.Correo.Length > 50)
            {
                _mensaje = "El correo electrónico rebasa la longitud de caracteres permitida.";
                return false;
            }

            if (_persona.Codigo_Postal.Equals(String.Empty))
            {
                _mensaje = "El campo de codigo postal es requerido";
                return false;
            }
            if (_persona.Codigo_Postal.Length > 5 || _persona.Codigo_Postal.Length < 5)
            {
                _mensaje = "Codigo postal Fuera de rango";
                return false;
            }
            if (_persona.Rfc.Equals(String.Empty))
            {
                _mensaje = "El campo de Rfc es requerido";
                return false;
            }

            if (!this.rfcc.IsMatch(_persona.Rfc.ToString()))
            {
                _mensaje = "Rfc invalido";
                return false;
            }
            if (_persona.Rfc.Length > 13)
            {
                _mensaje = "Rango de Rfc no es valido";
                return false;
            }
            return true;
        }

        public bool ValidacionSql(ref String _mensaje)
        {
            ControlSQl ctrsql = new ControlSQl();
            String _mensajeFuncion = String.Empty;
            
            if (ctrsql.sqlInjectionValida(this.txtClaveUnica.Text.Trim(), ref _mensajeFuncion, "Clave Única", ref this.txtClaveUnica))
            {
                _mensaje = _mensajeFuncion;
                return false;
            }
            if (ctrsql.sqlInjectionValida(this.txtNombre.Text.Trim(), ref _mensajeFuncion, "Nombre", ref this.txtNombre))
            {
                _mensaje = _mensajeFuncion;
                return false;
            }
            if (ctrsql.sqlInjectionValida(this.txtAPaterno.Text.Trim(), ref _mensajeFuncion, "Apellido Paterno", ref this.txtAPaterno))
            {
                _mensaje = _mensajeFuncion;
                return false;
            }
            if (ctrsql.sqlInjectionValida(this.txtAMaterno.Text.Trim(), ref _mensajeFuncion, "Apellido Materno", ref this.txtAMaterno))
            {
                _mensaje = _mensajeFuncion;
                return false;
            }
            ////////////////////////
            if (ctrsql.sqlInjectionValida(this.txtNumeroHermanos.Text.Trim(), ref _mensajeFuncion, "Numero de hermanos", ref this.txtNumeroHermanos))
            {
                _mensaje = _mensajeFuncion;
                return false;
            }
            if (ctrsql.sqlInjectionValida(this.txtCorreo.Text.Trim(), ref _mensajeFuncion, "Correo Electronico", ref this.txtCorreo))
            {
                _mensaje = _mensajeFuncion;
                return false;
            }
            if (ctrsql.sqlInjectionValida(this.txtCodigoPostal.Text.Trim(), ref _mensajeFuncion, "Codigo Postal", ref this.txtCodigoPostal))
            {
                _mensaje = _mensajeFuncion;
                return false;
            }
            if (ctrsql.sqlInjectionValida(this.txtRfc.Text.Trim(), ref _mensajeFuncion, "Rfc", ref this.txtRfc))
            {
                _mensaje = _mensajeFuncion;
                return false;
            }
            return true;
        }

        public bool ValidacionHtml(ref String _mensaje)
        {
            ControlSQl valida = new ControlSQl();
            String mensajeFuncion = String.Empty;
            if (valida.htmlInjectionValida(this.txtClaveUnica.Text.Trim(), ref mensajeFuncion, "Clave Única", ref this.txtClaveUnica))
            {
                _mensaje = mensajeFuncion;
                return false;
            }
            if (valida.htmlInjectionValida(this.txtNombre.Text.Trim(), ref mensajeFuncion, "Nombre", ref this.txtNombre))
            {
                _mensaje = mensajeFuncion;
                return false;
            }
            if (valida.htmlInjectionValida(this.txtAPaterno.Text.Trim(), ref mensajeFuncion, "Apellido Paterno", ref this.txtAPaterno))
            {
                _mensaje = mensajeFuncion;
                return false;
            }
            if (valida.htmlInjectionValida(this.txtAMaterno.Text.Trim(), ref mensajeFuncion, "Apellido Materno", ref this.txtAMaterno))
            {
                _mensaje = mensajeFuncion;
                return false;
            }
            if (valida.htmlInjectionValida(this.txtNumeroHermanos.Text.Trim(), ref mensajeFuncion, "Numero de hermanos", ref this.txtNumeroHermanos))
            {
                _mensaje = mensajeFuncion;
                return false;
            }
            if (valida.htmlInjectionValida(this.txtCorreo.Text.Trim(), ref mensajeFuncion, "Correo", ref this.txtCorreo))
            {
                _mensaje = mensajeFuncion;
                return false;
            }
            if (valida.htmlInjectionValida(this.txtCodigoPostal.Text.Trim(), ref mensajeFuncion, "Codigo Postal", ref this.txtCodigoPostal))
            {
                _mensaje = mensajeFuncion;
                return false;
            }
            if (valida.htmlInjectionValida(this.txtRfc.Text.Trim(), ref mensajeFuncion, "Rfc", ref this.txtRfc))
            {
                _mensaje = mensajeFuncion;
                return false;
            }
            return true;
        }
        #endregion



        protected void CustomValidator1_ServerValidate(object source, ServerValidateEventArgs args)
        {
            int sexo = int.Parse(this.ddlSexo.SelectedValue);
            if (sexo > 0)
            {
                args.IsValid = true;
            }
            else
            {
                args.IsValid = false;
            }
        }

        protected void CustomValidator2_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (this.txtCodigoPostal.Text.Trim().Length == 5)
            {
                args.IsValid = true;
            }
            else
            {
                args.IsValid = false;
            }
        }

        protected void IdCalendar_SelectionChanged(object sender, EventArgs e)
        {

        }
    }
}