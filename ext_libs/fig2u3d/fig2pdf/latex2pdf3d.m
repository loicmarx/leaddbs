function [] = latex2pdf3d(fname, latex_compiler,options)
%LATEX2PDF3D    Compile LaTeX code to PDF.
%
% usage
%   LATEX2PDF3D
%   LATEX2PDF3D(fname, latex_compiler)
%
% optional input
%   fname = file name string
%   latex_compiler = 'pdflatex' | 'xelatex'
%
% output
%   If compilation succeeds, then a PDF file is produced.
%
% dependency
%   pdflatex or xelatex should be available in the system path
%
% See also FIG2PDF3D, FIG2LATEX, U3D_IN_LATEX.
%
% File:      latex2pdf3d.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2012.06.21
% Language:  MATLAB R2012a
% Purpose:   compile LaTeX file to a PDF
%
% acknowledgment
%   Based on demo_mesh2pdf by Alexandre Gramfort.
%   This can be found on the MATLAb Central File Exchange:
%       http://www.mathworks.com/matlabcentral/fileexchange/25383-matlab-mesh-to-pdf-with-3d-interactive-object
%   and is covered by the BSD License.

% depends
%   {pdflatex | xelatex}, {media9 | movie15}

%% input

%% Use pdflatex to generate the pdf
cd(fileparts(fname));
cmd = [options.prefs.ltx.pdfconverter,' --interaction=nonstopmode ', fname, '.tex'];

status = system(cmd);
% run twice to correct references.
status = system(cmd);

if status ~= 0
    warning('latex:compile', 'LaTeX compilation warning.')
end
