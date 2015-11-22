# foo = %W(AgeingAidsAnimal WelfareBird FluBSECoal PitsEUCountrysideCrimeDefenceDrug AbuseEconomyEducationFarmingGerman ReunificationGM foodsHousingInflation/PricesInner CitiesLocal GovtLow PayMoralityNHSNorthern IrelandNuclear PowerNuclear WeaponsPensionsFuel PricesEnvironmentThe PoundPoverty/InequalityPrivatisationPublic ServicesImmigrationScots/Welsh AssemblyTaxationTrade UnionsTransportTsunamiUnemploymen)

# p foo.size

# colors = ["#48A36D",  "#56AE7C",  "#64B98C", "#72C39B", "#80CEAA", "#80CCB3", "#7FC9BD", "#7FC7C6", "#7EC4CF", "#7FBBCF", "#7FB1CF", "#80A8CE", "#809ECE", "#8897CE", "#8F90CD", "#9788CD", "#9E81CC", "#AA81C5", "#B681BE", "#C280B7", "#CE80B0", "#D3779F", "#D76D8F", "#DC647E", "#E05A6D", "#E16167", "#E26962", "#E2705C", "#E37756", "#E38457", "#E39158", "#E29D58", "#E2AA59", "#E0B15B", "#DFB95C", "#DDC05E", "#DBC75F", "#E3CF6D", "#EAD67C", "#F2DE8A"]

# even_colors = colors.select.each_with_index{|c,i| i.odd?}

# p even_colors

# p colors.size

# cs = %w(Faxctom	unknown	Ascribe	Open Assets	Proof of Existence	Monegraph	Eternity Wall	BlockSign	Colu	Omni Layer	Stampery	Remembr	Bitproof	Blockstore	fooFactom CoinSpark	stampd)

# p cs.find_index{|e| e=~/Factom/}


# p cs.size

# p Time.at(1429690641).strftime "%Y-%m-%d %H:%M"

# h = (1..10).to_a.map{|e| 'ph_'+e.to_s}

# p h


# p h

# h.push('blarg')

# p h 
# a= ["#56AE7C", "#72C39B", "#80CCB3", "#7FC7C6", "#7FBBCF", "#80A8CE", "#8897CE", "#9788CD", "#AA81C5", "#C280B7", "#D3779F", "#DC647E", "#E16167", "#E2705C", "#E38457", "#E29D58", "#E0B15B", "#DDC05E", "#E3CF6D", "#F2DE8A"]

# p a.reverse

# p Time.at(1445443626)

a = (1..30).to_a.each_slice(3){|g| p g}