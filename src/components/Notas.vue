<template>
  <plantillaPsico>
    <div class="container">
      <div class="contenido">
        <div class="contenido-derecha">
          <div class="perfil">
            <img :src="perfil.foto_perfil"
              alt="Foto de perfil" class="imagen-perfil" />
            <h1>
              {{ perfil.NOMBRE }} {{ perfil.APELLIDO_PATERNO }}
              {{ perfil.APELLIDO_MATERNO }}
            </h1>
            <p>ID: {{ perfil.ID_ALUMNO }}</p>
            <p>Carrera: {{ perfil.CARRERA }}</p>
            <p>motivos de la cita: {{ perfil.MOTIVO }}</p>
            <p>Expectativas para la terapia: {{ perfil.EXPECTATIVA }}</p>
          </div>
        </div>

        <div class="contenido-izquierda">
          <!-- Contenido de hacer notas -->
          <div v-if="mostrarHacer">
            <div class="notas form-group">
              <label for="numero-sesion">Número de sesión:</label>
              <input type="text" id="numero-sesion" v-model="ultimoNumeroSesion" disabled />
            </div>
            <div class="notas form-group">
              <label for="fecha">Fecha:</label>
              <input type="date" id="fecha" v-model="fecha" disabled />
            </div>
            <p v-if="mostrarHacer" class="titulo-hacer">Notas</p>
            <div class="form-group2" v-if="mostrarHacer">
              <label for="editor"></label>
              <div id="editor" class="quill-editor"></div>
            </div>
            <button @click="enviarNotas" class="boton">Enviar</button>
            <button @click="showContent('leer')" class="boton">
              leer notas
            </button>
            <button @click="showContent('agendar')" class="boton">
              Agendar una cita
            </button>
          </div>

<!-- Contenido de agendar citas -->
<div v-if="mostrarAgendar" class="agendar-container">
  <div class="notas form-group">
    <label for="fecha">Fecha:</label>
    <input type="date" id="fecha" v-model="nuevoEvento.fecha" class="input" />
  </div>
  <div class="notas form-group" style="margin-left: 50px;">
    <label for="hora">Hora:</label>
    <input type="time" id="hora" v-model="nuevoEvento.hora" class="input" />
  </div>
  <!--calendario-->
  <div class="calendar-container">
    <FullCalendar :options="calendarOptions" />
  </div>
  <div class="boton-container">
    <button @click="agendarEventoAlumno" class="boton">Agendar</button>
    <button @click="showContent('hacer')" class="boton">Regresar</button>
  </div>
</div>


          <!-- Contenido de leer notas -->

          <div v-else-if="mostrarLeer">
            <div class="notas form-group">
              <label for="numero-sesion">Número de sesión:</label>
              <input type="text" id="numero-sesion" v-model="numeroSesion" />
            </div>
            <div class="notas form-group">
              <label for="fecha">Fecha:</label>
              <input type="date" id="fecha" v-model="fecha" />
            </div>

            <div class="form-group">
              <p>Notas anteriores</p>
              <label for="editor"></label>
              <div class="notas-container">
                <div class="notas-content" v-html="notas"></div>
              </div>
            </div>

            <button @click="solicitarNotas" class="boton">Solicitar</button>
            <button @click="showContent('hacer')" class="boton">
              regresar
            </button>
          </div>
        </div>
      </div>
    </div>
  </plantillaPsico>
</template>

<script>
import plantillaPsico from "./plantillaPsico.vue";
import axios from "axios";
import { mapGetters } from "vuex";
import FullCalendar from "@fullcalendar/vue3";
import dayGridPlugin from "@fullcalendar/daygrid";
import esLocale from "@fullcalendar/core/locales/es";
import Quill from "quill";
import "quill/dist/quill.snow.css";
import Swal from 'sweetalert2';

export default {
  components: {
    FullCalendar,
    plantillaPsico,
  },
  data() {
    const fechaActual = new Date();
    const dia = fechaActual.getDate();
    const mes = fechaActual.getMonth() + 1; 
    const año = fechaActual.getFullYear();
    const sysdate = `${año}-${mes < 10 ? "0" + mes : mes}-${dia < 10 ? "0" + dia : dia
      }`;

    return {
      filtroNumeroSesion: "",
      filtroFecha: "",
      ultimoNumeroSesion: [],
      calendarOptions: {
        plugins: [dayGridPlugin],
        initialView: "dayGridMonth",
        headerToolbar: {
          left: "prev,next",
          center: "title",
          right: "dayGridMonth,dayGridWeek,dayGridDay",
        },
        events: [],
        locale: esLocale,
      },

      perfil: {
        NOMBRE: "",
        APELLIDO_PATERNO: "",
        APELLIDO_MATERNO: "",
        CARRERA: "",
        ID_ALUMNO: null,
        MOTIVO: "",
        EXPECTATIVA: "",
      },

      mostrarHacer: true,
      mostrarLeer: false,
      mostrarAgendar: false,
      numeroSesion: "",
      fecha: sysdate,
      notas: "",
      notasExistentes: [],
      nuevoEvento: { titulo: "", fecha: "", hora: "", color: "#ff5900" },

      quill: null,
      quillOptions: {
        modules: {
          toolbar: [
            ["bold", "italic", "underline", "strike"],
            [{ list: "ordered" }, { list: "bullet" }],
          ],
        },
        theme: 'snow',
      },
    };
  },

  mounted() {

    this.cargarDatosAlumno();
    this.cargarNotas();
    this.obtenerEventosUsuario();
    this.obtenerUltimoNumeroSesion();


    const mostrarAgendar = localStorage.getItem("mostrarAgendar");

    if (mostrarAgendar === "true") {
      this.mostrarAgendar = true;
      this.mostrarHacer = false;

      localStorage.removeItem("mostrarAgendar");
    }

    this.quill = new Quill("#editor", this.quillOptions);
    this.quill.root.style.width = "100%";
    this.quill.root.style.overflowWrap = "break-word";
  },

  computed: {
    ...mapGetters(["usuario"]),
  },

  methods: {

    obtenerUltimoNumeroSesion() {
      const idAlumno = this.$route.params.id;
      axios
        .get(`http://localhost/bea/back/cargarNotas.php?idAlumno=${idAlumno}`)
        .then((response) => {
          if (response.data && response.data.length > 0) {
            const ultimoNumeroSesion = Math.max(
              ...response.data.map((nota) => nota.numeroSesion)
            );
            this.ultimoNumeroSesion = ultimoNumeroSesion + 1;
          } else {
            this.ultimoNumeroSesion = 1;
          }
          if (this.ultimoNumeroSesion > 4) {
            // Si el último número de sesión es mayor a 4, mostrar la notificación
            Swal.fire({
              title: '¡Atención!',
              text: 'El número de citas con este alumno ha sido completado.',
              icon: 'info',
              showCancelButton: false,
              confirmButtonColor: '#3085d6',
              cancelButtonColor: '#d33',
              confirmButtonText: 'Regresar al inicio'
            }).then((result) => {
              if (result.isConfirmed) {
                
                this.$router.push('/iniciopsico');
              }

            });
          }
        })
        .catch((error) => {
          console.error("Error al cargar las notas del alumno:", error);
        });
    },

    obtenerEventosUsuario() {
      const idUsuario = this.usuario.id;
      axios
        .get(
          `http://localhost/BEA/back/obtenerEventosAdmin.php?idUsuario=${idUsuario}`
        )
        .then((response) => {
          this.calendarOptions.events = response.data;
        })
        .catch((error) =>
          console.error("Hubo un error al obtener los eventos:", error)
        );
    },

    cargarDatosAlumno() {
      const idAlumno = this.$route.params.id;
      axios
        .get(`http://localhost/bea/back/notas-perfil.php?idAlumno=${idAlumno}`)
        .then((response) => {
          this.perfil = response.data;
        })
        .catch((error) => {
          console.error("Error al cargar los datos del alumno:", error);
        });
    },

    cargarNotas() {
      const idAlumno = this.$route.params.id;
      axios
        .get(`http://localhost/bea/back/cargarNotas.php?idAlumno=${idAlumno}`)
        .then((response) => {
          if (response.data && response.data.length > 0) {
            this.notasExistentes = response.data.map((nota) => ({
              numeroSesion: nota.numeroSesion.toString(),
              fecha: nota.fecha,
              contenido: nota.contenido,
            }));
          } else {
            console.error("La respuesta del servidor está vacía.");
          }
        })
        .catch((error) => {
          console.error("Error al cargar las notas del alumno:", error);
        });
    },

    showContent(option) {
      if (option === "hacer") {
        window.location.reload();
      } else if (option === "leer") {
        this.mostrarHacer = false;
        this.mostrarLeer = true;
        this.fecha = null;
        this.numeroSesion = "";
        this.solicitarNotas();
      } else if (option === "agendar") {
        this.mostrarHacer = false;
        this.mostrarLeer = false;
        this.mostrarAgendar = true;
      }
    },
    enviarNotas() {
      const contenidoQuill = this.quill.root.innerHTML;

      if (!contenidoQuill || contenidoQuill.trim() === "") {
        Swal.fire(
          'Error',
          'No se puede enviar una nota vacía.',
          'error'
        );
        return;
      }

      // Obtener el último número de sesión
      const ultimoNumeroSesion = this.ultimoNumeroSesion;
      const fechaActual = new Date();
      const dia = fechaActual.getDate();
      const mes = fechaActual.getMonth() + 1; 
      const año = fechaActual.getFullYear();
      const sysdate = `${año}-${mes < 10 ? "0" + mes : mes}-${dia < 10 ? "0" + dia : dia
        }`;
      // Agregar el título al inicio del contenido de la nota
      const titulo = `<h3>Notas Sesión ${ultimoNumeroSesion} fecha: ${sysdate}  </h3>`;
      const contenidoConTitulo = titulo + contenidoQuill;

      const formData = new FormData();
      formData.append("numero_sesion", ultimoNumeroSesion);
      formData.append("fecha", this.fecha);
      formData.append("contenido", contenidoConTitulo);
      formData.append("id_administrador", this.$store.state.usuario.id);
      formData.append("id_alumno", this.$route.params.id);

      axios
        .post("http://localhost/bea/back/guardar-nota.php", formData)
        .then((response) => {
          Swal.fire(
            'Éxito',
            'Nota enviada exitosamente.',
            'success'
          );

          this.mostrarAgendar = true;
          this.mostrarHacer = false;
          this.numeroSesion = "";
          this.fecha = "";

          this.quill.setText("");
        })
        .catch((error) => {

          console.error("Error en la petición:", error);
        });
    },

    solicitarNotas() {

      let notasFiltradas = this.notasExistentes;


      if (this.numeroSesion) {
        notasFiltradas = notasFiltradas.filter(
          (nota) => nota.numeroSesion === this.numeroSesion
        );
      }

      if (this.fecha) {
        notasFiltradas = notasFiltradas.filter(
          (nota) => nota.fecha === this.fecha
        );
      }

      if (notasFiltradas.length > 0) {

        this.notas = notasFiltradas.map((nota) => nota.contenido).join("");
      } else {

        this.notas =
          "<p>No se encontraron notas para los criterios de búsqueda proporcionados.</p>";
      }
    },


    agendarEventoAlumno() {
      if (!this.nuevoEvento.fecha || !this.nuevoEvento.hora) {
        Swal.fire(
          'Error',
          'Por favor completa todos los campos.',
          'error'
        );
        return;
      } else if (
        this.nuevoEvento.fecha < new Date().toISOString().slice(0, 10)
      ) {
        Swal.fire(
          'Error',
          'La fecha del evento no puede ser menor a la fecha actual.',
          'error'
        );
        return;
      }

      const horaSeleccionada = new Date(`01/01/2000 ${this.nuevoEvento.hora}`);
      const horaInicio = new Date(`01/01/2000 09:00`);
      const horaFin = new Date(`01/01/2000 18:00`);

      if (horaSeleccionada < horaInicio || horaSeleccionada > horaFin) {
        Swal.fire(
          'Error',
          'Por favor selecciona un horario entre las 9:00 a.m. y las 6:00 p.m.',
          'error'
        );
        return;
      }

      const tituloAlumno = "Cita con " + this.usuario.nombre;

      const formDataAlumno = new FormData();
      formDataAlumno.append("id_usuario", this.$route.params.id);
      formDataAlumno.append("titulo", tituloAlumno);
      formDataAlumno.append("fecha", this.nuevoEvento.fecha);
      formDataAlumno.append("hora", this.nuevoEvento.hora);
      formDataAlumno.append("color", this.nuevoEvento.color);
      formDataAlumno.append("id_administrador", this.$store.state.usuario.id);

      axios
        .post("http://localhost/bea/back/guardar-evento.php", formDataAlumno)
        .then((response) => {
          // Una vez que se agrega el evento para el alumno, se activa el método para agregarlo para el administrador
          this.agendarEventoAdmin(tituloAlumno);
        })
        .catch((error) => {
          console.error("Error al agendar el evento para el alumno:", error);
          Swal.fire(
            'Error',
            'Ocurrió un error al agendar el evento para el alumno.',
            'error'
          );
        });
    },

    agendarEventoAdmin(tituloAlumno) {
      if (!this.perfil || !this.perfil.NOMBRE) {
        console.error("No se ha cargado correctamente el perfil del alumno.");
        Swal.fire(
          'Error',
          'Ocurrió un error al cargar el perfil del alumno.',
          'error'
        );
        return;
      }

      const tituloAdmin = "Cita con " + this.perfil.NOMBRE;

      const formDataAdmin = new FormData();
      formDataAdmin.append("id_alumno", this.$route.params.id);
      formDataAdmin.append("titulo", tituloAdmin);
      formDataAdmin.append("fecha", this.nuevoEvento.fecha);
      formDataAdmin.append("hora", this.nuevoEvento.hora);
      formDataAdmin.append("color", this.nuevoEvento.color);
      formDataAdmin.append("id_administrador", this.$store.state.usuario.id);

      axios
        .post(
          "http://localhost/bea/back/guardar-evento-admin.php",
          formDataAdmin
        )
        .then((response) => {
          Swal.fire(
            'Éxito',
            'Eventos agendados exitosamente.',
            'success'
          );
          // Reiniciar el objeto nuevoEvento
          this.nuevoEvento = {
            titulo: "",
            fecha: "",
            hora: "",
            color: "",
          };
          // Recargar la página con mostrarAgendar establecido en true
          localStorage.setItem("mostrarAgendar", "true");
          window.location.reload();
        })
        .catch((error) => {
          console.error(
            "Error al agendar el evento para el administrador:",
            error
          );
          Swal.fire(
            'Error',
            'Ocurrió un error al agendar el evento para el administrador.',
            'error'
          );
        });
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
    margin-bottom: 80px;
    width: 100%;
    padding: 20px;
    border: 1px solid #ddd;
    border-radius: 10px;
    box-shadow: 0 5px 5px rgba(0, 0, 0, 0.541);
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
  width: 280px;
  height: 280px;
  border-radius: 50%;
  object-fit: cover;
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
  position: sticky;
  /* Hacer que la parte derecha sea pegajosa */
  top: 20px;
  /* La distancia desde la parte superior donde se pegará */
}

.contenido-izquierda {
  flex: 70%;
  padding-right: 60px;
  padding-left: 100px;
  margin-top: 20px;
  margin-bottom: 20px;
  animation: slideIn 0.5s ease forwards;
  color: #fdfdfd;
}

.boton {
  top: 10px;
  bottom: 20px;
  border: none;
  background-color: #423a38;
  color: white;
  padding: 10px 20px;
  text-align: center;
  text-decoration: none;
  display: inline-block;
  font-size: 14px;
  margin: 4px 2px;
  cursor: pointer;
  border-radius: 10px;
  margin-top: 15px;
  margin-bottom: 15px;
  box-shadow: 0 5px 5px rgba(0, 0, 0, 0.541);
  max-width: 150px;
  transition: background-color 0.3s ease;
}


.container {
  display: flex;
  justify-content: space-between;
  background-image: linear-gradient(to bottom, #ff5900, #c21c02);
  z-index: -9999;
}

.notas-container {
  width: 900px;
  height: 420px;
  overflow-y: auto;
  border: 1px solid #ccc;
  padding: 5px;
  border-radius: 10px;
  box-shadow: 0 5px 5px rgba(0, 0, 0, 0.541);
  background-color: white;
  margin: 0 auto;
  font-size: 18px;
}

.notas-content {
  text-align: justify;
  padding: 10px;
  color: black;
}


.notas.form-group {
  display: inline-block;
  width: calc(50% - 100px);
}



.form-group2 {
  background-color: white;
  padding: 10px;
  color: black;
  width: 900px;
  padding: 5px;
  border-radius: 10px;
  box-shadow: 0 5px 5px rgba(0, 0, 0, 0.541);
  background-color: white;
  margin: 0 auto;
  font-size: 18px;

}

.notas label {
  display: block;
  margin-bottom: 10px;
}

.notas input[type="text"] {
  max-width: 20%;
  padding: 12px;
  border: 1px solid #ccc;
  border-radius: 20px;
  box-sizing: border-box;
  font-size: 18px;
  box-shadow: 0 5px 5px rgba(0, 0, 0, 0.541);
  animation: slideIn 0.5s ease forwards;
  text-align: center;
}

.notas input[type="date"] {
  max-width: 40%;
  padding: 12px;
  border: 1px solid #ccc;
  border-radius: 20px;
  box-sizing: border-box;
  font-size: 18px;
  box-shadow: 0 5px 5px rgba(0, 0, 0, 0.541);
  animation: slideIn 0.5s ease forwards;
  text-align: center;
}

.notas input[type="time"] {
  max-width: 45%;
  padding: 12px;
  border: 1px solid #ccc;
  border-radius: 20px;
  box-sizing: border-box;
  font-size: 18px;
  box-shadow: 0 5px 5px rgba(0, 0, 0, 0.541);
  animation: slideIn 0.5s ease forwards;

}

.quill-editor {
  width: 900px;
  height: 420px;
  margin-left: auto;
  margin-right: auto;
  padding: 10px;
  background-color: #fff;
  overflow-wrap: break-word;
}

.notas> :last-child {
  margin-bottom: 10px;
  color: black;
}

.calendar-container {
  max-width: 100%;
  border: 1px solid #ddd;
  border-radius: 10px;
  background-color: rgb(255, 255, 255);
  box-shadow: 0 5px 5px rgba(0, 0, 0, 0.541);
  transition: 0.3s ease;
  animation: slideIn 0.5s ease forwards;
  padding: 10px;
  color: black;
  margin-top: 20px;
}

.fc .fc-button-group>.fc-button {
  margin-right: 50px;
}

.fc .fc-button-group>.fc-button:last-child {
  margin-right: 0;
}

.fc .fc-button {
  padding: 8px 120px;
}

.fc-header-toolbar {
  margin-bottom: 30px;
}

@media only screen and (max-width: 767px) {
  .perfil {
    margin: 20px;
    padding: 20px;
    max-width: 80%;
    margin: 0 auto; 
    position: static;
  }

  .imagen-perfil {
    width: 200px;
    height: 200px;
    margin-bottom: 20px;
  }

  .contenido {
    flex-direction: column;
    width: 100%;
  }

  .contenido-izquierda {
    padding: 0 20px;
    margin-top: 20px;
    width: 100%;
  }

  .contenido-derecha{
    position: relative;
  }

  .boton {
    max-width: 80%; 
    margin: 10px auto; 
    margin-top: 20px;
    margin-right: 30px;
  }

  .notas-container {
    width: 350px;
    height: 500px;
    max-width: 90%; 
    margin: 0 auto; 
    margin-right: 12%;
  }

  .quill-editor {
    width: 400px;
    height: 500px;
    max-width: 80%;
    margin: 0 auto; 
  }

  .calendar-container {
    padding: 10px;
    margin-top: 20px;
    margin-bottom: 20px;
    max-width: 80%;
    margin: 0 auto; 
    margin-right: 12%;
  }

  .fc .fc-button {
    padding: 8px 20px;
  }


  .form-group2 {
  background-color: white;
  padding: 10px;
  color: black;
  width: 350px;
  padding: 5px;
  border-radius: 10px;
  box-shadow: 0 5px 5px rgba(0, 0, 0, 0.541);
  margin: 0 auto;
  font-size: 18px;
  margin-right: 12%

}

.notas{
  transform: translateX(-35%);
}

.notas label {
  display: block;
  margin-bottom: 10px;
  margin-right: 12%;
  margin-top: 30px;
}

.notas input[type="text"] {
  max-width: 50%;
  padding: 12px;
  border: 1px solid #ccc;
  border-radius: 20px;
  box-sizing: border-box;
  font-size: 18px;
  box-shadow: 0 5px 5px rgba(0, 0, 0, 0.541);
  animation: slideIn 0.5s ease forwards;
  text-align: center;
  
}

.notas input[type="date"] {
  max-width: 145%;
  padding: 10px;
  border: 1px solid #ccc;
  border-radius: 20px;
  box-sizing: border-box;
  font-size: 18px;
  box-shadow: 0 5px 5px rgba(0, 0, 0, 0.541);
  animation: slideIn 0.5s ease forwards;
  text-align: center;
  
}

.notas input[type="time"] {
  max-width: 100%;
  padding: 12px;
  border: 1px solid #ccc;
  border-radius: 20px;
  box-sizing: border-box;
  font-size: 18px;
  box-shadow: 0 5px 5px rgba(0, 0, 0, 0.541);
  animation: slideIn 0.5s ease forwards;
  
}


.titulo-hacer{
  transform: translateX(-10px);
}



}






@media only screen and (min-width: 768px) and (max-width: 991px){
  .perfil {
  font-family: Arial, sans-serif;
    margin-right: 20px;
    margin-left: 20px;
    margin-top:20px;
    margin-bottom: 80px;
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
  width: 200px;
  height: 200px;
  border-radius: 50%;
  object-fit: cover;
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
  position: sticky;
  top: 20px;
}

.contenido-izquierda {
  flex: 70%;
  padding-right: 60px;
  padding-left: 100px;
  margin-top: 20px;
  margin-bottom: 20px;
  animation: slideIn 0.5s ease forwards;
  color: #fdfdfd;
}

.boton {
  top: 10px;
  bottom: 20px;
  border: none;
  background-color: #423a38;
  color: white;
  padding: 10px 20px;
  text-align: center;
  text-decoration: none;
  display: inline-block;
  font-size: 14px;
  margin: 4px 2px;
  cursor: pointer;
  border-radius: 10px;
  margin-top: 15px;
  margin-bottom: 15px;
  box-shadow: 0 5px 5px rgba(0, 0, 0, 0.541);
  max-width: 150px;
  transition: background-color 0.3s ease;
}

/* Estilo base */

.container {
  display: flex;
  justify-content: space-between;
  background-image: linear-gradient(to bottom, #ff5900, #c21c02);
  z-index: -9999;
}

.notas-container {
  width: 400px;
  height: 420px;
  overflow-y: auto;
  border: 1px solid #ccc;
  padding: 5px;
  border-radius: 10px;
  box-shadow: 0 5px 5px rgba(0, 0, 0, 0.541);
  background-color: white;
  margin: 0 auto;
  font-size: 18px;
}

.notas-content {
  text-align: justify;
  padding: 10px;
  color: black;
}

/* Espaciado para los elementos internos */

.notas.form-group {
  display: inline-block;
  width: calc(50% - 100px);
}



.form-group2 {
  background-color: white;
  padding: 10px;
  color: black;
  width: 400px;
  padding: 5px;
  border-radius: 10px;
  box-shadow: 0 5px 5px rgba(0, 0, 0, 0.541);
  margin: 0 auto;
  font-size: 18px;

}

.notas label {
  display: block;
  margin-bottom: 10px;

}

.notas input[type="text"] {
  max-width: 50%;
  padding: 12px;
  border: 1px solid #ccc;
  border-radius: 20px;
  box-sizing: border-box;
  font-size: 18px;
  box-shadow: 0 5px 5px rgba(0, 0, 0, 0.541);
  animation: slideIn 0.5s ease forwards;
  text-align: center;
  margin-right: 50px;
}

.notas input[type="date"] {
  max-width: 145%;
  padding: 10px;
  border: 1px solid #ccc;
  border-radius: 20px;
  box-sizing: border-box;
  font-size: 18px;
  box-shadow: 0 5px 5px rgba(0, 0, 0, 0.541);
  animation: slideIn 0.5s ease forwards;
  text-align: center;
}

.notas input[type="time"] {
  max-width: 100%;
  padding: 12px;
  border: 1px solid #ccc;
  border-radius: 20px;
  box-sizing: border-box;
  font-size: 18px;
  box-shadow: 0 5px 5px rgba(0, 0, 0, 0.541);
  animation: slideIn 0.5s ease forwards;
  
}

.quill-editor {
  width: 400px;
  height: 420px;
  margin-left: auto;
  margin-right: auto;
  padding: 10px;
  background-color: #fff;
  overflow-wrap: break-word;

}

.notas> :last-child {
  margin-bottom: 10px;
  color: black;
}

.calendar-container {
  max-width: 100%;
  border: 1px solid #ddd;
  border-radius: 10px;
  background-color: rgb(255, 255, 255);
  box-shadow: 0 5px 5px rgba(0, 0, 0, 0.541);
  transition: 0.3s ease;
  animation: slideIn 0.5s ease forwards;
  padding: 10px;
  color: black;
  margin-top: 20px;
}

}
</style>
