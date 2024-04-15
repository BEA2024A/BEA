<template>
  <plantilla>
    <div class="fondo">
      <div class="formulario">
        <div class="leonel">
          <img src="https://www.anahuac.mx/sites/default/files/gbb-uploads/img_leonel-i5aru2.png" alt="Leonel Médico"/>
          <form @submit.prevent="enviarFormulario">
            <!-- Entrada para '¿Cuál es tu carrera?' -->
            <div v-if="preguntaActual === 0" class="campo-entrada">
              <select v-model="respuestas.carrera" required class="animacion-entrada entrada-carrera">
                <option disabled value="">Selecciona tu carrera</option>
                <option v-for="carrera in carreras" :key="carrera" :value="carrera">{{ carrera }}</option>
              </select>
            </div>
           
            <div v-if="preguntaActual === 1" class="campo-entrada">
              <select v-model="respuestas.semestre" required class="entrada-semestre">
                <option disabled value="">Elige un semestre</option>
                <option v-for="num in 12" :key="num" :value="num">{{ num }}</option>
              </select>
            </div>
            <!-- Entrada para '¿Por qué decidiste comunicarte con acompañamiento?' -->
            <div v-if="preguntaActual === 2" class="campo-entrada">
              <textarea v-model="respuestas.motivo" maxlength="500" required class="entrada-motivo" rows="5" placeholder="escribe tu respuesta aqui"></textarea>
            </div>
            <!-- Entrada para '¿Qué esperas de nosotros?' -->
            <div v-if="preguntaActual === 3" class="campo-entrada">
              <textarea v-model="respuestas.expectativa" maxlength="500" required class="entrada-expectativa" rows="5" placeholder="escribe tu respuesta aqui"></textarea>
            </div>
            
            <div class="burbuja">
              <!-- Contenido de burbuja para pregunta y botón -->
              <div v-if="preguntaActual === 0">
                <p class="pregunta-texto">{{ preguntas[preguntaActual] }}</p>
                <button @click="siguientePregunta" class="boton-siguiente" :disabled="!respuestas.carrera">Siguiente</button>
              </div>
              <div v-if="preguntaActual === 1">
                <p class="pregunta-texto">{{ preguntas[preguntaActual] }}</p>
                <button @click="siguientePregunta" class="boton-siguiente" :disabled="!respuestas.semestre">Siguiente</button>
              </div>
              <div v-if="preguntaActual === 2">
                <p class="pregunta-texto">{{ preguntas[preguntaActual] }}</p>
                <button @click="siguientePregunta" class="boton-siguiente" :disabled="!respuestas.motivo">Siguiente</button>
              </div>
              <div v-if="preguntaActual === 3">
                <p class="pregunta-texto">{{ preguntas[preguntaActual] }}</p>
                <button type="submit" class="boton-enviar" :disabled="!respuestas.expectativa">Enviar</button>
              </div>
            </div>
          </form>
        </div>
      </div>
    </div>
  </plantilla>
</template>


<script>
import axios from 'axios';
import { mapGetters } from 'vuex';
import plantilla from './plantilla.vue';

export default {
  components:{
    plantilla,
  },
  data() {
 
    return {
      preguntas: [
        "¿Cuál es tu carrera?",
        "¿Qué semestre estás cursando?",
        "¿Por qué decidiste comunicarte con acompañamiento?",
        "¿Qué esperas de nosotros?"
      ],
      respuestas: {
        carrera: '',
        semestre: null,
        motivo: '',
        expectativa: ''
      },
      preguntaActual: 0,
      carreras: [
      'licenciatura en derecho',
      'licenciatura en psicologia',
      'licenciatura en ingenieria civil',
      'licenciatura en ingenieria para la direccion',
      'licenciatura en finanzas y contaduria publica',
      'licenciatura en administracion y direccion de empresas',
      'licenciatura en mercadotectnia estrategica',
      'licenciatura en negocios internacionales',
      'licenciatura en comunicacion',
      'licenciatura en diseño multimedia',
      'licenciatura en diseño industrial',
      'licenciatura en ingenieria biomedica',
      'licenciatura en ingenieria mecatronica',
      'licenciatura en diseño grafico',
      'licenciatura en diseño de moda e innovacion',
      'ingenieria en tecnologias de la informacion y negocios digitales',
      ],
    };
  },
  computed: {
    ...mapGetters(['usuario']),
  },
  methods: {
    siguientePregunta() {
      if (this.preguntaActual < this.preguntas.length - 1) {
        this.preguntaActual++;
      } else {
        this.enviarFormulario();
      }
    },
    enviarFormulario() {
      const formData = new FormData();
      formData.append('ID_ALUMNO', this.usuario.id); // Asegúrate de que `usuario.id` exista y tenga el valor correcto.
      formData.append('CARRERA', this.respuestas.carrera);
      formData.append('SEMESTRE', this.respuestas.semestre);
      formData.append('MOTIVO', this.respuestas.motivo);
      formData.append('EXPECTATIVA', this.respuestas.expectativa);

      axios.post('http://localhost/BEA/back/citas.php', formData)
        .then(response => {
          this.$router.push('/agradecimiento');
        })
        .catch(error => {
          console.error('Error al enviar los datos:', error);
          alert('Ocurrió un error al enviar los datos.');
        });
    }
  },
};
</script>


<style scoped>


.animacion-entrada {
    margin-bottom: 20px;
  }

.fondo {
  background-color: #ff5900; 
  height: 100vh;
  display: flex;
  align-items: center;
  justify-content: center;
  overflow: hidden;
  position: relative;
 
}

.leonel {
  margin-right: 800px;
  margin-bottom: 400px;
}

.pregunta-animada {
  animation: fadeIn 1s ease forwards;
}

.finalizado-animado {
  animation: fadeIn 1s ease forwards;
}

.pregunta-texto {
  font-size: 30px;
}



.boton-siguiente,
.boton-enviar {
  background-color: #423a38; 
  color: #fff;
  width: 10%;
  border: none;
  font-size: 18px;
  cursor: pointer;
  border-radius: 8px;
  transition: background-color 0.3s ease;
}

.boton-siguiente:hover,
.boton-enviar:hover {
  background-color: #625750;
}

.leonel img {
  width: 40%;
  transform: translateX(100%);
  z-index: 2;
  position: absolute;
  bottom: 0;
  margin-bottom: 70px;
}

.entrada-carrera {
  width: 100%;
  height: 100px;
  font-size: 20px;
  animation: fadeIn 1s ease forwards;
  box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
  border: 1px solid #ccc; 
  resize: none; 
}

.entrada-semestre {
  width: 310%;
  height: 100px;
  box-shadow: 0 0 20px rgba(0, 0, 0, 0.5); 
  font-size: 20px;
  border: 2px solid #625750;
  animation: fadeIn 1s ease forwards;
  transform: translateX(-35%);
}



.entrada-motivo, .entrada-expectativa {
  height: 300px;
  width: 200%; 
  font-size: 20px;
  padding: 10px; 
  box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
  border: 1px solid #ccc; 
  resize: none;
  transform: translateX(-30%);
}

.entrada-motivo::placeholder, .entrada-expectativa::placeholder {
  text-align: left; 
}

.burbuja {
  position: absolute;
  width: 100vw;
  bottom: -10px;
  left: 0;
  padding: 100px;
  background-color: #0000006b;
  color: aliceblue;
  font-size: 30px;
  z-index: 1;
  text-align: left;
  margin-bottom: 70px;
}



@keyframes fadeIn {
  to {
    opacity: 1;
  }
}

</style>