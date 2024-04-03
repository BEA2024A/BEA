<template>
  <div class="login-container">
    <div class="background-image"></div>
    <div class="login-box" @mouseover="changeCursor">
      <div class="back-to-home" @click="goToHome">
        <span class="arrow">←</span>
        <span class="text">Correo Equivocado</span>
      </div>
      <img src="https://www.anahuac.mx/sites/default/files/LogoRUA_HUB_1.png" class="logo">
      <div class="content">
        <h3 class="title">Escribir Contraseña</h3>
        <div class="email-input">
          <input type="password" v-model="password" class="input-field" placeholder="Contraseña" @focus="hideBottomBorder" @blur="showBottomBorder">
          <div class="input-line"></div>
        </div>
      </div>
      <button @click="submit" class="submit-button">Iniciar Sesión</button>
    </div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      password: ''
    }
  },
  methods: {
    submit() {
      if (this.password === 'contraseña') {
        this.$router.push('/');
      } else {
        alert('Contraseña incorrecta');
      }
    },
    hideBottomBorder() {
      this.$refs.passwordInput.style.borderBottom = 'none';
    },
    showBottomBorder() {
      this.$refs.passwordInput.style.borderBottom = '2px solid blue';
    },
    changeCursor() {
      this.$refs.passwordInput.style.cursor = 'text';
    },
    goToHome() {
      this.$router.push('/iniciosesion');
    }
  }
}
</script>

<style scoped>
.login-container {
  position: relative;
  display: flex;
  justify-content: center;
  align-items: center;
  height: 100vh;
}

.background-image {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background-image: url("https://i.postimg.cc/RCgngn7k/fondo-sesion.png");
  background-size: cover;
  z-index: -1;
}

.login-box {
  background-color: rgb(255, 255, 255);
  padding: 40px;
  box-shadow: 0 0 10px rgba(0, 0, 0, 0.3);
  text-align: left;
  position: relative;
  width: 500px;
  height: 370px;
  display: flex;
  flex-direction: column;
  justify-content: center;
}

.logo {
  position: absolute;
  top: 30px;
  left: 30px;
  width: 150px;
  height: auto;
}

.title {
  font-size: 30px;
  margin-bottom: 20px;
  color:rgb(24, 23, 23)
}

.email-input {
  position: relative;
  margin-bottom: 20px;
}

.input-field {
  width: 100%;
  padding: 10px 0;
  border: none;
  border-bottom: 2px solid blue;
  background-color: transparent;
  font-size: 16px;
  outline: none;
}

.input-line {
  position: absolute;
  bottom: 0;
  left: 0;
  width: 100%;
  height: 2px;
  background-color:#0078d4;
}

.input-line:hover {
  background-color: grey;
}

.submit-button {
  display: inline-block;
  background-color: #0078d4;
  color: white;
  padding: 10px 20px;
  text-decoration: none;
  border-radius: 5px;
  margin-top: 20px;
  margin-bottom: 20px; 
}
.submit-button:hover {
  background-color: #005a9e;
}
.back-to-home {
  display: flex;
  align-items: center;
  cursor: pointer;
  color: grey;
}

.arrow {
  font-size: 20px;
  margin-right: 5px;
}

.text {
  font-size: 14px;
}
</style>
