public class Libro
{
    public uint ISBN { get; set; }    
    public uint idAutor { get; set; }    
    public uint? idOtroAutor { get; set; }      
    public byte idGenero { get; set; }    
    public string titulo { get; set; }
    public DateTime publicacion { get; set; }
    public decimal calificacion { get; set; }
    public bool disponible { get; set; }
}