public class Sancion
{
    public uint IdSancion { get; set; }    
    public uint IdBibliotecario { get; set; }    
    public uint IdPrestamo { get; set; }    
    public DateTime FechaEmision { get; set; }
    public decimal Multa { get; set; }
}

