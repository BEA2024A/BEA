<template>
  <plantilla>
  <div class="fondo">
    <div class="formulario">
      <div v-if="preguntaActual < preguntas.length">
        <!-- Textarea y botón Siguiente fuera y arriba de la burbuja -->
        <textarea v-model="respuestas[preguntaActual]" rows="4" class="textarea-animada" placeholder="ESCRIBE TU RESPUESTA AQUI"></textarea>
      
      </div>

      <div class="leonel">
        <img src="https://www.anahuac.mx/sites/default/files/gbb-uploads/img_leonel-i5aru2.png" alt="Leonel Médico"/>
        <div class="burbuja">
          <!-- Solo la pregunta dentro de la burbuja -->
          <div v-if="preguntaActual < preguntas.length" class="pregunta-animada" :key="preguntaActual">
            <p class="pregunta-texto">{{ preguntas[preguntaActual] }}</p>
            <button @click="siguientePregunta" class="boton-siguiente">Siguiente</button>
          </div>
          <div v-else class="finalizado-animado">
        <p>EN UNOS MINUTOS TE LLEGARA UN CORREO CON LOS DATOS DE TU CITA</p>
        <p>PUEDES ADMINISTRAR TUS CITAS EN TU CALENDARIO</p>
        <button @click="enviarFormulario" class="boton-enviar">ir a tu calendario</button>
      </div> 
        </div>
      </div>
    </div>
  </div>
</plantilla>
</template>

<script>import Plantilla from './plantilla.vue';
export default {
  components: {
    Plantilla,
  },
  data() {
    return {
      preguntas: [
        "¿CUAL ES TU CARRERA?",
        "¿QUE SEMESTRE ESTAS CURSANDO?",
        "¿PORQUE DECIDISTE COMUNICARTE CON ACOMPAÑAMIENTO?",
        "¿QUE ESPERAS DE NOSOTROS?"
      ],
      respuestas: Array.from({ length: 3 }, () => ""),
      preguntaActual: 0,
    };
  },
  methods: {
    siguientePregunta() {
      this.preguntaActual++;
    },
    enviarFormulario() {
      console.log("Respuestas:", this.respuestas);
      // Implementar lógica de envío aquí
       this.$router.push('/horario');
    },
  },
};
</script>

<style scoped>
.fondo {
  background-color: #ff5900; /* Mismo color de fondo que primeracita.vue */
  height: 100vh;
  display: flex;
  align-items: center;
  justify-content: center;
  overflow: hidden;
  position: relative;
}

.formulario {
  color: aliceblue; /* Mismo color de texto que primeracita.vue */
  font-size: 18px;
  text-align: center;
  margin-right: 800px;
  margin-bottom: 400px;
}

.pregunta-animada {
  opacity: 0;
  animation: fadeIn 1s ease forwards;
  margin-bottom: 20px;
}

.finalizado-animado {
  opacity: 0;
  animation: fadeIn 1s ease forwards;
  font-size: 24px;
}

.pregunta-texto {
  font-size: 24px;
}

.textarea-animada {
  width: 600px;
  height: 300px;
  padding: 15px;
  font-size: 18px;
  border: 2px solid #423a38;
  border-radius: 8px;
  resize: none;
  margin-bottom: 20px;
  opacity: 0;
  animation: fadeIn 1s ease forwards;
  box-shadow: 0 5px 5px rgba(0, 0, 0, 0.541);
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

/* Media queries para ajustes responsivos */
@media (max-width: 639px) {
  .textarea-animada {
    width: 100%; /* Ajuste para dispositivos móviles */
  }
  .boton-siguiente,
  .boton-enviar {
    width: auto;
    padding: 10px 15px;
  }
}
</style>
