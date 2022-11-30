namespace System.Runtime.Versioning {

    public class TargetFrameworkAttributeAttribute : System.Attribute {
        
        public string FrameworkName { get; set; }

        public string FrameworkDisplayName { get; set; }
        
        public TargetFrameworkAttributeAttribute(string frameworkName) {
            this.FrameworkName = frameworkName;
        }

    }

}