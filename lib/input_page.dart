import 'package:bmi_calculator/results_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'icon_content.dart';
import 'reuseable_card.dart';
import 'constants.dart';
import 'calculator_brain.dart';

class InputPage extends StatefulWidget {
  const InputPage({super.key});

  @override
  State<InputPage> createState() => _InputPageState();
}

enum Gender { male, female }

class _InputPageState extends State<InputPage> {
  Gender? selectedGender;

  int height = 180;
  int weight = 60;
  int age = 18;

  void selectMaleGender() {
    setState(() {
      selectedGender = Gender.male;
    });
  }

  void selectFemaleGender() {
    setState(() {
      selectedGender = Gender.female;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BMI CALCULATOR'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: ReuseableCard(
                    color: selectedGender == Gender.male
                        ? kActiveCardColor
                        : kInactiveColor,
                    onTap: selectMaleGender,
                    cardChild: const IconContent(
                      iconData: FontAwesomeIcons.mars,
                      label: "MALE",
                    ),
                  ),
                ),
                Expanded(
                  child: ReuseableCard(
                      color: selectedGender == Gender.female
                          ? kActiveCardColor
                          : kInactiveColor,
                      onTap: selectFemaleGender,
                      cardChild: const IconContent(
                        iconData: FontAwesomeIcons.venus,
                        label: "FEMALE",
                      )),
                )
              ],
            ),
          ),
          Expanded(
            child: ReuseableCard(
              color: kActiveCardColor,
              cardChild: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "HEIGHT",
                    style: kLabelTextStyle,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text(
                        "$height",
                        style: kNumberTextStyle,
                      ),
                      const Text(
                        "cm",
                        style: kLabelTextStyle,
                      )
                    ],
                  ),
                  SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                        trackHeight: 2.0,
                        thumbColor: Color(0xFFFB1555),
                        overlayColor: Color(0x1FFB1555),
                        activeTrackColor: Colors.white,
                        inactiveTrackColor: kSliderInctiveColor,
                        thumbShape: RoundSliderThumbShape(
                          enabledThumbRadius: 15.0,
                        ),
                        overlayShape: RoundSliderOverlayShape(
                          overlayRadius: 30.0,
                        )),
                    child: Slider(
                      onChanged: (value) => {
                        setState(
                          () => {
                            height = value.toInt(),
                          },
                        )
                      },
                      value: height.toDouble(),
                      min: 120.0,
                      max: 220.0,
                    ),
                  ),
                ],
              ),
              onTap: () => {},
            ),
          ),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: ReuseableCard(
                    color: kActiveCardColor,
                    onTap: () => {},
                    cardChild: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "WEIGHT",
                          style: kLabelTextStyle,
                        ),
                        Text(
                          "$weight",
                          style: kNumberTextStyle,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            RoundIconButton(
                              onPressed: () {
                                setState(() {
                                  weight--;
                                });
                              },
                              iconData: FontAwesomeIcons.minus,
                            ),
                            const SizedBox(width: 10.0),
                            RoundIconButton(
                              onPressed: () {
                                setState(() {
                                  weight++;
                                });
                              },
                              iconData: FontAwesomeIcons.plus,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: ReuseableCard(
                    color: kActiveCardColor,
                    onTap: () => {},
                    cardChild: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "AGE",
                          style: kLabelTextStyle,
                        ),
                        Text(
                          "$age",
                          style: kNumberTextStyle,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            RoundIconButton(
                              onPressed: () {
                                setState(() {
                                  age--;
                                });
                              },
                              iconData: FontAwesomeIcons.minus,
                            ),
                            const SizedBox(width: 10.0),
                            RoundIconButton(
                              onPressed: () {
                                setState(() {
                                  age++;
                                });
                              },
                              iconData: FontAwesomeIcons.plus,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          BottomButton(
            onTap: () {
              CalculatorBrain calc = CalculatorBrain(
                height: height,
                weight: weight,
              );

              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return ResultsPage(
                    bmiText: calc.calculateBMI(),
                    resultText: calc.getResult(),
                    description: calc.getDescription(),
                  );
                },
              ));
            },
            buttonTitle: "CALCULATE",
          ),
        ],
      ),
    );
  }
}

class RoundIconButton extends StatelessWidget {
  final IconData iconData;
  final Function onPressed;

  const RoundIconButton({
    super.key,
    required this.iconData,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: () {
        onPressed();
      },
      shape: const CircleBorder(),
      fillColor: const Color(0xFF4C4F5E),
      constraints: const BoxConstraints.tightFor(
        width: 56.0,
        height: 56.0,
      ),
      elevation: 6.0,
      disabledElevation: 6.0,
      child: Icon(
        iconData,
        color: Colors.white,
      ),
    );
  }
}
