#Hw04 - Evaluate an Arithmetic Expression from a given Input String.
# Calc.main runs the program and calc.evals evaluates the input String

#main program for running the Calculator, main funnction continously takes an
#mathematical expression string from user and evaluates it continously until
#the program is terminated using ctrl +c
defmodule Calc do 
	#(User Input->Integer)
	def main do
		inputString = IO.gets("> ")
		inputString
		|>eval() #Evaluate function handles all the logic of Program.
		|>IO.puts()
		main()
	end

	#Dictionary for the Operator Precedence preference.
	@precedence_rule %{"*" => 3, "/" => 3,
	"x" => 3, "+" => 2, "-" => 2, "(" => 1}

  # evaluates an arithmetic Expression by converting into Postfix form and then
  #evaluating the postfix String. It Involves 6 pipe operations which can be
  #described as follows:
  #1.Splitting String, on the basis of Nextline check
  #2.Conversion from Infix String to Postfix String Using Shunting Yard Algo.
  #3.Enum.map returns a singleton list, thus extracting first returns Postfix
  #	 String.
  #4.All the elements of postfix string are separated by space element thus 
  #splitting it on the basis of space, gives a list of elements.
  #5.Evaluate Postfix Expression, which traverses the list from left to right,
  # computes the operation when operator is encountered by popping two elements
  #before the operator index.
  def eval(expression) do
  	expression
	  	|>String.split("\r\n") #
	  	|>Enum.map(& InfixToPostfix.intopost(&1))
	  	|>List.first()
	  	|>String.split(" ")
	  	|>eval_postfix([])
	  end


	  def eval_postfix(expr, stack) do  
	  	if expr == [] do
	  		case stack do
	  			[res | _] -> res
	  			[] -> "0"
	  		end
	  	else
	  		[first_exp | expr] = expr
	  		check_cases_for_operator(first_exp,expr,stack)
	  	end
	  end

	  def check_cases_for_operator(first_exp,expr,stack) do
	  	op? = Map.has_key?(@precedence_rule, first_exp)
	  	if op? do
	  		[op2 | [op1 | stack]] = stack
	  		stack = [eval_operation(first_exp, op1, op2) | stack]
	  		eval_postfix(expr, stack)
	  	else
	  		eval_postfix(expr, [first_exp | stack])
	  	end
	  end

  # does arithmetic
  def eval_operation(first_exp, op1, op2) do
  	operand1 = String.to_integer(op1)
  	operand2 = String.to_integer(op2)
  	case first_exp do
  		"+" -> (operand1 + operand2) |>Integer.to_string()
  		"-" -> (operand1 - operand2) |>Integer.to_string()
  		"*" -> (operand1 * operand2) |>Integer.to_string()
  		"/" -> div(operand1, operand2) |>Integer.to_string()
  	end
  end


end


#InfixToPostfix Module uses Shunting-Yard Algorithm to convert infix String to Postfix String 

defmodule  InfixToPostfix do
	@precedence_rule %{"*" => 3, "/" => 3, "x" => 3, "+" => 2, "-" => 2, "(" => 1}

	#Case when the function is called for the first time ,it will convert String into first_exp expression
	def intopost(exp) do 
		exp
		|>String.split("")
		|> Enum.filter(fn x -> x != " " && x != "" && x != "\n" end)
		|> stringToListFormat("", [])
		|>intopost({[], []})
	end

	def intopost([], {s, l}) do 
		(l ++ Enum.reverse(s))  |> Enum.join(" ")
	end

	def intopost([h|t], {s, l}) do
		op? = Map.has_key?(@precedence_rule, h)
		cond do
			op? ->
				cond do
					Enum.empty?(s) -> intopost(t, {s ++ [h], l})
					h == "(" -> intopost(t, {s ++ [h], l})
					true -> intopost(t, pushOperator(s, h, l))
				end
				h == ")" -> intopost(t, par(s, l))
				true -> intopost(t, {s, l ++ [h]})
			end
		end

		def pushOperator(s, op, l) do
			if s == [] do
				{[op], l}
			else
				peek = Enum.at(s, length(s) - 1)
				cond do
					@precedence_rule[op] > @precedence_rule[peek] -> {s ++ [op], l}
					true -> pushOperator(Enum.slice(s, 0, length(s) - 1), op, l ++ [peek])
				end
			end
		end

		def par(s, l) do
			peek = Enum.at(s, length(s) - 1)
			case peek do
				"(" -> {Enum.slice(s, 0, length(s) - 1), l}
				_  -> par(Enum.slice(s, 0, length(s) - 1), l ++ [peek])
			end
		end

		def checkparanthesis?(first) do
			(first == ")" || first == "(" || first == " ") 
		end

		def stringToListFormat(string_list, string_buffer, output_string) do
			if string_list == [] do
				case string_buffer do
					"" -> output_string
					_ -> output_string ++ [string_buffer]
				end
			else
				[first | rest] = string_list
				op? = Map.has_key?(@precedence_rule, first)
				cond do
					(op? || checkparanthesis?(first)) && string_buffer == "" ->
						stringToListFormat(rest, "", output_string ++ [first])

					(op? || checkparanthesis?(first)) ->
						stringToListFormat(rest, "", output_string ++ [string_buffer, first])

					true ->
						stringToListFormat(rest, string_buffer <> first, output_string)
					end
				end
			end
		end