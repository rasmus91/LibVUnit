using VUnit;

namespace VunitTest{

    public class SampleTest : TestBase{

        public string info = "not initialized!";

        construct{
            message("SampleTestConstruct");
        }

        public void set_up() throws Error{
            message("set_up called!");
            this.info = "Initialized!";
        }

        public void tear_down() throws Error{
            message("tear_down called!");
            this.info = "Not Initialized!";
        }

        public void test_sample() throws Error{
            message("test_sample called!");
            message(this.info);
            assert( 1 == 1);
        }

    }

}
