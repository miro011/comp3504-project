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


@APP.route('/deviceID', methods=['GET'])
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


@APP.route('/holes', methods=['GET'])
def get_holes():
    argsDict = None
    getArgs = request.args

    prepedStatementStr = ""
    valuesArr = []

    # list of all items
    if len(getArgs) == 0:
        prepedStatementStr = "SELECT * from holes"

    # searching for items
    elif len(getArgs) == 1:
        if "deviceID" not in getArgs:
            return "holes can only be searched using their deviceID"
        else:
            devID = getArgs['deviceID']
            print(f"Getting holes for device '{devID}'")
            prepedStatementStr = "SELECT coordOneX, coordOneY, coordTwoX, coordTwoY, coordThreeX, coordThreeY, coordFourX, coordFourY FROM holes WHERE deviceID=%s"
            print(f"Executing SQL ${prepedStatementStr}")
            valuesArr.append(devID)

    else:
        return "Only 1 argument expected"

    # RESPONSE
    response = talk_to_db(prepedStatementStr, valuesArr)
    if talk_to_db_success(response):
        return jsonify(response)
    else:
        print(response)
        return "internal error with the API"


# http://127.0.0.1:80/holes/
# example:
# {
#     "deviceID": "ABc1-396",
#     "coordOneX": "53.01",
#     "coordOneY": "-113.78857",
#     "coordTwoX": "54.01",
#     "coordTwoY": "-113.76805",
#     "coordThreeX": "55.01",
#     "coordThreeY": "-113.7683",
#     "coordFourX": "56.01",
#     "coordFourY": "-113.7617"

# }

@APP.route('/holes', methods=['POST'])
def add_new_hole():
    deviceID = request.args['deviceID']
    print(f"Received holes for device '{deviceID}'")

    holes = request.get_json()

    expectedKeysArr = ["coordOneX", "coordOneY", "coordTwoX", "coordTwoY", "coordThreeX", "coordThreeY", "coordFourX", "coordFourY"]
    sqlInsetCmdBase = "INSERT INTO holes (deviceID,coordOneX,coordOneY,coordTwoX,coordTwoY,coordThreeX,coordThreeY,coordFourX,coordFourY)"
    sqlInsetCmdValues = ""
    valuesArr = []

    for dt, data in holes.items():
        result = arguments_validation(data, expectedKeysArr)
        if result != "success":
            print(result)
            return result

        sqlInsetCmdValues += "(%s, %s, %s, %s, %s, %s, %s, %s, %s),"
        valuesArr.append(deviceID)
        for key in expectedKeysArr:
            valuesArr.append(data[key])

    prepedStatementStr = f"{sqlInsetCmdBase} VALUES {sqlInsetCmdValues[:-1]}" # remove last coma
    print(prepedStatementStr)
    response = talk_to_db(prepedStatementStr, valuesArr)

    if talk_to_db_success(response):
        return jsonify(success=True)
    else:
        print(response)
        return "internal error with the API"

    return jsonify(success=True)


@APP.route('/highscores', methods=['GET'])
def get_highscores():
    request.args

    sql_statement = ""
    statement_data = []

    # list of all items
    if len(request.args) == 0:
        sql_statement = "select count(id) as num_holes, deviceID from holes group by deviceID order by num_holes"

    elif len(request.args) == 1:
        if "deviceID" not in request.args:
            return "holes can only be searched using their deviceID"
        else:
            sql_statement = "select count(id) as num_holes, deviceID from holes where deviceID=%s group by deviceID order by num_holes"
            statement_data.append(request.args['deviceID'])

    else:
        return "Only 1 argument expected"

    # RESPONSE
    response = talk_to_db(sql_statement, statement_data)
    if talk_to_db_success(response):
        return jsonify(response)



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

        DB.commit()

    cursor.close()
    return result


def talk_to_db_success(response):
    return True if type(response) is dict or response is True else False


def stip_dict(dictRef):
    for key, value in dictRef.items():
        dictRef[key] = value.strip()


def arguments_validation(dictRef, expectedKeysArr):
    if len(dictRef.keys()) < len(expectedKeysArr):
        return ["Not enough arguments provided."]
    elif len(dictRef.keys()) > len(expectedKeysArr):
        return ["Too many arguments provided."]
    elif sorted(dictRef.keys()) != sorted(expectedKeysArr):
        return ["Unexpected arguments present."]

    return "success"


if __name__ == '__main__':
    APP.run(host='0.0.0.0', port=81)
