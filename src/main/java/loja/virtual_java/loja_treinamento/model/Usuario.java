package loja.virtual_java.loja_treinamento.model;

import java.util.Collection;
import java.util.Date;
import java.util.List;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import jakarta.persistence.*;

@Entity
@Table(name = "usuario")
@SequenceGenerator(name = "usuario_seq", sequenceName = "usuario_seq", allocationSize = 1, initialValue = 1)

public class Usuario implements UserDetails{

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "usuario_seq")
    private Long id;

    @Column(name = "login", nullable = false)
    private String login;

    @Column(name = "senha", nullable = false)
    private String senha;

    @Column(name = "data_atual_senha", nullable = false)
    @Temporal(TemporalType.DATE)
    private Date dataAtualSenha;

    @ManyToOne(targetEntity = Pessoa.class)
    @JoinColumn(name = "id_pessoa", nullable = false, foreignKey = @ForeignKey(value = ConstraintMode.CONSTRAINT, name = "fk_nota_fiscal_compra_pessoa"))
    private Pessoa pessoa;

    @OneToMany(fetch = FetchType.LAZY)
    @JoinTable(name = "usuario_acesso", uniqueConstraints = @UniqueConstraint(columnNames = {"usuario_id", "acesso_id"},
            name = "unique_usuario_acesso"),
            joinColumns = @JoinColumn(name = "usuario_id", referencedColumnName = "id", table = "usuario", unique = false,
            foreignKey = @ForeignKey(name = "fk_usuario_acesso_usuario", value = ConstraintMode.CONSTRAINT)),
            inverseJoinColumns = @JoinColumn(name = "acesso_id", referencedColumnName = "id", table = "acesso", unique = false,
            foreignKey = @ForeignKey(name = "fk_usuario_acesso_acesso", value = ConstraintMode.CONSTRAINT)))
    private List<Acesso> acessos;

    public void setPessoa(Pessoa pessoa) {
		this.pessoa = pessoa;
	}
	
	public Pessoa getPessoa() {
		return pessoa;
	}


    /*Autoridade = São os acessos, ou seja ROLE_ADMIN, ROLE_SECRETARIO, ROLE_FINANCEIRO etc*/
    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
       return this.acessos;
    }

    @Override
    public String getPassword() {
       return this.senha;
    }

    @Override
    public String getUsername() {
       return this.login;
    }
    @Override
    public boolean isAccountNonExpired() {
        return true;
    }
    @Override
    public boolean isAccountNonLocked() {
        return true;
    }
    @Override
    public boolean isCredentialsNonExpired() {
        return true;
    }
    @Override
    public boolean isEnabled() {
        return true;
    }

    
}
