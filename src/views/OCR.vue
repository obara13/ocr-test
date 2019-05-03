<template>
  <div class="OCR">
    <input type="file" @change="fileUploaded($event)">
    <p>process: {{ocrProgress}}</p>
    <p>result: {{ocrResult}}</p>
    <p>error: {{ocrError}}</p>
    <img :src="imageData" v-if="imageData">
    <v-btn
      :loading="loading3"
      :disabled="loading3"
      @click="loader = 'loading3'"
    >
      Upload
      <v-icon right dark>cloud_upload</v-icon>
    </v-btn>
    					<v-text-field label="Select Image" @click='pickFile' v-model='imageName' prepend-icon='attach_file'></v-text-field>

    <input
						type="file"
						ref="image"
						accept="image/*"
						@change="onFilePicked"
					>
  </div>
</template>

<script>
import Tesseract from 'tesseract.js/dist/tesseract.js';
// import Tesseract from 'tesseract.ts'

export default {
  name: 'OCR',
  props: {
  },
  data() {
    return {
      ocrProgress: '',
      ocrError: '',
      ocrResult: '',
      imageData: '',
    };
  },
  methods: {
    fileUploaded(event) {
      const file = event.target.files[0];
      const reader = new FileReader();
      reader.onload = (e) => {
        this.imageData = e.target.result;
        Tesseract.recognize(this.imageData)
          .progress((message) => this.ocrProgress = message)
          // .catch(err => this.ocrError = err)
          .then((result) => this.ocrResult = result.text);
        };
      reader.readAsDataURL(file);
    },
  },
};
</script>
