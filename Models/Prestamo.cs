public class Prestamo
{
    public uint IdPrestamo { get; set; }    
    public uint IdBibliotecario { get; set; }    
    public uint ISBN { get; set; }    
    public uint DNI { get; set; }    
    public DateTime FechaEntrega { get; set; }
    public DateTime FechaDevolucion { get; set; }
    public bool Devuelto { get; set; }
}


