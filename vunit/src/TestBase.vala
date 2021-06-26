[CCode (gir_namespace = "VUnit", gir_version = "0.1")]
namespace VUnit{


    public class TestBase : GLib.Object{

        public virtual void set_up() throws Error{
            return;
        }
        public virtual void tear_down() throws Error{
            return;
        }


    }

}
