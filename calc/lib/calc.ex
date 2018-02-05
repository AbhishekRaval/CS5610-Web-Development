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
  #Attribution : https://brilliant.org/wiki/shunting-yard-algorithm/
  #3.Enum.map returns a singleton list, thus extracting first returns Postfix
  #	 String.
  #4.All the elements of postfix string are separated by space element thus 
  #splitting it on the basis of space, gives a list of elements.
  #5.Evaluate Postfix Expression, which traverses the list from left to right,
  # computes the operation when operator is encountered by popping two elements
  #before the operator index.
  #(String->Number)
  def eval(expression) do
  	expression
	  	|>String.split("\r\n") #
	  	|>Enum.map(&intopost(&1))
	  	|>List.first()
	  	|>String.split(" ")
	  	|>eval_postfix([])
	  end

  #eval_postfix evaluates the postfix expression by pushin all the operands 
  # into stack until an operator is received.When Operator is received, last 
  # two operands are curled out and operation with operator on top of stack is
  #performed
  #(List Of String -> Number) 
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

  #check cases if the top of stack is operator or operand
  #(List.first,List.rest,List->Number)
  def check_cases_for_operator(first_exp,expr,stack) do
  	op? = Map.has_key?(@precedence_rule, first_exp)
  	if op? do
  		[operand2 | [operand1 | stack]] = stack
  		stack = [eval_operation(first_exp, operand1, operand2) | stack]
  		eval_postfix(expr, stack)
  	else
  		eval_postfix(expr, [first_exp | stack])
  	end
  end

  #evaluates arithmetic expression, by doing operand1(operator)operand2 computn
  #(Operator,operand,operand -> Number)
  def eval_operation(first_exp, operand1, operand2) do
  	operand1 = String.to_integer(operand1)
  	operand2 = String.to_integer(operand2)
  	case first_exp do
  		"+" -> (operand1 + operand2) |>Integer.to_string()
  		"-" -> (operand1 - operand2) |>Integer.to_string()
  		"*" -> (operand1 * operand2) |>Integer.to_string()
  		"/" -> div(operand1, operand2) |>Integer.to_string()
  	end
  end

  def filterfn(x) do
  	x != " " && x != "" && x != "\n" 
  end

  #Case when the function is called for the first time with input expression,
  #it will convert String into List of operator and operand Strings.
  #Pipe operations are executed in following order. 
  #1.It Splits the string's each character into list of strings
  #2.It filters out all the list elements white spaces and line endings 
  #3.It calls StringToListFormat which reformats the list of characters to list
  #of operators,operands and paranthesis
  #4.It will pass the formated string to intopost function with empty stack, 
  #and finalString
  #Attribution: https://www.youtube.com/watch?v=vq-nUF0G4fI&t=922s
  def intopost(arithexpress) do 
  	arithexpress
  	|>String.split("")
  	|> Enum.filter(fn x ->filterfn(x) end)
  	|> stringToListFormat("", [])
  	|>intopost({[], []})
  end

  #When the List of operator and operands is empty, it returns final string 
  #by appending all the elements of Stack back to final String
  def intopost([], {stack, final_string}) do 
  	(final_string ++ Enum.reverse(stack))  |> Enum.join(" ")
  end

  def intopost([first|rest], {stack, final_string}) do
  	op? = Map.has_key?(@precedence_rule, first)
  	if op? do
  		cond do
  			Enum.empty?(stack) -> 
  				intopost(rest, {stack ++ [first], final_string})
  				first == "(" -> 
  					intopost(rest, {stack ++ [first], final_string})
  					true -> 
  						intopost(rest, pushOperator(stack, first, final_string))
  					end
		else
			cond do
				first == ")" ->
					intopost(rest, parenthesisStack(stack,final_string))
					true ->
						intopost(rest, {stack, final_string ++ [first]})
					end
				end
			end

	#It will get a stack, operator and final_String, if the stack is empty, it
	#will return final_string appended with, operator, else
	#it will append the operator to the final string if operator precedence of
	#operator on head is less than op!
	def pushOperator(stack, op, final_string) do
		if stack == [] do
			{[op], final_string}
		else
			peek = Enum.at(stack, length(stack) - 1)
			cond do
				@precedence_rule[op] > @precedence_rule[peek] -> 
					{stack ++ [op], final_string}
					true -> 
						pushOperator(Enum.slice(stack, 0, length(stack) - 1), 
							op, final_string ++ [peek])
					end
				end
  			end

	def parenthesisStack(stack, final_string) do
		peek = Enum.at(stack, length(stack) - 1)
		case peek do
			"(" -> 
				{Enum.slice(stack, 0, length(stack) - 1), final_string}
			_ -> 
				parenthesisStack(Enum.slice(stack, 0, length(stack)-1), 
				final_string ++ [peek])
		end
	end

	#helper for StringToListFormat
	def checkparanthesis?(first) do
		(first == ")" || first == "(" || first == " ") 
	end

	#Construct the List of operand, operators and paranthesis from raw list of 
	#characters
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
					stringToListFormat(rest, "",
						output_string ++ [string_buffer, first])

					true ->
						stringToListFormat(rest,
							string_buffer <> first, output_string)
					end
				end
			end
		end
