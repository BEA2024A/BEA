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
  
        <!-- Botón Hamburguesa para dispositivos móviles -->
        <div class="hamburguesa" @click="toggleMenu">
          <div class="linea"></div>
          <div class="linea"></div>
          <div class="linea"></div>
        </div>
  
        <!-- Secciones -->
        <div class="secciones-navegacion" :class="{ 'mostrar-menu': mostrarMenu }">
          <router-link to="/inicioPsico" class="enlace-navegacion">Alumnos</router-link>
          <router-link to="/HorarioPsico" class="enlace-navegacion">Citas</router-link>
        </div>
  
        <!-- Botón de Inicio de Sesión -->
        <div class="boton-inicio-sesion">
          <button @click="abrirEnlace('/iniciosesion')">Iniciar sesión</button>
        </div>
      </nav>
  
      <!-- Contenido de la Página -->
      <slot></slot>
  
      <!-- Pie de Página -->
      <footer class="pie-pagina">
        <div class="contenido-pie">
          <!-- Imagen a la derecha -->
          <div class="derecha-pie">
            <img src="https://www.anahuac.mx/oaxaca/sites/default/files/img/Inicial.png" alt="Logo Anáhuac">
          </div>
  
          <!-- Información de contacto -->
          <div class="contacto-pie">
            <button class="boton-pie" @click="abrirMapa" target="_blank">
              <strong>Dirección:</strong> Blvd. Guadalupe Hinojosa de Murat No. 1100.<br>San Raymundo Jalpan, Oaxaca C.P. 71248.
            </button>
            <p><strong>Teléfono:</strong> (951) 50-1-62-50<br>Lada sin costo: 800-737-26-24<br>E-mail: orientacionpsicologica.uao@anahuac.mx</p>
          </div>
  
          <!-- Enlaces a Aviso de Privacidad y Compendio Reglamentario como botones -->
          <div class="botones-pie">
            <button v-for="(enlace, texto) in enlacesPie" :key="texto" class="boton-pie" @click="abrirEnlace(enlace)">{{ texto }}</button>
          </div>
  
          <!-- Botones de redes sociales como botones -->
          <div class="botones-sociales-pie">
            <button v-for="(botonSocial, index) in botonesSociales" :key="index" class="boton-pie" @click="abrirEnlace(botonSocial.enlace)" target="_blank">
              <img :src="botonSocial.icono" alt="Icono de red social">
            </button>
          </div>
        </div>
      </footer>
    </div>
  </template>
  
  <script>
  export default {
    data() {
      return {
        mostrarMenu: false,
        botonesSociales: [
          { icono: 'https://www.anahuac.mx/oaxaca/sites/default/files/img/redFacebook_1.png', enlace: 'https://www.facebook.com/anahuacoaxaca/' },
          { icono: 'https://www.anahuac.mx/oaxaca/sites/default/files/img/redInstagram.png', enlace: 'https://www.instagram.com/anahuacoaxaca' },
          { icono: 'https://www.anahuac.mx/oaxaca/sites/default/files/img/redTwitter.png', enlace: 'https://twitter.com/anahuacoaxaca' },
          { icono: 'https://www.anahuac.mx/oaxaca/sites/default/files/img/redYoutube.png', enlace: 'https://www.youtube.com/channel/UCk5xAk91c-F_lNKn6ceDVZQ' },
        ],
        enlacesPie: {
          'Aviso de Privacidad': 'https://www.anahuac.mx/oaxaca/aviso-privacidad',
          'Compendio Reglamentario': 'https://www.anahuac.mx/oaxaca/compendio-reglamentario',
        },
      };
    },
    methods: {
      abrirMapa() {
        window.location.href = 'https://maps.app.goo.gl/te3G28WuD56cTgyHA';
      },
      abrirEnlace(url) {
        window.location.href = url;
      },
      toggleMenu() {
        this.mostrarMenu = !this.mostrarMenu;
      },
    },
  };
  </script>
  
  <style scoped>
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
  .hamburguesa {
    display: none; 
    cursor: pointer;
  }
  
  .linea {
    height: 3px;
    width: 25px;
    background-color: white;
    margin: 6px 0;
  }
  @media only screen and (max-width: 600px) {
   .hamburguesa {
      display: block; 
    }
    .secciones-navegacion {
      display: none; 
      flex-direction: column;
      background-color: black;
      position: absolute;
      top: 60px;
      left: 0;
      width: 100%;
      z-index: 1; 
    }
    .mostrar-menu {
      display: flex;
    }
    .enlace-navegacion {
      margin-right: 0;
      padding: 10px;
      text-align: center;
      color: white;
      text-decoration: none;
      transition: color 0.3s ease;
    }
    .enlace-navegacion:hover {
      color: #d45c37;
    }
    .boton-inicio-sesion {
      order: -1;
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
      left: 150px;
    }
    .logo img {
    max-height: 30px;
  }
  }
  @media (min-width: 769px) {
    .hamburguesa {
      display: none; 
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
  }
  .contenido-pagina {
    padding: 10px;
  }
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
  @media (max-width: 768px) {
    .contenido-pie {
      flex-direction: column; 
    }
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

  @media only screen and (max-width: 600px) {
    
  }
  </style>