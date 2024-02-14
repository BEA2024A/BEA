<template>
    <div>
      <!-- Barra de Navegación -->
      <nav class="barra-navegacion">
        <!-- Logo -->
        <div class="logo">
          <router-link to="/" class="enlace-navegacion">
            <img src="https://i.ibb.co/TkHLsmX/anahuac-oaxaca.png" alt="Logo Anáhuac">
          </router-link>
        </div>
  
        <!-- Secciones -->
        <div class="secciones-navegacion">
          <router-link to="/primeracita" class="enlace-navegacion">Primera Cita</router-link>
          <router-link to="/seguimiento" class="enlace-navegacion">Seguimiento</router-link>
          <router-link to="/horario" class="enlace-navegacion">Horario</router-link>
          <router-link to="/autoayuda" class="enlace-navegacion">Autoayuda</router-link>
        </div>
  
        <!-- Botón de Inicio de Sesión -->
        <div class="boton-inicio-sesion">
          <button @click="abrirEnlace('/inicio-sesion')">Iniciar sesión</button>
        </div>
      </nav>
  
      <!-- Contenido de la Página -->
      <div class="contenido-pagina">
        <!-- Contenido Izquierdo -->
        <div class="contenido-izquierdo">
          <!-- Calendario -->
          <h2>Proximas Citas</h2>
          <!-- Panel de Recordatorios -->
          <div class="panel-recordatorios recordatorio-urgente">
            <p>Tienes una cita muy pronto.</p>
            <router-link to="/Horario" class="enlace-recordatorio">Ir a tu Itinerario</router-link>
          </div>
          <!-- videos de autoayuda -->
          <section class="seccion-autoayuda">
            <div class="titulo-seccion-autoayuda">
              <h1>SESIONES DE MEDITACIÓN</h1>
            </div>
            <!-- Primer Cajón -->
            <div class="cajon-autoayuda" v-for="(video, index) in videosAutoayuda" :key="index" :class="{ 'inverted': (index % 2 !== 0) }">
              <div class="contenido-cajon">
                <div class="texto-cajon">
                  <h2>{{ video.titulo }}</h2>
                  <p>{{ video.descripcion }}</p>
                </div>
                <div class="video-cajon">
                  <iframe :src="video.enlace" frameborder="0" allowfullscreen></iframe>
                </div>
              </div>
            </div>
          </section>
        </div>
  
        <!-- Contenido Derecho -->
        <div class="contenido-derecho">
          <h2>Formulario</h2>
          <!-- Formulario -->
          <form @submit.prevent="enviarFormulario">
            <div class="pregunta">
              <label for="pregunta1">¿Cuáles han sido los cambios o progresos que has notado desde nuestra última sesión?</label>
              <input type="text" id="pregunta1" v-model="respuestas.pregunta1" required>
            </div>
            <div class="pregunta">
              <label for="pregunta2">¿Hubo algún tema o situación específica que te gustaría abordar con más detalle en esta cita?</label>
              <input type="text" id="pregunta2" v-model="respuestas.pregunta2" required>
            </div>
            <div class="pregunta">
              <label for="pregunta3">¿Has experimentado alguna dificultad o desafío desde nuestra última sesión que te gustaría discutir?</label>
              <input type="text" id="pregunta3" v-model="respuestas.pregunta3" required>
            </div>
            <div class="pregunta">
              <label for="pregunta4">¿Hay alguna emoción o pensamiento recurrente que te esté preocupando últimamente?</label>
              <input type="text" id="pregunta4" v-model="respuestas.pregunta4" required>
            </div>
            <div class="pregunta">
              <label for="pregunta5">¿Has implementado alguna estrategia o técnica que hayamos discutido en nuestra primera sesión? ¿Cómo te ha funcionado?</label>
              <input type="text" id="pregunta5" v-model="respuestas.pregunta5" required>
            </div>
            <button type="submit">Enviar</button>
          </form>
        </div>
      </div>
    </div>
  </template>
  
  <script>
  export default {
    data() {
      return {
        videosAutoayuda: [
          {
            enlace: 'https://www.youtube.com/embed/aBsnQjJ2_Nk?si=JjuEzSsuCh2UxwV8',
            titulo: 'Superar situaciones difíciles',
            descripcion: 'Esta meditación guiada busca eliminar la ansiedad y superar situaciones difíciles. Se invita a sentarse cómodamente, cerrar los ojos y observar la respiración. A través de la visualización, la emoción negativa se representa como un objeto que rodea al individuo. La meditación se centra en respirar para disolver esa energía, creando espacio y purificando el entorno. La exhalación impregna el aire con una "ola de calma" que alivia el dolor.',
          },
          {
            enlace: 'https://www.youtube.com/embed/4mSwSMO8cEQ?si=cIrOaUMu1mo60Ukg',
            titulo: 'Relájate y descansa',
            descripcion: 'Jorge Benito te da la bienvenida a una meditación para calmar la mente y liberar el estrés al final del día. Invita a adoptar una postura cómoda, mover suavemente los hombros y el cuello, y cerrar los ojos. La respiración se convierte en el foco, inhalando y exhalando lentamente. Con los ojos cerrados, se presta atención a los sonidos y la temperatura ambiente.',
          },
          {
            enlace: 'https://www.youtube.com/embed/gxBNte5VDJE?si=BU7t3G1f73szUFgA',
            titulo: 'Meditación para los momentos difíciles',
            descripcion: 'Esta meditación guiada, liderada por Rosario Vicencio, invita a cerrar los ojos y comenzar inhalando y exhalando suave y profundamente. Se visualiza una luz poderosa y llena de certeza que cae sobre la coronilla, iluminando el cuerpo y proporcionando fortaleza. La fe se destaca como la certeza absoluta de influir sobre lo físico con la mente y la energía. Se insta a confiar y mantener la certeza de que todo estará bien.',
          },
        ],
        respuestas: {
          pregunta1: '',
          pregunta2: '',
          pregunta3: '',
          pregunta4: '',
          pregunta5: ''
        }
      };
    },
  
    methods: {
      abrirMapa() {
        window.location.href = 'https://maps.app.goo.gl/te3G28WuD56cTgyHA';
      },
      abrirEnlace(url) {
        window.location.href = url;
      },
      enviarFormulario() {
        // Aquí podrías enviar las respuestas a un servidor o hacer lo que necesites
        // Una vez enviado, puedes cerrar el formulario, por ejemplo:
        alert('Formulario enviado!');
        // Aquí puedes agregar código para cerrar el formulario, por ejemplo, limpiar las respuestas:
        this.respuestas = {
          pregunta1: '',
          pregunta2: '',
          pregunta3: '',
          pregunta4: '',
          pregunta5: ''
        };
      }
    }
  };
  </script>
  
  <style scoped>
  
  /* Barra de Navegación */
  .barra-navegacion {
    display: flex;
    justify-content: space-around;
    align-items: center;
    padding: 15px;
    background-color: black;
    color: white;
  }
  
  .logo img {
    max-height: 40px;
  }
  
  .secciones-navegacion {
    display: flex;
  }
  
  .enlace-navegacion {
    margin-right: 30px;
    color: white;
    text-decoration: none;
    transition: color 0.3s ease;
  }
  
  .enlace-navegacion:hover {
    color: #d45c37;
  }
  
  .boton-inicio-sesion button {
    background-color: #d45c37;
    color: white;
    border: none;
    padding: 10px 15px;
    text-align: center;
    text-decoration: none;
    display: inline-block;
    font-size: 16px;
    cursor: pointer;
    border-radius: 5px;
    transition: background-color 0.3s ease;
  }
  
  .boton-inicio-sesion button:hover {
    background-color: #a03722;
  }
  
  /* Contenido de la Página */
  .contenido-pagina {
    display: flex;
    justify-content: space-between;
    padding: 10px;
  }
  
  .contenido-izquierdo,
  .contenido-derecho {
    flex: 1;
    padding: 10px;
  }
  
  .contenido-izquierdo {
    background-color: #f0f0f0; /* Color de fondo para distinguir */
  }
  
  .contenido-derecho {
    background-color: #e0e0e0; /* Color de fondo para distinguir */
  }
  
  /* Panel de Recordatorios */
  .panel-recordatorios {
    background-color: #d3d3d3;
    padding: 10px;
    margin-bottom: 20px;
  }
  
  .enlace-recordatorio {
    display: block;
    margin-top: 10px;
  }
  
  /* Pie de Página */
  .pie-pagina {
    background-color: black;
    color: white;
    padding: 30px;
  }
  
  .contenido-pie {
    display: flex;
    flex-wrap: wrap;
    justify-content: space-around;
    align-items: center;
  }
  
  .derecha-pie img {
    max-height: 80px;
  }
  
  .contacto-pie p {
    margin: 10px;
  }
  
  .botones-pie {
    display: flex;
    flex-direction: column;
  }
  
  .boton-pie {
    background-color: #000000;
    color: white;
    border: none;
    text-align: center;
    cursor: pointer;
    border-radius: 5px;
    margin-bottom: 10px;
  }
  
  .botones-sociales-pie img {
    max-height: 35px;
    margin-right: 5px;
  }
  
  .botones-sociales-pie button {
    background: none;
    border: none;
    padding: 0;
    cursor: pointer;
  }
  .contenido-izquierdo {
  background-color: #f0f0f0; /* Color de fondo para distinguir */
  padding: 20px;
}

/* Estilos para el panel de recordatorios */
.panel-recordatorios {
  border-radius: 5px;
  padding: 15px;
  margin-bottom: 20px;
  box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
}

.panel-recordatorios p {
  margin-bottom: 10px;
}

.enlace-recordatorio {
  display: inline-block;
  padding: 8px 15px;
  background-color: #d45c37;
  color: white;
  text-decoration: none;
  border-radius: 5px;
  transition: background-color 0.3s ease;
}

.enlace-recordatorio:hover {
  background-color: #a03722;
}

/* Estilos para la urgencia del recordatorio */
.recordatorio-urgente {
  background-color: #ff7f7f; /* Rojo */
}

.recordatorio-importante {
  background-color: #ffd97f; /* Amarillo */
}

.recordatorio-normal {
  background-color: #a3ffa3; /* Verde */
}

.seccion-autoayuda {
  margin-top: 40px;
  background-image: url('https://i.ibb.co/MNhbG6b/Campus-Ana-huac-Oaxaca.png"'); /* URL de la imagen */
  background-size: cover;
  background-position: center;
  padding: 20px;
  border-radius: 10px;
}

.titulo-seccion-autoayuda {
  background-color: rgba(255, 255, 255, 0.5); /* Blanco transparente */
  text-align: center;
  margin-bottom: 20px;
  width: 70%;
  padding: 20px;
  border-radius: 15px;
  margin-left: auto;
  margin-right: auto;
  color: rgb(3, 3, 3); /* Color del texto */
  transition: background-color 0.3s ease, transform 0.3s ease;
}

.titulo-seccion-autoayuda:hover {
  background-color: rgba(255, 255, 255, 0.8); /* Blanco más sólido al pasar el mouse */
  transform: scale(1.05); /* Agrandar al pasar el mouse */
}

.titulo-seccion-autoayuda h1 {
  font-size: 30px;
  margin: 0;
  opacity: 0;
  animation: fadeIn 1s ease forwards;
}

.cajon-autoayuda {
  background-color: rgba(255, 255, 255, 0.5); /* Blanco transparente */
  border-radius: 15px;
  margin-bottom: 50px;
  overflow: hidden;
  width: 70%;
  margin-left: auto;
  margin-right: auto;
  display: flex;
  flex-direction: column;
  transition: background-color 0.3s ease, transform 0.3s ease; /* Transición en el cambio de color y tamaño */
}

.cajon-autoayuda:hover {
  background-color: rgba(255, 255, 255, 0.8); /* Blanco más sólido al pasar el mouse */
  transform: scale(1.05); /* Agrandar al pasar el mouse */
}

.cajon-autoayuda.inverted .contenido-cajon {
  flex-direction: row-reverse;
}

.contenido-cajon {
  display: flex;
  align-items: center;
}

.texto-cajon {
  flex: 1;
  padding: 20px;
  text-align: center;
}

.texto-cajon h2 {
  color: black;
  font-size: 24px;
  margin-bottom: 10px;
}

.texto-cajon p {
  color: black;
}

.video-cajon {
  flex: 1;
}

.video-cajon iframe {
  width: 100%;
  height: 500px;
}
/* Estilos específicos para el contenido derecho */
.contenido-derecho {
  background-color: #f0f0f0; /* Color de fondo para distinguir */
  padding: 20px;
  flex: 1; /* Para que ocupe todo el espacio disponible */
}

/* Estilos para el formulario */
form {
  max-width: 100%;
  margin: 0 auto;
}

.pregunta {
  margin-bottom: 30px;
}

label {
  display: block;
  font-weight: bold;
  margin-bottom: 10px;
  color: #333;
}

input[type="text"] {
  width: calc(100% - 22px); /* Para tener en cuenta el padding */
  padding: 12px;
  border: 1px solid #ccc;
  border-radius: 5px;
}

button[type="submit"] {
  background-color: #d45c37;
  color: white;
  border: none;
  padding: 15px 30px;
  border-radius: 5px;
  cursor: pointer;
  transition: background-color 0.3s ease;
  font-size: 16px;
  margin-top: 20px;
}

button[type="submit"]:hover {
  background-color: #a03722;
}

/* Estilos adicionales */
.panel-formulario {
  background-color: #fff;
  box-shadow: 0px 0px 20px rgba(0, 0, 0, 0.1);
  border-radius: 10px;
  padding: 30px;
}
  </style>
  
  
  