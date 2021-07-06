
namespace VUnit.Runner{

    internal class TestCaseInfo : Object{

        internal weak TestSuiteInfo parent { get; private set; }
        internal TestFixtureFunc test;
        private GI.FunctionInfo _test_method;
        internal GI.FunctionInfo test_method {
            get{
                return this._test_method;
            }
        }
        internal string method_name {
            get{
                return this.test_method.get_name();
            }
        }

        internal TestCaseInfo (string method_name, TestSuiteInfo parent){
            this.parent = parent;
            this.configure_delegate(method_name);

        }

        private void configure_delegate(string method_name){
            var objArg = GI.Argument();
            objArg.v_pointer = (void*)this.parent.instance;

            var method = ((GI.ObjectInfo)this.parent.registered_type).find_method(method_name);

            this._test_method = method;

            this.test = (v) => {
                message("pre-test");
                method.invoke({ objArg }, {}, GI.Argument());
                message("post-test");
            };

        }

        internal TestCase create_test_case(){
            return new TestCase(
                this.test_method.get_name(),
                this.parent.set_up,
                this.test,
                this.parent.tear_down
            );
        }

    }

}
