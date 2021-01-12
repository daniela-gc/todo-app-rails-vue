module.exports = {
  purge: ["./public/**/*.html", "./src/**/*.{vue,js,ts,jsx,tsx}"],
  darkMode: false, // or 'media' or 'class'
  theme: {
    fontFamily: {
      sans: ["Open Sans", "ui-sans-serif", "system-ui"],
      headings: ["Dosis", "ui-serif", "Georgia"]
    },
    customForms: () => ({
      default: {
        select: {
          icon:
            '<svg fill="#e2e8f0" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg"><path d="M9.293 12.95l.707.707L15.657 8l-1.414-1.414L10 10.828 5.757 6.586 4.343 8z"/></svg>'
        },
        checkbox: {
          icon:
            '<svg fill="#fff" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg" ><path d="M0 11l2-2 5 5L18 3l2 2L7 18z"/></svg>'
        },
        radio: {
          icon:
            '<svg fill="#fff" viewBox="0 0 16 16" xmlns="http://www.w3.org/2000/svg"><circle cx="8" cy="8" r="3"/></svg>'
        }
      }
    })
  },
  variants: {
    extend: {}
  },
  plugins: [require("@tailwindcss/forms")]
};
