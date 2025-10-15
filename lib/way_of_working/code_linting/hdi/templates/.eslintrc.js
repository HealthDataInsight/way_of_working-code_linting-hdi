module.exports = {
  extends: ['standard'],
  plugins: ['cypress', 'jasmine'],
  overrides: [
    {
      // Cypress test files
      files: ['**/*.cy.js'],
      env: {
        'cypress/globals': true
      }
    },
    {
      // Jasmine test files
      files: ['**/*_spec.js'],
      env: {
        jasmine: true
      }
    }
  ]
}
