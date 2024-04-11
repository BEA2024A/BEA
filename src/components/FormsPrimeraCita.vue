<template>
  <plantilla>
    <div class="fondo">
      <form @submit.prevent="enviarFormulario" class="formulario">
        <h2>Agenda tu primera cita</h2>

        <div class="campo-formulario">
          <label for="carrera">¿Cuál es tu carrera?</label>
          <select id="carrera" v-model="respuestas.carrera" required>
            <option disabled value="">Selecciona una carrera</option>
            <option v-for="carrera in carreras" :key="carrera" :value="carrera">{{ carrera }}</option>
          </select>
        </div>

        <div class="campo-formulario">
          <label for="semestre">¿Qué semestre estás cursando?</label>
          <input id="semestre" type="number" v-model.number="respuestas.semestre" min="1" max="12" required>
        </div>

        <div class="campo-formulario">
          <label for="motivo">¿Por qué decidiste comunicarte con acompañamiento?</label>
          <input id="motivo" type="text" v-model="respuestas.motivo" maxlength="140" required>
        </div>

        <div class="campo-formulario">
          <label for="expectativa">¿Qué esperas de nosotros?</label>
          <input id="expectativa" type="text" v-model="respuestas.expectativa" maxlength="140" required>
        </div>

        <button type="submit">Enviar</button>
      </form>
    </div>
  </plantilla>
</template>

<script>
import Plantilla from './plantilla.vue';
import { mapGetters } from 'vuex';
import axios from 'axios';

export default {
  components: {
    Plantilla,
  },
  data() {
    return {
      respuestas: {
        carrera: '',
        semestre: null,
        motivo: '',
        expectativa: '',
      },
      carreras: [
        'Licenciatura en Médico Cirujano',
        // Añade aquí todas las carreras
      ],
    };
  },
  computed: {
    ...mapGetters(['usuario']),
  },
  methods: {
    enviarFormulario() {
      // Preparación de los datos a enviar
      const datosFormulario = {
        ...this.respuestas,
        id_usuario: this.usuario.id,
        nombre: this.usuario.nombre,
        a_paterno: this.usuario.a_paterno,
        a_materno: this.usuario.a_materno,
      };

      // Envío del formulario
      axios.post('http://localhost/BEA/back/agregarCita.php', datosFormulario)
        .then(response => {
          alert('Cita agendada con éxito');
          this.$router.push('/horario'); // Ajusta según sea necesario
        })
        .catch(error => {
          console.error('Error al agendar la cita:', error);
        });
    },
  },
};
</script>

<style scoped>
.fondo {
  display: flex;
  justify-content: center;
  padding: 20px;
}

.formulario {
  width: 100%;
  max-width: 500px;
  background-color: #f2f2f2;
  padding: 20px;
  border-radius: 8px;
}

.campo-formulario {
  margin-bottom: 15px;
}

label {
  display: block;
  margin-bottom: 5px;
}

input[type="number"], input[type="text"], select {
  width: 100%;
  padding: 10px;
  margin-bottom: 10px;
  border-radius: 5px;
  border: 1px solid #ccc;
}

button {
  width: 100%;
  padding: 10px;
  background-color: #007bff;
  color: white;
  border: none;
  border-radius: 5px;
  cursor: pointer;
}

button:hover {
  background-color: #0056b3;
}
</style>
