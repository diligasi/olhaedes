# Department ========================================================================================
department = { name: 'Secretaria Municipal de Saúde de Niterói', description: 'www.saude.niteroi.rj.gov.br - Rua Visconde de Sepetiba, 987, 8° andar - Niterói - Tel: (21) 2716-5800 - Designer: C. S. Rodrigues' }
current_department = Department.find_or_create_by(department)

# Regions ============================================================================================
[
  { name: '1A', department: current_department },
  { name: '1B', department: current_department },
  { name: '2A', department: current_department },
  { name: '2B', department: current_department },
  { name: '3A', department: current_department }
].each do |region|
  Region.find_or_create_by(region)
end

# PropertyTypes ======================================================================================
[
  { name: 'Residência', description: 'Moradia fixa em determinado lugar; casa, apartamento.' },
  { name: 'Terreno Baldio', description: 'Terreno abandonado ou sem dono.' },
  { name: 'Comércio', description: 'Estabelecimento comercial seja ele para a venda de produtos físicos ou serviços.' },
  { name: 'Ponto Estratégico', description: '' },
  { name: 'Outros', description: '' }
].each do |property_type|
  PropertyType.find_or_create_by(property_type)
end

# ShedTypes ==========================================================================================
[
  { name: "CX D'água", description: 'Tanque destinado a armazenar água para consumo humano, agrícola ou qualquer outra função que requeira o uso da mesma.' },
  { name: 'Depósito Fixo', description: '' },
  { name: 'Depósito Natural', description: '' },
  { name: 'Dep. Pequeno', description: '' },
  { name: 'Lixo (depositos)', description: '' },
  { name: 'Nível Solo', description: '' },
  { name: 'Pneus', description: '' }
].each do |shed_type|
  ShedType.find_or_create_by(shed_type)
end

# LarvaSpecies =======================================================================================
[
  { name: 'Aedes aegypti', description: '' },
  { name: 'Aedes albopictus', description: '' },
  { name: 'Anopheles aquasalis', description: '' },
  { name: 'Culex quinquefasciatus', description: '' },
  { name: 'Outras', description: '' }
].each do |larva_specy|
  LarvaSpecies.find_or_create_by(larva_specy)
end
