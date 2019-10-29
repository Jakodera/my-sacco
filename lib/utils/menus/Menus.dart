import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mysacco/data/models/ModelPageMetaData.dart';
import 'package:mysacco/pages/transact/AccountStatement.dart';
import 'package:mysacco/pages/transact/CashWithdrawal.dart';
import 'package:mysacco/utils/icons/FeatherIcons.dart';
import 'package:mysacco/utils/storage/Storage.dart';

class Menu {
    final String title;
    final String route;
    final IconData icon;
    final Color color;
    final Color backgroundColor;

    Menu(this.title, this.route, this.icon, this.color, this.backgroundColor);
}

class MenuTypes {
    static const String LIST = "LIST";
    static const String GRID = "GRID";
}

class MenuItems {
    //HOME
    static Menu miHome = Menu(
            "Home",
            'HOME',
            FeatherIcons.home,
            Colors.indigo,
            Colors.indigo[50]
    );


    //TRANSACT
    static Menu miWithdrawMoney = Menu(
            "Withdraw Money",
            'CASH_WITHDRAWAL',
            FeatherIcons.upload,
            Colors.red,
            Colors.red[50]
    );

    static Menu miDepositMoney = Menu(
            "Deposit Money",
            'DEPOSIT_MONEY',
            FeatherIcons.download,
            Colors.green,
            Colors.green[50]
    );

    static Menu miBuyAirtime = Menu(
            "Buy Airtime",
            'BUY_AIRTIME',
            FeatherIcons.phone,
            Colors.orange,
            Colors.orange[50]
    );

    static Menu miPayBill = Menu(
            "Pay Bill",
            'PAY_BILL',
            FeatherIcons.archive,
            Colors.deepPurple,
            Colors.deepPurple[50]
    );

    static Menu miBankTransfer = Menu(
            "Bank Transfer",
            'BANK_TRANSFER',
            FeatherIcons.external_link,
            Colors.brown,
            Colors.brown[50]
    );

    static Menu miFundsTransfer = Menu(
            "Funds Transfer",
            'FUNDS_TRANSFER',
            FeatherIcons.shuffle,
            Colors.pink,
            Colors.pink[50]
    );


    //MY ACCOUNT
    static Menu miAccountBalance = Menu(
            "Account Balance",
            'ACCOUNT_BALANCE',
            FeatherIcons.pocket,
            Colors.blue,
            Colors.blue[50]
    );

    static Menu miAccountStatement = Menu(
            "Account Statement",
            'ACCOUNT_STATEMENT',
            FeatherIcons.file_text,
            Colors.deepOrange,
            Colors.deepOrange[50]
    );

    static Menu miChangePassword = Menu(
            "Change PIN",
            'CHANGE_PIN',
            FeatherIcons.key,
            Colors.teal,
            Colors.teal[50]
    );


    //LOANS
    static Menu miApplyLoan = Menu(
            "Apply Loan",
            'APPLY_LOAN',
            FeatherIcons.edit,
            Colors.teal,
            Colors.teal[50]
    );

    static Menu miPayLoan = Menu(
            "Pay Loan",
            'PAY_LOAN',
            FeatherIcons.bookmark,
            Colors.orange,
            Colors.orange[50]
    );

    static Menu miLoanBalance = Menu(
            "Loan Balance",
            'LOAN_BALANCE',
            FeatherIcons.help_circle,
            Colors.green,
            Colors.green[50]
    );

    static Menu miLoanLimit = Menu(
            "Check Loan Limit",
            'LOAN_LIMIT',
            FeatherIcons.percent,
            Colors.deepPurple,
            Colors.deepPurple[50]
    );

    static Menu miLoanStatement = Menu(
            "Loan Statement",
            'LOAN_STATEMENT',
            FeatherIcons.file_text,
            Colors.brown,
            Colors.brown[50]
    );

    static Menu miLoanGuarantors = Menu(
            "My Loan Guarantors",
            'LOAN_GUARANTORS',
            FeatherIcons.users,
            Colors.blueGrey,
            Colors.blueGrey[50]
    );

    static Menu miLoansGuaranteed = Menu(
            "Loans Guaranteed",
            'LOANS_GUARANTEED',
            FeatherIcons.list,
            Colors.cyan,
            Colors.cyan[50]
    );
}


final List<Menu> homeMenus = <Menu>[
    MenuItems.miAccountBalance,
    MenuItems.miWithdrawMoney,
    MenuItems.miDepositMoney,
    MenuItems.miAccountStatement,
    MenuItems.miApplyLoan,
    MenuItems.miPayLoan,
    MenuItems.miFundsTransfer,
    MenuItems.miLoanBalance,
    MenuItems.miBuyAirtime
];

final List<Menu> transactMenus = <Menu>[
    MenuItems.miWithdrawMoney,
    MenuItems.miDepositMoney,
    MenuItems.miBuyAirtime,
    MenuItems.miPayBill,
    MenuItems.miBankTransfer,
    MenuItems.miFundsTransfer
];

final List<Menu> myAccountMenus = <Menu>[
    MenuItems.miAccountBalance,
    MenuItems.miAccountStatement,
    MenuItems.miChangePassword
];

final List<Menu> loansMenus = <Menu>[
    MenuItems.miApplyLoan,
    MenuItems.miPayLoan,
    MenuItems.miLoanBalance,
    MenuItems.miLoanLimit,
    MenuItems.miLoanStatement,
    MenuItems.miLoanGuarantors,
    MenuItems.miLoansGuaranteed
];


class NavigationMenu {
    static Widget fnGetNavigationRoute(Storage storage, PageMetaData metadata) {
        switch (metadata.strRoute) {
        //TRANSACT
            case "CASH_WITHDRAWAL":
                {
                    return CashWithdrawal(storage: storage, metadata: metadata);
                }
            case "DEPOSIT_MONEY":
                {
                    return CashWithdrawal(storage: storage, metadata: metadata);
                }
            case "BUY_AIRTIME":
                {
                    return CashWithdrawal(storage: storage, metadata: metadata);
                }
            case "PAY_BILL":
                {
                    return CashWithdrawal(storage: storage, metadata: metadata);
                }
            case "BANK_TRANSFER":
                {
                    return CashWithdrawal(storage: storage, metadata: metadata);
                }
            case "FUNDS_TRANSFER":
                {
                    return CashWithdrawal(storage: storage, metadata: metadata);
                }

        //MY ACCOUNT
            case "ACCOUNT_BALANCE":
                {
                    return CashWithdrawal(storage: storage, metadata: metadata);
                }
            case "ACCOUNT_STATEMENT":
                {
                    return AccountStatement();
                }
            case "CHANGE_PIN":
                {
                    return CashWithdrawal(storage: storage, metadata: metadata);
                }

        //LOANS
            case "APPLY_LOAN":
                {
                    return CashWithdrawal(storage: storage, metadata: metadata);
                }
            case "PAY_LOAN":
                {
                    return CashWithdrawal(storage: storage, metadata: metadata);
                }
            case "LOAN_BALANCE":
                {
                    return CashWithdrawal(storage: storage, metadata: metadata);
                }
            case "LOAN_LIMIT":
                {
                    return CashWithdrawal(storage: storage, metadata: metadata);
                }
            case "LOAN_STATEMENT":
                {
                    return CashWithdrawal(storage: storage, metadata: metadata);
                }
            case "LOAN_GUARANTORS":
                {
                    return CashWithdrawal(storage: storage, metadata: metadata);
                }
            case "LOANS_GUARANTEED":
                {
                    return CashWithdrawal(storage: storage, metadata: metadata);
                }
        }
        return CashWithdrawal(storage: storage, metadata: metadata);
    }
}

class ResultMenuOptions {
    static List<Menu> getMenus(String strPageMeta) {
        List<Menu> rVal = new List<Menu>();
        switch (strPageMeta) {
            case 'ACCOUNT_BALANCE':
                {
                    rVal.add(MenuItems.miHome);
                    break;
                }
            case 'CASH_WITHDRAWAL':
                {
                    rVal.add(MenuItems.miHome);
                    rVal.add(MenuItems.miAccountBalance);
                    rVal.add(MenuItems.miDepositMoney);
                    break;
                }
            case 'DEPOSIT_MONEY':
                {
                    rVal.add(MenuItems.miHome);
                    break;
                }
            case 'ACCOUNT_STATEMENT':
                {
                    rVal.add(MenuItems.miHome);
                    break;
                }
            case 'APPLY_LOAN':
                {
                    rVal.add(MenuItems.miHome);
                    break;
                }
            case 'PAY_LOAN':
                {
                    rVal.add(MenuItems.miHome);
                    break;
                }
            case 'FUNDS_TRANSFER':
                {
                    rVal.add(MenuItems.miHome);
                    rVal.add(MenuItems.miDepositMoney);
                    break;
                }
            case 'LOAN_BALANCE':
                {
                    rVal.add(MenuItems.miHome);
                    break;
                }
            case 'BUY_AIRTIME':
                {
                    rVal.add(MenuItems.miHome);
                    break;
                }
        }
        return rVal;
    }
}