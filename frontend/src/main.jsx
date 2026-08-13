import React from 'react'
import ReactDOM from 'react-dom/client'
import axios from 'axios'
import './style.css'

const API = import.meta.env.VITE_API_URL || '/api'

function App() {
  const [products, setProducts] = React.useState([])
  const [cart, setCart] = React.useState([])

  React.useEffect(() => {
    axios.get(`${API}/products`)
      .then(res => setProducts(res.data))
      .catch(err => console.error(err))
  }, [])

  const addToCart = (product) => {
    setCart([...cart, product])
  }

  return (
    <div>
      <header>
        <div>
          <h1>CloudCart</h1>
          <p>Cloud-native E-Commerce</p>
        </div>
        <div className="cart">Cart: {cart.length}</div>
      </header>

      <main>
        <section className="hero">
          <h2>Products</h2>
          <p>Products are loaded from the Spring Boot API and MySQL database.</p>
        </section>

        <section className="grid">
          {products.map(product => (
            <article className="card" key={product.id}>
              <div className="icon">🛒</div>
              <h3>{product.name}</h3>
              <p>{product.description}</p>
              <strong>₹{product.price}</strong>
              <p>Stock: {product.stock}</p>
              <button onClick={() => addToCart(product)}>Add to cart</button>
            </article>
          ))}
        </section>
      </main>
    </div>
  )
}

ReactDOM.createRoot(document.getElementById('root')).render(<App />)
