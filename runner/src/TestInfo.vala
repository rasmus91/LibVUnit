

namespace VUnit.Runner{

    public class TestInfo : Object{

        public GI.ObjectInfo gi_info { get; private set; }
        public Type gtype { get; private set; }
        public Object instance { get; private set; }

        public static string method_pattern = "test_[\\w\\d_]*";
        private string current_method_pattern;

        private GI.FunctionInfo _set_up;
        public GI.FunctionInfo set_up { 
            get{
                if (this._set_up == null)
                    this._set_up = this.gi_info.find_method("set_up");
                return this._set_up;
            }
        }

        private GI.FunctionInfo _tear_down;
        public GI.FunctionInfo tear_down { 
            get{
                if (this._tear_down == null)
                    this._tear_down = this.gi_info.find_method("tear_down");
                return this._tear_down;
            }
        }

        private GI.FunctionInfo[] _tests;
        public GI.FunctionInfo[] tests { 
            get{
                if (_tests == null || this.current_method_pattern != method_pattern){
                    this._tests = this.discover_tests(method_pattern);
                    this.current_method_pattern = method_pattern;
                }
                return this._tests;
            }
        }

        public TestInfo(GI.ObjectInfo info){
            this.gi_info = info;
            this.gtype = ((GI.RegisteredTypeInfo)info).get_g_type();
            this.instance = Object.new(this.gtype);
        }

        private GI.FunctionInfo[] discover_tests(string method_pattern){
            var testMethods = new GI.FunctionInfo[1];
            for (var i = 0; i < this.gi_info.get_n_methods(); i++){
                var method = this.gi_info.get_method(i);
                if(
                    method.get_flags() != GI.FunctionInfoFlags.IS_CONSTRUCTOR
                    && method.get_flags() != GI.FunctionInfoFlags.IS_GETTER
                    && method.get_flags() != GI.FunctionInfoFlags.IS_SETTER
                    && !Regex.match_simple("^set_up$|^tear_down$", method.get_name())
                    && Regex.match_simple(method_pattern, method.get_name())
                ){
                    testMethods += method;
                }
            }

            return testMethods;
        }

        public void add_tests(string path_prefix = "/"){
            var setUp = this.set_up;
            var tearDown = this.tear_down;
            var objInstance = this.instance;

            foreach ( var test in this.tests){
                GLib.TestFunc delegateTest = () => {
                    var objArg = GI.Argument();
                    objArg.v_pointer = (void*)objInstance;

                    setUp.invoke({ objArg }, {}, GI.Argument());

                    test.invoke({ objArg }, {}, GI.Argument());

                    tearDown.invoke( {objArg }, {}, GI.Argument());
                };

                GLib.Test.add_func(
                    "%s%s/%s".printf(path_prefix, this.gi_info.get_namespace(), this.gi_info.get_name()),
                    delegateTest
                );
            }
        }

    }

}
