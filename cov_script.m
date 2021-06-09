

%%
if 1
    clear; clc; close all; 
    scrSize = get(0,'Screensize'); format compact;
    
    filename = 'covEurope.csv';
    spdir = date;
    mkdir(spdir);
    
    %   column1: iso_code (%q)
    iso_code = 1;
    %	column2: continent (%q)
    continent = 2;
    %   column3: location (%q)
    location = 3;
    %	column4: date (%q)
    dates = 4;
    %   column5: total_cases (%f)
    total_cases = 5;
    %	column6: new_cases (%f)
    new_cases = 6; 
    %   column7: new_cases_smoothed (%f)
    new_cases_smoothed = 7;
    %	column8: total_deaths (%f)
    total_deaths = 8;
    %   column9: new_deaths (%f)
    new_deaths = 9;
    %	column10: new_deaths_smoothed (%f)
    new_deaths_smoothed = 10;
    %   column11: total_cases_per_million (%f)
    total_cases_per_million = 11;
    %	column12: new_cases_per_million (%f)
    new_cases_per_million = 12;
    %   column13: new_cases_smoothed_per_million (%f)
    new_cases_smoothed_per_million = 13;
    %	column14: total_deaths_per_million (%f)
    total_deaths_per_million = 14;
    %   column15: new_deaths_per_million (%f)
    new_deaths_per_million = 15;
    %	column16: new_deaths_smoothed_per_million (%f)
    new_deaths_smoothed_per_million = 16;
    %   column17: double (%f)
    new_tests = 17;
    %	column18: double (%f)
    total_tests = 18;
    %   column19: double (%f)
    total_tests_per_thousands = 19;
    %	column20: double (%f)
    new_tests_per_thousands = 20;
    %   column21: double (%f)
    new_tests_smoothed = 21;
    %	column22: double (%f)
    new_tests_smoothed_per_thousands = 22;
    %   column23: double (%f)
    positive_rate = 23;
    %	column24: double (%f)
    tests_per_case = 24;
    %   column25: text (%q)
    total_vaccinations = 25;
    %	column26: text (%q)
    people_vaccinated = 26;
    %   column27: text (%q)
    people_fully_vaccinated = 27;
    %	column28: text (%q)
    new_vaccinations = 28;
    %   column29: text (%q)
    new_vaccinations_smoothed = 29;
    %	column30: text (%q)
    total_vaccinations_per_hundred = 30;
    %   column31: text (%q)
    people_vaccinated_per_hundred = 31;
    %	column32: text (%q)
    people_fully_vaccinated_per_hundred = 32;
    %   column33: text (%q)
    new_vaccinations_smoothed_per_million = 33;
    %	column34: text (%q)
    fff = 34;
    %   column35: text (%q)
    population = 35;
    
    delimiter = ',';
    startRow = 2;
    formatSpec = '%q%q%q%q%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%q%q%q%q%q%q%q%q%q%q%q%[^\n\r]';
    fileID = fopen(filename,'r');
    dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'TextType', 'string', 'EmptyValue', NaN, 'HeaderLines' ,startRow-1, 'ReturnOnError', false, 'EndOfLine', '\r\n');
    fclose(fileID);
    dataArray([5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24]) = cellfun(@(x) num2cell(x), dataArray([5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24]), 'UniformOutput', false);
    dataArray([1, 2, 3, 4, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35]) = cellfun(@(x) mat2cell(x, ones(length(x), 1)), dataArray([1, 2, 3, 4, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35]), 'UniformOutput', false);
    covEurope = [dataArray{1:end-1}];
    clearvars filename delimiter startRow formatSpec fileID dataArray ans;
end
%%

% ID country, name, population
countries_all = [...
    {1}, {'Albania'}, {};...
    {2}, {'Austria'}, {};...
    {3}, {'Andorra'}, {};...
    {4}, {'Belarus'}, {};...
    {5}, {'Belgium'}, {};...
    {6}, {'Bosnia and Herzegovina'}, {};...
    {7}, {'Bulgaria'}, {};...
    {8}, {'Croatia'}, {};...
    {9}, {'Cyprus'}, {};...
    {10}, {'Czechia'}, {};...
    {11}, {'Denmark'}, {};...
    {12}, {'Estonia'}, {};...
    {13}, {'Finland'}, {};...
    {14}, {'France'}, {};...
    {15}, {'Germany'}, {};...
    {16}, {'Greece'}, {};...
    {17}, {'Hungary'}, {};...
    {18}, {'Iceland'}, {};...
    {19}, {'Ireland'}, {};...
    {20}, {'Italy'}, {};...
    {21}, {'Kosovo'}, {};...
    {22}, {'Latvia'}, {};...
    {23}, {'Liechtenstein'}, {};...
    {24}, {'Lithuania'}, {};...
    {25}, {'Luxembourg'}, {};...
    {26}, {'Malta'}, {};...
    {27}, {'Moldova'}, {};...
    {28}, {'Monaco'}, {};...
    {29}, {'Montenegro'}, {};...
    {30}, {'Netherlands'}, {};...
    {31}, {'North Macedonia'}, {};...
    {32}, {'Norway'}, {};...
    {33}, {'Poland'}, {};...
    {34}, {'Portugal'}, {};...
    {35}, {'Romania'}, {};...
    {36}, {'Russia'}, {};...
    {37}, {'San Marino'}, {};...
    {38}, {'Serbia'}, {};...
    {39}, {'Slovakia'}, {};...
    {40}, {'Slovenia'}, {};...
    {41}, {'Spain'}, {};...
    {42}, {'Sweden'}, {};...
    {43}, {'Switzerland'}, {};...
    {44}, {'Ukraine'}, {};...
    {45}, {'United Kingdom'}, {};...
    {46}, {'Vatican'}, {}];

% countries = countries_all([7,14:16,20,35,41, 45], 2);
countries = countries_all(1:45, 2);
% countries = countries_all([7,8, 14,15, 16, 17, 20, 27, 34, 35, 38, 41, 42, 45], 2);
% countries = countries_all([45, 47], 2);% UK USA
% countries = countries_all(1:4, 2);
%%
IDX = [];

idxStart = []; idxEnd = [];
Ncountries_csv = size(covEurope,1);
Ncountries = size(countries,1);

for i = 1:Ncountries
    
    country = countries{i};
    ok = 0;
    for ii = 1:Ncountries_csv
        if strcmpi(country,covEurope{ii,3}), if ok == 0, idxStart = ii; ok = 1; else, idxEnd = ii; end, end
    end
    if ~isempty(idxStart) && ~isempty(idxEnd), IDX = [IDX; idxStart idxEnd]; end
    
end

sizefont = 20;
colmap = jet(Ncountries);

%% New vaccinations per thousand
if 0
    fhx=figure(1001);
    idxvary = new_vaccinations;
    set(0, 'currentfigure', fhx);
    datestart = datenum('01-Jan-2021');
    
    VV = []; DD = []; CCL = []; ccl = [];
    for ik = 1:Ncountries
        ik
        DATE = []; VARY = [];
        cc = covEurope(IDX(ik,1):IDX(ik,2), dates);
%         dateend = datenum(cc{end})-1;
        dateend = datenum('06-May-2021');
        for ikk = 1:numel(cc), DATE = [DATE; datenum(cc{ikk})]; end
        cc = covEurope(IDX(ik,1):IDX(ik,2), idxvary);
        pop = covEurope(IDX(ik,1):IDX(ik,2), population); pop = pop(1:numel(cc));
        POP = str2double(cell2mat(pop{1}));
        idxdate = [];
        for ikk = 1:numel(cc), if isempty(cell2mat(cc{ikk})), idxdate = [idxdate, ikk]; else, VARY = [VARY; str2double(cell2mat(cc{ikk}))];  end, end
        DATE(idxdate)=[];
        idxstart = find(DATE < datestart, 1, 'last');
        if isempty(idxstart), idxstart = 1; end
        idxend = find(DATE >= dateend, 1, 'first'); idxend = idxend - 1;
        if idxend < 0, continue; end
        if idxend == 0, idxend = 1; end
        try, if isempty(idxend), dateend = DATE(end); idxend = numel(DATE); end, catch, continue; end
        DATE = DATE(idxstart:idxend); VARY = VARY(idxstart:idxend);
        DATE(isnan(VARY)) = []; DATE(VARY<0) = [];
        VARY(isnan(VARY)) = []; VARY(VARY<0) = [];
        if numel(DATE) < 3, continue; end
        VARY = VARY./POP*1000; % only the 1st value, some issue in data
        try VARY = smooth(DATE,VARY,3,'moving'); catch, end
        VV = [VV, {VARY}];
        DD = [DD, {DATE}];
        CCL = [CCL, countries(ik)];
    end
    
    vv=[]; for ikk = 1:numel(VV), vv(ikk) = VV{ikk}(end);  end
    [~, px] = sort(vv, 'descend');
    colmap = flipud(jet(numel(px)));
    ikkk = 1;
    for ikk = px
        ikk
        vv = VV{ikk};
        dd = DD{ikk};
                
        if  ~strcmpi(CCL(ikk), 'Romania')
            plot(datetime(dd,'ConvertFrom','datenum'), vv, 'color', colmap(ikkk,:), 'linewidth', 4);hold on;
        else
            plot(datetime(dd,'ConvertFrom','datenum'), vv, 'color', 'k', 'linewidth', 8);hold on;
        end
        ccl = [ccl, {[num2str(ikkk), '. ', CCL{ikk}]}];
        ikkk = ikkk+1;
    end
    
    grid on;
    set(gca, 'fontsize', sizefont, 'fontweight', 'b', 'yscale', 'lin');
    xlabel('Data', 'fontsize', sizefont, 'fontweight', 'b'); ylabel('Nr. vaccinuri', 'fontsize', sizefont, 'fontweight', 'b');
    title('Numar de vaccinari zilnice (per 1000 locuitori)', 'fontsize', 24, 'fontweight', 'b');
    legend(ccl, 'fontsize', 8, 'fontweight', 'b', 'location', 'eastoutside');

    set(fhx,'PaperUnits','points','PaperPosition',[0 0 0.95*scrSize(3) 0.6*scrSize(4)]); print(fhx,[spdir, '/people_new_vaccinated_per_thousand'],'-dpng', '-r150');
    try darkBackground(fhx,[0.2 0.2 0.2],[0.9 0.7 0.7]), catch, end % https://www.mathworks.com/matlabcentral/fileexchange/30222-quick-dark-or-custom-plot-background
end

%% New vaccinations
if 0
    fhx=figure(1002);
    idxvary = new_vaccinations;
    set(0, 'currentfigure', fhx);
    datestart = datenum('01-Jan-2021');
    
    VV = []; DD = []; CCL = []; ccl = [];
    for ik = 1:Ncountries
        ik
        DATE = []; VARY = [];
        cc = covEurope(IDX(ik,1):IDX(ik,2), dates);
%         dateend = datenum(cc{end})-1;
        dateend = datenum('06-June-2021');
        for ikk = 1:numel(cc), DATE = [DATE; datenum(cc{ikk})]; end
        cc = covEurope(IDX(ik,1):IDX(ik,2), idxvary);
        idxdate = [];
        for ikk = 1:numel(cc), if isempty(cell2mat(cc{ikk})), idxdate = [idxdate, ikk]; else, VARY = [VARY; str2double(cell2mat(cc{ikk}))]; end, end
        DATE(idxdate)=[];
        idxstart = find(DATE < datestart, 1, 'last');
        if isempty(idxstart), idxstart = 1; end
        idxend = find(DATE >= dateend, 1, 'first'); idxend = idxend - 1;
        if idxend < 0, continue; end
        if idxend == 0, idxend = 1; end
        try if isempty(idxend), dateend = DATE(end); idxend = numel(DATE); end, catch, continue; end
        DATE = DATE(idxstart:idxend); VARY = VARY(idxstart:idxend);
        DATE(isnan(VARY)) = []; DATE(VARY<0) = [];
        VARY(isnan(VARY)) = []; VARY(VARY<0) = [];
        if numel(DATE) < 3, continue; end
        try VARY = smooth(DATE,VARY,3,'moving'); catch, end
        VV = [VV, {VARY}];
        DD = [DD, {DATE}];
        CCL = [CCL, countries(ik)];
    end
    
    vv=[]; for ikk = 1:numel(VV), vv(ikk) = VV{ikk}(end);  end
    [~, px] = sort(vv, 'descend');
    colmap = flipud(jet(numel(px)));
    ikkk = 1;
    for ikk = px
        ikk
        vv = VV{ikk};
        dd = DD{ikk};
                
        if  ~strcmpi(CCL(ikk), 'Romania')
            plot(datetime(dd,'ConvertFrom','datenum'), vv/1000, 'color', colmap(ikkk,:), 'linewidth', 4);hold on;
        else
            plot(datetime(dd,'ConvertFrom','datenum'), vv/1000, 'color', 'k', 'linewidth', 8);hold on;
        end
        ccl = [ccl, {[num2str(ikkk), '. ', CCL{ikk}]}];
        ikkk = ikkk+1;
    end
    
    grid on;
    fff = [50 100:100:1500];
    set(gca, 'fontsize', sizefont, 'fontweight', 'b', 'ytick', fff, 'yticklabel', fff); ytickformat('%g'); 
    xlabel('Date', 'fontsize', sizefont, 'fontweight', 'b'); ylabel('Doses per day (x1000)', 'fontsize', sizefont, 'fontweight', 'b');
    title('Daily vaccinated people', 'fontsize', 24, 'fontweight', 'b');
    legend(ccl, 'fontsize', 8, 'fontweight', 'b', 'location', 'eastoutside');

    set(fhx,'PaperUnits','points','PaperPosition',[0 0 0.95*scrSize(3) 0.6*scrSize(4)]); print(fhx,[spdir, '/people_new_vaccinated'],'-dpng', '-r150');
%     try darkBackground(fhx,[0.2 0.2 0.2],[0.9 0.7 0.7]), catch, end % https://www.mathworks.com/matlabcentral/fileexchange/30222-quick-dark-or-custom-plot-background
end

%% New vaccinations tendencies
if 0
    fhx=figure(1010);
    idxvary = new_vaccinations;
    set(0, 'currentfigure', fhx);
    datestart = datenum('01-Jan-2021');
    
    VV = []; DD = []; CCL = []; ccl = [];
    for ik = 1:Ncountries
        ik
        DATE = []; VARY = [];
        cc = covEurope(IDX(ik,1):IDX(ik,2), dates);
%         dateend = datenum(cc{end})-1;
        dateend = datenum('06-June-2021');
        for ikk = 1:numel(cc), DATE = [DATE; datenum(cc{ikk})]; end
        cc = covEurope(IDX(ik,1):IDX(ik,2), idxvary);
        idxdate = [];
        for ikk = 1:numel(cc), if isempty(cell2mat(cc{ikk})), idxdate = [idxdate, ikk]; else, VARY = [VARY; str2double(cell2mat(cc{ikk}))]; end, end
        DATE(idxdate)=[];
        idxstart = find(DATE < datestart, 1, 'last');
        if isempty(idxstart), idxstart = 1; end
        idxend = find(DATE >= dateend, 1, 'first'); idxend = idxend - 1;
        if idxend < 0, continue; end
        if idxend == 0, idxend = 1; end
        try if isempty(idxend), dateend = DATE(end); idxend = numel(DATE); end, catch, continue; end
        DATE = DATE(idxstart:idxend); VARY = VARY(idxstart:idxend);
        DATE(isnan(VARY)) = []; DATE(VARY<0) = [];
        VARY(isnan(VARY)) = []; VARY(VARY<0) = [];
        if numel(DATE) < 7, continue; end
        try VARY = smooth(DATE,VARY,7,'moving'); catch, end
        VV = [VV, {VARY}];
        DD = [DD, {DATE}];
        CCL = [CCL, countries(ik)];
    end
    
    vv=[]; for ikk = 1:numel(VV), vv(ikk) = VV{ikk}(end);  end
    [~, px] = sort(vv, 'descend');
    colmap = flipud(jet(numel(px)));
    ikkk = 1;
    for ikk = px
        ikk
        vv = VV{ikk};
        dd = DD{ikk};
        subplot(4,9,ikkk);
        if  ~strcmpi(CCL(ikk), 'Romania')
            plot(datetime(dd,'ConvertFrom','datenum'), vv, 'color', colmap(ikkk,:), 'linewidth', 3);
            text(datetime(dd(fix(end/2)),'ConvertFrom','datenum'), vv(fix(end/2)), CCL(ikk), 'color', 'k', 'FontSize', 15, 'FontWeight', 'b');
            set(gca, 'visible', 'off', 'xtick', []);grid off;
        else
            plot(datetime(dd,'ConvertFrom','datenum'), vv, 'color', 'k', 'linewidth', 3);
            text(datetime(dd(fix(end/2)),'ConvertFrom','datenum'), vv(fix(end/2)), CCL(ikk), 'color', 'k', 'FontSize', 17, 'FontWeight', 'b');
            set(gca, 'visible', 'off', 'xtick', []);grid off;
        end
        ikkk = ikkk+1;
    end
    set(fhx,'PaperUnits','points','PaperPosition',[0 0 0.95*scrSize(3) 0.6*scrSize(4)]); print(fhx,[spdir, '/people_new_vaccinated'],'-dpng', '-r150');
end

%% Vaccination per hundred tendencies
if 1
    fhx=figure(1011);
    idxvary = people_vaccinated_per_hundred;
    set(0, 'currentfigure', fhx);
    datestart = datenum('01-Jan-2021');
    
    VV = []; DD = []; CCL = []; ccl = [];
    for ik = 1:Ncountries
        ik
        DATE = []; VARY = [];
        cc = covEurope(IDX(ik,1):IDX(ik,2), dates);
%         dateend = datenum(cc{end})-1;
        dateend = datenum('07-June-2021');
        for ikk = 1:numel(cc), DATE = [DATE; datenum(cc{ikk})]; end
        cc = covEurope(IDX(ik,1):IDX(ik,2), idxvary);
        idxdate = [];
        for ikk = 1:numel(cc), if isempty(cell2mat(cc{ikk})), idxdate = [idxdate, ikk]; else, VARY = [VARY; str2double(cell2mat(cc{ikk}))]; end, end
        DATE(idxdate)=[];
        idxstart = find(DATE < datestart, 1, 'last');
        if isempty(idxstart), idxstart = 1; end
        idxend = find(DATE >= dateend, 1, 'first'); idxend = idxend - 1;
        if idxend < 0, continue; end
        if idxend == 0, idxend = 1; end
        if isempty(idxend), dateend = DATE(end); idxend = numel(DATE); end
        DATE = DATE(idxstart:idxend); VARY = VARY(idxstart:idxend);
        DATE(isnan(VARY)) = []; DATE(VARY<0) = [];
        VARY(isnan(VARY)) = []; VARY(VARY<0) = [];
        if numel(DATE) < 3, continue; end
        try VARY = smooth(DATE,VARY,3,'moving'); catch, end
        VV = [VV, {VARY}];
        DD = [DD, {DATE}];
        CCL = [CCL, countries(ik)];
    end
    
    vv=[]; for ikk = 1:numel(VV), vv(ikk) = VV{ikk}(end);  end
    [~, px] = sort(vv, 'descend');
    colmap = flipud(jet(numel(px)));
    ikkk = 1;
    for ikk = px
        ikk
        vv = VV{ikk};
        dd = DD{ikk};
        subplot(5,9,ikkk);
        if  ~strcmpi(CCL(ikk), 'Romania')
            plot(datetime(dd,'ConvertFrom','datenum'), vv, 'color', colmap(ikkk,:), 'linewidth', 3);
            text(datetime(dd(fix(end/2)),'ConvertFrom','datenum'), vv(fix(end/2)), CCL(ikk), 'color', 'k', 'FontSize', 15, 'FontWeight', 'b');
            text(datetime(dd(fix(0.95*end)),'ConvertFrom','datenum'), vv(fix(0.85*end)), [num2str(max(vv)), '%'], 'color', 'k', 'FontSize', 15, 'FontWeight', 'b');
            set(gca, 'visible', 'off', 'xtick', []);grid off;
        else
            plot(datetime(dd,'ConvertFrom','datenum'), vv, 'color', 'k', 'linewidth', 3);
            text(datetime(dd(fix(end/2)),'ConvertFrom','datenum'), vv(fix(end/2)), CCL(ikk), 'color', 'k', 'FontSize', 17, 'FontWeight', 'b');
            text(datetime(dd(fix(0.95*end)),'ConvertFrom','datenum'), vv(fix(0.85*end)), [num2str(max(vv)), '%'], 'color', 'k', 'FontSize', 15, 'FontWeight', 'b');
            set(gca, 'visible', 'off', 'xtick', []);grid off;
        end
        ikkk = ikkk+1;
    end
    set(fhx,'PaperUnits','points','PaperPosition',[0 0 0.95*scrSize(3) 0.6*scrSize(4)]); print(fhx,[spdir, '/people_new_vaccinated'],'-dpng', '-r150');
end


%% Vaccination per hundred
if 0
    fhx=figure(1000);
    idxvary = people_vaccinated_per_hundred;
    set(0, 'currentfigure', fhx);
    datestart = datenum('01-Jan-2021');
    
    VV = []; DD = []; CCL = []; ccl = [];
    for ik = 1:Ncountries
        ik
        DATE = []; VARY = [];
        cc = covEurope(IDX(ik,1):IDX(ik,2), dates);
%         dateend = datenum(cc{end})-1;
        dateend = datenum('07-June-2021');
        for ikk = 1:numel(cc), DATE = [DATE; datenum(cc{ikk})]; end
        cc = covEurope(IDX(ik,1):IDX(ik,2), idxvary);
        idxdate = [];
        for ikk = 1:numel(cc), if isempty(cell2mat(cc{ikk})), idxdate = [idxdate, ikk]; else, VARY = [VARY; str2double(cell2mat(cc{ikk}))]; end, end
        DATE(idxdate)=[];
        idxstart = find(DATE < datestart, 1, 'last');
        if isempty(idxstart), idxstart = 1; end
        idxend = find(DATE >= dateend, 1, 'first'); idxend = idxend - 1;
        if idxend < 0, continue; end
        if idxend == 0, idxend = 1; end
        if isempty(idxend), dateend = DATE(end); idxend = numel(DATE); end
        DATE = DATE(idxstart:idxend); VARY = VARY(idxstart:idxend);
        DATE(isnan(VARY)) = []; DATE(VARY<0) = [];
        VARY(isnan(VARY)) = []; VARY(VARY<0) = [];
        if numel(DATE) < 3, continue; end
        try VARY = smooth(DATE,VARY,3,'moving'); catch, end
        VV = [VV, {VARY}];
        DD = [DD, {DATE}];
        CCL = [CCL, countries(ik)];
    end
    
    vv=[]; for ikk = 1:numel(VV), vv(ikk) = VV{ikk}(end);  end
    [~, px] = sort(vv, 'descend');
    colmap = flipud(jet(numel(px)));
    ikkk = 1;
    for ikk = px
        ikk
        vv = VV{ikk};
        dd = DD{ikk};
                
        if  ~strcmpi(CCL(ikk), 'Romania')
            plot(datetime(dd,'ConvertFrom','datenum'), vv, 'color', colmap(ikkk,:), 'linewidth', 4);hold on;
        else
            plot(datetime(dd,'ConvertFrom','datenum'), vv, 'color', 'k', 'linewidth', 8);hold on;
        end
        ccl = [ccl, {[num2str(ikkk), '. ', CCL{ikk}]}];
        ikkk = ikkk+1;
    end
    
    grid on;
    set(gca, 'fontsize', sizefont, 'fontweight', 'b');
    xlabel('Data', 'fontsize', sizefont, 'fontweight', 'b'); ylabel('Procent', 'fontsize', sizefont, 'fontweight', 'b');
    title('Top % populatie vaccinata', 'fontsize', 24, 'fontweight', 'b');
    legend(ccl, 'fontsize', 8, 'fontweight', 'b', 'location', 'eastoutside');

    set(fhx,'PaperUnits','points','PaperPosition',[0 0 0.95*scrSize(3) 0.6*scrSize(4)]); print(fhx,[spdir, '/people_vaccinated_per_hundred1'],'-dpng', '-r150');
%     try darkBackground(fhx,[0.2 0.2 0.2],[0.9 0.7 0.7]), catch, end % https://www.mathworks.com/matlabcentral/fileexchange/30222-quick-dark-or-custom-plot-background
end

%% Vaccination per hundred with prediction
if 0
    fhx=figure(1);
    idxvary = people_vaccinated_per_hundred;
    set(0, 'currentfigure', fhx);
    fittype = 'poly2';
    herdimmun = 70;
    datestart = datenum('01-May-2021');
    dateendregression = datenum('31-December-2021');
    
    gggg = fix(linspace(10,60,Ncountries));
    for ik = 1:Ncountries
        ik
        DATE = []; VARY = [];
        cc = covEurope(IDX(ik,1):IDX(ik,2), dates);
        dateend = datenum(cc{end})-1;
        for ikk = 1:numel(cc), DATE = [DATE; datenum(cc{ikk})]; end
        cc = covEurope(IDX(ik,1):IDX(ik,2), idxvary);
        idxdate = [];
        for ikk = 1:numel(cc), if isempty(cell2mat(cc{ikk})), idxdate = [idxdate, ikk]; else, VARY = [VARY; str2double(cell2mat(cc{ikk}))]; end, end
        DATE(idxdate)=[];
        idxstart = find(DATE < datestart, 1, 'last');
        if isempty(idxstart), idxstart = 1; end
        idxend = find(DATE >= dateend, 1, 'first'); idxend = idxend - 1;
        if idxend < 0, continue; end
        if idxend == 0, idxend = 1; end
        if isempty(idxend), dateend = DATE(end); idxend = numel(DATE); end
        DATE = DATE(idxstart:idxend); VARY = VARY(idxstart:idxend);
        DATE(isnan(VARY)) = []; DATE(VARY<0) = [];
        VARY(isnan(VARY)) = []; VARY(VARY<0) = [];
        if numel(DATE) < 7, continue; end
        
        try VARY = smooth(DATE,VARY,7,'moving'); catch, end
        [fitobject, ~, ~] = fit(DATE, VARY, fittype);
%         fnc = @(x) (fitobject.p1*x.^4+fitobject.p2*x.^3+fitobject.p3*x.^2+fitobject.p4*x+fitobject.p5);
        fnc = @(x) (fitobject.p1*x.^2+fitobject.p2*x+fitobject.p3);
        if strcmpi(countries{ik}, 'United Kingdom') || ...
           strcmpi(countries{ik}, 'United States of America') || ...
           strcmpi(countries{ik}, 'Malta')
            [fitobject, ~, ~] = fit(DATE, VARY, 'poly1');
            fnc = @(x) (fitobject.p1*x+fitobject.p2);
        end
        VARY_1 = fnc(DATE);
        plot(datetime(DATE,'ConvertFrom','datenum'), VARY, 's-', 'markerfacecolor', colmap(ik,:), 'markeredgecolor', colmap(ik,:));hold on;
        DATE1 = dateend:dateendregression;
        VARY_2 = fnc(DATE1);
%         if  ~strcmpi(countries{ik}, 'Romania')
%             plot(datetime(DATE1,'ConvertFrom','datenum'), VARY_2, 'linewidth', 1.5, 'color', colmap(ik,:)); 
%         else
%             plot(datetime(DATE1,'ConvertFrom','datenum'), VARY_2, 'color', 'k', 'linewidth', 7);hold on;
%         end
        plot(datetime(DATE1,'ConvertFrom','datenum'), VARY_2, 'linewidth', 1.5, 'color', colmap(ik,:)); 
        idx = find(VARY_2 >= herdimmun, 1, 'first'); % 65% to achieve herd immunity
%         if ~isempty(idx)
%             if  ~strcmpi(countries{ik}, 'Romania')
%                 line([datetime(DATE1(idx),'ConvertFrom','datenum') datetime(DATE1(idx),'ConvertFrom','datenum')], [herdimmun, 100], 'linewidth', 4, 'color', colmap(ik,:));
%             else
%                 line([datetime(DATE1(idx),'ConvertFrom','datenum') datetime(DATE1(idx),'ConvertFrom','datenum')], [herdimmun, 100], 'linewidth', 7, 'color', 'k');
%             end
%         end
        if  VARY_2(gggg(ik)) > 100, gggg(ik) = 20; end
        text(datetime(DATE1(gggg(ik)),'ConvertFrom','datenum'), VARY_2(gggg(ik)), countries(ik), 'color', colmap(ik,:), 'FontSize', 15, 'FontWeight', 'b');
    end
    dateas = datenum('01-Jan-2021');
    line([datetime(dateas,'ConvertFrom','datenum') datetime(DATE1(end),'ConvertFrom','datenum')], [herdimmun, herdimmun], 'linewidth', 4, 'linestyle', ':', 'color', 'k');
    text(datetime(dateas,'ConvertFrom','datenum'), herdimmun+5, 'Herd Immunity (70%)', 'color', 'k', 'FontSize', 15, 'FontWeight', 'b');

    grid on;
    set(gca, 'ylim', [0 100]);
    set(gca, 'fontsize', sizefont, 'fontweight', 'b');
    xlabel('Date', 'fontsize', sizefont, 'fontweight', 'b'); ylabel('%', 'fontsize', sizefont, 'fontweight', 'b');
    title(['Percentage of vaccinated population (at least 1 dose) [as of ', date, ']'], 'fontsize', 24, 'fontweight', 'b');

    set(fhx,'PaperUnits','points','PaperPosition',[0 0 0.95*scrSize(3) 0.6*scrSize(4)]); print(fhx,[spdir, '/people_vaccinated_per_hundred_pred'],'-dpng', '-r150');
%     try darkBackground(fhx,[0.2 0.2 0.2],[0.9 0.7 0.7]), catch, end % https://www.mathworks.com/matlabcentral/fileexchange/30222-quick-dark-or-custom-plot-background
end

%% Vaccination per hundred with prediction new view
if 0
    fhx=figure(1);
    idxvary = people_vaccinated_per_hundred;
    set(0, 'currentfigure', fhx);
    herdimmun = 70;
    datestart = datenum('01-April-2021');
    dateendregression = datenum('01-Mars-2022');
    
    VV = []; DD = []; CCL = []; ccl = [];
    VV2 = []; DD1 = []; IDHERD = [];
    for ik = 1:Ncountries
        ik
        DATE = []; VARY = [];
        cc = covEurope(IDX(ik,1):IDX(ik,2), dates);
        dateend = datenum(cc{end})-1;
        for ikk = 1:numel(cc), DATE = [DATE; datenum(cc{ikk})]; end
        cc = covEurope(IDX(ik,1):IDX(ik,2), idxvary);
        idxdate = [];
        for ikk = 1:numel(cc), if isempty(cell2mat(cc{ikk})), idxdate = [idxdate, ikk]; else, VARY = [VARY; str2double(cell2mat(cc{ikk}))]; end, end
        DATE(idxdate)=[];
        idxstart = find(DATE < datestart, 1, 'last');
        if isempty(idxstart), idxstart = 1; end
        idxend = find(DATE >= dateend, 1, 'first'); idxend = idxend - 1;
        if idxend < 0, continue; end
        if idxend == 0, idxend = 1; end
        if isempty(idxend), dateend = DATE(end); idxend = numel(DATE); end
        DATE = DATE(idxstart:idxend); VARY = VARY(idxstart:idxend);
        DATE(isnan(VARY)) = []; DATE(VARY<0) = [];
        VARY(isnan(VARY)) = []; VARY(VARY<0) = [];
        if numel(DATE) < 7, continue; end
        
        [fitobject, ~, ~] = fit(DATE, VARY, 'poly1');
        fnc = @(x) (fitobject.p1*x+fitobject.p2);
        DATE1 = dateend:dateendregression;
        VARY_2 = fnc(DATE1);
        IDHERD = [IDHERD, VARY(end)];
        VV = [VV, {VARY}];
        DD = [DD, {DATE}];
        VV2 = [VV2, {VARY_2}];
        DD1 = [DD1, {DATE1}];
        CCL = [CCL, countries(ik)];
    end
    
    [~, px] = sort(IDHERD, 'descend');
    colmap = flipud(jet(numel(px)));
    gggg = fix(linspace(10,80,numel(px)));
    ikkk = 1;
    for ikk = px
        ikk
        vv2 = VV2{ikk};
        dd1 = DD1{ikk};
        vv = VV{ikk};
        dd = DD{ikk};
        if  ~strcmpi(CCL(ikk), 'Romania')
            plot(datetime(dd,'ConvertFrom','datenum'), vv, 's-', 'markerfacecolor', colmap(ikk,:), 'markeredgecolor', colmap(ikk,:));hold on;
            plot(datetime(dd1,'ConvertFrom','datenum'), vv2, 'color', colmap(ikk,:), 'linewidth', 4);
        else
            plot(datetime(dd,'ConvertFrom','datenum'), vv, 's-', 'markerfacecolor', 'k', 'markeredgecolor', 'k');hold on;
            plot(datetime(dd1,'ConvertFrom','datenum'), vv2, 'color', 'k', 'linewidth', 8);hold on;
        end
        if  vv2(gggg(ikkk)) > 100, gggg(ikkk) = 20; end
        if  ~strcmpi(CCL(ikk), 'Romania')
            text(datetime(dd1(gggg(ikkk)),'ConvertFrom','datenum'), vv2(gggg(ikkk)), countries(ikk), 'color', colmap(ikk,:), 'FontSize', 15, 'FontWeight', 'b');
        else
            text(datetime(dd1(10),'ConvertFrom','datenum'), vv2(10), countries(ikk), 'color', 'k', 'FontSize', 18, 'FontWeight', 'b');
        end
        ikkk = ikkk+1;
    end
    dateas = datestart;
    line([datetime(dateas,'ConvertFrom','datenum') datetime(DATE1(end),'ConvertFrom','datenum')], [herdimmun, herdimmun], 'linewidth', 4, 'linestyle', ':', 'color', 'k');
    text(datetime(dateas,'ConvertFrom','datenum'), herdimmun+5, 'Herd Immunity (70%)', 'color', 'k', 'FontSize', 15, 'FontWeight', 'b');
     
    grid on;
    set(gca, 'ylim', [0 100], 'xlim', [datetime(dateas,'ConvertFrom','datenum') datetime(dateendregression,'ConvertFrom','datenum')]);
    set(gca, 'fontsize', sizefont, 'fontweight', 'b');
    xlabel('Date', 'fontsize', sizefont, 'fontweight', 'b'); ylabel('%', 'fontsize', sizefont, 'fontweight', 'b');
    title(['Percentage of vaccinated population (at least 1 dose) [as of ', date, ']'], 'fontsize', 24, 'fontweight', 'b');
    
    set(fhx,'PaperUnits','points','PaperPosition',[0 0 0.95*scrSize(3) 0.6*scrSize(4)]); print(fhx,[spdir, '/people_vaccinated_per_hundred_pred'],'-dpng', '-r150');
%     try darkBackground(fhx,[0.2 0.2 0.2],[0.9 0.7 0.7]), catch, end % https://www.mathworks.com/matlabcentral/fileexchange/30222-quick-dark-or-custom-plot-background
end

%% New deaths
if 0
    fhx=figure(2);
    idxvary = new_deaths;
    set(0, 'currentfigure', fhx);
    datestart = datenum('01-April-2020');
    
    VV = []; DD = []; CCL = []; ccl = [];
    for ik = 1:Ncountries
        ik
        DATE = []; VARY = [];
        cc = covEurope(IDX(ik,1):IDX(ik,2), dates);
%         dateend = datenum(cc{end})-1;
        dateend = datenum('04-May-2021');
        for ikk = 1:numel(cc), DATE = [DATE; datenum(cc{ikk})]; end
        cc = covEurope(IDX(ik,1):IDX(ik,2), idxvary);
        idxdate = [];
        try
            for ikk = 1:numel(cc), if isempty(cell2mat(cc{ikk})), idxdate = [idxdate, ikk]; else, VARY = [VARY; str2double(cell2mat(cc{ikk}))]; end, end
        catch
            for ikk = 1:numel(cc), if isnan(cc{ikk}), idxdate = [idxdate, ikk]; else, VARY = [VARY; cc{ikk}]; end, end
        end
        DATE(idxdate)=[];
        idxstart = find(DATE < datestart, 1, 'last');
        if isempty(idxstart), idxstart = 1; end
        idxend = find(DATE >= dateend, 1, 'first'); idxend = idxend - 1;
        if idxend < 0, continue; end
        if idxend == 0, idxend = 1; end
        if isempty(idxend), dateend = DATE(end); idxend = numel(DATE); end
        DATE = DATE(idxstart:idxend); VARY = VARY(idxstart:idxend);
        DATE(isnan(VARY)) = []; DATE(VARY<0) = [];
        VARY(isnan(VARY)) = []; VARY(VARY<0) = [];
        if numel(DATE) < 3, continue; end
        try VARY = smooth(DATE,VARY,3,'moving'); catch, end
        VV = [VV, {VARY}];
        DD = [DD, {DATE}];
        CCL = [CCL, countries(ik)];
        
    end
    
    vv=[]; for ikk = 1:numel(VV), vv(ikk) = VV{ikk}(end);  end
    [~, px] = sort(vv, 'descend');
    colmap = flipud(jet(numel(px)));
    ikkk = 1;
    for ikk = px
        ikk
        vv = VV{ikk};
        dd = DD{ikk};
                
        if  ~strcmpi(CCL(ikk), 'Romania')
            plot(datetime(dd,'ConvertFrom','datenum'), vv, 'color', colmap(ikkk,:), 'linewidth', 4);hold on;
        else
            plot(datetime(dd,'ConvertFrom','datenum'), vv, 'color', 'k', 'linewidth', 8);hold on;
        end
        ccl = [ccl, {[num2str(ikkk), '. ', CCL{ikk}]}];
        ikkk = ikkk+1;
    end
    
    grid on;
    set(gca, 'fontsize', sizefont, 'fontweight', 'b');
    xlabel('Data', 'fontsize', sizefont, 'fontweight', 'b'); ylabel('Numar Decese', 'fontsize', sizefont, 'fontweight', 'b');
    title('Top Numar Decese', 'fontsize', 24, 'fontweight', 'b');
    legend(ccl, 'fontsize', 8, 'fontweight', 'b', 'location', 'eastoutside');

    set(fhx,'PaperUnits','points','PaperPosition',[0 0 0.95*scrSize(3) 0.6*scrSize(4)]); print(fhx,[spdir, '/new_deaths'],'-dpng', '-r150');
end

%% New deaths per million
if 0
    fhx=figure(3);
    idxvary = new_deaths_per_million;
    set(0, 'currentfigure', fhx);
    datestart = datenum('01-April-2020');
    
    VV = []; DD = []; CCL = []; ccl = [];
    for ik = 1:Ncountries
        ik
        DATE = []; VARY = [];
        cc = covEurope(IDX(ik,1):IDX(ik,2), dates);
%         dateend = datenum(cc{end})-1;
        dateend = datenum('04-May-2021');
        for ikk = 1:numel(cc), DATE = [DATE; datenum(cc{ikk})]; end
        cc = covEurope(IDX(ik,1):IDX(ik,2), idxvary);
        idxdate = [];
        try
            for ikk = 1:numel(cc), if isempty(cell2mat(cc{ikk})), idxdate = [idxdate, ikk]; else, VARY = [VARY; str2double(cell2mat(cc{ikk}))]; end, end
        catch
            for ikk = 1:numel(cc), if isnan(cc{ikk}), idxdate = [idxdate, ikk]; else, VARY = [VARY; cc{ikk}]; end, end
        end
        DATE(idxdate)=[];
        idxstart = find(DATE < datestart, 1, 'last');
        if isempty(idxstart), idxstart = 1; end
        idxend = find(DATE >= dateend, 1, 'first'); idxend = idxend - 1;
        if idxend < 0, continue; end
        if idxend == 0, idxend = 1; end
        if isempty(idxend), dateend = DATE(end); idxend = numel(DATE); end
        DATE = DATE(idxstart:idxend); VARY = VARY(idxstart:idxend);
        DATE(isnan(VARY)) = []; DATE(VARY<0) = [];
        VARY(isnan(VARY)) = []; VARY(VARY<0) = [];
        if numel(DATE) < 3, continue; end
        try VARY = smooth(DATE,VARY,3,'moving'); catch, end
        VV = [VV, {VARY}];
        DD = [DD, {DATE}];
        CCL = [CCL, countries(ik)];
    end
    
    vv=[]; for ikk = 1:numel(VV), vv(ikk) = VV{ikk}(end);  end
    [~, px] = sort(vv, 'descend');
    colmap = flipud(jet(numel(px)));
    ikkk = 1;
    for ikk = px
        ikk
        vv = VV{ikk};
        dd = DD{ikk};
                
        if  ~strcmpi(CCL(ikk), 'Romania')
            plot(datetime(dd,'ConvertFrom','datenum'), vv, 'color', colmap(ikkk,:), 'linewidth', 4);hold on;
        else
            plot(datetime(dd,'ConvertFrom','datenum'), vv, 'color', 'k', 'linewidth', 8);hold on;
        end
        ccl = [ccl, {[num2str(ikkk), '. ', CCL{ikk}]}];
        ikkk = ikkk+1;
    end
    
    grid on;
    set(gca, 'fontsize', sizefont, 'fontweight', 'b', 'yscale', 'log');
    xlabel('Data', 'fontsize', sizefont, 'fontweight', 'b'); ylabel('Numar Decese/milion loc.', 'fontsize', sizefont, 'fontweight', 'b');
    title('Top Numar Decese/milion loc.', 'fontsize', 24, 'fontweight', 'b');
    legend(ccl, 'fontsize', 8, 'fontweight', 'b', 'location', 'eastoutside');

    set(fhx,'PaperUnits','points','PaperPosition',[0 0 0.95*scrSize(3) 0.6*scrSize(4)]); print(fhx,[spdir, '/new_deaths_per_million'],'-dpng', '-r150');
end

%% New cases per million
if 0
    fhx=figure(4);
    idxvary = new_cases_per_million;
    set(0, 'currentfigure', fhx);
    datestart = datenum('01-April-2020');
    
    VV = []; DD = []; CCL = []; ccl = [];
    for ik = 1:Ncountries
        ik
        DATE = []; VARY = [];
        cc = covEurope(IDX(ik,1):IDX(ik,2), dates);
%         dateend = datenum(cc{end})-1;
        dateend = datenum('04-May-2021');
        for ikk = 1:numel(cc), DATE = [DATE; datenum(cc{ikk})]; end
        cc = covEurope(IDX(ik,1):IDX(ik,2), idxvary);
        idxdate = [];
        try
            for ikk = 1:numel(cc), if isempty(cell2mat(cc{ikk})), idxdate = [idxdate, ikk]; else, VARY = [VARY; str2double(cell2mat(cc{ikk}))]; end, end
        catch
            for ikk = 1:numel(cc), if isnan(cc{ikk}), idxdate = [idxdate, ikk]; else, VARY = [VARY; cc{ikk}]; end, end
        end
        DATE(idxdate)=[];
        idxstart = find(DATE < datestart, 1, 'last');
        if isempty(idxstart), idxstart = 1; end
        idxend = find(DATE >= dateend, 1, 'first'); idxend = idxend - 1;
        if idxend < 0, continue; end
        if idxend == 0, idxend = 1; end
        if isempty(idxend), dateend = DATE(end); idxend = numel(DATE); end
        DATE = DATE(idxstart:idxend); VARY = VARY(idxstart:idxend);
        DATE(isnan(VARY)) = []; DATE(VARY<0) = [];
        VARY(isnan(VARY)) = []; VARY(VARY<0) = [];
        if numel(DATE) < 3, continue; end
        try VARY = smooth(DATE,VARY,3,'moving'); catch, end
        VV = [VV, {VARY}];
        DD = [DD, {DATE}];
        CCL = [CCL, countries(ik)];
        
    end
    
    vv=[]; for ikk = 1:numel(VV), vv(ikk) = VV{ikk}(end);  end
    [~, px] = sort(vv, 'descend');
    colmap = flipud(jet(numel(px)));
    ikkk = 1;
    for ikk = px
        ikk
        vv = VV{ikk};
        dd = DD{ikk};
                
        if  ~strcmpi(CCL(ikk), 'Romania')
            plot(datetime(dd,'ConvertFrom','datenum'), vv, 'color', colmap(ikkk,:), 'linewidth', 4);hold on;
        else
            plot(datetime(dd,'ConvertFrom','datenum'), vv, 'color', 'k', 'linewidth', 8);hold on;
        end
        ccl = [ccl, {[num2str(ikkk), '. ', CCL{ikk}]}];
        ikkk = ikkk+1;
    end
    
    
    grid on;
    set(gca, 'fontsize', sizefont, 'fontweight', 'b', 'yscale', 'log');
    xlabel('Data', 'fontsize', sizefont, 'fontweight', 'b'); ylabel('Numar Cazuri/milion loc.', 'fontsize', sizefont, 'fontweight', 'b');
    title('Top Numar Cazuri/milion loc.', 'fontsize', 24, 'fontweight', 'b');
    legend(ccl, 'fontsize', 8, 'fontweight', 'b', 'location', 'eastoutside');

    set(fhx,'PaperUnits','points','PaperPosition',[0 0 0.95*scrSize(3) 0.6*scrSize(4)]); print(fhx,[spdir, '/new_cases_per_million'],'-dpng', '-r150');
end

%% New tests per thousand
if 0
    fhx=figure(2);
    idxvary = new_tests_per_thousands;
    set(0, 'currentfigure', fhx);
    datestart = datenum('01-April-2020');
    
    VV = []; DD = []; CCL = []; ccl = [];
    for ik = 1:Ncountries
        ik
        DATE = []; VARY = [];
        cc = covEurope(IDX(ik,1):IDX(ik,2), dates);
%         dateend = datenum(cc{end})-1;
        dateend = datenum('04-May-2021');
        for ikk = 1:numel(cc), DATE = [DATE; datenum(cc{ikk})]; end
        cc = covEurope(IDX(ik,1):IDX(ik,2), idxvary);
        idxdate = [];
        try
            for ikk = 1:numel(cc), if isempty(cell2mat(cc{ikk})), idxdate = [idxdate, ikk]; else, VARY = [VARY; str2double(cell2mat(cc{ikk}))]; end, end
        catch
            for ikk = 1:numel(cc), if isnan(cc{ikk}), idxdate = [idxdate, ikk]; else, VARY = [VARY; cc{ikk}]; end, end
        end
        DATE(idxdate)=[];
        idxstart = find(DATE < datestart, 1, 'last');
        if isempty(idxstart), idxstart = 1; end
        idxend = find(DATE >= dateend, 1, 'first'); idxend = idxend - 1;
        if idxend < 0, continue; end
        if idxend == 0, idxend = 1; end
        try, if isempty(idxend), dateend = DATE(end); idxend = numel(DATE); end, catch, continue; end
        DATE = DATE(idxstart:idxend); VARY = VARY(idxstart:idxend);
        DATE(isnan(VARY)) = []; DATE(VARY<0) = [];
        VARY(isnan(VARY)) = []; VARY(VARY<0) = [];
        if numel(DATE) < 3, continue; end
        try VARY = smooth(DATE,VARY,3,'moving'); catch, end
        VV = [VV, {VARY}];
        DD = [DD, {DATE}];
        CCL = [CCL, countries(ik)];
    end
    
    vv=[]; for ikk = 1:numel(VV), vv(ikk) = VV{ikk}(end);  end
    [~, px] = sort(vv, 'descend');
    colmap = flipud(jet(numel(px)));
    ikkk = 1;
    for ikk = px
        ikk
        vv = VV{ikk};
        dd = DD{ikk};
                
        if  ~strcmpi(CCL(ikk), 'Romania')
            plot(datetime(dd,'ConvertFrom','datenum'), vv, 'color', colmap(ikkk,:), 'linewidth', 4);hold on;
        else
            plot(datetime(dd,'ConvertFrom','datenum'), vv, 'color', 'k', 'linewidth', 8);hold on;
        end
        ccl = [ccl, {[num2str(ikkk), '. ', CCL{ikk}]}];
        ikkk = ikkk+1;
    end
    
    grid on;
    set(gca, 'fontsize', sizefont, 'fontweight', 'b', 'yscale', 'log');
    xlabel('Data', 'fontsize', sizefont, 'fontweight', 'b'); ylabel('Numar Teste/1000 loc.', 'fontsize', sizefont, 'fontweight', 'b');
    title('Top Numar Teste/1000 loc.', 'fontsize', 24, 'fontweight', 'b');
    legend(ccl, 'fontsize', 9, 'fontweight', 'b', 'location', 'eastoutside');

    set(fhx,'PaperUnits','points','PaperPosition',[0 0 0.95*scrSize(3) 0.6*scrSize(4)]); print(fhx,[spdir, '/new_tests_per_thousand'],'-dpng', '-r150');
end

%% Population
if 0
    fhx=figure(4);
    idxvary = population;
    set(0, 'currentfigure', fhx);
    datestart = datenum('01-Jan-2021');
    
    VV = []; DD = []; CCL = []; ccl = [];
    for ik = 1:Ncountries
        ik
        DATE = []; VARY = [];
        cc = covEurope(IDX(ik,1):IDX(ik,2), dates);
%         dateend = datenum(cc{end})-1;
        dateend = datenum('06-June-2021');
        for ikk = 1:numel(cc), DATE = [DATE; datenum(cc{ikk})]; end
        cc = covEurope(IDX(ik,1):IDX(ik,2), idxvary);
        idxdate = [];
        for ikk = 1:numel(cc), if isempty(cell2mat(cc{ikk})), idxdate = [idxdate, ikk]; else, VARY = [VARY; str2double(cell2mat(cc{ikk}))]; end, end
        DATE(idxdate)=[];
        idxstart = find(DATE < datestart, 1, 'last');
        if isempty(idxstart), idxstart = 1; end
        idxend = find(DATE >= dateend, 1, 'first'); idxend = idxend - 1;
        if idxend < 0, continue; end
        if idxend == 0, idxend = 1; end
        try, if isempty(idxend), dateend = DATE(end); idxend = numel(DATE); end, catch, continue; end
        DATE = DATE(idxstart:idxend); VARY = VARY(idxstart:idxend);
        DATE(isnan(VARY)) = []; DATE(VARY<0) = [];
        VARY(isnan(VARY)) = []; VARY(VARY<0) = [];
        if numel(DATE) < 3, continue; end
        try VARY = smooth(DATE,VARY,3,'moving'); catch, end
        VV = [VV, {VARY}];
        DD = [DD, {DATE}];
        CCL = [CCL, countries(ik)];
    end
    
    vv=[]; for ikk = 1:numel(VV), vv(ikk) = VV{ikk}(end);  end
    [~, px] = sort(vv, 'descend');
    colmap = flipud(jet(numel(px)));
    ikkk = 1;
    for ikk = px
        ikk
        vv = VV{ikk};
        dd = DD{ikk};
                
        if  ~strcmpi(CCL(ikk), 'Romania')
            plot(datetime(dd,'ConvertFrom','datenum'), vv, 'color', colmap(ikkk,:), 'linewidth', 4);hold on;
        else
            plot(datetime(dd,'ConvertFrom','datenum'), vv, 'color', 'k', 'linewidth', 8);hold on;
        end
        ccl = [ccl, {[num2str(ikkk), '. ', CCL{ikk}]}];
        ikkk = ikkk+1;
    end
    
    grid on;
    set(gca, 'fontsize', sizefont, 'fontweight', 'b', 'yscale', 'log');
    xlabel('Data', 'fontsize', sizefont, 'fontweight', 'b'); ylabel('Populatie', 'fontsize', sizefont, 'fontweight', 'b');
    title('Populatie', 'fontsize', 24, 'fontweight', 'b');
    legend(ccl, 'fontsize', 8, 'fontweight', 'b', 'location', 'eastoutside');

    set(fhx,'PaperUnits','points','PaperPosition',[0 0 0.95*scrSize(3) 0.6*scrSize(4)]); print(fhx,[spdir, '/population'],'-dpng', '-r150');
%     try darkBackground(fhx,[0.2 0.2 0.2],[0.9 0.7 0.7]), catch, end % https://www.mathworks.com/matlabcentral/fileexchange/30222-quick-dark-or-custom-plot-background
end
