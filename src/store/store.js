import { createStore } from 'vuex';
import VuexPersistence from 'vuex-persist';

// Crea una instancia de VuexPersistence configurada para usar el almacenamiento local
const vuexLocal = new VuexPersistence({
  storage: window.localStorage,
  reducer: (state) => ({ usuario: state.usuario }), 
});

export default createStore({
  state: {
    usuario: null, // Aquí almacenas la información del usuario
  },
  mutations: {
    setUsuario(state, { nombre, correo, id, a_paterno, a_materno }) {
      state.usuario = { nombre, correo, id, a_paterno, a_materno };
    },
    clearUsuario(state) {
      state.usuario = null;
    },
  },
  actions: {
    iniciarSesion({ commit }, { nombre, correo, id, a_paterno, a_materno }) {
      commit('setUsuario', { nombre, correo, id, a_paterno, a_materno });
    },
    
    cerrarSesion({ commit }) {
      commit('clearUsuario');
    },
  },
  getters: {
    usuario: (state) => state.usuario,
    isUsuarioLogueado: (state) => !!state.usuario,
  },
  plugins: [vuexLocal.plugin], 
});
