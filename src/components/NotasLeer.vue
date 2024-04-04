<template>
    <plantilla-psico>
      <div class="plantilla-psico">
        <div class="contenido">
          <div class="contenido-derecha">
            <div class="perfil">
              <img :src="perfil.imagen" alt="Foto de perfil" class="imagen-perfil">
              <h1>{{ perfil.nombre }}</h1>
              <p>ID: 00{{ perfil.ide }}</p>
              <p>Edad: {{ perfil.edad }}</p>
              <p>Carrera: {{ perfil.carrera }}</p>
              <p>Problemas principales: {{ perfil.problemas }}</p>
              <p>Historial médico: {{ perfil.historial }}</p>
              <p>Medicación actual: {{ perfil.medicacion }}</p>
              <p>Tratamientos anteriores: {{ perfil.tratamientosAnteriores }}</p>
              <p>Expectativas para la terapia: {{ perfil.expectativas }}</p>
            </div>
          </div>
          <div class="contenido-izquierda">
            <div class="num-sesion">
              <label for="numero-sesion">Número de sesión:</label>
              <input type="text" id="numero-sesion" v-model="numeroSesion">
            </div>
            
            <div class="fecha">
              <label for="fecha">Fecha:</label>
              <input type="date" id="fecha" v-model="fecha">
            </div>
  
            <button @click="solicitarNotas" class="boton">Solicitar</button>
            
            <div class="notas">
              <label for="notas">Notas:</label>
              <textarea id="notas" v-model="notas" readonly></textarea>
            </div>
            
          </div>
        </div>
      </div>
    </plantilla-psico>
  </template>
  
  <script>
  import plantillaPsico from './plantillaPsico.vue'
  
  export default {
    components: {
      plantillaPsico,
    },
    data() {
      return {
        perfil: {
          nombre: 'Carlos González',
          ide: 456641,
          edad: 22,
          carrera: 'Ingeniería en Tecnologías de la Información y Negocios Digitales',
          problemas: 'Ansiedad y depresión',
          historial: 'Ha tenido episodios de ansiedad desde la adolescencia. Ha experimentado síntomas de depresión en los últimos dos años.',
          medicacion: 'Actualmente toma medicamentos recetados para la ansiedad.',
          tratamientosAnteriores: 'Ha recibido terapia cognitivo-conductual en el pasado.',
          expectativas: 'Espera encontrar herramientas para manejar mejor su ansiedad y depresión, así como mejorar su calidad de vida en general.',
          imagen: 'https://i.postimg.cc/05WbLPJJ/Dise-o-sin-t-tulo.png',
          comentarios: "Últimamente he estado experimentando mucha ansiedad en situaciones sociales. Me siento nervioso y tenso, y a veces evito encontrarme con amigos o familiares. Creo que esto está afectando mi vida social y mi bienestar emocional. Me gustaría hablar sobre estrategias para manejar esta ansiedad y sentirme más cómodo en estas situaciones."
        },
        numeroSesion: '',
        fecha: '',
        notas: '',
        notasExistentes: [
        { numeroSesion: '1', fecha: '2024-04-01', contenido: 'Hoy discutimos sobre las técnicas de respiración para reducir la ansiedad.' },
        { numeroSesion: '2', fecha: '2024-04-14', contenido: 'En la sesión de hoy, exploramos los desencadenantes de la ansiedad social.' },
        { numeroSesion: '3', fecha: '2024-04-29', contenido: 'Hablamos sobre estrategias para establecer límites saludables en las relaciones.' },
        { numeroSesion: '4', fecha: '2024-05-12', contenido: 'En la sesión de hoy, discutimos la importancia de la autocompasión en el proceso de recuperación.' },
        ]
      };
    },
    methods: {
      solicitarNotas() {
        const notaEncontrada = this.notasExistentes.find(nota => nota.numeroSesion === this.numeroSesion && nota.fecha === this.fecha);
        if (notaEncontrada) {
          this.notas = notaEncontrada.contenido;
        } else {
          this.notas = 'No se encontraron notas para la sesión y fecha especificadas.';
        }
      }
    }
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
  
    .boton {
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
  
  .boton:hover {
    background-color: #ffae00;
  }
  
    .contenido-izquierda > div {
    margin-bottom: 15px;
    background-color: #d45c37;
    padding: 10px;
    border-radius: 12px;
  }
  
  .contenido-izquierda label {
    display: block;
    margin-bottom: 5px;
    color: white;
  }
  
  .contenido-izquierda input[type="text"],
  .contenido-izquierda input[type="date"],
  .contenido-izquierda textarea {
    width: 100%;
    padding: 8px;
    border: 1px solid #ccc;
    border-radius: 4px;
    box-sizing: border-box;
    font-size: 16px;
  }
  
  .contenido-izquierda textarea {
    height: 100px;
  }

    </style>