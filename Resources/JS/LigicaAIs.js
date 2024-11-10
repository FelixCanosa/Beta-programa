// header_Footer.js (o el archivo JS donde quieras colocar el código)

document.addEventListener('DOMContentLoaded', () => {
    const botonesCharlar = document.querySelectorAll('.btn-primary');
    const contenedorDialogo = crearContenedorDialogo();
    let personajeActual = null;

    botonesCharlar.forEach(boton => {
        boton.addEventListener('click', () => {
            const card = boton.closest('.card');
            personajeActual = card.querySelector('.card-title').textContent;
            mostrarDialogo(personajeActual);
        });
    });

    function crearContenedorDialogo() {
        const contenedor = document.createElement('div');
        contenedor.id = 'contenedorDialogo';
        contenedor.style.display = 'none'; // Inicialmente oculto
        contenedor.innerHTML = `
            <div class="dialogo-header">
                <span id="nombrePersonaje"></span>
                <button id="cerrarDialogo">X</button>
            </div>
            <div id="historialMensajes"></div>
            <input type="text" id="mensajeUsuario">
            <button id="enviarMensaje">Enviar</button>
        `;
        document.body.appendChild(contenedor);

        document.getElementById('cerrarDialogo').addEventListener('click', () => {
            contenedor.style.display = 'none';
            personajeActual = null; // Limpiar personaje al cerrar
        });
        document.getElementById('enviarMensaje').addEventListener('click', enviarMensaje);

        return contenedor;
    }

    function mostrarDialogo(nombrePersonaje) {
        document.getElementById('nombrePersonaje').textContent = nombrePersonaje;
        contenedorDialogo.style.display = 'block';
        document.getElementById('historialMensajes').innerHTML = ''; // Limpiar historial al abrir
        document.getElementById('mensajeUsuario').focus(); // Enfocar el input
    }

    async function enviarMensaje() {
        const mensajeUsuario = document.getElementById('mensajeUsuario').value;
        document.getElementById('mensajeUsuario').value = ''; // Limpiar input

        agregarMensajeAlHistorial('Tú', mensajeUsuario);

        const respuestaIA = await obtenerRespuestaIA(personajeActual, mensajeUsuario);
        agregarMensajeAlHistorial(personajeActual, respuestaIA);
    }



    async function obtenerRespuestaIA(personaje, mensaje) {
        try {
          const response = await fetch('/api/chat', {  // Reemplaza '/api/chat' con la ruta correcta de tu API
            method: 'POST',
            headers: {
              'Content-Type': 'application/json'
            },
            body: JSON.stringify({ personaje: personaje, mensaje: mensaje })
          });

          if (!response.ok) {
            throw new Error(`Error HTTP: ${response.status}`);
          }

          const data = await response.json();
          return data.respuesta;

        } catch (error) {
          console.error('Error al obtener respuesta de la IA:', error);
          return 'Lo siento, ha ocurrido un error. Inténtalo de nuevo.';
        }
      }

    function agregarMensajeAlHistorial(remitente, mensaje) {
        const historial = document.getElementById('historialMensajes');
        const nuevoMensaje = document.createElement('p');
        nuevoMensaje.textContent = `${remitente}: ${mensaje}`;
        historial.appendChild(nuevoMensaje);
        historial.scrollTop = historial.scrollHeight; // Scroll automático al final
    }
});