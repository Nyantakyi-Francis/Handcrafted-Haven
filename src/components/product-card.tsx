import type { Product } from "@/data/marketplace";
import { formatPrice, getAverageRating, getSellerById, getStars } from "@/data/marketplace";
import Link from "next/link";

type ProductCardProps = {
  product: Product;
};

export function ProductCard({ product }: ProductCardProps) {
  const seller = getSellerById(product.sellerId);
  const average = getAverageRating(product.id);

  return (
    <article className="card" aria-label={`Product ${product.title}`}>
      <div className="card-media" style={{ padding: 0, overflow: 'hidden', height: '200px' }}>
        <img
          src={product.imageUrl}
          alt={product.title}
          style={{ width: '100%', height: '100%', objectFit: 'cover', transition: 'transform 0.3s' }}
          className="hover-zoom"
        />
      </div>
      <div className="card-body">
        <span className="badge">{product.category}</span>
        <h3 className="card-title">{product.title}</h3>
        <p className="card-meta">by {seller?.name ?? "Seller"}</p>
        <div className="price-and-rating">
          <span className="price">{formatPrice(product.price)}</span>
          <span className="rating" aria-label={`Rating ${average} out of 5`}>
            <span className="stars" aria-hidden="true">
              {getStars(average || 4)}
            </span>{" "}
            {average || "New"}
          </span>
        </div>
        <Link className="btn-secondary" href={`/products/${product.id}`}>
          View details
        </Link>
      </div>
    </article>
  );
}