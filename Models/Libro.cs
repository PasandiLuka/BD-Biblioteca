public class Libro
{
    public uint ISBN { get; set; }    
    public uint IdAutor { get; set; }    
    public uint? IdOtroAutor { get; set; }      
    public byte IdGenero { get; set; }    
    public string Titulo { get; set; }
    public DateTime Publicacion { get; set; }
    public decimal Calificacion { get; set; }
    public bool Disponible { get; set; }
}

