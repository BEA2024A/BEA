<template>
  <plantillaPsico>
    <div class="plantillaPsico">
      <div class="contenido">
        <div class="contenido-derecha">
          <div class="perfil">
            <img :src="perfil.imagen" alt="Foto de perfil" class="imagen-perfil">
            <h1>{{ perfil.nombre }}</h1>
            <p>Edad: {{ perfil.edad }}</p>
            <p>Ocupación: {{ perfil.ocupacion }}</p>
            <p>Problemas principales: {{ perfil.problemas }}</p>
            <p>Historial médico: {{ perfil.historial }}</p>
            <p>Medicación actual: {{ perfil.medicacion }}</p>
            <p>Tratamientos anteriores: {{ perfil.tratamientosAnteriores }}</p>
            <p>Expectativas para la terapia: {{ perfil.expectativas }}</p>
          </div>
        </div>
        <div class="contenido-izquierda">
          <FullCalendar :options="calendarOptions" :events="calendarEvents" @dateClick="handleDateClick" />
        </div>
      </div>
    </div>
  </plantillaPsico>
</template>

<script>
import FullCalendar from '@fullcalendar/vue3'
import dayGridPlugin from '@fullcalendar/daygrid'
import plantillaPsico from './plantillaPsico.vue'

export default {
  components: {
    plantillaPsico,
    FullCalendar,
  },
  data() {
    return {
      perfil: {
        nombre: 'Carlos Gonzales',
        edad: 22,
        ocupacion: 'Estudiante Ingenieria',
        problemas: 'Ansiedad y depresión',
        historial: 'Ha tenido episodios de ansiedad desde la adolescencia. Ha experimentado síntomas de depresión en los últimos dos años.',
        medicacion: 'Actualmente toma medicamentos recetados para la ansiedad.',
        tratamientosAnteriores: 'Ha recibido terapia cognitivo-conductual en el pasado.',
        expectativas: 'Espera encontrar herramientas para manejar mejor su ansiedad y depresión, así como mejorar su calidad de vida en general.',
        imagen: 'https://i.postimg.cc/SRQkK6jX/MTRA-SYLVIA-GUTI-RREZ-CANDIANI.png'
      },
      calendarOptions: {
        plugins: [dayGridPlugin],
        initialView: 'dayGridMonth',
        weekends: false,
        locale: 'es'
      },
      events: [
        { title: 'Meeting', start: new Date() }
      ]
    };
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
};
</script>

<style scoped>
.plantillaPsico {
  display: flex;
}

.perfil {
  font-family: Arial, sans-serif;
  margin-right: 20px;
  width: 100%; 
  padding: 20px;
  border: 1px solid #ddd;
  border-radius: 5px;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
  position: sticky;
  top: 0;
}

.imagen-perfil {
  display: block;
  margin: 0 auto 20px auto;
  width: 100%;
  max-width: 200px;
  border-radius: 50%;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}

.perfil h1 {
  font-size: 2rem;
  margin-top: 0;
  color: #444;
}

.perfil p {
  margin-bottom: 10px;
  font-size: 1.2rem;
  color: #666;
}

.contenido {
  flex: 1;
  display: flex;
}

.contenido-derecha {
  flex: 30%;
  
}

.contenido-izquierda {
  flex: 70%;
  padding-right: 60px;
  padding-left: 100px;
}
</style>
