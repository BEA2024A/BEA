<template>
  <plantilla>



    <div v-if="!usuario" class="overlay"></div>
    <div v-if="!usuario" class="modal-sesion">
      <h3>Necesitas iniciar sesión para ver tu calendario</h3>
      <button @click="$router.push('/inicioSesion')">Iniciar sesión</button>
      <button @click="$router.push('/')">regresar al inicio</button>
    </div>



    <div class="container">
      <div class="events-container">
        <div class="eventos">
          <h2>Citas próximas</h2>
          <ul class="events-list">
            <li v-for="event in calendarOptions.events" :key="event.title">
              {{ event.title }} - {{ event.date }} - {{ event.time }} hrs
            </li>
          </ul>
        </div>
        <div class="botones">
          <button @click="activarNotificaciones" class="notifications-button">
            Activar notificaciones del sistema
          </button>
          <button @click="enviarCorreoRecordatorio" class="mail-notifications-button">
            Activar notificaciones por correo
          </button>
        </div>
      </div>
      <div class="calendar-container">
        <FullCalendar :options="calendarOptions" />
      </div>
    </div>
  </plantilla>
</template>

<script>
import axios from 'axios';
import Plantilla from './plantilla.vue';
import FullCalendar from '@fullcalendar/vue3';
import dayGridPlugin from '@fullcalendar/daygrid';
import { mapGetters } from 'vuex';
import esLocale from '@fullcalendar/core/locales/es';
import Swal from 'sweetalert2';

export default {
  components: {
    FullCalendar,
    Plantilla,
  },
  data() {
    return {
      calendarOptions: {
        plugins: [dayGridPlugin],
        initialView: 'dayGridMonth',
        headerToolbar: {
          left: 'prev,next',
          center: 'title',
          right: 'dayGridMonth,dayGridWeek,dayGridDay'
        },
        events: [],
        locale: esLocale,
      }
    };
  },

  computed: {
    ...mapGetters(['usuario'])
  },

  mounted() {
    if (!this.usuario) {
      this.mostrarMensajeSesion();
    } else {
      this.obtenerEventosUsuario();
    }
  },

  methods: {
    obtenerEventosUsuario() {
      const idUsuario = this.usuario.id;
      axios.get(`http://localhost/BEA/back/obtenerEventos.php?idUsuario=${idUsuario}`)
        .then(response => {
          this.calendarOptions.events = response.data;
        })
        .catch(error => console.error("Hubo un error al obtener los eventos:", error));
    },

    activarNotificaciones() {
      if (!("Notification" in window)) {
        Swal.fire(
          'Error',
          'Este navegador no soporta notificaciones del sistema',
          'error'
        );
      } else if (Notification.permission === "granted") {
        this.verificarEventosHoy();
      } else if (Notification.permission !== "denied") {
        Notification.requestPermission().then(permission => {
          if (permission === "granted") {
            this.verificarEventosHoy();
          }
        });
      }
    },
    verificarEventosHoy() {
      const fechaActual = new Date();
      const dia = fechaActual.getDate();
      const mes = fechaActual.getMonth() + 1; // Los meses van de 0 a 11, por lo que sumamos 1
      const año = fechaActual.getFullYear();
      const sysdate = `${año}-${mes < 10 ? '0' + mes : mes}-${dia < 10 ? '0' + dia : dia}`;

      this.calendarOptions.events.forEach(evento => {
        const eventoDate = new Date(evento.date);
        const unDiaAntes = new Date(eventoDate);
        unDiaAntes.setDate(eventoDate.getDate() - 1);

        // Notificación un día antes del evento
        if (unDiaAntes.toISOString().slice(0, 10) === sysdate) {
          this.enviarNotificacion("Recordatorio: Mañana tienes un evento", evento.title);
        }

        // Notificación el día del evento
        if (evento.date === sysdate) {
          this.enviarNotificacion("Evento Hoy", `Recordatorio: ${evento.title}`);
        }

        // Notificación 15 minutos antes del evento
        const quinceMinutosAntes = new Date(eventoDate);
        quinceMinutosAntes.setMinutes(eventoDate.getMinutes() - 15);
        const ahora = new Date();
        if (quinceMinutosAntes < ahora && eventoDate > ahora) {
          this.enviarNotificacion("Evento en 15 minutos", `Recordatorio: ${evento.title}`);
        }
      });
    },
    enviarNotificacion(titulo, cuerpo) {
      Swal.fire(
        titulo,
        cuerpo,
        'info'
      );
    },

    enviarCorreoRecordatorio() {
      const fechaActual = new Date();
      const dia = fechaActual.getDate();
      const mes = fechaActual.getMonth() + 1; // Los meses van de 0 a 11, por lo que sumamos 1
      const año = fechaActual.getFullYear();
      const hoy = `${año}-${mes < 10 ? '0' + mes : mes}-${dia < 10 ? '0' + dia : dia}`;
      this.calendarOptions.events.forEach(evento => {
        const eventoDate = new Date(evento.date);
        const unDiaAntes = new Date(eventoDate);
        unDiaAntes.setDate(eventoDate.getDate() - 1);

        // Correo un día antes del evento
        if (unDiaAntes.toISOString().slice(0, 10) === hoy) {
          this.enviarCorreo("Recordatorio: tienes un evento proximo", `!Hola ${this.usuario.nombre}! Tienes un evento programado: ${evento.title} el ${evento.date} a las ${evento.time} hrs`);
        }

        // Correo el día del evento
        if (evento.date === hoy) {
          this.enviarCorreo("Evento Hoy", `!Hola ${this.usuario.nombre}! Tienes un evento programado para hoy: ${evento.title} a las ${evento.time} hrs`);
        }

        // Correo 15 minutos antes del evento
        const quinceMinutosAntes = new Date(eventoDate);
        quinceMinutosAntes.setMinutes(eventoDate.getMinutes() - 15);
        const ahora = new Date();
        if (quinceMinutosAntes < ahora && eventoDate > ahora) {
          this.enviarCorreo("Evento en 15 minutos", `!Hola ${this.usuario.nombre}! Tu evento "${evento.title}" comienza en 15 minutos`);
        }
      });
    },

    enviarCorreo(asunto, mensaje) {
      axios.post('http://localhost/BEA/back/enviarCorreo.php', {
        correoDestinatario: this.usuario.correo,
        asunto: asunto,
        mensaje: mensaje
      })
        .then(response => {
          console.log(response.data);
          Swal.fire(
            'Éxito',
            'Correo enviado',
            'success'
          );
        })
        .catch(error => {
          console.error(error);
          Swal.fire(
            'Error',
            'Hubo un error al enviar el correo',
            'error'
          );
        });
    },

    mostrarMensajeSesion() {
      Swal.fire(
        'Sesión no iniciada',
        'Por favor inicia sesión para ver tus eventos',
        'warning'
      );
    },
  }
};
</script>


<style scoped>
@keyframes slideIn {
  from {
    opacity: 0;
    transform: translateY(-50px);
  }

  to {
    opacity: 1;
    transform: translateY(0);
  }
}

@keyframes fadeIn {
  from {
    opacity: 0;
  }

  to {
    opacity: 1;
  }
}

.overlay {
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background-color: rgba(0, 0, 0, 0.712);
  z-index: 1;
}

.modal-sesion {
  position: fixed;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  background-color: white;
  padding: 50px;
  border-radius: 10px;
  box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
  text-align: center;
  z-index: 2;
  animation: fedeIn 0.5s ease forwards;
}

.modal-sesion button {
  margin-top: 20px;
  padding: 10px;
}


.calendar-container {
  max-width: 700px;
  border: 1px solid #ddd;
  border-radius: 8px;
  background-color: rgb(255, 255, 255);
  box-shadow: 0 5px 5px rgba(0, 0, 0, 0.541);
  flex: 2;
  margin-right: 50px;
  margin-top: 50px;
  margin-bottom: 50px;
  padding: 30px;
  transition: 0.3s ease;
  animation: slideIn 0.5s ease forwards;
}

.container {
  display: flex;
  justify-content: space-between;
  background-image: linear-gradient(to bottom, #ff5900, #c21c02);
}

.events-container {
  flex: 2;
  margin-right: 20px;
  margin-left: 20px;
}

.eventos {
  margin-top: 50px;
  padding-top: 10px;
  padding-bottom: 25px;
  padding-left: 20px;
  padding-right: 20px;
  border-radius: 10px;
  background-color: #ffffff;
  box-shadow: 0 5px 5px rgba(0, 0, 0, 0.541);
  transition: 0.3s ease;
  animation: slideIn 0.5s ease forwards;
}


.eventos:hover {
  transform: scale(1.02);
}

.botones:hover {
  transform: scale(1.02);
}

.calendar-container:hover {
  transform: scale(1.02);
}

.botones {
  margin-top: 50px;
  padding-top: 10px;
  padding-bottom: 25px;
  padding-left: 20px;
  padding-right: 20px;
  border-radius: 10px;
  background-color: #ffffff;
  box-shadow: 0 5px 5px rgba(0, 0, 0, 0.541);
  transition: 0.3s ease;
  animation: slideIn 0.5s ease forwards;
}

.events-list {
  list-style-type: none;
  text-align: center;
}

.events-list li {
  margin-bottom: 10px;
}

.notifications-button {
  margin-top: 20px;
  padding: 10px 20px;
  background-color: #423a38;
  color: white;
  border: none;
  border-radius: 4px;
  cursor: pointer;
  transition: 0.3s ease;
}

.mail-notifications-button {
  margin-top: 20px;
  padding: 10px 20px;
  background-color: #423a38;
  color: white;
  border: none;
  border-radius: 4px;
  cursor: pointer;
  transition: 0.3s ease;
}


@media only screen and (min-width: 768px) and (max-width: 991px) {


  .container {
    flex-direction: column;
    padding: 10px;
    padding-right: 20px;
  }

  .calendar-container {
    padding: 100px;
    border-radius: 8px;
    margin: 100px;
    margin-bottom: 10px;
    margin-top: 50px;
    padding-bottom: 100px;
  }
 
  .events-container {
    margin: 30px;
  }

  .events-list {
    list-style-type: none;
    text-align: center;
    transform: translateX(0%);
  }

  .eventos {
    margin-top: 0;
    padding-top: 10px;
    padding-bottom: 25px;
    padding-left: 20px;
    padding-right: 20px;
  }

  .botones {
    margin-top: 20px;
    padding-top: 10px;
    padding-bottom: 25px;
    padding-left: 20px;
    padding-right: 20px;
  }



  /* Orden de visualización */
  .calendar-container {
    order: 1;
  }

  .events-container {
    order: 2;
  }

  .botones {
    order: 3;
  }


}

@media only screen and (max-width: 767px) {


.container {
  flex-direction: column;
  padding: 10px;
  padding-right: 20px;
}

.calendar-container {
  padding: 40px;
  border-radius: 8px;
  margin: 5px;
  padding-bottom: 100px;
}

.events-container {
  margin: 30px;
}

.events-list {
  list-style-type: none;
  text-align: center;
  transform: translateX(0%);
}

.eventos {
  margin-top: 0;
  padding-top: 10px;
  padding-bottom: 25px;
  padding-left: 20px;
  padding-right: 20px;
}

.botones {
  margin-top: 20px;
  padding-top: 10px;
  padding-bottom: 25px;
  padding-left: 20px;
  padding-right: 20px;
}



/* Orden de visualización */
.calendar-container {
  order: 1;
}

.events-container {
  order: 2;
}

.botones {
  order: 3;
}


}

</style>