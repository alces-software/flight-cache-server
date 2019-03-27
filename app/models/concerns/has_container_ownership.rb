
class HasContainerOwnership < Module
  OwnershipStruct = Struct.new(:containers) do
    def blobs
      Blob.where(container: containers)
    end
  end

  def initialize(method)
    super() do
      define_method(:owns) do
        OwnershipStruct.new(self.public_send(method))
      end
    end
  end
end
