public class Sancion
{
    public uint idSancion { get; set; }    
    public uint idBibliotecario { get; set; }    
    public uint idPrestamo { get; set; }    
    public DateTime fechaEmision { get; set; }
    public decimal multa { get; set; }
}