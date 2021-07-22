import { extend } from "vee-validate";
import { required } from "vee-validate/dist/rules";

extend("required", { ...required, message: "{_field_} не может быть пустым" });
extend("requiredMany", { ...required, message: "{_field_} не могут быть пустыми" });
extend("requiredWomanSex", { ...required, message: "{_field_} не может быть пустой" });