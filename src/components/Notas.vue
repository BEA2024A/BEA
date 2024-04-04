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
            <button @click="redirect('hacer')" class="boton-notas">Hacer Notas</button>
            <button @click="redirect('leer')" class="boton-notas">Leer Notas</button>
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
          carrera: 'Ingenieria en Tecnologías de la Información y Negocios Digitales',
          problemas: 'Ansiedad y depresión',
          historial: 'Ha tenido episodios de ansiedad desde la adolescencia. Ha experimentado síntomas de depresión en los últimos dos años.',
          medicacion: 'Actualmente toma medicamentos recetados para la ansiedad.',
          tratamientosAnteriores: 'Ha recibido terapia cognitivo-conductual en el pasado.',
          expectativas: 'Espera encontrar herramientas para manejar mejor su ansiedad y depresión, así como mejorar su calidad de vida en general.',
          imagen: 'https://i.postimg.cc/05WbLPJJ/Dise-o-sin-t-tulo.png',
          comentarios: "Últimamente he estado experimentando mucha ansiedad en situaciones sociales. Me siento nervioso y tenso, y a veces evito encontrarme con amigos o familiares. Creo que esto está afectando mi vida social y mi bienestar emocional. Me gustaría hablar sobre estrategias para manejar esta ansiedad y sentirme más cómodo en estas situaciones."
        },
      };
    },
    methods: {
  redirect(option) {
    if (option === 'hacer') {
      
      window.location.href = '/NotasCrear'; 
    } else if (option === 'leer') {
      window.location.href = '/NotasLeer'; 
    }
  }
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
  </style>