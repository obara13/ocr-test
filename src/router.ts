import Vue from 'vue';
import Router from 'vue-router';
import OCR from './views/OCR.vue';

Vue.use(Router);

export default new Router({
  mode: 'history',
  base: process.env.BASE_URL,
  routes: [
    {
      path: '/',
      name: 'ocr',
      component: OCR,
    },
  ],
});
