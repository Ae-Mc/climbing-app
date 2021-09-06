import { extend } from "vee-validate";
import { required } from "vee-validate/dist/rules";

extend("required", { ...required, message: "{_field_} не может быть пустым" });
extend("requiredMany", { ...required, message: "{_field_} не могут быть пустыми" });
extend("requiredWomanSex", { ...required, message: "{_field_} не может быть пустой" });

extend(
  "size50MB",
  {
    validate: (files: File[]) => files.map(x => x.size).reduce((prev, cur) => prev + cur) < 50000000,
    message: 'Суммарный размер файлов не должен превышать 50MB'
  }
);