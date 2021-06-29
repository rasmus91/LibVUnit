using VUnit;

namespace VUnit.Runner{

    internal class TestInfo : Object{

        internal GI.RegisteredTypeInfo registered_type { get; private set; }
        private Type object_type;

        internal Object instance { get; private set; }

        private TestSuite _test_suite;

        internal TestSuite test_suite { 
            get{
                return this._test_suite;
            } 
        }

        internal TestFixtureFunc set_up { get; private set;}
        internal TestFixtureFunc tear_down { get; private set;}
        internal Gee.List<GI.FunctionInfo> tests { get; private set; }

        internal TestInfo(GI.ObjectInfo info, string method_name_pattern = "test_[\\w\\d_]*"){
            this.registered_type = (GI.RegisteredTypeInfo)info;
            this.object_type = registered_type.get_g_type();
            this.object_type.ensure();
            this.instance = Object.new(this.object_type);
            this.register_fixture_functions(info);
            this.register_test_functions(info);
        }

        private void register_fixture_functions(GI.ObjectInfo objectInfo){

            var objArg = GI.Argument();
            objArg.v_pointer = (void*)this.instance;

            var setup = objectInfo.find_method("set_up");
            this.set_up = (v) => { setup.invoke({ objArg }, { }, GI.Argument()); };

            var teardown = objectInfo.find_method("tear_down");
            this.tear_down = (v) => { teardown.invoke({ objArg }, { }, GI.Argument()); };
        }

        private void register_test_functions(GI.ObjectInfo objectinfo, string method_name_pattern = "test_[\\w\\d_]*"){
            this.tests = new Gee.ArrayList<GI.FunctionInfo>();
            for (var i = 0; i < objectinfo.get_n_methods(); i++){
                var method = objectinfo.get_method(i);
                if(
                    method.get_flags() == GI.FunctionInfoFlags.IS_METHOD
                    && !Regex.match_simple("^set_up$|^tear_down$", method.get_name())
                    && Regex.match_simple(method_name_pattern, method.get_name())
                ){
                    this.tests.add(method);
                }
            }
        }

        internal TestSuite createTestSuite(){
            var suite = new TestSuite(this.registered_type.get_name());
            foreach (var test in this.tests){
                var objArg = GI.Argument();
                objArg.v_pointer = (void*)this.instance;

                suite.add(
                    new TestCase(
                        test.get_name(),
                        this.set_up,
                        (v) => { test.invoke({ objArg }, { }, GI.Argument()); },
                        this.tear_down
                    )
                );
            }
            return suite;
        }

    }

}
