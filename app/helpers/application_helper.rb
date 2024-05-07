module ApplicationHelper
  def with_variant(new_variant, &block)
    old_variants = lookup_context.variants

    begin
      lookup_context.variants = [new_variant]
      return block.call
    ensure
      lookup_context.variants = old_variants
    end
  end
end
