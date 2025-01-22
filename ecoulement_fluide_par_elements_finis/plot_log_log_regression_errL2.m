function plot_log_log_regression_errL2(h, err_L2, err_H1)

    log_h = log10(1 ./ h); % log(1/h)
    log_err_L2 = log10(err_L2);
    log_err_H1 = log10(err_H1);

    figure;
    
    plot(log_h, log_err_L2, 'o', 'MarkerFaceColor', 'b', 'MarkerSize', 8, 'DisplayName', 'log(err\_L2)');
    hold on;

    coeffs_L2 = polyfit(log_h, log_err_L2, 1); 
    y_fit_L2 = polyval(coeffs_L2, log_h);
    plot(log_h, y_fit_L2, '-b', 'LineWidth', 2, 'DisplayName', 'Régression L2');

    plot(log_h, log_err_H1, 'o', 'MarkerFaceColor', 'r', 'MarkerSize', 8, 'DisplayName', 'log(err\_H1)');

    coeffs_H1 = polyfit(log_h, log_err_H1, 1); 
    y_fit_H1 = polyval(coeffs_H1, log_h);
    plot(log_h, y_fit_H1, '-r', 'LineWidth', 2, 'DisplayName', 'Régression H1');

    xlabel('log(1/h)');
    ylabel('log(error)');
    title('Régression linéaire en échelle log-log pour err\_L2 et err\_H1');
    legend('Location', 'SouthWest');
    grid on;
    hold off;

end