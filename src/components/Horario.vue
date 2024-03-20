<template>
  <plantilla>
    <div class="contenido-pagina">
      <router-view></router-view>
      <!-- Calendario -->
      <FullCalendar :options="calendarOptions" :events="calendarEvents" @dateClick="handleDateClick" />
    </div>
  </plantilla>
</template>

<script>
import FullCalendar from '@fullcalendar/vue3'
import dayGridPlugin from '@fullcalendar/daygrid'
import plantilla from './plantilla.vue'

export default {
  components: {
    FullCalendar,
    plantilla,
  },
  data() {
    return {
      calendarOptions: {
        plugins: [dayGridPlugin],
        initialView: 'dayGridMonth',
        weekends: false,
      },
      events: [
        { title: 'Meeting', start: new Date() }
      ],
    }
  },
  methods: {
    handleDateClick(info) {
      console.log('Fecha clickeada:', info.dateStr);
      let eventTitle = prompt('Ingrese el título del evento para ' + info.dateStr);
      if (eventTitle) {
        this.events.push({
          title: eventTitle,
          start: info.date,
          allDay: true
        })
      }
    }
  },
  computed: {
    calendarEvents() {
      return this.events;
    }
  }
}
</script>

<style scoped>
.contenido-pagina {
  padding: 30px;
}
</style>