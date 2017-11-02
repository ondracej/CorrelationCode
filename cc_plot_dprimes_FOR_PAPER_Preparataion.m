function [] = cc_plot_dprimes_FOR_PAPER_Preparataion()

d = load('/home/janie/Documents/INI/CorrPaperVersions/CorrPaperNew/Data/PopulationData/Population-106Neurons/FiringRate_Bout/dprimes106-cells/Dprimes.mat');
saveDir = '/home/janie/Documents/INI/CorrPaperVersions/CorrPaperNew/Data/PopulationData/Population-106Neurons/FiringRate_Bout/dprimes106-cells/';

%stim_set = [1 6 7 8 12];
stim_set = [1 6 7 8];
stim_size = size(stim_set, 2);
 total_num_cells = size(d.All_stim_FR_vector{1, stim_set(1)}, 1);
 
 
    for c = 1:total_num_cells
        
        for u = 1: stim_size
            this_stim1 = stim_set(u);
            
            this_cell_resp_mean1 = nanmean(d.All_stim_FR_vector{1, this_stim1}{c});
            this_cell_resp_std1 = nanstd(d.All_stim_FR_vector{1, this_stim1}{c});
            
            for v = 1: stim_size
                
            this_stim2 = stim_set(v);
            
            this_cell_resp_mean2 = nanmean(d.All_stim_FR_vector{1, this_stim2}{c});
            this_cell_resp_std2 = nanstd(d.All_stim_FR_vector{1, this_stim2}{c});
            
                this_d_prime(u,v) = roundn(2 * (this_cell_resp_mean1 - this_cell_resp_mean2) / sqrt(this_cell_resp_std1^2 + this_cell_resp_std2^2), -2);
                
            end
        end
        
        dprime_per_cell{c} = this_d_prime;
    end
    
    
    for p = 1: numel(dprime_per_cell)
    
        thisDPrime = dprime_per_cell{p};
        
        
        D.WN_REV(p) = thisDPrime(1, 2);
        D.WN_CON(p) = thisDPrime(1, 3);
        D.WN_BOS(p) = thisDPrime(1, 4);
        
        D.REV_WN(p) = thisDPrime(2, 1);
        D.REV_CON(p) = thisDPrime(2, 3);
        D.REV_BOS(p) = thisDPrime(2, 4);
        
        D.CON_WN(p) = thisDPrime(3, 1);
        D.CON_REV(p) = thisDPrime(3, 2);
        D.CON_BOS(p) = thisDPrime(3, 4);
        
        D.BOS_WN(p) = thisDPrime(4, 1);
        D.BOS_REV(p) = thisDPrime(4, 2);
        D.BOS_CON(p) = thisDPrime(4, 3);
    end
    
    disp('')
    
    save([saveDir 'DPrimes.mat'], 'D')
    %% average d prime over all individual cells for each threshold
    
    for u = 1: stim_size
        
        for v = 1: stim_size
            
             cell_stim_combo_dprime = [];
            for i = 1:total_num_cells
                
                cell_stim_combo_dprime(i) = dprime_per_cell{1, i}(u, v);
            end
            
            mean_dprime_over_cells(u, v) = nanmean(cell_stim_combo_dprime);
            std_dprime_over_cells(u, v) = nanstd(cell_stim_combo_dprime);
            sem_dprime_over_cells(u, v) = (nanstd(cell_stim_combo_dprime))/(sqrt(numel(cell_stim_combo_dprime)));
            
        end
    end
   
    BOS_CON = mean_dprime_over_cells(3, 2);
    CON_BOS = mean_dprime_over_cells(2, 3);
    
    BOS_CON_sem = sem_dprime_over_cells(3, 2);
    CON_BOS_sem = sem_dprime_over_cells(2, 3);
    
    BOS_REV = mean_dprime_over_cells(3, 1);
    REV_BOS = mean_dprime_over_cells(1, 3);
    
    BOS_REV_sem = sem_dprime_over_cells(3, 1);
    REV_BOS_sem = sem_dprime_over_cells(1, 3);
    
   subplot(2, 1, 1)
 barweb([BOS_CON; CON_BOS]', [BOS_CON_sem; CON_BOS_sem]', 1, []);
 legend('BOS-CON', 'CON-BOS') 
ylim([-3 3])
 
subplot(2, 1, 2)
 barweb([BOS_REV ;REV_BOS]', [BOS_REV_sem ;REV_BOS_sem]',  1, []);
legend('BOS-REV', 'REV-BOS') 
ylim([-3 3])
colormap (gray)

save_dir = '/home/janie/Dropbox/Theses/JaniesThesisStuff/Figs-Corel/CH7/';

save_name = [save_dir 'dprime-mydata'];
  pos = [2.5 2.5 5 30];
    print_in_A4(0, save_name, '-depsc', 0, pos);


end