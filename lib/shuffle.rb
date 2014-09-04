require "rand"

class Shuffle
  PREFIXES = {
    "mono" => 1,
    "di"   => 2,
    "tri"  => 3,
    "quad" => 4
  }
  
  attr_reader :sequence, :rejoin
  
  def initialize(sequence)
    @sequence = if sequence.is_a?(String) && sequence !~ /\s/
      @rejoin = true
      sequence.split(//)
    else
      sequence
    end
  end
  
  def shuffle(size = 1)
    shuffled_sequence = sequence.length > 1 ? shuffler(size) : sequence
    
    rejoin ? shuffled_sequence.join : shuffled_sequence
  end
  
  def valid?(other_sequence, size)
    split_other_sequence = other_sequence.is_a?(String) && sequence !~ /\s/ ? other_sequence.split(//) : other_sequence
    
    frequency(sequence.each_cons(size)) == frequency(split_other_sequence.each_cons(size))
  end
  
  def validate_random(size)
    valid?(shuffler(size), size)
  end
  
  private
  
  def shuffler(size)
    if size == 1
      sequence.shuffle
    else
      edge_hash = shuffle!(edge_list(size))
      shuffle!(edge_hash) until connected?(last_edge_graph(edge_hash, size), size)
      construct_from(edge_hash, size)
    end
  end
  
  def start(size)
    sequence[0, size - 1]
  end
  
  def terminal(size)
    sequence[(-(size - 1))..-1]
  end
  
  def edge_list(size)
    sequence.each_cons(size).inject(Hash.new { |hash, key| hash[key] = [] }) do |hash, subsequence|
      hash.tap { hash[subsequence[0..-2]] << subsequence }
    end
  end
  
  def shuffle!(edge_hash)
    edge_hash.tap { edge_hash.values.map(&:shuffle!) }
  end
  
  def last_edge_graph(edge_hash, size)
    edge_hash.reject { |token, edges| token == terminal(size) }.values.map(&:last)
  end
  
  def connected?(edges, size)
    terminal          = terminal(size)
    vertex_terminates = edges.map { |edge| edge[0..-2] }.inject({}) { |hash, v| hash.tap { hash[v] = false } }
    queue             = edges.select { |edge| edge[1..-1] == terminal }
  
    until queue.empty?
      edge = queue.pop
      
      if vertex_terminates[edge[0..-2]] = vertex_terminates[edge[1..-1]] || edge[1..-1] == terminal
        queue.push(*edges.select { |queueable_edge| queueable_edge[1..-1] == edge[0..-2] })
      end
    end
  
    vertex_terminates.values.all?
  end
  
  def construct_from(edge_hash, size)
    shuffled_sequence = edge_hash[start(size)].shift
    
    until edge_hash.values.flatten.empty?
      shuffled_sequence.concat(edge_hash[shuffled_sequence[-(size - 1)..-1]].shift[-1, 1])
    end
    
    shuffled_sequence
  end
  
  def frequency(array)
    array.inject(Hash.new { |hash, key| hash[key] = 0 }) { |hash, token| hash.tap { hash[token] += 1 } }
  end
  
  def method_missing(name, *args, &block)
    if size = PREFIXES[name.to_s.match(/^(\w+)shuffle$/)[1]]
      shuffle(size.to_i)
    else
      super
    end
  end
end