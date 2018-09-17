# Genome-wide-hitchhiking
Simulatation details for KONE applicaiton
# Code used for proof of concept

# Run to create population in mutaion drift equilibrium
./quantinemo marine_ancestor_forw2.ini --patch_number 10 --patch_capaity 100 --dispersal_rate 0.01 --generations 1000 --ntrl_genot_logtime 1000 --ntrl_ini_genotypes "./ancestral_coal/simulation_g10000.dat" --folder "ancestral_forw"

# Now simulate 100 generations of selection, 100 replicates each with h2=1
./quantinemo Ne_LD_unlinked.ini --folder selection_met_1 --quanti_selection_model 1 --quanti_stab_sel_optima 10 --quanti_stab_sel_intensity 0.5 --ntrl_ini_genotypes "ancestral_forw/simulation_g1000.dat" --patch_number 10 --patch_capacity 100 --dispersal_rate 0.01 --quanti_environmental_model 1 --quanti_heritability 1 --replicates 100
# With h2=0.8
./quantinemo Ne_LD_unlinked.ini --folder selection_met_0.8 --quanti_selection_model 1 --quanti_stab_sel_optima 10 --quanti_stab_sel_intensity 0.5 --ntrl_ini_genotypes "ancestral_forw/simulation_g1000.dat" --patch_number 10 --patch_capacity 100 --dispersal_rate 0.01 --quanti_environmental_model 1 --quanti_heritability 0.8 --replicates 100
# With h2=0.5
./quantinemo Ne_LD_unlinked.ini --folder selection_met_0.5 --quanti_selection_model 1 --quanti_stab_sel_optima 10 --quanti_stab_sel_intensity 0.5 --ntrl_ini_genotypes "ancestral_forw/simulation_g1000.dat" --patch_number 10 --patch_capacity 100 --dispersal_rate 0.01 --quanti_environmental_model 1 --quanti_heritability 0.5 --replicates 100
# With h2=0.001
./quantinemo Ne_LD_unlinked.ini --folder selection_met_0.001 --quanti_selection_model 1 --quanti_stab_sel_optima 10 --quanti_stab_sel_intensity 0.5 --ntrl_ini_genotypes "ancestral_forw/simulation_g1000.dat" --patch_number 10 --patch_capacity 100 --dispersal_rate 0.01 --quanti_environmental_model 1 --quanti_heritability 0.001 --replicates 100

# Print output with code in Figure.R
Rscript Figure1.R

# Summary of simulation details can be found in simulaton log files for each run in folder quantinemo
