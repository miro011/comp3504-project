import json
import re
import os

from flask import *
# from dotenv import load_dotenv

import mysql.connector
from mysql.connector import errorcode

##########################################################
# GLOBALS

# load_dotenv()

APP = Flask(__name__)

DB = None
DB_CONFIG = {
    'user': 'mysql3504',
    'password': 'u]fN"8GFJf[$4q.B',
    'host': '34.168.150.80',
    'database': 'travelaDB'
}

INFO = '''It's Alive'''


@APP.route("/")
def home_page():
    if request.method != "GET":
        return "Base route is GET only and it provides infomration about this API"

    # trick to display new lines in response
    return Markup(INFO.replace("\n", "<br>"))


@APP.route('/deviceID/', methods=['GET'])
def get_deviceID():
    argsDict = None
    getArgs = request.args
    try:
        argsDict = json.loads(getArgs["json"])
    except Exception as e:
        print("IGNORED EXCEPTION", e)
        argsDict = {}
    stip_dict(argsDict)

    prepedStatementStr = ""
    valuesArr = []

    # list of all items
    if len(argsDict) == 0:
        prepedStatementStr = "SELECT deviceID from holes"

    else:
        return "No arguments allowed"

    # RESPONSE
    response = talk_to_db(prepedStatementStr, valuesArr)
    if talk_to_db_success(response):
        return jsonify(response)
    else:
        print(response)
        return "internal error with the API"

# http://127.0.0.1/holes?deviceID=ABc1-395


@APP.route('/holes/', methods=['GET'])
def get_holes():
    argsDict = None
    getArgs = request.args
    try:
        argsDict = json.loads(getArgs["json"])
    except Exception as e:
        print("IGNORED EXCEPTION", e)
        argsDict = {}
    stip_dict(argsDict)

    prepedStatementStr = ""
    valuesArr = []

    # list of all items
    if len(argsDict) == 0:
        prepedStatementStr = "SELECT * from holes"

    # searching for items
    elif len(argsDict) == 1:
        if "deviceID" not in argsDict:
            return "holes can only be searched using their deviceID"
        else:
            prepedStatementStr = "SELECT coordOneX, coordOneY, coordTwoX, coordTwoY, coordThreeX, coordThreeY, coordFourX, coordFourY FROM holes WHERE deviceID=%s"
            valuesArr.append(argsDict['deviceID'])

    else:
        return "Only 1 argument expected"

    # RESPONSE
    response = talk_to_db(prepedStatementStr, valuesArr)
    if talk_to_db_success(response):
        return jsonify(response)
    else:
        print(response)
        return "internal error with the API"


def connect_to_db():
    global DB

    try:
        if DB.is_connected():
            return "success"
    except Exception as e:
        print("IGNORED EXCEPTION", e)
        pass

    try:
        DB = mysql.connector.connect(**DB_CONFIG)
        return "success"
    except mysql.connector.Error as err:
        if err.errno == errorcode.ER_ACCESS_DENIED_ERROR:
            return "connect_to_db(): Something is wrong with your user name or password"
        elif err.errno == errorcode.ER_BAD_DB_ERROR:
            return "connect_to_db(): Database does not exist"
        else:
            return f"connect_to_db(): {err}"
    except Exception as e:
        return f"connect_to_db(): {e}"


def talk_to_db(prepedStatementStr, valuesArr=None):
    connectToDbResult = connect_to_db()
    if connectToDbResult != "success":
        return connectToDbResult

    prepedStatementStr = prepedStatementStr.strip()
    if not valuesArr:
        valuesArr = []

    cursor = None

    try:
        cursor = DB.cursor()
        cursor.execute(prepedStatementStr, valuesArr)
    except Exception as e:
        return f"talk_to_db(): {e}"

    result = None

    if prepedStatementStr.lower().startswith("select"):
        result = {}
        resultKey = 0
        # cursor.description returns the row names => [("rowName", "otherInfo"), (rowName, "otherInfo"), ...]
        # have to call and copy cursor.description before fetchall() because fetchall() seems to screw it up
        rowNamesArr = []
        for rowInfoArr in cursor.description:
            rowNamesArr.append(rowInfoArr[0])

        rowsArr = cursor.fetchall()
        for rowDataArr in rowsArr:
            rowDict = {}
            for i in range(len(rowNamesArr)):
                rowDict[rowNamesArr[i]] = rowDataArr[i]
            result[f"{resultKey}"] = rowDict
            resultKey += 1
    else:
        result = True
        # by default Connector/Python does not autocommit, it is important to call this method after every transaction that modifies data for tables
        DB.commit()

    cursor.close()
    return result


def talk_to_db_success(response):
    return True if type(response) is dict or response is True else False


def stip_dict(dictRef):
    for key, value in dictRef.items():
        dictRef[key] = value.strip()


if __name__ == '__main__':
    APP.run(host='0.0.0.0', port=80)
