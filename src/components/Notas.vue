<template>
  <plantillaPsico>
    <div class="container">
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
          <!-- Contenido de hacer notas -->
          <div v-if="mostrarHacer">
            <h2>Crear una nueva nota</h2>    
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
      <button @click="showContent('leer')" class="boton">ir a leer notas</button>
      <button @click="showContent('agendar')" class="boton">agenda una cita</button>
    </div>
          <!-- Contenido de leer notas -->
          
          <div v-if="mostrarAgendar">
            <h2>Agendar Nuevo Evento</h2>
            <div >
              <div class="notas">
                <label for="titulo">Título:</label>
                <input type="text" id="titulo" v-model="nuevoEvento.titulo">
              </div>
              <div class="notas">
                <label for="fecha">Fecha:</label>
                <input type="date" id="fecha" v-model="nuevoEvento.fecha">
              </div>
              <div class="notas">
                <label for="hora">Hora:</label>
                <input type="time" id="hora" v-model="nuevoEvento.hora">
              </div>
              <div class="notas">
                <label for="color" class="color">Color:</label>
                <input type="color" id="color" v-model="nuevoEvento.color">
              </div>
              <button @click="agendarEvento" class="boton">Agendar</button>
            </div>
        </div>
        <div v-else-if="mostrarLeer">
            <h2>Consulta una nota anterior</h2> 
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
            <button @click="showContent('hacer')" class="boton">ir a hacer notas</button>
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
      mostrarHacer: true,
    mostrarLeer: false,
    mostrarAgendar: false,
    numeroSesion: '',
    fecha: new Date().toISOString().slice(0, 10),
    notas: '',
    notasExistentes: [],
    nuevoEvento: {
      titulo: '',
      fecha: '',
      hora: '',
      color: '#000000'
    }
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
      this.numeroSesion= '';
      this.fecha= new Date().toISOString().slice(0, 10);
      this.notas= '';
      } else if (option === 'leer') {
        this.mostrarHacer = false;
        this.mostrarLeer = true;
        this.fecha= null;
        this.numeroSesion= '';
        this.notas= '';
      } else if(option === 'agendar'){

        if(this.mostrarAgendar === true){
          this.mostrarAgendar = !this.mostrarAgendar;
        }else{this.mostrarHacer = true;
        this.mostrarLeer = false;
        this.mostrarAgendar = true;}

        
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

agendarEvento() {
    if (!this.nuevoEvento.titulo || !this.nuevoEvento.fecha || !this.nuevoEvento.hora || !this.nuevoEvento.color) {
      alert('Por favor complete todos los campos.');
      return;
    } else if(this.nuevoEvento.fecha < new Date().toISOString().slice(0, 10)){
      alert('la fecha de evento no puede ser menor a la fecha actual');
      return;
    }


    const formData = new FormData();
    formData.append('id_usuario', this.$route.params.id);
    formData.append('titulo', this.nuevoEvento.titulo);
    formData.append('fecha', this.nuevoEvento.fecha);
    formData.append('hora', this.nuevoEvento.hora);
    formData.append('color', this.nuevoEvento.color);

    // Enviar petición al servidor para guardar el evento
    axios.post('http://localhost/bea/back/guardar-evento.php', formData)
      .then(response => {
        alert('Evento agendado exitosamente.');
        // Limpiar formulario después de guardar el evento
        this.nuevoEvento = {
          titulo: '',
          fecha: '',
          hora: '',
          color: '#000000' // Color por defecto
        };
      })
      .catch(error => {
        console.error('Error al agendar el evento:', error);
        alert('Ocurrió un error al agendar el evento.');
      });
  },
    recargarPagina() {
      this.mostrarHacer = false;
        this.mostrarLeer = false;
    },
  },
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

  .perfil {
    font-family: Arial, sans-serif;
    margin-right: 20px;
    margin-left: 20px;
    margin-top:20px;
    margin-bottom: 20px;
    width: 100%;
    padding: 20px;
    border: 1px solid #ddd;
    border-radius: 10px;
    box-shadow: 0 5px 5px rgba(0, 0, 0, 0.541);
    position: sticky;
    top: 0;
    text-align: justify;
    background-color: #fdfdfd;
    
  }
  
  .perfil p {
    margin-bottom: 30px;
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
    margin-top: 20px;
    margin-bottom: 20px;
    animation: slideIn 0.5s ease forwards;
    color:#fdfdfd;
  }


.boton {
  top: 10px;
  bottom: 20px;
  border: none;
  background-color: #423a38;
  color: white;
  padding: 15px 32px;
  text-align: center;
  text-decoration: none;
  display: inline-block;
  font-size: 16px;
  margin: 4px 2px;
  cursor: pointer;
  border-radius: 10px;
  margin-top: 15px;
  margin-bottom: 15px;
  box-shadow: 0 5px 5px rgba(0, 0, 0, 0.541);
}



/* Estilo base */

.container {
  display: flex;
  justify-content: space-between;
  background-color: #ff5900;
  z-index: -9999;
}

.notas {
  background-color: #423a38;
  border-radius: 12px;
  color: white;
  padding: 20px;
  margin-top: 15px;
  margin-bottom: 15px;
  box-shadow: 0 5px 5px rgba(0, 0, 0, 0.541);
}

/* Espaciado para los elementos internos */
.notas > * {
  margin-bottom: 40px;
  margin-left: 10px;
  margin-right: 10px;
}

/* Estilo para los inputs y textarea */
.notas input[type="text"],
.notas input[type="date"],
.notas input[type="time"],
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