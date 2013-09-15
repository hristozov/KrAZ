module.exports = function (grunt) {
    grunt.loadNpmTasks('grunt-contrib-coffee');
    grunt.loadNpmTasks('grunt-jasmine-node');

    grunt.initConfig({
        coffee: {
            compile_source: {
                files: {
                    'target/main.js': 'src/main.coffee',
                    'target/sexp.js': 'src/sexp.coffee',
                    'target/translator.js': 'src/translator.coffee',
                    'target/parser.js': 'src/parser.coffee'
                }
            },
            compile_spec: {
                files: {
                    'target/spec/spec1.spec.js': 'spec/parser.spec.coffee'
                }
            }
        },
        jasmine_node: {
            specNameMatcher: [".spec"],
            projectRoot: "target/",
            requirejs: false,
            forceExit: true,
            jUnit: {
                report: false,
                savePath : "./build/reports/jasmine/",
                useDotNotation: true,
                consolidate: true
            }
        }
    });

    grunt.registerTask(
        'default', [
            'coffee:compile_source']);

    grunt.registerTask(
        'test', [
            'coffee:compile_source', 'coffee:compile_spec', 'jasmine_node']);
}