
#ifndef CALCULATOR_LOGIC_HPP
#include "CalculatorLogic.hpp"
#endif

#include <QtMath>

#ifdef QT_DEBUG
#include <exception>
#endif

CalculatorLogic::CalculatorLogic( QObject *const qParent ) noexcept
    : QObject ( qParent ),
      mStoredValue( "" ),
      mLeftArg( "" ),
      mRightArg( "" ),
      mOutput( "" ),
      mOperationType( NONE_OPERATION_TYPE )
{
}

CalculatorLogic::~CalculatorLogic( ) noexcept = default;

QString CalculatorLogic::setOperationType( const QString pType ) noexcept
{

    //if ( mLeftArg.size( ) < 1 && mRightArg.size( ) < 1 )
        //return( mOutput );



    if ( pType == "-" )
        mOperationType = SUB_OPERATION_TYPE;
    else if ( pType == "+" )
        mOperationType = SUM_OPERATION_TYPE;
    else if ( pType == "/" )
        mOperationType = DIV_OPERATION_TYPE;
    else if ( pType == "*" )
        mOperationType = MUL_OPERATION_TYPE;
    else if ( pType == "@" )
    {

        if ( mRightArg.size( ) < 1 )
            return( mOutput );

        mOperationType = PLUS_MINUS_OPERATION_TYPE;

        const int arg1_d = mRightArg.toInt() ;

        const int result_ = (arg1_d * (-1));

        mOutput = QString::number( result_ );

        //onCalculationDone();

        mOperationType = NONE_OPERATION_TYPE;

        mLeftArg = mOutput;
        mRightArg = "";

        onUpdateOutput( );

        return( mLeftArg );

    }


    mLeftArg = mRightArg;
    mRightArg = "";


    onUpdateOutput( );
    return (mOutput);
}

void CalculatorLogic::onUpdateOutput( ) noexcept
{

    mOutput = "";

    if ( mLeftArg.size( ) > 0 && (mLeftArg != "+" || mLeftArg != "-" || mLeftArg != "*" || mLeftArg != "@" || mLeftArg != "/"))
        mOutput += mLeftArg;

    if ( mOperationType != NONE_OPERATION_TYPE )
    {
        switch( mOperationType )
        {
        case DIV_OPERATION_TYPE:
        {
            mOutput += " / ";
            break;
        }
        case MUL_OPERATION_TYPE:
        {
            mOutput += " * ";
            break;
        }
        case PERC_OPERATION_TYPE:
        {
            mOutput += " % ";
            break;
        }
        case SUB_OPERATION_TYPE:
        {
            mOutput += " - ";
            break;
        }
        default:
        case SUM_OPERATION_TYPE:
        {
            mOutput +=  " + ";
            break;
        }
        }
    }


    if ( mRightArg.size( ) > 0 )
        mOutput += mRightArg;


    if ( mOutput.size( ) < 1 )
        mOutput = "0";

}

Q_INVOKABLE QString CalculatorLogic::onDot( ) noexcept
{


    if ( mRightArg.size( ) < 1 )
    {

        mRightArg = "0.";

        onUpdateOutput( );

        return( mOutput );

    }

    if ( mRightArg.contains( '.' ) )
        return( mOutput );

    mRightArg += ".";

    onUpdateOutput( );

    return( mOutput );

}

void CalculatorLogic::onCalculationDone( ) noexcept
{

    mLeftArg.clear( );

    mRightArg.clear( );

    mOperationType = NONE_OPERATION_TYPE;

}

QString CalculatorLogic::onKeyboardInput( const QString pValue ) noexcept
{

    if ( pValue == "0" || pValue == "1" || pValue == "2"
         || pValue == "3" || pValue == "4" || pValue == "5"
         || pValue == "6" || pValue == "7" || pValue == "8"
         || pValue == "9" || pValue == "-" || pValue == "+")
        return( onNumberInput( pValue ) );

    return( mOutput );

}

QString CalculatorLogic::onNumberInput( const QString pVal ) noexcept
{

    mRightArg += pVal;

    onUpdateOutput( );

    return( mOutput );

}

QString CalculatorLogic::onRemoveLastNumber( ) noexcept
{

    if ( mRightArg.size( ) == 0 )
        return( mOutput );

    mRightArg.chop( 1 );


    mOutput.chop( 1 );

    return( mOutput );

}

QString CalculatorLogic::doMath( ) noexcept
{


    if ( mOperationType == NONE_OPERATION_TYPE || mLeftArg.size( ) < 1 )
        return( mOutput );

    const double arg1_d( mLeftArg.toDouble(  ) );


    if ( mRightArg.size( ) < 1 )
    {


        const qreal result_ = arg1_d/100;


        mOutput = QString::number( result_ );


        onCalculationDone( );


        return( mOutput );

    }


    const double arg2_d( mRightArg.toDouble( ) );


    switch( mOperationType )
    {
    case SUB_OPERATION_TYPE:
    {
        const auto result_( arg1_d - arg2_d );
        mOutput = QString::number( result_ );
        onCalculationDone( );
        break;
    }
    case MUL_OPERATION_TYPE:
    {

        const auto result_( arg1_d * arg2_d );

        mOutput = QString::number( result_ );

        onCalculationDone( );

        break;

    }
    case DIV_OPERATION_TYPE:
    {

        const auto result_( arg1_d / arg2_d );

        mOutput = QString::number( result_ );

        onCalculationDone( );

        break;

    }
    case SUM_OPERATION_TYPE:
    default:
    {

        const auto result_( arg1_d + arg2_d );

        mOutput = QString::number( result_ );

        onCalculationDone( );

        break;

    }
    }

    return( mOutput );

}


void CalculatorLogic::resetLogic( ) noexcept
{

    mLeftArg = "";
    mRightArg = "";
    mOutput = "0";
    mOperationType = NONE_OPERATION_TYPE;

}
