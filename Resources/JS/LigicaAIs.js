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
        contenedor.style.display = 'none';
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
            personajeActual = null;
        });
        document.getElementById('enviarMensaje').addEventListener('click', enviarMensaje);

        return contenedor;
    }

    function mostrarDialogo(nombrePersonaje) {
        document.getElementById('nombrePersonaje').textContent = nombrePersonaje;
        contenedorDialogo.style.display = 'block';
        document.getElementById('historialMensajes').innerHTML = '';
        document.getElementById('mensajeUsuario').focus();
    }

    async function enviarMensaje() {
        const mensajeUsuario = document.getElementById('mensajeUsuario').value;
        document.getElementById('mensajeUsuario').value = '';

        agregarMensajeAlHistorial('Tú', mensajeUsuario);



        const backendURL = 'https://felixcanosa1.pythonanywhere.com/chatbot'; //  URL completa de tu backend

        try {
            const response = await fetch(backendURL, { // Usar backendURL aquí
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({ personaje: personajeActual, message: mensajeUsuario })
            });

            if (!response.ok) {
                const errorData = await response.json();
                const errorMessage = errorData.error || `Error HTTP: ${response.status}`;
                throw new Error(errorMessage);
            }

            const data = await response.json();
            const respuestaIA = data.response;
            agregarMensajeAlHistorial(personajeActual, respuestaIA);

        } catch (error) {
            console.error('Error:', error);
            agregarMensajeAlHistorial('Error', error.message);
        }
    }

    function agregarMensajeAlHistorial(remitente, mensaje) {
        const historial = document.getElementById('historialMensajes');
        const nuevoMensaje = document.createElement('p');
        nuevoMensaje.textContent = `${remitente}: ${mensaje}`;
        historial.appendChild(nuevoMensaje);
        historial.scrollTop = historial.scrollHeight;
    }
});