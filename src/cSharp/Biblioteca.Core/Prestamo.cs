public class Prestamo
{
    public uint idPrestamo { get; set; }    
    public uint idBibliotecario { get; set; }    
    public uint ISBN { get; set; }    
    public uint DNI { get; set; }    
    public DateTime fechaEntrega { get; set; }
    public DateTime fechaDevolucion { get; set; }
    public bool devuelto { get; set; }
}