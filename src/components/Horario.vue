<template>
  <plantilla>
    <div class="container">
      <div class="events-container">
        <h2>Citas próximas</h2>
        <ul class="events-list">
          <li v-for="event in calendarOptions.events" :key="event.title">
            {{ event.title }} - {{ event.date }}
          </li>
        </ul>
        <button @click="activarNotificaciones" class="notifications-button">
          Activar notificaciones
        </button>
      </div>
      <div class="calendar-container">
        <FullCalendar :options="calendarOptions" />
      </div>
    </div>
  </plantilla>
</template>

<script>
import Plantilla from './plantilla.vue'; // Asegúrate de que la importación coincida con el nombre de tu archivo y componente
import FullCalendar from '@fullcalendar/vue3';
import dayGridPlugin from '@fullcalendar/daygrid';

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
          left: 'prev,next today',
          center: 'title',
          right: 'dayGridMonth,dayGridWeek,dayGridDay'
        },
        events: [
          { title: 'Evento 1', date: '2024-04-01' },
          { title: 'Evento 2', date: '2024-04-02' },
          {title: 'noti de prueba', date: '2024-03-31'}
          
          // más eventos...
        ],
      }
    };
  },
  mounted() {
    this.verificarEventosHoy();
  },
  methods: {
    activarNotificaciones() {
      if (!("Notification" in window)) {
        alert("Este navegador no soporta notificaciones del sistema");
      } else if (Notification.permission === "granted") {
        this.verificarEventosHoy(); // Si ya están los permisos, revisamos eventos hoy
      } else if (Notification.permission !== "denied") {
        Notification.requestPermission().then(permission => {
          if (permission === "granted") {
            this.verificarEventosHoy(); // Si el usuario acepta, revisamos eventos hoy
          }
        });
      }
    },
    verificarEventosHoy() {
      const hoy = new Date().toISOString().slice(0, 10); // Obtiene la fecha de hoy
      this.calendarOptions.events.forEach(evento => {
        if (evento.date === hoy) {
          this.enviarNotificacion(evento);
        }
      });
    },
    enviarNotificacion(evento) {
      new Notification("Evento Hoy", {
        body: `Recordatorio: ${evento.title}`,
        icon: "ruta/a/un/icono.png" // Asegúrate de reemplazar esto con la ruta a tu icono
      });
    }
  }
};
</script>


<style scoped>
.calendar-container {
  max-width: 900px;
  margin: auto;
  padding: 10px;
  border: 1px solid #ddd;
  border-radius: 8px;
  background-color: white;
  box-shadow: 0 2px 5px rgba(0,0,0,0.1);
}
.container {
  display: flex;
  justify-content: space-between;
}

.events-container {
  flex: 1;
  margin-right: 20px;
}

.events-list {
  list-style-type: none;
  padding: 0;
}

.events-list li {
  margin-bottom: 10px;
}

.notifications-button {
  margin-top: 20px;
  padding: 10px 20px;
  background-color: #007bff;
  color: white;
  border: none;
  border-radius: 4px;
  cursor: pointer;
}

.calendar-container {
  flex: 2;
  /* Resto de estilos */
}
</style>
