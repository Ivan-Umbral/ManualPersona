function myFunction() {
    document.getElementById("demo").innerHTML = "My First JavaScript Function";

}
function soloLetras(e)
{
        key = e.keyCode || e.which;
        tecla = String.fromCharCode(key).toLowerCase();
        letras = " Ã¡Ã©Ã­Ã³ÃºabcdefghijklmnÃ±opqrstuvwxyz";
        especiales = "8-37-39-46";

        tecla_especial = false
        for (var i in especiales) {
            if (key == especiales[i]) {
                tecla_especial = true;
                break;
            }
        }

        if (letras.indexOf(tecla) == -1 && !tecla_especial) {
            return false;
        }
}
function Numeros(string) {
    var out = '';
    var filtro = '1234567890';
    for (var i = 0; i < string.length; i++)
        if (filtro.indexOf(string.charAt(i)) != -1)
            out += string.charAt(i);
    return out;
}

//function validarEmail(valor) {
//    if (/^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3,4})+$/.test(valor)) {
//        alert("La dirección de email " + valor + " es correcta.");
//    } else {
//        alert("Correo no es valido");
//    }
//}
function vEmail(email) {//email
    var out = '';
    //Se añaden las letras validas
    var filtro = '1234567890abcdefghijklmnÃ±opqrstuvwxyzABCDEFGHIJKLMNÃ‘OPQRSTUVWXYZ.-_@';//Caracteres validos

    for (var i = 0; i < email.length; i++)
        if (filtro.indexOf(email.charAt(i)) != -1)
            out += email.charAt(i);
    return out;
}
function validarCP() {
    
    document.getElementById("idcodigo").className = "";
    var valor = document.getElementById("idcodigo").value;
    var patron = /^\d{5}$/;
    if (patron.test(document.getElementById("idcodigo").value) && (!isNaN(valor))) {
        document.getElementById("idcodigo").className = "correcto";
        return true;
    } else {
        
        alert("El código debe tener al menos 5 digitos.\n");
        document.getElementById("idcodigo").focus();
        document.getElementById("idcodigo").className = "error";
        return false;
    }

}
const emailRegex = /^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
const rfcRegex = /^([A-ZÑ\x26]{3,4}([0-9]{2})(0[1-9]|1[0-2])(0[1-9]|1[0-9]|2[0-9]|3[0-1]))([A-Z\d]{3})?$/;


const mensagecorreo = document.querySelector("#txtCorreo");
const mensagecorreoo = document.querySelector("#txtMensageJS"); 
const txtClaveUnica = document.querySelector('#txtClaveUnica');
//txtClaveUnica.addEventListener("keyup", function () {
if (txtClaveUnica.value.length !== 3) {
    erroresArray.push({
        field: 'Clave Única',
        message: 'La clave única debe tener una longitud de 3 caracteres.'
    });
    return false;
}

mensagecorreo.addEventListener("keyup", function () {
    if (!emailRegex.test(this.value.toLowerCase())) {
        mensagecorreoo.innerText = "Correo no es valido";
        //return false;
    } else {
        mensagecorreoo.innerText = "";
    }

});

//const mensagerfc = document.querySelector("#txtRfc");
//const mensagerfccc = document.querySelector("#txtMensageJS");
//mensagerfc.addEventListener("keyup", function () {
//    if (!rfcRegex.test(this.value.toLowerCase())) {
//        mensagerfccc.innerText = "Rfc no es valido";
//        //return false;
//    } else {
//        mensagerfccc.innerText = "";
//    }

//});
//const mensageCodigoPostal = document.querySelector("#txtCodigoPostal");
//const mensageCodigoPostalllll = document.querySelector("#txtMensageJS");
//mensageCodigoPostal.addEventListener("keyup", function () {
//    if (!validCP.test(this.value.toLowerCase())) {
//        mensageCodigoPostalllll.innerText = "Codigo Postal no es valido";
//        //return false;
//    } else {
//        mensageCodigoPostalllll.innerText = "";
//    }
//});