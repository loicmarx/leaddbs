function ea_init_coregmrpopup(handles,refine)
if ~exist('refine','var')
    refine=0;
end

    cmethods={'Coreg MRIs: SPM',...
        'Coreg MRIs: FSL',...
        'Coreg MRIs: ANTs',...
        'Coreg MRIs: BRAINSFIT',...
        'Coreg MRIs: Hybrid SPM & ANTs',...
        'Coreg MRIs: Hybrid SPM & FSL',...
        'Coreg MRIs: Hybrid SPM & BRAINSFIT',...
        'Do not coregister MRIs (already coregistered)'};
set(handles.coregmrpopup,'String',cmethods)
set(handles.coregmrpopup,'Value',1); % default SPM
