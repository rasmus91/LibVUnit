using VUnit;

namespace VunitTest{

    public class Sample : TestBase{

        construct{
            message("SampleConstruct");
        }

        public void set_up(){
            message("set_up called!");
        }

        public void tear_down(){
            message("tear_down called!");
        }

        public void test_sample(){
            message("test_sample called!");
        }

    }

}
