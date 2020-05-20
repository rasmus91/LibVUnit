using VUnit;
using GI;

namespace VUnit.Runner{

    errordomain RunnerError{
        NAMESPACE_NOT_SPECIFIED,
        TYPELIB_NOT_FOUND,
        SHARED_LIB_NOT_FOUND,
    }

    public class TestRunner : Object{

        internal HashTable<string, Option> options;
        internal Repository repository;


        public static int main(string[] args){
            var runner = new TestRunner();
            string test_namespace = null;
            string? path = runner.get_path(args);

            //Get namespace and path from args
            try{
                test_namespace = runner.get_namespace(args);
            }catch(RunnerError.NAMESPACE_NOT_SPECIFIED err){
                stdout.printf("A namespace for the test runner to work with need to be specified by using: \n    -n <namespace>\n    --namespace <namespace>\n");
                return 1;
            }

            //Firstly, 'require' (load) the library in question, if path is set, do a private require
            if(path == null){
                try{
                    runner.repository.require(test_namespace, null, 0);
                }catch(Error err){
                    stdout.printf("\nFailed to load namespace: %s, error message is: %s\n", test_namespace, err.message);
                    return 2;
                }
            }else{
                try{
                    message("Trying to find: %s, in: %s".printf(test_namespace, path));
                    runner.repository.require_private(path, test_namespace, null, 0);
                }catch(Error err){
                    stdout.printf("\nFailed to load namespace: %s, with Typelib in: %s, error was: %s\n", test_namespace, path, err.message);
                    return 2;
                }
            }
            //discover all classes based on VUnit.TestBase
            


            //add all methods in each of the discovered classes with name matching (test_*|fact_*|theory_*) to tests

            //run all unit tests

            return 0;
        }

        construct{
            this.repository = Repository.get_default();
            this.options = new HashTable<string, Option>(
                (key) => { return key.hash(); }, 
                (a, b) => {return a == b; });

            this.options.@set("namespace", new Option(
                {"-n", "--namespace"},
                "The namespace containing the unit tests, this should be part of a shared library"
            ));

            this.options.@set("path", new Option(
                {"-p", "--path"},
                "The path containing the typelib, if not set, this will default to the PATH, where shared libraries are also found",
                true
            ));
        }


        private string? get_argument(string option_name, string[] args){
            var option = options.@get(option_name);

            if(option != null){
                var pattern = string.joinv("|", option.syntax);
                MatchInfo match;
                Regex rex = new Regex(pattern);
                for(var i = 1; i < args.length; i++){
                    if(rex.match(args[i], 0, out match)){
                        string? result = i + 1 < args.length ? args[i+1] : null;
                        return result;
                    }
                }

            }

            return null;
        }

        private string get_namespace(string[] args) throws RunnerError{
            var val = get_argument("namespace", args);
            if(val == null){
                throw new RunnerError.NAMESPACE_NOT_SPECIFIED("test 1.2.3..");
            }
            return (string)val;
        }

        private string? get_path(string[] args){
            return get_argument("path", args);
        }

        private Type[] get_test_classes(string test_namespace){
            typeof(TestBase);
            Gee.List<Type> test_suites = new Gee.ArrayList<Type>();
            for(var i = 0; i < this.repository.get_n_infos(test_namespace); i++){
                
            }
            Type[] test_types = new Type[1];

            return test_types;
        }


    }

}
