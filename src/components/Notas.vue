<template>
  <plantillaPsico>
    <div class="plantilla-psico">
      <div class="contenido">
        <div class="contenido-derecha">
          <div class="perfil">
            <img src="https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png" alt="Foto de perfil" class="imagen-perfil">
            <h1>{{ perfil.NOMBRE }} {{ perfil.APELLIDO_PATERNO }} {{ perfil.APELLIDO_MATERNO }}</h1>
            <p>ID: 00{{ perfil.ID_ALUMNO }} </p>
            <p>Carrera: {{ perfil.CARRERA}}</p>
            <p>motivos de la cita: {{ perfil.MOTIVO }}</p>
            <p>Expectativas para la terapia: {{ perfil.EXPECTATIVA }}</p>
          </div>
        </div>
        <div class="contenido-izquierda">
          <button v-if="!mostrarHacer && !mostrarLeer" @click="showContent('hacer')" class="boton-notas">Hacer Notas</button>
          <button v-if="!mostrarHacer && !mostrarLeer" @click="showContent('leer')" class="boton-notas">Leer Notas</button>
          <!-- Contenido de hacer notas -->
          <div v-if="mostrarHacer">
      <div class="notas">
        <label for="numero-sesion">Número de sesión:</label>
        <input type="text" id="numero-sesion" v-model="numeroSesion">
      </div>
      <div class="notas">
        <label for="fecha">Fecha:</label>
        <input type="date" id="fecha" v-model="fecha">
      </div>
      <div class="notas">
        <label for="notas">Notas:</label>
        <textarea id="notas" v-model="notas"></textarea>
      </div>
      <button @click="enviarNotas" class="boton">Enviar</button>
      <button @click="recargarPagina" class="boton">Regresar</button>
    </div>
          <!-- Contenido de leer notas -->
          <div v-else-if="mostrarLeer">
            <div class="notas">
              <label for="numero-sesion">Número de sesión:</label>
              <input type="text" id="numero-sesion" v-model="numeroSesion">
            </div>
            
            <div class="notas">
              <label for="fecha">Fecha:</label>
              <input type="date" id="fecha" v-model="fecha">
            </div>
  
            <button @click="solicitarNotas" class="boton">Solicitar</button>
            
            <div class="notas">
              <label for="notas">Notas:</label>
              <textarea id="notas" v-model="notas" readonly></textarea>
            </div>
            <button @click="recargarPagina" class="boton">Regresar</button>
          </div>
        </div>
      </div>
    </div>
  </plantillaPsico>
</template>

<script>
import plantillaPsico from './plantillaPsico.vue';
import axios from 'axios';
import { mapGetters } from 'vuex';

export default {
  components: {
    plantillaPsico,
  },
  data() {
    return {
      
      perfil: {
        NOMBRE: "",
  APELLIDO_PATERNO: "",
    APELLIDO_MATERNO: "",
    CARRERA: "",
    ID_ALUMNO: null,
    MOTIVO: "",
  EXPECTATIVA: ""
      },
      mostrarHacer: false,
      mostrarLeer: false,
      numeroSesion: '',
      fecha: new Date().toISOString().slice(0, 10),
      notas: '',
      notasExistentes: [
        { numeroSesion: '1', fecha: '2024-04-01', contenido: 'Hoy discutimos sobre las técnicas de respiración para reducir la ansiedad.' },
        { numeroSesion: '2', fecha: '2024-04-14', contenido: 'En la sesión de hoy, exploramos los desencadenantes de la ansiedad social.' },
        { numeroSesion: '3', fecha: '2024-04-29', contenido: 'Hablamos sobre estrategias para establecer límites saludables en las relaciones.' },
        { numeroSesion: '4', fecha: '2024-05-12', contenido: 'En la sesión de hoy, discutimos la importancia de la autocompasión en el proceso de recuperación.' },
      ]
    };
  },

  mounted() {
    this.cargarDatosAlumno();
    this.cargarNotas();

  },

  computed: {
    ...mapGetters(['usuario'])
  },

  methods: {

    cargarDatosAlumno() {
      const idAlumno = this.$route.params.id; 
      axios.get(`http://localhost/bea/back/notas-perfil.php?idAlumno=${idAlumno}`)
        .then(response => {
          this.perfil = response.data;
        })
        .catch(error => {
          console.error('Error al cargar los datos del alumno:', error);
        });
    },

    cargarNotas() {
  const idAlumno = this.$route.params.id; 
  axios.get(`http://localhost/bea/back/cargarNotas.php?idAlumno=${idAlumno}`)
    .then(response => {
      
      if (response.data && response.data.length > 0) {
        
        this.notasExistentes = response.data.map(nota => ({
          numeroSesion: nota.numeroSesion.toString(),
          fecha: nota.fecha,
          contenido: nota.contenido
        }));
      } else {
        console.error('La respuesta del servidor está vacía.');
      }
    })
    .catch(error => {
      console.error('Error al cargar las notas del alumno:', error);
    });
},

    
    showContent(option) {
      if (option === 'hacer') {
        this.mostrarHacer = true;
        this.mostrarLeer = false;
      } else if (option === 'leer') {
        this.mostrarHacer = false;
        this.mostrarLeer = true;
      }
    },
    enviarNotas() {
  const hoy = new Date().toISOString().slice(0, 10); // Obtiene la fecha de hoy

  if (this.fecha != hoy) {
    alert('Error de fecha.');
    return; 
  }


  const formData = new FormData();
  formData.append('numero_sesion', this.numeroSesion);
  formData.append('fecha', this.fecha);
  formData.append('contenido', this.notas);
  formData.append('id_administrador', this.$store.state.usuario.id); 
  formData.append('id_alumno', this.$route.params.id); 


  axios.post('http://localhost/bea/back/guardar-nota.php', formData)
    .then(response => {
      
      alert('nota enviada');
    
    })
    .catch(error => {
      
      console.error('Error en la petición:', error);
      alert('Ocurrió un error al guardar la nota.');
    });


  this.numeroSesion = '';
  this.fecha = '';
  this.notas = '';
},

    solicitarNotas() {
  const notaEncontrada = this.notasExistentes.find(nota => {
    return (nota.numeroSesion === this.numeroSesion && nota.fecha === this.fecha) ||
           (nota.numeroSesion === this.numeroSesion && nota.fecha !== this.fecha);
  });

  if (notaEncontrada && notaEncontrada.fecha === this.fecha) {
    this.notas = notaEncontrada.contenido;
  } else {
    this.notas = 'No se encontraron notas para la sesión y fecha especificadas.';
  }
},
    recargarPagina() {
      window.location.reload();
    },
  },
};
</script>

  
  <style scoped>
  .plantilla-psico {
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
    text-align: justify;
  }
  
  .perfil p {
    margin-bottom: 10px;
    font-size: 1.2rem;
    color: #666;
    text-align: justify; 
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
    text-align: center;
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

  .boton-notas {
  background-color: #d45c37;
  border: none;
  color: white;
  padding: 15px 32px;
  text-align: center;
  text-decoration: none;
  display: inline-block;
  font-size: 16px;
  margin: 4px 2px;
  cursor: pointer;
  border-radius: 37px;
}

.boton-notas:hover {
  background-color: #ffae00;
}

.boton {
  top: 10px;
  bottom: 20px;
  background-color: #d45c37;
  border: none;
  color: white;
  padding: 15px 32px;
  text-align: center;
  text-decoration: none;
  display: inline-block;
  font-size: 16px;
  margin: 4px 2px;
  cursor: pointer;
  border-radius: 37px;
  margin-top: 15px;
  margin-bottom: 15px;
}

.boton:hover {
  background-color: #ffae00;
}

/* Estilo base */
.notas {
  background-color: #d45c37;
  border-radius: 12px;
  color: white;
  padding: 20px;
  margin-top: 15px;
  margin-bottom: 15px;
}

/* Espaciado para los elementos internos */
.notas > * {
  margin-bottom: 10px;
}

/* Estilo para los inputs y textarea */
.notas input[type="text"],
.notas input[type="date"],
.notas textarea {
  width: calc(100% - 24px); /* Ten en cuenta el padding y el borde */
  padding: 12px;
  border: 1px solid #ccc;
  border-radius: 8px;
  box-sizing: border-box;
  font-size: 18px;
}

/* Estilo específico para textarea */
.notas textarea {
  height: 200px;
}

.notas > :last-child {
  margin-bottom: 0;
}

</style>